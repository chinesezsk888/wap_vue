<template>
  <div id="app">
    <div v-if="resultCode == 1">
      <div class="header">
        <div class="header_bg" @click="goTopNews">
          <img :src="specialInfo.pic">
        </div>
        <div class="top_bg"></div>
        <div class="date" :style="styleDate" @click="showCalendar">
          <div class="type1">{{dateInfo.year}}年{{dateInfo.month}}月</div>
          <div class="type2" v-if="dateInfo.festival==''">{{dateInfo.day}}</div>
          <div class="type2" v-else>{{dateInfo.day}}<i class="festival">{{dateInfo.festival}}</i></div>
          <div class="type3">{{dateInfo.lunarDate}}</div>
        </div>
        <div v-if="calendarData.resultCode==1">
          <zwpaper-calendar v-show='showCalendarStatus' :class="{show_calendar:showCalendarStatus}"
          :data="calendarData" :bgColor="gradationColor" :current='dateInfo' @close="closeCalendar"></zwpaper-calendar>
        </div>
        <div class="infor"  @click="goTopNews">
          <div class="infor_body">
            <div class="title">{{specialInfo.title}}</div>
            <div class="node_summary">{{specialInfo.nodeSummary}}</div>
            <span class="con_link" v-if="specialInfo.topContInfo">查看详情>></span>
            <div class="author">
              <i v-if="specialInfo.majorEditor">本期主编：{{specialInfo.majorEditor}}</i>
              <i v-if="specialInfo.responEditor">责编：{{specialInfo.responEditor}}</i>
            </div>
          </div>
        </div>
      </div>
      <zwpaper-bvideo :item="virtualAnchor" v-if="virtualAnchor.contId"></zwpaper-bvideo>

      <div v-for="(audioItem,index) in audioList" :key='index+"audio"'>
        <zwpaper-audio :url="audioItem.url" :title="audioItem.name" :duration="audioItem.duration"></zwpaper-audio>
      </div>

      <zwpaper-aditem :url="topAdUrl"></zwpaper-aditem>
      <div class="content">
        <div v-for="(conItem,index) in childNodeList" :key='index+"cildNode"' >
          <div class="h2_title">{{conItem.name}}</div>
          <div v-for="(item,index) in conItem.contList" :key='index+"zwperitem"' class="zwperitem">
            <zwpaper-item
            :title="item.name"
            :summary="item.summary"
            :img-url="item.pic"
            :img-count="item.imageNum"
            :link="item.href"
            :video="item.videos"
            ></zwpaper-item>
          </div>
        </div>
      </div>
      <zwpaper-aditem :url="bottomAdUrl"></zwpaper-aditem>
      <a href="javascript:void(0);" ref="moblinkZwpaper" id="moblink_zwpaper" class="zwpaper_gomob" moblink-featured>
        打开澎湃新闻APP 浏览往期早晚报
      </a>

    </div>
    <div v-if="resultCode == 5">
        <div class="error_page">{{resultMsg}}</div>
    </div>
  </div>
</template>

<script>
import zwpaperItem from './components/zwpaperItem.vue'
import zwpaperAudio from './components/zwpaperItemAudio.vue'
import zwpaperAditem from './components/zwpaperAditem.vue'
import zwpaperCalendar from './components/zwpaperCalendar.vue'
import zwpaperBvideo from './components/zwpaperBvideo.vue'
import { getUrlKey } from '@/util/common.js'

export default {
  name: 'app',
  components: {
    zwpaperItem,
    zwpaperAudio,
    zwpaperAditem,
    zwpaperCalendar,
    zwpaperBvideo
  },
  computed: {
    styleDate () {
      let startColor = this.gradationColor.startColor
      let endColor = this.gradationColor.endColor
      let fontColor = this.gradationColor.fontColor
      return {
        backgroundImage: 'linear-gradient(134deg, ' + startColor + ' 0%, ' + endColor + ' 100%)',
        color: fontColor
      }
    }
  },
  methods: {
    goTopNews () {
      if (this.specialInfo.topContInfo) {
        window.location.href = this.specialInfo.topContInfo.href
      }
    },
    closeCalendar () {
      setTimeout(() => {
        this.showCalendarStatus = false
      }, 800)
    },
    showCalendar () {
      this.showCalendarStatus = true
    },
    getPageData () {
      let n = getUrlKey('n')
      let status = getUrlKey('status')
      if (status == 1) {
        this.showCalendarStatus = true
      }
      let url = 'morningEveningNewsDetail.jsp'
      if (n && n != '') {
        url += '?n=' + n
      }
      this.axios.get(url)
        .then(res => {
          let resp = res.data
          this.resultCode = resp.resultCode
          this.resultContId = resp.resultContId
          this.resultMsg = resp.resultMsg
          this.specialInfo = resp.specialInfo
          this.dateInfo = resp.dateInfo
          this.gradationColor = resp.gradationColor
          this.audioList = resp.audioList
          this.childNodeList = resp.childNodeList
          this.topAdUrl = resp.topAdUrl
          this.bottomAdUrl = resp.bottomAdUrl
          this.virtualAnchor = resp.virtualAnchor
          this.mywindow.MobLink({
            el: '#moblink_zwpaper',
            path: 'demo/a',
            params: {
              contId: this.resultContId,
              contType: '42'
            }
          })
          this.mywindow.initHeadPanel({
            contType: 42,
            contId: this.resultContId
          })
          this.mywindow.baseMobLinkInit("a[id^='moblink']")
          this.mywindow.wxShare({
            title: this.specialInfo.shareTitle,
            desc: this.specialInfo.shareSummary,
            link: this.mywindow.location.href,
            img: this.specialInfo.sharePic
          })
          this.getCalendar(this.dateInfo.year + this.dateInfo.month)
        }).catch(() => {
          console.log('请稍后重试')
        })
    },
    getCalendar (yearMonth) {
      let url = 'morningEveningNewsCalendar.jsp?dateStr=' + yearMonth
      this.axios.get(url).then(res => {
        this.calendarData = res.data
      }).catch(() => {
        console.log('请稍后重试')
      })
    }
  },
  created () {
    this.getPageData()
  },
  data: function () {
    return {
      resultCode: '',
      resultMsg: '',
      resultContId: '1',
      specialInfo: {},
      dateInfo: {},
      gradationColor: {},
      audioList: [],
      childNodeList: [],
      topAdUrl: '',
      bottomAdUrl: '',
      calendarData: {},
      showCalendarStatus: false,
      virtualAnchor: {}
    }
  }
}
</script>

