<template>
  <div class="topic_home" v-cloak>
    <div class="vue_loading" v-show="isLoading"></div>
    <div class="topic_home_error" v-if="resultCode == 5">
            该专题已经下线
            <a href="//m.thepaper.cn" class="btn">去首页转转</a>
        </div>
    <template v-if="resultCode == 1">
            <div class="topic_home_header">
        <div class="infor_img">
          <img :src="specialInfo.pic">
          <span v-if="specialInfo.name">{{specialInfo.name | langName(32)}}</span>
                </div>
                <div class="infor" v-if="specialInfo.desc">
          <div class="label">
            导读
            <a v-if="specialInfo.moblinkId == 3" class="infor_moblink" id="vuemoblink_infor" :data-moblink="'demo/a?contType='+specialInfo.moblinkId+'&contId='+specialInfo.contId" moblink-featured>打开APP关注<span class="icon_tri"></span></a>
          </div>
                    <div class="description">{{specialInfo.desc}}</div>
                </div>
                <div class="topic_header_swiper" v-if="headLineData.length>0">
                    <div class="th_swpier_container swiper-container">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide "  v-for="contItem in headLineData" :key="contItem.contId">
                                <a :href="'newsDetail_forward_'+contItem.contId">
                                    <img :src="contItem.pic" class="th_swpier_img">
                                    <div class="th_swpier_title"><span>{{contItem.name}}</span></div>
                                    <water-mark :item="contItem" />
                                </a>
                            </div>
                        </div>
                        <div class="swiper-pagination"></div>
                    </div>
                </div>
                <div class="more_topic_label" v-if="relateSpecial.length > 0">
                    <span class="icon"></span>其他专题
                </div>
                <div class="more_topic_list" v-if="relateSpecial.length == 1">
                    <a class="more_topic_item"  :href="'newsDetail_forward_'+relateSpecial[0].forwordNodeId" >
                        <div class="title">
                           {{relateSpecial[0].name | langName(40)}}
                        </div>
                    </a>
                </div>
                <div class="more_topic_list clearfix" v-if="relateSpecial.length > 1">
                    <a class="more_topic_items" :href="'newsDetail_forward_'+item.forwordNodeId" :class="'more_topic_item'+(index%4+1)" v-for="(item,index) in relateSpecial" :key="item.forwordNodeId">
                        <div class="title">{{item.name | langName(24)}}</div>
                    </a>
                </div>
            </div>
            <div class="topic_main">
        <div class="topic_nav" :class="{'fixed':isNavFixed}">
                    <div class="topic_nav_swpier">
                        <div class="nav_swpier_container swiper-container">
                            <div class="swiper-wrapper">
                <div class="swiper-slide"
                  v-for="item in nodeInfo"
                  :key="item.id"
                  :id="item.id"
                  :class="{on:item.id == navCurrent}" @click="selectNode(item.id)">{{item.name}}</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="topic_list" :data-nodeid="nodeItem.nodeId"  v-for="nodeItem in childNodeList" :key="nodeItem.nodeId">
                    <template v-if="nodeItem.dataType!='4' && nodeItem.dataType!='5'">
              <a class="topic_title">
                {{nodeItem.name}}
                    </a>
              <div class="topic_item" :key="contItem.contId" :class="{topic_item_big:contItem.imgCardMode==2}"   v-for="contItem in nodeItem.contList">
                        <a class="topic_item_author" :href="contItem.authorInfo.link" v-if="contItem.nodeInfo&&contItem.nodeInfo.nodeType==1">
                            <div class="thum"><img :src="contItem.authorInfo.pic"><span class="icon_vip" v-if="contItem.authorInfo.isAuth == '1'"></span></div>{{contItem.authorInfo.name}}
                        </a>
                        <list-item :contItem="contItem"></list-item>
                                    </div>
              <a v-if="nodeItem.hasMore == 1" class="moblink_btn-650-white" :id="'vuemoblink_list'+nodeItem.nodeId" :data-moblink="'demo/a?contType='+specialInfo.moblinkId+'&contId='+specialInfo.contId" moblink-featured>打开APP查看全部{{nodeItem.name | langName(14) }}</a>
                    </template>
                </div>
            </div>
    </template>
    </div>
