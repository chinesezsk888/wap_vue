<template>
  <div class="pa_panel" id="vuePanel">
    <div class="vue_loading" v-show="isLoading"></div>
    <div
      v-infinite-scroll="loadMore"
      infinite-scroll-disabled="scroll_busy"
      infinite-scroll-distance="400"
      ref="body"
    >
      <div v-for='contItem in contList' v-cloak :key='contItem.contId'>
        <template v-if="contItem.cardMode ==3&&contItem.childList.length!=0">
          <recommend-panel :contItem="contItem" :moblinkId="moblinkId"/>
        </template>
        <template  v-if="contItem.cardMode == 2">
          <topic-specail :contItem="contItem" :moblinkId="moblinkId" />
        </template>
        <template v-if="contItem.cardMode == 4">
          <recommend-select :contItem="contItem"/>
        </template>
        <div class="pa_item" :class="{pa_item_big:contItem.imgCardMode==2}" v-if="contItem.cardMode == 1">
            <a class="pa_item_header" :href="contItem.authorInfo.url" v-if="isShowAuthor(contItem)">
                <div class="pa_item_author"><div class="thum_bg"><img class="thum" :src="contItem.authorInfo.pic"><span class="icon_vip" v-if="contItem.authorInfo.isAuth == '1'"></span></div>{{contItem.authorInfo.sname}}</div>
                <div class="pa_tri"></div>
            </a>
            <list-item :contItem="contItem"></list-item>
        </div>
      </div>
    </div>
    <div class="status_panel" id="listEnd" v-show="nextUrl==''&&!isLoading">
      <span class="status_panel_txt">到底了</span>
    </div>
    <div class="newspath" v-show="nextUrl!='' && pageIndex <= 5 && !isLoading"></div>
    <a class="moblink_btn-690 more_moblink" id="vuemoblink_list" :data-moblink="'demo/a?contType=51&contId='+moblinkId" moblink-featured v-show="pageIndex>5">更多澎湃号好文，下载澎湃新闻APP</a>
  </div>
</template>

<script>
import infiniteScroll from 'vue-infinite-scroll'
import ListItem from '@/components/ListItem'
import RecommendPanel from './components/RecommendPanel.vue'
import RecommendSelect from './components/RecommendSelect.vue'
import TopicSpecail from './components/TopicSpecail.vue'
import { apiUrl } from './config.js'
import { getUrlKey2 } from '@/util/common.js'
export default {
  name: 'app',
  data () {
    return {
      contList: [],
      nextUrl: '',
      isLoading: true,
      nodeName: '',
      moblinkId: '',
      scroll_busy: false,
      pageIndex: 0
    }
  },
  components: {
    ListItem,
    RecommendPanel,
    RecommendSelect,
    TopicSpecail
  },
  directives: { infiniteScroll },
  filters: {
    langName: function (value, length) { // 更多专题字数超出
      if (value.length > length) {
        value = value.substr(0, length - 1) + '...'
      }
      return value
    }
  },
  updated: function () {
    this.scroll_busy = false
    this.$nextTick(function () {
      this.mywindow.createSwiper()
      this.mywindow.initHeadPanel({
        contType: 51,
        contId: this.moblinkId,
        channelName: '澎湃号',
        channelId: this.nodeId
      })
      this.mywindow.baseMobLinkInit("a[id^='moblink']")
      this.mywindow.vueMoblinkInit()
    })
  },
  created () {
    this.getPageData()
  },
  methods: {
    getContItemName (contItem) {
      let result = contItem.name
      if (contItem.name.length > 40) {
        result = contItem.name.substr(0, 39) + '...'
      }
      if (contItem.smallPic && contItem.imgCardMode == 1) {
        if (contItem.name.length > 32) {
          result = contItem.name.substr(0, 31) + '...'
        }
      }
      if (contItem.pic && contItem.imgCardMode == 2) {
        if (contItem.name.length > 36) {
          result = contItem.name.substr(0, 35) + '...'
        }
      }
      return result
    },
    isShowAuthor (item) { // 澎湃问政不显示
      let result = false
      if (item.authorInfo && item.authorInfo.sname) {
        if (item.authorInfo.isSpecial == '1') {
          result = false
        } else {
          result = true
        }
      }
      return result
    },
    getPageData (nextUrl) {
      let url = ''
      if (nextUrl) {
        url = nextUrl
      } else {
        let channelID = getUrlKey2()
        url = apiUrl
        if (channelID && channelID != '') {
          url += '?channelID=' + channelID
        }
      }
      this.axios.get(url)
        .then(res => {
          this.addData(res)
          this.pageIndex++
          this.isLoading = false
        })
        .catch(() => {
          console.log('请稍后重试')
        })
    },
    addData (res) {
      let resp = res.data
      this.resultCode = resp.resultCode
      this.contList = this.contList.concat(resp.contList)
      this.resultMsg = resp.resultMsg
      this.nextUrl = resp.nextUrl
      this.nodeName = resp.nodeName
      this.moblinkId = resp.moblinkId
      this.nodeId = resp.nodeId
    },
    loadMore () {
      if (this.nextUrl == '-1' || this.nextUrl == '' || this.pageIndex > 5) {
        return
      }
      this.scroll_busy = true
      this.getPageData(this.nextUrl)
    }
  }
}
</script>
