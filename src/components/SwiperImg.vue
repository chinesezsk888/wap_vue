<template>
  <div class="imgwin">
    <div class="head">
      <div class="back" @click="close"></div>
      <div class="count"><span class="">{{index+1}}</span>/{{imgList.length}}</div>
    </div>
    <div class="foot"></div>
    <div class="imgwin_swpier_container swiper-container">
      <div class="swiper-wrapper">
          <div class="swiper-slide" v-for="url in imgList" :key="url">
            <div class="swiper-zoom-container"><img :src="url"></div>
          </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'SwiperImg',
  props: {
    imgList: Array,
    index: Number
  },
  updated () {
    if (this.index != -1) {
      this.mywindow.initSwiperImg(this.index)
    }
  },
  methods: {
    close () {
      this.$emit('close')
    }
  }
}
</script>
