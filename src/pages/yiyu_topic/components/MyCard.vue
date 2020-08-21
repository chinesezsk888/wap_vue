<template>
  <div class="card " :class="{card_bg:index>1}">
      <div class="card_title">
          <div class="card_title_index">{{index}}</div>
          <div class="card_title_con">{{item.name}}</div>
      </div>
      <div class="card_news" v-for="wordrelation in item.wordRelationList" :key="wordrelation.name">
        {{wordrelation.name}}
        <a :href="'newsDetail_forward_'+wordrelation.contId"><i>>></i>阅读新闻</a>
      </div>
      <div class="card_icon"></div>
      <div class="card_con" :class="{card_expend:isExpend}">{{item.content}}</div>
      <div class="card_tri" :class="{card_expend:isExpend}" @click="handleTri"></div>
  </div>

</template>
<script>
export default {
  name: 'MyCard',
  props: {
    item: Object,
    index: String,
  },
  data () {
    return{
      isExpend:false // 控制是否展开
    }
  },
  methods: {
    handleTri () {
      this.isExpend = !this.isExpend
    }
  }
}
</script>

