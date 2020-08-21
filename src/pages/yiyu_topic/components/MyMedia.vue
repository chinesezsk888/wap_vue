<template>
  <div>
    <div class="audio_panel" v-if="type == 1">
      <audio :src="item.url" :data-duration="item.duration" id="topAudio" preload="auto" controls></audio>
      <div class="audio_name">{{item.name}}</div>
    </div>
    <div class="video_panel" v-if="type == 2">
      <video
        x5-playsinline=""
        webkit-playsinline=""
        playsinline=""
        x-webkit-airplay="allow"
        preload="preload"
        controls="controls"
        :poster="item.pic"
        :src="item.url"
      ></video>
    </div>
  </div>

</template>
<script>
export default {
  name: 'MyMedia',
  props: {
    type: String,//1音频 2视频
    item: Object
  },
  mounted () {
    if (this.type == 1) {
      let audioList = this.mywindow.$("#topAudio")
      let duration = audioList.data("duration")
      duration = typeof(duration) == 'undefined' ? '...':duration
      audioList.audioPlayer({'duration':duration})
    }
  }
}
</script>

