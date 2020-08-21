<template>
    <div :class="{ commenpagebg :userInfo.userType >= '3'}" >
        <div class="vue_loading" v-show="isLoading"></div>
        <!-- 非普通用户头部 -->
        <div class="consumer header_card" v-if="userInfo.userType <= 2 ">
            <div class="card_top">
                <div class="ct_left">
                    <div class="header_protrait" v-if="userInfo.facePic && userInfo.facePic!=''">
                        <img :src="userInfo.facePic" @click="showImg(userInfo.facePic)">
                        <div class="hp_renzheng_icon" v-if="userInfo.isAuth=='1'"></div>
                    </div>
                </div>
                <div class="cl_right">
                    <div class="cr_box">
                        <div class="cb_info">
                            <p class="own">{{userInfo.sname | showUserName}}</p>
                            <p class="cr_zw">{{userInfo.userLable}}</p>
                        </div>
                        <a class="follow" :id="'vuemoblink_'+userInfo.userId+(Math.floor(Math.random() * 100))"
                          v-if="userInfo.userId!=''"
                          :data-moblink="'demo/a?contType=31&contId='+userInfo.userId+'&optType='+userInfo.userType" moblink-featured>通过APP关注</a>
                    </div>
                    <p class="organiza">{{userInfo.authInfo}}</p>
                </div>
            </div>
            <div class="card_message" v-if="userInfo.powerNum != undefined && userInfo.powerNum !='' || userInfo.area != undefined && userInfo.area !='' ||userInfo.matrixList && userInfo.matrixList.length>=1">
                <div class="cpi" v-if="userInfo.powerNum != undefined && userInfo.powerNum !='' || userInfo.area != undefined && userInfo.area !='' ">
                    <div class="cpi_icon" v-if="userInfo.powerNum != undefined && userInfo.powerNum !=''">
                    </div>
                    <span class="cpi_type" v-if="userInfo.powerNum != undefined && userInfo.powerNum !=''">{{userInfo.userLable}}指数：<span
                            class="cpi_num">{{userInfo.powerNum}}</span>
                    </span>
                    <div class="sex" v-if="userInfo.gender != ''">
                        <div class="sex_img_w" v-if="userInfo.gender == '女'">
                        </div>
                        <div class="sex_img_n" v-if="userInfo.gender == '男'">
                        </div>
                        <span>{{userInfo.gender}}</span>
                    </div>
                    <div class="location" v-if="userInfo.area != undefined && userInfo.area !=''">
                        <div class="location_img"></div>
                        <span>{{userInfo.area}}</span>
                    </div>
                </div>
                <a class="more_icon"
                v-if="userInfo.matrixList && userInfo.matrixList.length>=1"
                 :href="'pph_matrix.jsp?govId='+userInfo.userId"
                >
                    <span>矩阵</span>
                    <div class="imgbox">
                        <div class="specia_img" v-for="govMatrix in userInfo.matrixList" :key="govMatrix.userId">
                            <img :src="govMatrix.facePic">
                        </div>
                    </div>
                </a>
            </div>
            <div :class="showbg"></div>
            <div class="card_word">{{userInfo.desc}}</div>
        </div>
        <!-- 普通用户头部 -->
        <div class="nullsconsumer" :class="{header_card:userInfo.isAuth == '0',other_header_card:userInfo.isAuth == '1'}" v-if="userInfo.userType == 3">
            <div class="card_top">
                <div class="ct_left">
                    <div class="header_protrait">
                        <img :src="userInfo.facePic" @click="showImg(userInfo.facePic)">
                        <div class="hp_renzheng_icon" v-if="userInfo.isAuth == '1'"></div>
                    </div>
                    <div class="cl_right" v-if="userInfo.isAuth == '1'">
                        <p class="own">{{userInfo.sname | showUserName}}</p>
                        <p class="organiza">{{userInfo.authInfo}}</p>
                    </div>
                    <span class="own" v-else>{{userInfo.sname | showUserName}}</span>
                </div>
                <a class="follow" :id="'vuemoblink_'+userInfo.userId" moblink-featured
                    v-if="userInfo.userId!=''"
                    :data-moblink="'demo/a?contType=31&contId='+userInfo.userId+'&optType='+userInfo.userType">
                    通过APP关注
                </a>
            </div>
            <div class="card_message">
                <div class="sex" v-if="userInfo.gender != ''">
                    <div class="sex_img_w" v-if="userInfo.gender == '女'">
                    </div>
                    <div class="sex_img_n" v-if="userInfo.gender == '男'">
                    </div>
                    <span>{{userInfo.gender}}</span>
                </div>
                <div class="location" v-if="userInfo.area !='' && userInfo.area.length >0">
                    <div class="location_img">
                    </div>
                    <span>{{userInfo.area}}</span>
                </div>
            </div>
            <div class="card_word"
                v-if="userInfo.desc != undefined && userInfo.desc != ''">
                {{userInfo.desc}}
            </div>
            <!-- 浮动卡片 -->
            <div class="card_info float_card" v-if="userInfo.userType == '3'">
                <ul class="card_ul">
                    <li>
                        <div class="info">
                            <p class="info_number">{{userInfo.followNum | isShowNum}}</p>
                            <p class="info_type">关注</p>
                        </div>
                    </li>
                    <li class="info_icon"></li>
                    <li>
                        <div class="info">
                            <p class="info_number">{{userInfo.fansNum | isShowNum}}</p>
                            <p class="info_type">粉丝</p>
                        </div>
                    </li>
                    <li class="info_icon"></li>
                    <li>
                        <div class="info">
                            <p class="info_number">{{userInfo.praiseTimes | isShowNum }}</p>
                            <p class="info_type">获赞</p>
                        </div>

                    </li>
                </ul>
            </div>
        </div>


        <!-- 卡片部分 -->
        <div class="nomargin" :class="{own_main:userInfo.userType<=2,own_comment:userInfo.userType>=3 }"
          v-infinite-scroll="loadMore"
          infinite-scroll-disabled="scroll_busy"
          infinite-scroll-distance="400"
          ref="body"
          >
            <!-- 为空 -->
            <div class="om_enpty" v-if="isShowEnpty">
                <img src="../img/pyq_enpty.png">
                <p v-if="userInfo.userId!=''">没有发表任何内容</p>
                <p v-else>该账号已注销</p>
            </div>
            <div class="om_commen_card_box" v-show="contList && contList !=''" v-for="item in contList"
                :key="item.contId">
                <!-- 非普通用户卡片（文章卡片） -->
                <Article :item="item"></Article>
                <PyqCard :item="item" @showImg="SwiperImgShow" :showZanDate="true"></PyqCard>
            </div>
        </div>
        <div class="status_panel" id="listEnd" v-show="nextUrl==''&&!isLoading">
          <span class="status_panel_txt">到底了</span>
        </div>
        <div class="newspath" v-show="nextUrl!='' && pageIndex <= 5 && !isLoading"></div>
        <a class="moblink_btn-690 more_moblink" id="vuemoblink_list" :data-moblink="'demo/a?contType=31&contId='+userInfo.userId" moblink-featured v-show="pageIndex>5">更多详情，下载澎湃新闻APP</a>
        <SwiperImg :imgList="winImgArray" :index="winImgIndex" :class="{show:winImgflag}"  @close="SwiperImgClose"></SwiperImg>

    </div>
