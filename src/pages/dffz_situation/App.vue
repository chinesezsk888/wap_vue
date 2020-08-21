<template>
  <div class="mypage epidemic_situation">
    <div class="myheader">
      <div class="banner" ref="banner"></div>
      <!--nav -->
      <app-nav
        :itemList="categoryList"
        propertyId="categoryId"
        propertyTxt="categoryName"
        @showPanel="limitScroll"
        @selectNav="changeLanmu"
        :defaultSelectId="defaultSelectId"
      ></app-nav>
    </div>

    <div class="mybody"
      v-infinite-scroll="loadMore"
      infinite-scroll-disabled="scroll_busy"
      infinite-scroll-distance="200"
      ref="body"
    >
      <!--列表 -->
      <card-item :item="item" v-for="item in contList" :key="item.id"></card-item>
      <template v-if="emptypanel">
        <div class="epidemic_situation_empty">
          <div class="empty_img"></div>
          <div class="txt">没有发表任何内容</div>
        </div>
      </template>
    </div>
    <div class="myfooter">
      <div class="btns">
        <div class="btn" @click="goGovPage"></div>
        <div class="btn complaint_btn" @click="btn_type=!btn_type" ref="complaintBtn"></div>
      </div>
      <ul class="btn_type" :class="{'show':btn_type}">
        <li @click="showReply(1)">建言</li>
        <li @click="showReply(2)">咨询</li>
        <li @click="showReply(3)">投诉</li>
        <li @click="showReply(4)">求助</li>
        <li @click="showReply(5)">感谢</li>
      </ul>
    </div>
    <div class="mypopup" :class="{show:mypopupShow}" ref="myPopup">
      <the-reply-panel
        @close="popupClose"
        :categoryList="categoryListForFrom"
        :cityList="categoryCityList"
        :interactionClassifyId="interactionClassifyId"
      ></the-reply-panel>
    </div>
  </div>

</template>
<script>
import infiniteScroll from 'vue-infinite-scroll'
import CardItem from './components/home_page/CardItem'
import AppNav from './components/AppNav'
import TheReplyPanel from './components/reply_page/ReplyPanel'
import { sendH5APP, getUrlKey } from '@/util/common.js'
import loading from '@/util/loading'
import msgAlert from '@/util/message'
import {
  apiUrl, govPageHref
} from './config.js'

