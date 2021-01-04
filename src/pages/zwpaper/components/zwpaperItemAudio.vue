<template>
  <div class="audio_panel">
    <div class="title">{{title}}</div>
    <audio ref="audio" :src="url"  controls="controls" loop="loop"></audio>
    <div class="audio_controls clearfix">
      <div class="play_btn">
        <img src="~@/assets/zwpaper/zw_audio_play.png" v-show="!status" @click="playAudio">
        <img src="~@/assets/zwpaper/zw_audio_pause.png" v-show="status" @click="pauseAudio">
      </div>
      <div class="audio_bar_bg" ref="audioBar">
        <div class="audio_bar"  @click="barClick">
          <div class="bar_loaded" :style="{width:percent*100+'%'}" ref="barLoaded"></div>
          <div class="bar_btn" :style="{left:barInfor.width*percent+'px'}" ref="barBtn"
              @touchstart.prevent="barTouchStart" @touchmove.prevent="barTouchMove" @touchend="barTouchEnd"
          >
          </div>
        </div>
        <div class="time clearfix">
          <div class="time_current">{{formatDuraton(currentTime)}}</div> <div class="time_duration">{{formatDuraton(duration)}}</div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>

export default {
  name: 'zwpaperAudio',
  data () {
    return {
      status: false, // 音频播放状态
      currentTime: 0, // 当前时间
      truthDuration: 0, // 音频真实长度 总多少秒
      barInfor: {
        moveFlag: false, // 移动中标识，处在移动中则 进度条不随着音乐播放而改变
        width: 0, // 进度条总长度,
        moveX: 0, // 一次拖动的变化长度
        movedX: 0 // 已经移动的长度
      }
    }
  },
  props: {
    title: String,
    url: String,
    duration: String
  },
  computed: {
    percent () {
      return Math.min(1, this.barInfor.movedX / this.barInfor.width)
    }
  },
  methods: {
    playAudio () {
      let audio = this.$refs.audio
      audio.play()
      this.status = true
    },
    pauseAudio () {
      let audio = this.$refs.audio
      audio.pause()
      this.status = false
    },
    barTouchStart (e) {
      this.barInfor.moveFlag = true
      this.barInfor.startX = e.touches[0].pageX
    },
    barTouchMove (e) {
      this.barInfor.moveX = e.touches[0].pageX - this.barInfor.startX // touch移动距离
      this.barInfor.movedX = this.barInfor.movedX + this.barInfor.moveX // 累计移动距离
      this.barInfor.startX = e.touches[0].pageX // 起点重新赋值
    },
    barTouchEnd () {
      this.barInfor.moveFlag = false
      this.barInfor.moveX = 0
      this.currentTime = (this.barInfor.movedX / this.barInfor.width) * this.truthDuration
      this.$refs.audio.currentTime = this.currentTime
    },
    barClick (e) {
      this.currentTime = (e.offsetX / this.barInfor.width) * this.truthDuration
      this.$refs.audio.currentTime = this.currentTime
      this.barInfor.movedX = e.offsetX
    },
    formatDuraton (time) {
      time = parseFloat(time)
      var hour = Math.floor(time / 3600)
      var min = Math.floor(Math.floor(time / 60) % 60)
      var sec = Math.floor(time % 60)
      hour = hour < 10 ? ('0' + hour + ':') : (hour + ':')
      min = min < 10 ? ('0' + min + ':') : (min + ':')
      sec = sec < 10 ? ('0' + sec) : (sec)
      time = hour == '00:' ? (min + sec) : (hour + min + sec)
      return time
    }
  },
  mounted: function () {
    let audio = this.$refs.audio
    var _self = this
    _self.truthDuration = parseFloat(this.duration)
    audio.ontimeupdate = () => {
      _self.currentTime = audio.currentTime
      if (!_self.barInfor.moveFlag) {
        _self.barInfor.movedX = (_self.currentTime / _self.truthDuration) * _self.barInfor.width
      }
    }
    this.barInfor.width = this.$refs.audioBar.clientWidth
  }
}

</script>
<style lang="scss">
.audio_panel{
  width:6.70rem;
  height:auto;
    padding:0.18rem 0.3rem 0.18rem;
    margin-bottom:0.60rem;
    margin-left: 0.4rem;
    box-shadow: 0 0.05rem 0.07rem 0.02rem rgba(0,0,0,0.10);
  audio{
    display: none;
  }
  .audio_controls{
    width:100%;
    height:0.72rem;
  }
  .title{
    font-size: .32rem;
    line-height: .42rem;
    color: #333;
    margin-bottom: .20rem;
    overflow: hidden;
  }
  .play_btn{
    float:left;
    width:0.72rem;
    height:0.72rem;
  }
  .play_btn img{
    width:100%;
    height:100%;
  }
  .audio_bar_bg{
    float:right;
    width:5.08rem;
    margin-top: 0.3rem;
  }
  .time{
    width:100%;
    margin-top:0.1rem;
    margin-left: 0;
    color:#333;
    font-size:0.18rem;
  }
  .time_current{
    float:left;
  }
  .time_duration{
    float:right;
  }
  .audio_bar{
    width:100%;
    height:0.04rem;
    background: #C8C8C8;
    border-radius: 2px;
    position: relative;
  }
  .bar_loaded{
    position: absolute;
    height:0.04rem;
    top:0;
    left:0;
    background: #434343;
  }
  .bar_btn{
    width:0.2rem;
    height:0.2rem;
    position: absolute;
    left:0.10rem;
    top: -0.08rem;
    background: url(~@/assets/zwpaper/zw_audio_bar.png) no-repeat;
    background-size: 0.12rem;
    background-position: center left;
  }
}
</style>
