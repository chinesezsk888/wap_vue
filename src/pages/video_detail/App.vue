<template>
  <div class="video_detail--page">
    <!-- 相关推荐卡片 -->
    <!-- <div class="related__recommend--box">
      <div class="recommend__title">
        <div class="title">相关推荐</div>
      </div>
      <ul class="card__ul">
        <li class="related__recommend--card"
          v-for="relatedItem in relatedCardList"
          :key="relatedItem.contId"
          >
            <a class="rc_item_thum"
              :id="'vuemoblink_'+relatedItem.contId+(Math.floor(Math.random() * 1001))"
              moblink-featured=""
              :data-moblink="'demo/a?contType='+relatedItem.contType+'&contId='+relatedItem.contId">
              <img :src="relatedItem.pic" class="recomImg">
              <water-mark :item="relatedItem" />
              <span class="datetime">{{relatedItem.pubTime}}</span>
            </a>
            <p class="card__des ellipsis">{{relatedItem.name}}</p>
        </li>
      </ul>
    </div> -->
    <!-- 热门推荐卡片 -->
    <div class="hot__recommend--card">
      <div class="recommend__title">
        <div class="title">热门推荐</div>
      </div>
      <div class="vue_loading" v-show="isLoading"></div>
      <ul class="card__ul">
        <li class="related__recommend--card"
          v-for="relatedItem in relatedCardList"
          :key="relatedItem.contId"
          >
            <a class="rc_item_thum"
               :href="'newsDetail_forward_'+relatedItem.contId"
              >
              <div class="rt__img__box">
                <img :src="relatedItem.pic" class="recomImg">
                <span class="datetime">{{relatedItem.pubTime}}</span>
                <water-mark :item="relatedItem" />
              </div>
              <p class="card__des ellipsis">{{relatedItem.name}}</p>
            </a>
        </li>
      </ul>
       <a class="news_open_app"
        id="moblink_morecomm"
        moblink-featured
        data-moblink="demo/a?contType=24">
           打开APP看全部热门推荐
        </a>
    </div>
  </div>
</template>

<script>
import { apiUrl } from './config.js'
import WaterMark from '../../components/WaterMark'
export default {
  components: { WaterMark },
  props: {},
  data () {
    return {
      relatedCardList: [],
      isLoading: true
    }
  },
  watch: {},
  computed: {},
  methods: {
    render (url) {
      this.axios.get(url)
        .then(res => {
          this.relatedCardList = res.data.contList
          this.isLoading = false
        })
        .catch((err) => {
          console.log(err)
        })
    }
    // collapseContent () {
    //   var htmlDom = document.querySelectorAll('html')[0]
    //   var htmlSizeStr = htmlDom.currentStyle ? htmlDom.currentStyle['fontSize'] : getComputedStyle(htmlDom, false)['fontSize']
    //   var htmlSizeNum = htmlSizeStr.slice(0, htmlSizeStr.indexOf('p')) * 0.3
    //   var cardDesArr = document.querySelectorAll('.card__des')
    //   Array.from(cardDesArr).forEach(function (v, i) {
    //     if (v.clientHeight > (1.5 * htmlSizeNum * 2)) {

    //     }
    //   })
    // }
  },
  created () {
  },
  mounted () {
    var videoConId = this.mywindow.$('#video__contId').val()
    var url = apiUrl + '?videoContId=' + videoConId
    this.render(url)
  }
}
</script>
