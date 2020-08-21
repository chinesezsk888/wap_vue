<template>
  <div class="mypopup_page" ref="myPage">
    <div class="mypopup_header">
      <div class="title">我要建言</div>
      <div class="close" @click="goback">返回</div>
    </div>
    <div class="mypopup_body">
      <div class="input" @click="showCategoryPanel">
        <div class="input_label">留言领域<span class="input_required"></span></div>
        <span v-if="!category.status" class="placeholder">请选择</span>
        {{category.value}}
        <span class="icon_tri"></span>
      </div>

      <div class="input" @click="showCityPanel">
        <div class="input_label">所属城市<span class="input_required"></span></div>
        <span v-if="!cityObj.status" class="placeholder">请选择</span>
        {{cityObj.value}}
        <span class="icon_tri"></span>
      </div>

      <app-input-card class="myinput_card"
        ref="area"
        :title="'留言对象'"
        :placeholder="'如：省市区名、城市名、政府机构名'"
        :required="true"
        :count="40"
        :type="1"
        :error="area.status"
        @getValue="(value)=>setValue(value,'area')"
      ></app-input-card>

      <app-input-card class="myinput_card"
        ref="title"
        :title="'标题'"
        :placeholder="'请输入标题，不超过40字请输入标题'"
        :required="true"
        :count="40"
        :type="1"
        :error="title.status"
         @getValue="(value)=>setValue(value,'title')"
      ></app-input-card>

      <app-input-card class="myinput_card_area myinput_card"
        ref="description"
        :title="'详细说明'"
        :placeholder="'1.如：事情经过、咨询内容、投诉诉求、具体建议等。2.请如实、客观、冷静填写，不用过多的修辞，不宣泄。3.如内容违法将由留言者承担法律责任。'"
        :required="true"
        :count="800"
        :type="1"
        :error="description.status"
         @getValue="(value)=>setValue(value,'description')"
      ></app-input-card>

      <div class="upload_panel">
        <div class="upload_list">
          <div v-for="(item, index)  in fileShowSrc" :key="index" class="upload_item">
            <template v-if="contType==2">
               <img :src="item" :class="fileImageOrientation[index]">
            </template>
            <template v-if="contType==3">
              <video :src="item" controls="controls"></video>
            </template>
            <span class="upload_btn_delete" @click="deleteUploadFile(index)"/>
          </div>

          <div :class="{'upload_controller':contType!=1,'upload_controller-image':contType==2,'upload_controller-video':contType==3} ">
            <div class="upload_image_btn"/>
            <input type="file" ref="fileImage" accept="image/*" @change="fileImageChange($event)" class="upload_input upload_input-image">
            <div class="upload_video_btn"/>
            <input type="file" ref="fileVideo" accept="video/*" @change="fileVideoChange($event)" class="upload_input upload_input-video">
          </div>

        </div>
        <div class="upload_txt">图片/视频中如有隐私信息，注意隐藏</div>
      </div>

      <div class="input" :class="{error:contactInformation.status}">
         <div class="input_label">联系方式<span class="input_required"></span></div>
         <input placeholder="仅用于核对信息，以使建言效果更好" type="number" v-model.number="contactInformation.value"
         @input="contactInformationInput"
         @focus="contactInformationFocus"
         @blur="contactInformationBlur">
      </div>

      <app-check-box
        :defaultValue="1"
        :txt="'同意将投诉内容、联系方式提供给留言对象相关部门，用于信息核对和反馈'"
        @getCheckStatus="(status)=>setCheckbox(status,'verify')"
      ></app-check-box>

      <app-check-box
        :txt="'匿名建言，勾选后将不显示澎湃昵称'"
        @getCheckStatus="(status)=>setCheckbox(status,'anonymous')"
      ></app-check-box>

      <div @click="showValues" class="submit_btn" :class="{unable:!submitBtnStatus}">提交</div>

      <div
      class="mypopup half"
      ref="myhalfpopup"
      :class="{show:categoryShow}"
      @click="setCategoryPanel"
      >
        <app-select-panel
          ref="categoryPanel"
          @btn1="setCategoryPanel"
          @btn2="getSelectCategory"
          :itemList="categoryList"
          propertyTxt="categoryName"
          propertyId="categoryId"
        ></app-select-panel>
      </div>
      <div
      class="mypopup half citypopup"
      ref="myhalfpopup"
      :class="{show:showCity}"
      @click="setCityPanel"
      >
        <app-city-panel
          ref="cityPanel"
          @citybtn1="setCityPanel"
          @citybtn2="getCitySelectCategory"
          :itemList="cityList"
          propertyTxt="categoryName"
          propertyId="categoryId"
        ></app-city-panel>
      </div>
    </div>
  </div>
