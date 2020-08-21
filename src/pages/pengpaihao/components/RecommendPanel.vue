/*
  推荐关注
 */
<template>
  <div class="recommend_panel" >
    <div class="rp_header">
      <div class="pa_common_title">推荐关注</div>
      <a class="pa_txt_tri" id="vuemoblink_recommend" :data-moblink="'demo/a?contType=53&contId='+moblinkId" moblink-featured>打开APP关注<span class="pa_tri"></span></a>
    </div>
    <div class="rp_swpier_container swiper-container">
      <div class="swiper-wrapper">
        <div class="swiper-slide"  v-for="childItem in contItem.childList" :key="childItem.userId">
          <div class="rp_item rp_gov_item" v-if="childItem.userId == ''">
            <a class="rp_gov_thum" href="getHotGovList.jsp"></a>
            <a class="rp_item_btn" href="getHotGovList.jsp">进入</a>
          </div>
          <div class="rp_item" v-else>
            <a :href="childItem.url">
              <div class="rp_item_thum"><img :src="childItem.pic"><span class="icon_vip"></span></div>
              <div class="rp_item_name">{{childItem.sname | langName(14)}}</div>
            </a>
            <a class="rp_item_app" :id="'vuemoblink_'+childItem.userId" :data-moblink="'demo/a?contType=31&contId='+childItem.userId+'&optType='+childItem.userType" moblink-featured >去APP关注</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'RecommendPanel',
  props: {
    contItem: Object,
    moblinkId: String
  },
  filters: {
    langName: function (value, length) { // 更多专题字数超出
      if (value.length > length) {
        value = value.substr(0, length - 1) + '...'
      }
      return value
    }
  }
}
</script>
