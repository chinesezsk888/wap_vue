<template>
    <div>
      <span class="watermark_videos"  v-if="isVideos(item)">
        <i class="icon_videos"></i><i class="watermark_num">{{item.videoNum}}</i>
      </span>
      <span class="watermark_topic" v-if="isSpecail(item)"></span>
      <span class="watermark_vliving" v-if="isVideoVliving(item)"></span>
      <span class="watermark_imgliving" v-if="isImageVliving(item)"></span>
      <span class="watermark_images" v-if="isImages(item)">
        <i class="icon_images"></i><i class="watermark_num"> {{item.imageNum}}</i>
      </span>
      <span class="watermark_luxiang" v-if="isLuxiang(item)"></span>
      <span class="watermark_duration" v-if="isVideo(item)">
        <i class="icon_play"></i><i class="watermark_num">{{item.duration}}</i>
      </span>
    </div>
</template>
<script>
export default {
  name: 'WaterMark',
  props: {
    item: Object
  },
  methods: {
    isVideo (item) { // 单视频 显示视频时长
      let result = false
      if (item.watermark == 1 && !item.liveType) {
        result = item.videoNum == 1 || item.videoNum == ''
      }
      return result
    },
    isVideos (item) { // 多视频 显示图标+视频数量
      return item.watermark == 1 && !item.liveType && item.videoNum > 1
    },
    isVideoVliving (item) { // 视频直播 显示红点+直播
      return item.watermark == 1 && item.liveType == 1
    },
    isLuxiang (item) { // 直播录像 显示录像
      return item.watermark == 1 && item.liveType == 2
    },
    isImageVliving (item) { // 图片直播 显示直播
      return item.watermark == 4
    },
    isSpecail (item) { // 专题 显示专题
      return item.watermark == 3
    },
    isImages (item) { // 多图片 显示图标+图片数量
      return item.watermark == 2
    }
  }
}
</script>
