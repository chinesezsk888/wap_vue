<template>
  <div class="zwpaper_item">
    <a :href="link" target="_blank"><div class="title">{{title}}</div></a>
    <div v-if="video" class="video_con"  @click="playBtnClick" onclick="">
      <img :src="imgUrl" class="poster" v-show="!isPlay">
      <div class="play_btn" v-show="!isPlay">
        <span class="icon_play"></span>
        <span class="duration">{{video.duration}}</span>
      </div>
      <video v-show="isPlay" :src="video.url" ref="video" :poster="imgUrl">您的浏览器不支持 video 标签。</video>
    </div>
    <div v-else>
      <a :href="link">
        <div v-if="imgUrl && imgCount == 0" class="img_con">
          <img :src="imgUrl" class="img">
        </div>
        <div v-if="imgUrl && imgCount > 0" class="img_con">
          <img :src="imgUrl" class="img">
          <div class="img_label"><div class="img_count">{{imgCount}}</div></div>
          <div class="img_bg"></div>
        </div>
      </a>
    </div>
    <a :href="link"><div class="summary">{{summary}}</div></a>
    <a :href="link"><div class="show_more">查看详情>></div></a>
  </div>
</template>
<script>
export default {
  name: 'zwpaperItem',
  props: {
    title: String,
    summary: String,
    link: String,
    videoUrl: String,
    imgUrl: String,
    imgCount: Number,
    video: Object
  },
  data () {
    return {
      isPlay: false
    }
  },
  methods: {
    playBtnClick () {
      this.isPlay = true
      this.$refs.video.controls = 'controls'
      this.$refs.video.play()
    }
  }
}
</script>
<style lang="scss">
.zwpaper_item{
  a{
    display:block;
  }
  div{
    letter-spacing: 0;
    text-align: justify;
    line-height: 0.42rem;
  }
  img:not([src]) {
      opacity: 0;
  }
  video{
    width:100%;height:100%;
  }
  .title{
    font-size: 0.36rem;
    color: #000;
    margin-bottom:0.2rem;
  }
  .summary{
    font-size: 0.30rem;
    color: #999;
    margin-bottom:0.1rem;
  }
  .show_more{
    font-size: 0.30rem;
    color: #666;
  }
  .img_con {
    width:100%;
    margin: 0.30rem 0 0.2rem;
    position: relative;
  }
  .img{
    width:6.30rem;
    height:3.55rem;
    object-fit: cover;
  }
  .img_bg{
    position: absolute;
    width:100%;
    text-align: center;
    z-index: -1;
  }
  .img_bg::before{
    content: "";
    display: block;
    width:6.10rem;
    height:0.1rem;
    background: #C8C8C8;
    margin:0 auto;
  }
  .img_bg::after{
    content: "";
    display: block;
    width:5.80rem;
    height:0.1rem;
    background: #F0F0F0;
    margin:0 auto;
  }
  .img_label{
    position: absolute;
    right:0.2rem;
    bottom:0.2rem;
    width:0.93rem;
    height:0.36rem;
    border-radius: 0.18rem;
    color:#fff;
    text-align: center;
    line-height: 0.36rem;
    background: url(~@/assets/zwpaper/zw_label_altas.png) no-repeat;
    background-size: 100%;
  }
  .video_con{
    position: relative;
    height: 3.55rem;
    margin-bottom:0.2rem;
    margin-top:0.3rem;
    .poster{
      width: 6.30rem;
      height: 3.55rem;
    }
    .play_btn{
      position: absolute;
      bottom: 0;
      right: 0;
      font-size: .24rem;
      color: #fff;
      background: rgba(0,0,0,.5);
      height: .42rem;
    }
    .icon_play{
      width: .42rem;
    height: .42rem;
    margin: 0;
    vertical-align: middle;
    }
    .duration{
      line-height: .42rem;
      margin-right: .2rem;
    }
  }
  .video_playbtn{
    top:50%;
    left:50%;
    margin-top:-0.45rem;
    margin-left:-0.45rem;
    position: absolute;
    height:0.9rem;
    width:0.9rem;
  }
  .img_count{
    position: absolute;
    right: 0.18rem;
    font-size: 0.18rem;
    color: #FFF;
    height: 0.36rem;
    text-align: center;
    top: -0.01rem;
  }
}
@media screen and (min-width: 750px){
  .zwpaper_item{
    .img{
      width:100%;
      height: auto;
    }
    .img_bg::before{width:95%}
    .img_bg::after{width:90%}
  }
}
</style>
