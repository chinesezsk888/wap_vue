<template>
  <div class="mypage epidemic_situation" >
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
      infinite-scroll-distance="400"
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
        <div class="btn" @click="goGovPage">进入政务</div>
        <div class="btn complaint_btn" @click="showReply">我要建言</div>
      </div>
    </div>
    <div class="mypopup" :class="{show:mypopupShow}" ref="myPopup">
      <the-reply-panel
        @close="popupClose"
        :categoryList="categoryListForFrom"
      ></the-reply-panel>
    </div>
  </div>

</template>
<script>
import infiniteScroll from 'vue-infinite-scroll'
import CardItem from './components/home_page/CardItem'
import AppNav from './components/AppNav'
import TheReplyPanel from './components/reply_page/ReplyPanel'
import { getUrlKey } from '@/util/common.js'
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
      categoryListForFrom: [], // 去除类似全部的分类信息
      contList: [],
      mypopupShow: false,
      nextUrl: '-1',
      scroll_busy: false,
      scrollTop: 0, // 滚动距离 用来判断是上滑还是下滑
      defaultSelectId: '0'
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
    // 处理软键盘挤压页面变形，之后即使软键盘小时页面也不会回复
    /*
    let mypopup = this.$refs.myPopup
    let panelHeight = window.screen.height;
    window.addEventListener('resize',() => {
      mypopup.style.height = panelHeight+"px";
    });
    */
  },
  updated () {
    this.scroll_busy = false
  },
  methods: {
    changeLanmu (categoryId) {
      this.contList = []
      this.nextUrl = '-1'
      let url = apiUrl + '?categoryId=' + categoryId
      this.limitScroll(false)
      this.getPageData(url)
    },
    goGovPage () {
      // if (this.AppStyle == 0) {
      //   this.mywindow.location = govPageHref
      // } else {
      //   sendH5APP('22|' + govPageId)
      // }
      this.mywindow.location = govPageHref
    },
    showReply () {
      if (this.mywindow.$('#isLogin').val() == 'false') { // 走wap登录流程
        this.mywindow.lgwdsshow()
      } else {
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
        this.categoryList = resData.categoryList
        this.categoryListForFrom = resData.categoryList.slice(1) // 获取表单提交的分类
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
  }

}
</script>
<style lang="scss">
  body{background:#f3f4f6}
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
    background: #F3F4F6;
    margin-top:3.7rem;
  }
  .myfooter{
    position: fixed;
    bottom:0;
    height:1.8rem;
    width: 100%;
    max-width: 7.50rem;
    background:linear-gradient(180deg,rgba(255,255,255,0) 0%,rgba(255,255,255,1) 100%);
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
    transition: all 0.3s;
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
      height:2.8rem;
      position: relative;
      background: url("~@/assets/epidemic_situation/epidemic_situation_banner.png") no-repeat;
      background-size: 100%;
      background-size: 100%;
      background-size: contain;
      background-position: center;
      background-color: #181738;
    }
    .btns{
      height: 1.38rem;
      text-align: center;
      width: 100%;
      position: absolute;
      bottom: 0;
    }
    .btn{
      cursor: pointer;
      width:2.20rem;
      height:0.70rem;
      line-height: 0.70rem;
      line-height: calc(0.70rem - 1px);
      display:inline-block;
      font-size:0.32rem;
      color:#333;
      background:rgba(255,255,255,1);
      box-shadow:0px 0px 0.20rem 0px rgba(233,239,245,1);
      border-radius:0.36rem;
      border:1px solid rgba(0,165,235,1);
    }
    .complaint_btn{
      cursor: pointer;
      margin-left:1.1rem;
      color:#fff;
      background:linear-gradient(315deg,rgba(0,136,255,1) 0%,rgba(0,197,255,1) 100%);
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
