<template>
  <div class="mypopup_page" ref="myPage">
    <div class="mypopup_header">
      <div class="title">我要投诉</div>
      <div class="close" @click="goback">返回</div>
    </div>
    <div class="mypopup_body">
      <div class="input" @click="showCategoryPanel">
        <div class="input_label">分类<span class="input_required"></span></div>
        <span v-if="!category.status" class="placeholder">请选择</span>
        {{category.value}}
        <span class="icon_tri"></span>
      </div>

      <app-input-card class="myinput_card"
        ref="complaintObject"
        :title="'投诉对象'"
        :placeholder="'如：公司名、机构名、产品名'"
        :required="true"
        :count="30"
        :type="1"
        :error="complaintObject.status"
        @getValue="(value)=>setValue(value,'complaintObject')"
      ></app-input-card>

      <app-input-card class="myinput_card"
        ref="title"
        :title="'标题'"
        :placeholder="'核心信息，如：违规行为、造成后果'"
        :required="true"
        :count="40"
        :type="1"
        :error="title.status"
         @getValue="(value)=>setValue(value,'title')"
      ></app-input-card>

      <app-input-card class="myinput_card_area myinput_card"
        ref="description"
        :title="'详细说明'"
        :placeholder="'如：发生时间、事情经过、当前进展、投诉诉求等<br>注意：此处请勿填写身份证、手机号等个人信息'"
        :required="true"
        :count="800"
        :type="1"
        :error="description.status"
         @getValue="(value)=>setValue(value,'description')"
      ></app-input-card>

      <app-check-box
        :txt="'匿名投诉，勾选后投诉页将不显示您的澎湃昵称'"
        @getCheckStatus="(status)=>setCheckbox(status,'anonymous')"
      ></app-check-box>

      <div class="input" :class="{error:contactInformation.status}">
         <div class="input_label">联系方式<span class="input_required"></span></div>
         <input placeholder="手机号，仅用于信息核对" type="number" v-model.number="contactInformation.value"
         @input="contactInformationInput"
         @focus="contactInformationFocus"
         @blur="contactInformationBlur">
      </div>

      <app-check-box
        :defaultValue="1"
        :txt="'同意将投诉内容、联系方式提供给投诉对象，用于信息核对'"
        @getCheckStatus="(status)=>setCheckbox(status,'verify')"
      ></app-check-box>

      <div @click="showValues" class="submit_btn" :class="{unable:!submitBtnStatus}">提交</div>

      <div class="txt_logo">澎湃质量报告</div>

      <div class="mypopup half" ref="myhalfpopup" :class="{show:categoryShow}" @click="setCategoryPanel">
        <app-select-panel
          ref="categoryPanel"
          @btn1="setCategoryPanel"
          @btn2="getSelectCategory"
          :itemList="categoryList"
          propertyTxt="categoryName"
          propertyId="categoryId"
        ></app-select-panel>
      </div>
    </div>
  </div>
</template>
<script>
import msgAlert from '@/util/message'
import AppInputCard from './AppInputCard'
import AppCheckBox from './AppCheckBox'
import AppSelectPanel from './AppSelectPanel'
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

export default {
  name: 'TheReplyPanel',
  props: {
    categoryList: Array
  },
  data () {
    return {
      uid: '', // 用户或者问政号ID
      userType: -1, // 0:湃客 1:媒体 2:问政 3:普通用户
      title: { // 投诉标题
        value: '',
        status: false
      },
      complaintObject: { // 投诉对象
        value: '',
        status: false
      },
      description: { // 投诉的详细说明
        value: '',
        status: false
      },
      category: { // 投诉分类
        value: '',
        id: '',
        status: false
      },
      contactInformation: { // 联系方式
        value: '',
        status: false
      },
      fenlei: '请选择',
      anonymous: 0, // 是否匿名显示 0:否 1:是
      verify: 1, // 是否同意向被投诉方核对 0:否 1:是
      categoryShow: false, // 分类面板控制
      isSubmit: false // 正在提交
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
    AppInputCard, AppSelectPanel, AppCheckBox
  },
  mounted () {
    let dom = this.$refs.myPage
    let myhalfpopupdom = this.$refs.myhalfpopup
    let panelHeight = getStyle(dom, 'height')
    window.addEventListener('resize', () => {
      // dom.style.height = panelHeight;
      myhalfpopupdom.style.height = panelHeight
    })
  },
  methods: {
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
    resetValue () {
      this.$refs.complaintObject.clearValue()
      this.$refs.title.clearValue()
      this.$refs.description.clearValue()
      this.$refs.categoryPanel.clearValue()
      this.clearCategory()
      this.contactInformation = {
        value: '',
        status: false
      }
      UCBlurDeal()
    },
    clearCategory () {
      this.category.status = false
      this.category.value = ''
      this.category.id = ''
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
    setCategoryPanel () { // 取消 表单父组件值赋给选框子组件
      this.$refs.categoryPanel.selectItem({
        categoryName: this.category.value,
        categoryId: this.category.id
      })
      this.categoryShow = false
    },
    showCategoryPanel () {
      this.categoryShow = true
    },
    goback () {
      this.$emit('close')
    },
    checkValue () {
      let result = true
      const checkList = ['title', 'complaintObject', 'description', 'contactInformation', 'category']
      checkList.forEach((item) => {
        if (this[item].value == '') {
          // this[item].status = true;
          result = false
        }
      })
      return result
    },
    showValues () {
      if (this.submitBtnStatus) {
        this.sendSubmit()
      }
    },
    sendSubmit () {
      if (this.isSubmit) {
        return
      }
      // 校验手机
      if (!(/^1[3-8]\d{9}$/.test(this.contactInformation.value))) {
        this.contactInformation.status = true
        msgAlert('请输入正确的手机号')
        return false
      }
      let url = '/wap/consumerComplaintSubmit.msp'
      this.isSubmit = true
      loading.show()

      var formData = new FormData()
      formData.append('categoryId', this.category.id)
      formData.append('title', this.title.value)
      formData.append('complaintObject', this.complaintObject.value)
      formData.append('description', this.description.value)
      formData.append('anonymous', this.anonymous)
      formData.append('verify', this.verify)
      formData.append('contactInformation', this.contactInformation.value)
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
    }
  }
}
</script>
<style lang="scss">
  .mypopup_header{
    width:100%;
    height:0.96rem;
    background:rgba(255,255,255,1);
    border-bottom: 1px solid #f1f1f1;
    .close{
      position: absolute;
      top:0.28rem;
      left:0.3rem;
      color:#333;
      font-size:0.28rem;
    }
    .title{
      text-align: center;
      font-size: 0.32rem;
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
      font-size: 0.28rem;
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
        background:url(~@/assets/consumers_complaint/tri_right.png) no-repeat ;
        background-size:100%;
        display:block;
        float:right;
      }
      &.error{
        border:1px solid #D0021B;
      }
      input{
        border: 0;
        font-size: 0.28rem;
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
    width: 6.90rem;
    height: .80rem;
    background: linear-gradient(315deg, #08f 0%, #00c5ff 100%);
    border-radius: 0.06rem;
    color: #fff;
    text-align: center;
    line-height: 0.8rem;
    font-size: 0.30rem;
    margin: 0 auto;
    margin-top: 0.37rem;
    margin-bottom: 1.37rem;
    &.unable{
     opacity: 0.5;
    }
  }
  .mypopup.half{
    background: rgba(19,19,19,0.5);
    top: inherit;
    bottom: 0;
  }
  .txt_logo{
    position: absolute;
    top:-9999px;
    left:-9999px;
  }

</style>
