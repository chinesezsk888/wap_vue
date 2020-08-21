<template>
    <div class="app_check_box" @click="clickHandle">
      <span :class="{icon_unchecked:!checkStatus,icon_checked:checkStatus}"></span>{{txt}}
    </div>
</template>
<script>
export default {
  name: 'AppCheckBox',
  props: {
    txt: String,
    defaultValue: {
      default: 0
    }
  },
  data () {
    return {
      checkStatus: false
    }
  },
  created () {
    this.checkStatus = this.defaultValue
  },
  methods: {
    clickHandle () {
      this.checkStatus = !this.checkStatus
      // 通知父类选择结果
      this.$emit('getCheckStatus', this.checkStatus)
    }
  }
}
</script>
<style lang="scss">
  .app_check_box{
    cursor: pointer;
    font-size:0.28rem;
    padding:0 0.3rem;
    margin-bottom:0.24rem;
    padding-left: 0.66rem;
    position: relative;
    .icon_checked{
      width:0.24rem;
      height:0.25rem;
      background:url(~@/assets/epidemic_situation/checked.png) no-repeat ;
      background-size:100%;
      display: inline-block;
      position: absolute;
      left: 0.3rem;
      top: 0.04rem;
    }
    .icon_unchecked{
      width:0.24rem;
      height:0.25rem;
      background:url(~@/assets/epidemic_situation/unchecked.png) no-repeat ;
      background-size:100%;
      display: inline-block;
      position: absolute;
      left: 0.3rem;
      top: 0.04rem;
    }
  }
</style>
