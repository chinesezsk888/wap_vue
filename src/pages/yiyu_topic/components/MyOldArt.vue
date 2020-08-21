<template>
  <div class="index_panel" v-show="isShow">
    <div class="index_close" @click="handleClose"></div>
    <ul class="clearfix">
        <li>
            <a href="https://m.thepaper.cn/yiyu_topic_3.jsp">第一期</a>
        </li>
        <li>
            <a href="https://m.thepaper.cn/yiyu_topic_4.jsp">第二期</a>
        </li>
        <li v-for="node in item" :key="node.nodeId">
            <a :href="'yiyu_topic.jsp?n='+node.nodeId">{{node.name}}</a>
        </li>
    </ul>
  </div>
</template>
<script>
export default {
  name: 'MyOldArt',
  props: {
    item: Object,
    isShow: Boolean
  },
  methods: {
    handleClose () {
      this.$emit("close")
    }
  }
}
</script>
