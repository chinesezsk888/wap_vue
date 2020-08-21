<template>
    <div>
        <header>
            <div class="header_top"></div>
            <div class="header_nav" @click="showOldArt(1)" v-show="oldArt.navShow"></div>
            <div class="header_author">
                <img src="//file.thepaper.cn/wap/v3/img/papertopic_author_shenyi_new1.png">
            </div>
            <div class="header_name">
                <span>沈逸</span>复旦大学网络空间治理研究中心主任
            </div>
        </header>
        <template v-if="video.url!=undefined">
            <MyMedia :item="video"></MyMedia>
        </template>
        <template v-if="audio.url!=undefined">
            <MyMedia :item="audio"></MyMedia>
        </template>
        <div class="card_list">
            <MyCard :item="item" :index="index" v-for="(item ,index) in contList" :key="item.contId"></MyCard>
            <Author></Author>
        </div>
        <div class="header_nav_footer"  @click="showOldArt(2)" v-show="oldArt.navFooterShow"></div>
        <MyOldArt :item="nodeList" :isShow="isShowOld" :chufa="oldChufa" @close="closeOldArt"></MyOldArt>

    </div>
</template>
<script>
import { getUrlKey } from '../../util/common.js'
import Author from './components/Author'
import MyCard from './components/MyCard'
import MyMedia from './components/MyMedia'
import MyOldArt from './components/MyOldArt'

export default {
  name: 'App',
  data () {
    return {
      contList: [], // 文章
      audio: {}, // 音频
      video: {}, // 视频
      nodeList: [], // 往期
      oldArt: {
        isShow: false, // 显示往期列表
        chufa: 1, // 1 nav触发，2 navfooter触发
        navShow: true,
        navFooterShow: false
      }
    }
  },
  components: {
    Author, MyCard, MyMedia, MyOldArt
  },
  methods: {
    showOldArt (type) {
      this.oldArt.isShow = true
      this.oldArt.chufa = type
      if (this.oldArt.chufa == 1) {
        this.oldArt.navShow = false
      } else {
        this.oldArt.navFooterShow = false
      }
    },
    closeOldArt () {
      this.oldArt.isShow = false
      if (this.oldArt.chufa == 1) {
        this.oldArt.navShow = true
      } else {
        this.oldArt.navFooterShow = true
      }
    },
    getPageData () {
      let url = 'yiyu_topic_json.jsp'
      let nodeId = getUrlKey('n')
      if (nodeId && nodeId != '') {
        url += '?n=' + nodeId
      }
      this.axios.get(url)
        .then(res => {
          this.addData(res)
        })
        .catch(() => {
          console.log('请稍后重试')
        })
    },
    addData (res) {
      let resp = res.data
      if (resp.resultCode == 1) {
        this.contList = resp.contList
        this.audio = resp.audio
        this.video = resp.video
        this.nodeList = resp.nodeList
      }
    }
  },
  created () {
    this.getPageData()
  }
}
</script>
