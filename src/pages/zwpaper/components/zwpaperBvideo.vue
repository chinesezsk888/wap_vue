<template>
  <div class="bvideo_panel" :style="bgImage" @click="goNewsDetail">
    <img class="play_btn" src="~@/assets/zwpaper/zw_bvideo_icon.png">
    <div class="name"  v-if="showDes.length>13" ><zwpaper-marquee :msg='showDes'></zwpaper-marquee></div>
    <div v-else class="name">{{showDes}}</div>
  </div>
</template>
<script>
import zwpaperMarquee from './zwpaperMarquee'
export default {
  name: 'zwpaperBvideo',
  props: {
    item: Object
  },
  components: {
    zwpaperMarquee
  },
  computed: {
    bgImage () {
      let result = ''
      if (this.item.videoPic != '') {
        result = {
          backgroundImage: 'url(' + this.item.videoPic + ')'
        }
      }
      return result
    },
    showDes () {
      let result = '澎湃新闻AI播报'
      if (this.item.desc != '') {
        result = this.item.desc
      }
      return result
    }
  },
  methods: {
    goNewsDetail () {
      var url = 'newsDetail_forward_' + this.item.contId
      if (this.item.isFullPlay == 1) {
        url = url + '?ap=1'
      }
      window.location.href = url
    }
  }
}
</script>
<style lang="scss">
  .bvideo_panel{
    background: url(~@/assets/zwpaper/zwvideo.gif) no-repeat;
    width: 6.30rem;
    height: 1.40rem;
    background-size: 100%;
    margin: 0 .6rem;
    overflow: hidden;
    position: relative;
    margin-bottom:0.52rem;
    margin-top: -0.6rem;
  .play_btn{
    width:0.61rem;
    height:0.61rem;
    position: absolute;
    left:0.2rem;
    bottom:0.2rem;
  }
  .name{
    font-size:0.30rem;
    width:3.9rem;
    color:#fff;
    margin-top:0.68rem;
    margin-left:0.92rem;
  }
  }
</style>
