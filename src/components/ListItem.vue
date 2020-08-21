<template>
  <div class="list_item">
    <a class="list_item_thumb" :href="'newsDetail_forward_'+contItem.contId"  v-if="contItem.smallPic&&contItem.imgCardMode==1">
      <img :src="contItem.smallPic">
      <water-mark :item="contItem" />
    </a>
    <a class="list_item_thumb" :href="'newsDetail_forward_'+contItem.contId" v-if="contItem.pic&&contItem.imgCardMode==2">
      <img :src="contItem.pic">
      <water-mark :item="contItem" />
    </a>
    <div class="list_item_infor">
      <a :href="'newsDetail_forward_'+contItem.contId" class="list_item_title">{{contItem.name}}</a>
      <div class="list_item_extra">
        <template v-if="contItem.nodeInfo&&contItem.nodeInfo.nodeType==0">
            <a :href="contItem.nodeInfo.nodeLink" v-if="contItem.authorInfo.isSpecial==0">{{contItem.nodeInfo.name}}</a>
            <span v-else>{{contItem.nodeInfo.name}}</span>
        </template>
        <span>{{contItem.pubTime}}</span>
        <span  v-if="contItem.interactionNum  > 10">{{contItem.interactionNum }}评</span>
      </div>
      <div class="list_item_label"  v-if="contItem.cornerLabelDesc!=''">{{contItem.cornerLabelDesc}}</div>
    </div>
  </div>
</template>
<script>
import WaterMark from '@/components/WaterMark'
export default {
  name: 'ListItem',
  components: {
    WaterMark
  },
  props: {
    contItem: Object
  },
  methods: {
  }
}
</script>