</template>
<script>
import msgAlert from '@/util/message'
import AppInputCard from './AppInputCard'
import AppCheckBox from './AppCheckBox'
import AppSelectPanel from './AppSelectPanel'
import AppCityPanel from './AppCityPanel'
import loading from '@/util/loading'
import { getStyle } from '@/util/common.js'

function UCBlurDeal () {
  var ua = navigator.userAgent.toLowerCase()
  if (/iphone|ipad|ipod/.test(ua)) {
    if (ua.indexOf('ucbrowser') > -1 || ua.indexOf('micromessenger') > -1) {
      document.getElementsByClassName('mypopup')[0].style.position = 'fixed'
      document.getElementsByClassName('mybody')[0].style.display = 'block'
    }
  }
}
function hasEmoji (substring) {
  for (var i = 0; i < substring.length; i++) {
    var hs = substring.charCodeAt(i)
    if (hs >= 0xd800 && hs <= 0xdbff) {
      if (substring.length > 1) {
        var ls = substring.charCodeAt(i + 1)
        var uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000
        if (uc >= 0x1d000 && uc <= 0x1f77f) {
          return true
        }
      }
    } else if (substring.length > 1) {
      let ls = substring.charCodeAt(i + 1)
      if (ls == 0x20e3) {
        return true
      }
    } else {
      if (hs >= 0x2100 && hs <= 0x27ff) {
        return true
      } else if (hs >= 0x2B05 && hs <= 0x2b07) {
        return true
      } else if (hs >= 0x2934 && hs <= 0x2935) {
        return true
      } else if (hs >= 0x3297 && hs <= 0x3299) {
        return true
      } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
        return true
      }
    }
  }
}
export default {
  name: 'TheReplyPanel',
  props: {
    categoryList: Array,
    cityList: Array,
    interactionClassifyId: String
  },
  data () {
    return {
      uid: '', // 用户或者问政号ID
      userType: -1, // 0:湃客 1:媒体 2:问政 3:普通用户
      title: { // 标题
        value: '',
        status: false,
        txt: '标题'
      },
      area: { // 地区
        value: '',
        status: false,
        txt: '地区'
      },
      description: { // 详细说明
        value: '',
        status: false,
        txt: '详细说明'
      },
      category: { // 分类
        value: '',
        id: '',
        status: false,
        txt: '分类'
      },
      cityObj: { // 城市
        value: '',
        id: '',
        status: false,
        txt: '城市'
      },
      realName: { // 真实姓名
        value: '',
        status: false,
        txt: '真实姓名'
      },
      contactInformation: { // 联系方式
        value: '',
        status: false,
        txt: '联系方式'
      },
      fenlei: '请选择',
      ossData: {
        region: '',
        accessKeyId: '',
        accessKeySecret: '',
        stsToken: '',
        bucket: '',
        putImageKey: '',
        putVideoKey: ''
      },
      anonymous: 0, // 是否匿名显示 0:否 1:是
      verify: 1, // 是否同意向被投诉方核对 0:否 1:是
      categoryShow: false, // 分类面板控制
      showCity: false, // 城市选项
      isSubmit: false, // 正在提交
      fileShowSrc: [], // 展示用 文件数组
      fileImageOrientation: [], // 相片拍摄方向
      fileList: [], // 上传用 文件数组
      uploadObject: [], // 提交用文件信息
      contType: 1 // 1纯文字，2带图片，3带视频
    }
  },
  watch: {
    'contactInformation.value': function (value) {
      this.contactInformation.value = (value + '').slice(0, 11)
    }
  },
  computed: {
    submitBtnStatus () { // 点击按钮控制 false 不能点
      return this.checkValue()
    }
  },
  components: {
    AppInputCard, AppSelectPanel, AppCheckBox, AppCityPanel
  },
  mounted () {
    let dom = this.$refs.myPage
    let myhalfpopupdom = this.$refs.myhalfpopup
    let panelHeight = getStyle(dom, 'height')
    window.addEventListener('resize', () => {
      // dom.style.height = panelHeight;
      myhalfpopupdom.style.height = panelHeight
      UCBlurDeal()
    })
  },
  methods: {
    // 建立一个可存取到该file的url
    getObjectURL (file) {
      var url = null
      if (window.createObjectURL != undefined) { // basic
        url = window.createObjectURL(file)
      } else if (window.URL != undefined) { // mozilla(firefox)
        url = window.URL.createObjectURL(file)
      } else if (window.webkitURL != undefined) { // webkit or chrome
        url = window.webkitURL.createObjectURL(file)
      }
      return url
    },
    // 多文件上传添加formData方法
    getinputFile (info, arr, inputname) {
      for (var i = 0; i < arr.length; i++) {
        info.append(inputname, arr[i])
      }
    },
    deleteUploadFile (index) {
      this.fileShowSrc.splice(index, 1)
      this.fileList.splice(index, 1)
      this.fileImageOrientation.splice(index, 1)
      if (this.fileShowSrc.length == 0) {
        this.contType = 1
      }
    },
    fileVideoChange (e) {
      let file = this.$refs.fileVideo.files[0]
      if (this.fileList.length > 2) {
        msgAlert('视频只能传3个')
        return
      }
      if (e.currentTarget.files[0].size > (200 * 1024 * 1024)) {
        msgAlert('视频请小于200M')
        return
      }
      let src = this.getObjectURL(file)
      this.fileShowSrc.push(src)
      this.fileList.push(file)
      this.contType = 3
      this.$refs.fileVideo.value = ''
    },
    fileImageChange (e) {
      let files = this.$refs.fileImage.files
      let that = this
      if (that.fileList.length > 2) {
        msgAlert('图片只能传3张')
        return
      }
      if (e.currentTarget.files[0].size > (20 * 1024 * 1024)) {
        msgAlert('视频请小于20M')
        return
      }
      loading.show()
      Array.prototype.forEach.call(files, (item, index) => {
        // 上限10
        if (index < 10) {
          var fileReader = new FileReader()
          fileReader.readAsDataURL(item)
          fileReader.onload = function (e) {
            that.fileShowSrc.push(e.target.result)
            that.fileList.push(item)
            that.contType = 2
            loading.hide()
          }
          window.EXIF.getData(item, () => {
            let orientation = window.EXIF.getTag(item, 'Orientation')
            let orientationCss = ''
            switch (orientation) {
              case 1:
                orientationCss = 'orientation1'
                break
              case 3:
                orientationCss = 'orientation3'
                break
              case 6:
                orientationCss = 'orientation6'
                break
              case 8:
                orientationCss = 'orientation8'
                break
              default:
                orientationCss = ''
                break
            }
            that.fileImageOrientation.push(orientationCss)
          })
        }
      })
      this.$refs.fileImage.value = ''
    },
    contactInformationFocus () {
      // 苹果uc浏览器 position: fixed;处理
      var ua = navigator.userAgent.toLowerCase()
      if (/iphone|ipad|ipod/.test(ua)) {
        if (ua.indexOf('ucbrowser') > -1 || ua.indexOf('micromessenger') > -1) {
          document.getElementsByClassName('mypopup')[0].style.position = 'absolute'
          document.getElementsByClassName('mybody')[0].style.display = 'none'
        }
      }
    },
    contactInformationBlur () {
      UCBlurDeal()
    },
    contactInformationInput () {
      if (this.contactInformation.value != '') {
        this.contactInformation.status = false
      }
    },
    realNameInput () {
      if (this.realName.value != '') {
        this.realName.status = false
      }
    },
    resetValue () {
      this.$refs.area.clearValue()
      this.$refs.title.clearValue()
      this.$refs.description.clearValue()
      this.$refs.categoryPanel.clearValue()
      this.$refs.cityPanel.clearValue()
      this.clearCategory()
      this.contactInformation = {
        value: '',
        status: false
      }
      this.realName = {
        value: '',
        status: false
      }

      this.fileShowSrc = []
      this.fileImageOrientation = []
      this.fileList = []
      this.contType = 1
      UCBlurDeal()
    },
    clearCategory () {
      this.category.status = false
      this.category.value = ''
      this.category.id = ''
      this.cityObj.status = false
      this.cityObj.value = ''
      this.cityObj.id = ''
    },
    setValue (value, type) {
      this[type].value = value
    },
    setCheckbox (status, type) {
      this[type] = Number(status)
    },
    getSelectCategory (item) { // 确定 选框子组件值赋给表单父组件
      this.category.value = item.categoryName
      this.category.id = item.categoryId
      this.category.status = true
      this.categoryShow = false
    },
    getCitySelectCategory (item) {
      this.cityObj.value = item.categoryName
      this.cityObj.id = item.categoryId
      this.cityObj.status = true
      this.showCity = false
    },
    setCategoryPanel () { // 取消 表单父组件值赋给选框子组件
      this.$refs.categoryPanel.selectItem({
        categoryName: this.category.value,
        categoryId: this.category.id
      })
      this.categoryShow = false
    },
    setCityPanel () {
      this.$refs.cityPanel.selectItem({
        categoryName: this.cityObj.value,
        categoryId: this.cityObj.id
      })
      this.showCity = false
    },
    showCategoryPanel () {
      this.categoryShow = true
    },
    showCityPanel () {
      this.showCity = true
    },
    goback () {
      this.$emit('close')
    },
    checkValue () {
      let result = true
      const checkList = [ 'area', 'title', 'description', 'contactInformation', 'category', 'cityObj' ]

      checkList.forEach((item) => {
        if (this[item].value == '') {
          // this[item].status = true;
          result = false
        }
      })
      return result
    },
    checkValueEmoji () {
      let result = true
      const checkList = [ 'area', 'title', 'description', 'contactInformation', 'category', 'cityObj' ]
      for (let i = 0; i < checkList.length; i++) {
        let item = checkList[i]
        if (hasEmoji(this[item].value)) {
          // this[item].status = true;
          result = false
          msgAlert(this[item].txt + '中的不能含有表情！')
          break
        }
      }
      return result
    },
    showValues () {
      if (this.submitBtnStatus) {
        this.sendSubmitPre()
      }
    },
    getOss (success, error) {
      loading.show()
      let url = '/wap/epidemicUpload.msp'
      this.axios({
        method: 'get',
        url: url
      }).then(res => {
        if (res.data.resultCode == 1) {
          let ossResp = res.data.ossResp
          this.ossData.region = ossResp.region
          this.ossData.accessKeyId = ossResp.accessKeyId
          this.ossData.accessKeySecret = ossResp.accessKeySecret
          this.ossData.stsToken = ossResp.stsToken
          this.ossData.bucket = ossResp.bucket
          this.ossData.putImageKey = ossResp.putImageKey
          this.ossData.putVideoKey = ossResp.putVideoKey
          this.ossSubmit(success)
        } else {
          msgAlert('上传失败请稍后重试')
          loading.hide()
          this.isSubmit = false
        }
      }).catch(() => {
        msgAlert('上传失败请稍后重试')
        loading.hide()
        this.isSubmit = false
      })
    },
    ossSubmit (success, error) {
      let client = new window.OSS.Wrapper({
        region: this.ossData.region,
        accessKeyId: this.ossData.accessKeyId,
        accessKeySecret: this.ossData.accessKeySecret,
        stsToken: this.ossData.stsToken,
        bucket: this.ossData.bucket
      })
      let storeAsName = ''
      let extraName = ''
      if (this.contType == 2) {
        storeAsName = this.ossData.putImageKey
        extraName = 'jpg'
      } else if (this.contType == 3) {
        storeAsName = this.ossData.putVideoKey
        extraName = 'mp4'
      }
      let file = {}
      let storeAs = ''
      let that = this
      let promiseList = []
      for (let i = 0; i < this.fileList.length; i++) {
        let p = new Promise((resolve, reject) => {
          file = that.fileList[i]
          storeAs = storeAsName + '_' + (i + 1) + '.' + extraName
          that.uploadObject.push({
            ossName: storeAs,
            ossFileSize: file.size
          })
          client.multipartUpload(storeAs, file).then(function (result) {
            if (result.res.status != 200) {
              reject(new Error('上传失败'))
            } else {
              resolve()
            }
          })
        })
        promiseList.push(p)
      }
      Promise.all(promiseList).then(function (results) {
        if (success) success()
      }).catch(() => {
        msgAlert('上传失败请稍后重试')
        loading.hide()
        that.isSubmit = false
      })
    },
    sendSubmit () {
      loading.show()
      let url = '/wap/userSuggestionsSubmit.msp'
      var formData = new FormData()
      formData.append('contType', this.contType)
      formData.append('categoryId', this.cityObj.id)
      formData.append('messagesDomainId', this.category.id)
      formData.append('title', this.title.value)
      formData.append('area', this.area.value)
      formData.append('description', this.description.value)
      formData.append('anonymous', this.anonymous)
      formData.append('verify', this.verify)
      formData.append('realName', this.realName.value)
      formData.append('contactInformation', this.contactInformation.value)
      formData.append('interactionType', 1)
      formData.append('interactionClassifyId', this.interactionClassifyId)
      for (let i = 0; i < this.uploadObject.length; i++) {
        let uObject = this.uploadObject[i]
        for (let key in uObject) {
          formData.append('uploadObject[' + i + '].' + key, uObject[key])
        }
      }
      this.axios({
        method: 'post',
        url: url,
        data: formData
      }).then(res => {
        msgAlert(res.data.resultMsg)
        if (res.data.resultCode == 1) { // 退出弹框
          setTimeout(() => {
            this.goback() // 返回上一级菜单
            this.resetValue() // 重置填写数据
            this.isSubmit = false // 放开请求
          }, 1000)
        } else {
          this.isSubmit = false // 放开请求
        }
        loading.hide()
      })
        .catch(() => {
          loading.hide()
          this.isSubmit = false
        })
    },
    sendSubmitPre () {
      if (this.isSubmit) {
        return
      }
      if (!this.checkValueEmoji()) {
        return
      }
      this.isSubmit = true
      this.uploadObject = []
      if (this.fileList.length == 0) {
        this.sendSubmit()
      } else {
        this.getOss(() => {
          this.sendSubmit()
        })
      }
    }
  }
}
</script>
<style lang="scss">
  .upload_panel{
    background:#fff;
    margin-top: -0.24rem;
    padding: 0.3rem 0.3rem 0.2rem;
    margin-bottom:0.2rem;
    position: relative;
    .upload_controller{
      position: relative;
      width: 2.2rem;
      height: 2.2rem;
      .upload_image_btn,.upload_video_btn{
        width: 2.2rem;
        height: 2.2rem;
      }
      .upload_input{
        width: 2.2rem;
        height: 2.2rem;
        top:0;
        left:0;
      }
    }
    .upload_controller-video{
      .upload_image_btn, .upload_input-image{
        display:none;
      }
    }
    .upload_controller-image{
      .upload_video_btn, .upload_input-video{
        display:none;
      }
    }
    .upload_input{
      cursor: pointer;
      position: absolute;
      top: 0.3rem;
      width:2.2rem;
      height:2.2rem;
      bottom: 1.5rem;
      opacity: 0;
    }
    .upload_input-image{
      left:0.3rem;
    }
    .upload_input-video{
      left: 2.7rem;
    }
    .upload_txt{
      font-size:0.24rem;
      color:#999;
    }
    .upload_image_btn,.upload_video_btn{
      width:2.2rem;
      height:2.2rem;
      background-size:99%;
      background-repeat: no-repeat;
      display:inline-block;
      cursor: pointer;
    }
    .upload_image_btn{
      margin-right:0.2rem;
      background-image:url(~@/assets/dffz_situation/upload_btn_image_icon.png);
    }
    .upload_video_btn{
      background-image:url(~@/assets/dffz_situation/upload_btn_video_icon.png);
    }
    .upload_list{
      display: flex;
      flex-flow:wrap;
      justify-content: space-between;
      height: 2.2rem;
      margin-bottom: 0.2rem;
      div {
        height: 2.2rem;
      }
      &::after{
        width: 2.2rem;
        height: 2.2rem;
        content: "";
      }
    }
    .upload_item{
      position: relative;
      width:2.2rem;
      height:2.2rem;
      img,video{
        width:100%;
        height:100%;
      }
      img{
        object-fit: cover;
      }
    }
    .upload_btn_delete{
      width:0.4rem;
      height:0.4rem;
      position: absolute;
      background-image:url(~@/assets/epidemic_situation/upload_btn_delete.png);
      background-size:100%;
      top: 0;
      right: 0;
    }
  }
  .mypopup_header{
    width:100%;
    height:0.96rem;
    background:rgba(255,255,255,1);
    border-bottom: 1px solid #f1f1f1;
    .close{
      cursor: pointer;
      position: absolute;
      top:0.28rem;
      left:0.3rem;
      color:#333;
      font-size:0.3rem;
    }
    .title{
      text-align: center;
      font-size: 0.34rem;
      color: #333;
      line-height: 0.96rem;
    }
  }
  .mypopup_page{
    width:100%;
    height:100%;
  }
  .mypopup_body{
    width:100%;
    height:100%;
    background: #F3F4F6;
    overflow: auto;
    .input{
      height: .70rem;
      background: #FFF;
      margin-bottom: 0.24rem;
      padding:0.15rem 0.3rem;
      font-size: 0.32rem;
      color:#333;
      position: relative;
      .placeholder{
        color:#999;
      }
      .input_label{
        display: inline-block;
        position: relative;
        margin-right: 0.3rem;
        color:#333;
      }
      .icon_tri{
        width:0.16rem;
        height:0.26rem;
        background:url(~@/assets/epidemic_situation/tri_right.png) no-repeat ;
        background-size:100%;
        display:block;
        float:right;
      }
      &.error{
        border:1px solid #D0021B;
      }
      input{
        border: 0;
        font-size: 0.30rem;
        width: 5.2rem;
        vertical-align: inherit;
      }
    }
  }
  .myinput_card{
    margin-bottom:0.24rem;
  }
  .myinput_card_area{
    height:3rem;
    textarea{
      height:2rem;
    }
  }

  .submit_btn{
    cursor: pointer;
    width: 6.90rem;
    max-width: 95%;
    height: 0.88rem;
    background: linear-gradient(315deg, #08f 0%, #00c5ff 100%);
    color: #fff;
    text-align: center;
    line-height: 0.88rem;
    font-size: 0.30rem;
    margin: 0 auto;
    margin-top: 0.37rem;
    margin-bottom: 2.37rem;
    &.unable{
     opacity: 0.5;
    }
  }
  .mypopup.half{
    background: rgba(19,19,19,0.5);
    top: inherit;
    bottom: 0;
  }
  .mypopup.half.show .app_select_panel,
  .mypopup.citypopup.show .app_select_panel
  {
    bottom: 0;
  }
  .mypopup.citypopup .app_select_panel .item_list {
    padding-bottom: 0.28rem;
  }
  .mypopup.citypopup .app_select_panel .item {
    margin-bottom: 0.2rem;
  }
  .orientation1{ // 不变
    transform:rotate(0)
  }
  .orientation3{ // 顺（逆）时针旋转180°
    transform:rotate(180deg)
  }
  .orientation6{ // 顺时针旋转90°
    transform: rotate(90deg);
  }
  .orientation8{ //逆时针旋转90°
    transform:rotate(-90deg)
  }
    /**iphone x**/
  @media (device-width: 375px) and (device-height: 812px) and (-webkit-min-device-pixel-ratio : 3){

  }
  //iphone Xs Max
  @media only screen and (device-width: 414px) and (device-height: 896px) and (-webkit-device-pixel-ratio:3) {

  }
  //iphone XR
  @media only screen and (device-width: 414px) and (device-height: 896px) and (-webkit-device-pixel-ratio:2) {
    .orientation1{ // 不变
      transform:rotate(0)
    }
    .orientation3{ // 顺（逆）时针旋转180°
      transform:rotate(0)
    }
    .orientation6{ // 顺时针旋转90°
      transform: rotate(0);
    }
    .orientation8{ //逆时针旋转90°
      transform:rotate(0)
    }
  }
</style>
