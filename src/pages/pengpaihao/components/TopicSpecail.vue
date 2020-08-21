<template>
  <div class="topic_specail">
    <div class="ts_header">
      <a class="pa_common_title" :href="'newsDetail_forward_'+contItem.forwordNodeId">{{contItem.title}}</a>
      <a class="pa_txt_tri" id="vuemoblink_topic_specail" :data-moblink="'demo/a?contType=3&contId='+contItem.forwordNodeId" moblink-featured>打开APP关注<span class="pa_tri"></span></a>
    </div>
    <div class="ts_swpier_container swiper-container">
      <div class="swiper-wrapper">
        <div class="swiper-slide" v-for="childItem in contItem.childList" :key="childItem.contId">
          <div class="ts_item">
            <a class="ts_item_thum" :href="'newsDetail_forward_'+childItem.contId">
              <img :src="childItem.pic">
              <div class="ts_item_title">
                {{childItem.name}}
                <water-mark :item="childItem"></water-mark>
              </div>
            </a>
            <div class="ts_item_con" v-if="isShowAuthor(childItem)">
              <a class="ts_item_author" :href="childItem.authorInfo.url">
                <div class="ts_ia_thum">
                  <img :src="childItem.authorInfo.pic">
                  <div class="icon_vip" v-if="childItem.authorInfo.isAuth == 1"></div>
                </div>
                {{childItem.authorInfo.sname}}
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import WaterMark from '@/components/WaterMark'
export default {
  name: 'TopicSpecail',
  props: {
    contItem: Object,
    moblinkId: String
  },
  components: {
    WaterMark
  },
  methods: {
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
    }
  }
}
</script>
