/*
  精选
 */
<template>
  <div class="recommend_select">
    <div class="rs_header">
      <div class="pa_common_title">{{contItem.title}}</div>
    </div>
    <a v-for="childItem in contItem.childList" :href="'newsDetail_forward_'+childItem.contId" :key='childItem.contId'>
      <img :src="childItem.pic" v-if="childItem.pic">
      <div v-else class="recommend_default">
        <div class="rd_title">{{childItem.name}}</div>
      </div>
    </a>
  </div>
</template>
<script>
export default {
  name: 'RecommendSelect',
  props: {
    contItem: Object
  }
}
</script>
