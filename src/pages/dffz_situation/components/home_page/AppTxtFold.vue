<template>
  <div class="app_txt_fold" ref="appFold">
    <div ref="appFoldChild" @click="showTxt()">
        <div v-html="txtShow"></div>
        <span class="app_txt_fold_btn" v-if="this.txtBtnStatus">展开</span>
    </div>
  </div>
</template>
<script>
import { getStyle } from '@/util/common.js'
export default {
  name: 'AppTxtFold',
  props: {
    txt: String
  },
  data () {
    return {
      txtShow: '',
      txtBtnStatus: false
    }
  },
  created () {
    if (this.txt.indexOf('<br>') != -1) {
      let txt1 = this.txt.split('<br>')[0]
      this.txtShow = txt1.substr(0, 34) + '...'
      this.txtBtnStatus = true
      return
    }
    if (this.txt.length > 36) {
      this.txtShow = this.txt.substr(0, 34) + '...'
      this.txtBtnStatus = true
    } else {
      this.txtShow = this.txt
      this.txtBtnStatus = false
    }
  },
  updated () {
    this.$nextTick(() => {
      this.$refs.appFold.style.height = getStyle(this.$refs.appFoldChild, 'height')
    })
  },
  methods: {
    showTxt () {
      this.$refs.appFold.style.height = getStyle(this.$refs.appFoldChild, 'height')
      this.txtShow = this.txt
      this.txtBtnStatus = false
    }
  }
}
</script>
<style lang="scss">
  .epidemic_situation {
    .app_txt_fold_btn{
      cursor: pointer;
      color:#333;
      font-size:0.28rem;
      float:right;
      position: absolute;
      right:0;bottom:0;
      font-weight: 500;
    }
    .app_txt_fold{
      position: relative;
      transition: height 0.2s ease-out;
    }
  }
</style>