</template>

<script>
import infiniteScroll from 'vue-infinite-scroll'
import PyqCard from '@/components/PyqCard'
import SwiperImg from '@/components/SwiperImg'
import Article from './components/Article'
export default {
  name: 'app',
  data () {
    return {
      userInfo: '',
      userType: '',
      shareInfo: '',
      contList: [],
      nextUrl: '',
      owntype: '',
      ownid: '',
      isShowEnpty: false,
      winImgArray: [], // 图片预览集合
      winImgIndex: '-1',
      winImgUrl: '',
      winImgflag: false, // 图片播放控件显示隐藏
      isLoading: true,
      isPraise: false,
      pageIndex: 0,
      scroll_busy: false
    }
  },
  directives: { infiniteScroll },
  computed: {
    showbg: function () {
      if (this.userType == '0') {
        return 'bg_img_paike'
      } else if (this.userType == '1') {
        return 'bg_img_meiti'
      } else if (this.userType == '2') {
        return 'bg_img_zhengwu'
      } else {
        return ''
      }
    }
  },
  filters: {
    newDateil: function (id) {
      return 'newsDetail_forward_' + id
    },
    showSname: function (val) {
      if (val.length > 8) {
        var newVal = val.slice(0, 8) + '...'
        return newVal
      } else {
        return val
      }
    },
    isShowNum: function (num) {
      if (num == '' || num == '0') {
        return '0'
      } else {
        return num
      }
    },
    showUserName: function (val) {
      if (val.length > 10) {
        var newVal = val.slice(0, 9) + '...'
        return newVal
      } else {
        return val
      }
    },
    ishasUrl: function (url) {
      if (url == '' || typeof (url) == 'undefined') {
        return 'javascript:void(0)'
      } else {
        return url
      }
    }
  },
  components: {
    PyqCard, SwiperImg, Article
  },
  methods: {
    getImgIndex () {
      let result = -1
      for (let [key, value] of new Map(this.winImgArray.map((value, key) => [key, value]))) {
        if (value == this.winImgUrl) {
          result = key
        }
      }
      return result
    },
    SwiperImgShow (url, imageList) {
      this.winImgArray = this.getImageUrl(imageList)
      this.winImgUrl = url
      this.winImgIndex = this.getImgIndex()
      this.winImgflag = true
    },
    SwiperImgClose () {
      this.winImgUrl = ''
      this.winImgflag = false
    },
    getImageUrl (imageList) {
      let winImgArrayTemp = []
      if (imageList) {
        for (let j = 0; j < imageList.length; j++) {
          var img = imageList[j]
          if (img && img.url) {
            winImgArrayTemp.push(img.url)
          }
        }
      }
      return winImgArrayTemp
    },
    showImg (url) {
      this.mywindow.location.href = url
    },
    render (nextUrl) {
      this.ownid = this.mywindow.$('#uidValue').val()
      this.owntype = this.mywindow.$('#uidType').val()
      let url = ''
      if (nextUrl) {
        url = nextUrl
      } else {
        url = 'userDynamicList.jsp'
        // url+= "?uid=98018&userType=0"
        url += '?utype=' + this.owntype + '&uid=' + this.ownid
      }
      this.axios.get(url)
        .then(res => {
          this.pageIndex++
          this.isLoading = false
          this.addContList(res)
        })
        .catch((err) => {
          console.log(err)
        })
    },
    addContList: function (res) {
      let resp = res.data
      if (this.nextUrl === '') {
        // 第一页
        let headMobString = 'demo/a?contType=31&contId=' + resp.userInfo.userId + '&optType=' + resp.userInfo.userType
        this.mywindow.initHeaderMob(headMobString)
        this.userInfo = resp.userInfo
        this.userType = resp.userInfo.userType
        this.shareInfo = resp.userInfo.shareInfo
        this.mywindow.goWxshare(this.shareInfo)
      }
      this.contList = this.contList.concat(resp.contList)
      this.nextUrl = resp.nextUrl
      if (!this.contList || this.contList == undefined || this.contList == '') {
        this.isShowEnpty = true
      }
    },
    loadMore () {
      if (this.nextUrl === '' || this.pageIndex > 5) {
        return
      }
      this.scroll_busy = true
      this.render(this.nextUrl)
    }
  },
  created () {
    this.render()
  },
  updated () {
    this.scroll_busy = false
    this.mywindow.initHeadPanel({
      contType: 31,
      contId: this.userInfo.userId + '&optType=' + this.userInfo.userType
    })
    this.mywindow.baseMobLinkInit("a[id^='moblink']")
    this.mywindow.vueMoblinkInit()
  }
}
</script>