export default {
  name: 'app',
  data () {
    return {
      resultCode: 0,
      emptypanel: false,
      categoryList: [],
      categoryCityList: [], // 去除类似全部的城市分类信息
      categoryListForFrom: [], // 留言领域的分类信息
      contList: [],
      mypopupShow: false,
      nextUrl: '-1',
      scroll_busy: false,
      scrollTop: 0, // 滚动距离 用来判断是上滑还是下滑
      defaultSelectId: '0',
      btn_type: false, // 按钮列表隐藏,
      interactionClassifyId: '' // 建言分类id
    }
  },
  components: {
    CardItem, AppNav, TheReplyPanel
  },
  directives: { infiniteScroll },
  created () {
    let categoryId = getUrlKey('categoryId')
    if (categoryId && categoryId != '') {
      this.defaultSelectId = categoryId
      this.changeLanmu(categoryId)
    } else {
      this.getPageData()
    }
  },
  mounted () {
    let _this = this
    document.addEventListener('click', function (e) {
      if (_this.$refs.complaintBtn.contains(e.target)) return
      _this.btn_type = false
    })
    _this.mywindow.addEventListener('scroll', function () {
      let scrollNum = document.documentElement.scrollTop || document.body.scrollTop
      if (scrollNum) {
        _this.btn_type = false
      }
    })
  },
  updated () {
    this.scroll_busy = false
  },
  methods: {
    changeLanmu (categoryId) {
      this.contList = []
      this.nextUrl = '-1'
      let url = apiUrl + '&categoryId=' + categoryId
      this.limitScroll(false)
      this.getPageData(url)
    },
    goGovPage () {
      if (this.AppStyle == 0) {
        this.mywindow.location = govPageHref
      } else {
        sendH5APP('51|-14')
      }
    },
    showReply (num) {
      if (this.mywindow.$('#isLogin').val() == 'false') { // 走wap登录流程
        this.mywindow.lgwdsshow()
      } else {
        if (num == 2) {
          this.interactionClassifyId = '2'
        } else if (num == 3) {
          this.interactionClassifyId = '3'
        } else if (num == 4) {
          this.interactionClassifyId = '4'
        } else if (num == 5) {
          this.interactionClassifyId = '5'
        } else {
          this.interactionClassifyId = '1'
        }
        this.limitScroll(true)
        this.mypopupShow = true
      }
    },
    limitScroll (status) {
      if (status) { // 禁止页面滚动
        this.scrollTop = document.documentElement.scrollTop + document.body.scrollTop
        document.body.style.height = window.screen.height + 'px'
        document.body.style.overflow = 'hidden'
      } else { // 开启页面滚动
        document.body.style.height = 'auto'
        document.body.style.overflow = 'auto'
        document.documentElement.scrollTop = this.scrollTop
        document.body.scrollTop = this.scrollTop
      }
    },
    popupClose () {
      this.limitScroll(false)
      this.mypopupShow = false
    },
    addData (resData) {
      if (resData.categoryList) {
        this.categoryList = resData.categoryList // 城市
        this.categoryCityList = resData.categoryList.slice(1) // 城市分类
      }
      if (resData.messagesDomainList) {
        this.categoryListForFrom = resData.messagesDomainList // 留言领域
      }
      if (resData.contList) {
        this.contList = this.contList.concat(resData.contList)
      }
      if (this.contList.length == 0) {
        this.emptypanel = true
      } else {
        this.emptypanel = false
      }
      this.nextUrl = resData.nextUrl
      loading.hide()
    },
    getPageData (url = apiUrl) {
      loading.show()
      this.axios.get(url)
        .then(res => {
          this.addData(res.data)
        })
        .catch(() => {
          loading.hide()
          msgAlert('请稍后重试')
        })
    },
    loadMore () {
      if (this.nextUrl == '-1') {
        return
      }
      if (this.nextUrl == '') {
        msgAlert('已经到底')
        return
      }
      this.scroll_busy = true
      this.getPageData(this.nextUrl)
    }
    // CommentHandle (msg) {
    //   // msgAlert(msg)
    //   // this.getPageData()
    //   console.log('')
    // }
  }

}
</script>
<style lang="scss">
  body{background:#f8f9f9}
/**vue通用样式**/
  .my_msg{font-size:.3rem;color:#fff;background:rgba(0,0,0,.5);border-radius:.06rem;position:fixed;bottom:3.6rem;padding:.03rem .1rem;left:50%;-webkit-transform:translate(-50%);transform:translate(-50%);z-index:10000}
  .fade-enter-active,.fade-leave-active{-webkit-transition:opacity .3s;transition:opacity .3s}.fade-enter,.fade-leave-to{opacity:0}
/****/
  .myheader{
    width:100%;
    max-width: 7.50rem;
    position: fixed;
    top:0;
    background: #fff;
    z-index: 10;
  }
  .mypage{
    width: 100%;
    max-width: 7.50rem;
    overflow: hidden;
    height: 100%;
  }
  .mybody{
    width: 100%;
    max-width: 7.50rem;
    padding-bottom: 1rem;
    background: #f8f9f9;
    margin-top:2.7rem;
  }
  .myfooter{
    position: fixed;
    bottom:0;
    height:2rem;
    width: 100%;
    max-width: 7.50rem;
    background:linear-gradient(180deg,rgba(255,255,255,0) 0%,rgba(255,255,255,1) 100%);
    .btn_type{
      position: absolute;
      width: 2.24rem;
      height: 0;
      background: rgba(255,255,255,1);
      box-shadow: 0px 0px 0.20rem 0px rgba(233,239,245,1);
      border-radius: 0.08rem 0.08rem 0px 0px;
      left: 50%;
      margin-left: 0.5rem;
      top: 1rem;
      z-index: -10;
      transition: all 0.4s;
      overflow: hidden;
      &.show{
        height: 4.00rem;
        top: -3.1rem;
      }
      li{
        padding:0.16rem;
        text-align: center;
        font-size:0.28rem;
        border-bottom:1px solid #f0f0f0;
      }
      li:last-child{
        border:none;
      }
    }
  }
  .mypopup{
    position: fixed;
    top: 0;
    left: 50%;
    width: 100%;
    max-width: 7.50rem;
    height: 100%;
    overflow: hidden;
    transform: translate3d(0, 100%, 0) translate(-50%);
    background: #fff;
    // transition: all 0.3s;
    opacity: 0;
    z-index: 9999;
    &.show{
        transform: translate3d(0, 0, 0) translate(-50%);
        opacity: 1;
    }
  }
  .epidemic_situation{
    max-width: 7.50rem;
    margin:0 auto;
    .banner{
      width:100%;
      height:1.8rem;
      position: relative;
      background: url("~@/assets/dffz_situation/dffz_situation_banner.png") no-repeat;
      background-size: 100%;
      background-size: 100%;
      background-size: contain;
      background-position: center;
      background-color: #181738;
    }
    .btns{
      height: 1.55rem;
      text-align: center;
      width: 100%;
      position: absolute;
      bottom: 0;
    }
    .btn{
      cursor: pointer;
      width:2.24rem;
      height:0.72rem;
      line-height: 0.72rem;
      line-height: calc(0.72rem - 2px);
      display:inline-block;
      background: url(~@/assets/dffz_situation/btn_gozw.png) no-repeat;
      background-size: 100%;
      box-shadow:0px 0px 0.20rem 0px rgba(233,239,245,1);
      border-radius:0.08rem;
    }
    .complaint_btn{
      cursor: pointer;
      margin-left: 1.02rem;
      color: #fff;
      background: url(~@/assets/dffz_situation/btn_jianyan.png) no-repeat;
      background-size: 100%;
      border: none;
      line-height: 0.72rem;
    }
  }
  .epidemic_situation_empty{
    text-align:center;
    padding: 3rem 0 1.79rem;
    .empty_img{
      width: 2.83rem;
      height: 2.50rem;
      margin: 0 auto;
      margin-bottom:0.32rem;
      background: url(//file.thepaper.cn/wap/v3/img/pyqcomment_empty.png) no-repeat;
      background-size: 100%;
    }
    .txt{
      font-size:0.30rem;
      color:#C8C8C8;
      margin-bottom:0.27rem;
    }
  }
</style>
