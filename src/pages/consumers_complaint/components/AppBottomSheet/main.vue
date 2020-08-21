<template>
<transition name="fade" v-show="visiable"  @after-leave="removeDom">
  <div class="app_bottom_sheet" v-show="visiable"  @click="close">
      <div class="panel"  @click.stop>
        <div class="item" @click="imgDownLoad">保存到手机</div>
        <div class="item" @click="close">取消</div>
      </div>
  </div>
   </transition>
</template>
<script>
import { downloadForApp } from '@/util/common.js'
import { weixinQrcode } from '../../config.js'
let weixinQrcodeUrl = 'http:' + weixinQrcode
export default {
  name: 'AppBottomSheet',
  props: {
    visiable: Boolean
  },
  methods: {
    imgDownLoad () {
      let data = {
        download_type: 1,
        download_url: weixinQrcodeUrl
      }
      downloadForApp(JSON.stringify(data))
    },
    close () {
      this.visiable = false
    },
    removeDom () {
      this.$destroy()
      this.$el.parentNode.removeChild(this.$el)
    }
  }
}
</script>
<style lang="scss">
.app_bottom_sheet{
  width: 100%;
  height: 100%;
  position: fixed;
  background: rgba(19,19,19,0.5);
  top: 0;
  left: 0;
  z-index: 10000;
  .panel{
    position: absolute;
    bottom: 0;
    background: #fff;
    width: 100%;
    border-radius: 0.2rem 0.2rem 0 0;
    font-size: 0.30rem;
    padding:0.15rem 0.32rem;
    text-align: center;
  }
  .item{
    padding:0.15rem;
    &:first-child{
      border-bottom:1px solid #e9eff5
    }
  }
}
</style>