<style lang="scss">
#app{
  max-width: 750px;
  margin: 0 auto;
  margin-top:0.88rem;
i{
  font-style: normal;
}
.top_bg{
  background:url(~@/assets/zwpaper/zw_top_bg.png) no-repeat;
  width:100%;
  height: 1.12rem;
  position: absolute;
  top: 0;
  left: 0;
  background-size: contain;
}
.header_bg img{
  width:100%;
}
.header{
  position: relative;
  margin-bottom:0.6rem;
}
.header .date{
  width:1.6rem;
  height:1.6rem;
  position: absolute;
  top:0;
  left:50%;
  margin-left:-0.8rem;
  text-align: center;
  color: #fff;
  font-size: 0.24rem;
}
.author i{
  font-size: 0.24rem;
  margin-right:0.2rem;
}
.date .type1{
  margin-top:0.14rem;
  font-size: 0.24rem;
}
.date .type2{
  font-size:0.48rem;
}
.date .type3{
  font-size: 0.24rem;
}
.festival{
  font-size: 0.22rem;
  width: 0.2rem;
  margin-left: 0.2rem;
  display: inline-block;
  line-height: 0.24rem;
  position: relative;
}
.festival::before{
  content: "";
  position: absolute;
  opacity: 0.3;
  height: 0.48rem;
  width: 1px;
  top: -0.01rem;
  left: -0.1rem;
  background: #FFFFFF;
}
.header .infor{
  position: absolute;
  bottom:0;
  padding:0.34rem 0.6rem 0.25rem;
  height:3.78rem;
  width:100%;
  background:url(~@/assets/zwpaper/zw_bottom_bg.png) no-repeat;
  background-size: contain;
}
.infor .title{
  font-size: 0.36rem;
  color: #FFF;
  line-height: 0.42rem;
  margin-bottom:0.30rem;
  text-shadow: 0 1px 0 rgba(0,0,0,0.50);
}
.infor_body{
  position: absolute;
  left: 0;
  bottom: 0;
  width: 100%;
  padding: 0.34rem 0.6rem 0.25rem;
}
.node_summary{
  position: relative;
  font-size: 0.30rem;
  color: #f0f0f0;
  line-height: 0.38rem;
  text-shadow: 0 1px 0 rgba(0,0,0,0.50);
}
.infor .con_link{
  display: block;
  font-size: 0.30rem;
  color: #f0f0f0;
  margin-bottom:0.3rem;
  text-shadow: 0 1px 0 rgba(0,0,0,0.50);
}
.infor .author{
  font-size: 0.24rem;
  color: #f0f0f0;
  text-shadow: 0 1px 0 rgba(0,0,0,0.50);
}
.content{
  padding:0 0.6rem ;
}
  .content .h2_title{
  font-size: 0.3rem;
  color: #00A5EB;
  position: relative;
  padding-left:0.22rem;
  margin-bottom:0.3rem;
}
  .content .h2_title::before{
  content: "";
  display: block;
  width:0.12rem;
  height:0.12rem;
  background: #00A5EB;
  position: absolute;
  left:0 ;
  top:0.16rem;
}
.zwperitem{
  margin-bottom:0.6rem;
}
.button{
  background-image: linear-gradient(-45deg, #3385DB 0%, #9889CE 100%);
  border-radius: 0.38rem;
  width:6.3rem;
  height:0.80rem;
  font-size: 0.32rem;
  color: #fff;
  text-align: center;
  line-height: 0.80rem;
  margin:0 auto;
  margin-top:1.05rem;
}
.error_page{
  font-size: 0.5rem;
  text-align: center;
  margin-top: 3rem;
}
.node_summary+.author{
  margin-top:0.3rem;
}
.zwpaper_gomob{
  display: block;
  background-image:linear-gradient(-45deg,#3385db,#9889ce);
  border-radius:.38rem;
  width:6.3rem;
  height:.8rem;
  font-size:.32rem;
  color:#fff;
  text-align:center;
  line-height:.8rem;
  margin:0 auto;
  margin-top:1.05rem;
  margin-bottom:0.9rem;
}
}
@media screen and (min-width: 750px){
  #app{
  .header .infor,.top_bg{
    background-repeat: repeat-x;
    }
  }
}

@media  screen and (min-width:640px) {
  #app{
    margin-top:93px;
  }
}
@media screen and (max-width: 360px){
  #app{
   .header .date{
     width:1.7rem;
     height:1.7rem;
   }
  }
}
</style>