</template>
<script>
import WaterMark from '@/components/WaterMark'
import ListItem from '@/components/ListItem'
import { apiUrl } from './config.js'
export default {
  name: 'app',
  data () {
    return {
      isLoading: true,
      resultCode: -0,
      isNavFixed: false,
      navCurrent: 0, // 栏口默认选中
      relateSpecial: {}, // 其他专题
      childNodeList: {}, // 栏口
      specialInfo: {}, // 头部信息
      headLineData: [],
      navSwiper: null,
      nodeInfo: [] // 栏口信息
    }
  },
  components: {
    WaterMark,
    ListItem
  },
  filters: {
    langName (value, length) { // 字数超出
      if (value.length > length) {
        value = value.substr(0, (length - 1)) + '...'
      }
      return value
    }
  },
  watch: {
    navCurrent () {
      var navSlide = this.mywindow.$('.nav_swpier_container .swiper-slide')
      var swiperFatherWidth = this.mywindow.$('.nav_swpier_container .swiper-wrapper').outerWidth()
      var slideMargin = parseInt(navSlide.eq(0).css('margin-right'))
      var totalWidth = 0
      for (var i = 0; i < navSlide.length; i++) {
        totalWidth = totalWidth + navSlide.eq(i).outerWidth() + slideMargin
        if (navSlide.eq(i).attr('id') == this.navCurrent) {
          break
        }
      }
      if (totalWidth > swiperFatherWidth) {
        this.navSwiper && this.navSwiper.setWrapperTranslate(swiperFatherWidth - totalWidth)
      } else {
        this.navSwiper && this.navSwiper.setWrapperTranslate(0)
      }
    }
  },
  updated () {

  },
  created () {
    this.getPageData()
  },
  mounted () {
  },
  methods: {
    setNavfixed (flag) { // 栏口导航fixed
      if (flag) {
        this.isNavFixed = true
        var navHeight = this.mywindow.$('.topic_nav').height()
        this.mywindow.$('.topic_main').css('paddingTop', navHeight)
      } else {
        this.isNavFixed = false
        this.mywindow.$('.topic_main').css('paddingTop', 0)
      }
    },
    getHeadlineData (data) {
      var result = []
      for (var i = 0; i < data.length; i++) {
        if (data[i].dataType == 5) {
          result = data[i].contList
          break
        }
      }
      return result
    },
    getNodeInfo (data) {
      var result = []
      for (var i = 0; i < data.length; i++) {
        if (data[i].dataType == 5) {
          continue
        }
        result.push({
          id: data[i].nodeId,
          name: data[i].name
        })
      }
      return result
    },
    setPageData (res) {
      this.isLoading = false
      this.resultCode = res.resultCode
      if (this.resultCode != '5') {
        this.relateSpecial = res.relateSpecial
        this.childNodeList = res.childNodeList
        this.specialInfo = res.specialInfo
        this.headLineData = this.getHeadlineData(res.childNodeList)
        this.nodeInfo = this.getNodeInfo(res.childNodeList)
        this.navCurrent = this.nodeInfo[0].id
        this.$nextTick(() => {
          // 滚动
          var that = this
          var originNavTop = that.mywindow.$('.topic_nav').offset().top
          window.onscroll = function (e) {
            var scrolltop = document.documentElement.scrollTop || document.body.scrollTop
            var headerHeight = that.mywindow.$('header').height() // 头部固定高度
            // 栏口导航fixed
            that.setNavfixed(originNavTop - scrolltop - headerHeight <= 0)
            // 内容与选中栏口切换
            var nodeList = that.mywindow.$('.topic_list')
            for (var i = 0; i < nodeList.length; i++) {
              if (nodeList.eq(i).offset().top - scrolltop < 300) {
                that.navCurrent = nodeList.eq(i).data('nodeid')
              }
            }
          }
          this.navSwiper = this.mywindow.createSwiper()
          this.mywindow.sendWxShare(this.specialInfo)
          this.mywindow.initHeadPanel({
            contType: this.specialInfo.moblinkId,
            contId: this.specialInfo.contId
          })
          this.mywindow.baseMobLinkInit("a[id^='moblink']")
          this.mywindow.vueMoblinkInit()
        })
      }
    },
    selectNode (nodeid) {
      var top = this.mywindow.$(".topic_list[data-nodeid='" + nodeid + "']").offset().top
      var headerHeight = this.mywindow.$('header').height()
      var navHeight = this.mywindow.$('.topic_nav').height()
      this.mywindow.$('html,body').animate({ scrollTop: top - headerHeight - navHeight - 20 }, 200)
    },
    getPageData (url = apiUrl) {
      var nodeId = this.mywindow.$('#nodeId').val()
      if (nodeId && nodeId != '') {
        url += '?c=' + nodeId
      }
      this.axios.get(url)
        .then(res => {
          this.setPageData(res.data)
        })
        .catch((err) => {
          console.log(err)
        })
    }
  }
}
</script>
