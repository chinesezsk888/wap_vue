<template>
  <div class="py_card_item">
    <a :href="detailLink">
      <div class="pci_img_box">
        <img :src="imgUrl" alt="" class="pci_img">
      </div>
      <p class="pci_title">{{title}}</p>
      <p class="pci_des">{{summary}}</p>
        <div class="pci_more">查看详情>></div>
      </a>
  </div>
</template>

<script>
export default {
  components:{},
  props:{
    title: String,
    summary: String,
    imgUrl: String,
    detailLink: String
  },
  data(){
    return {
    }
  },
  methods:{
  },
}
</script>
<style lang="scss">
.py_card_item {
  width: 100%;
  a {
    display:block;
  }
  .pci_img_box {
    width: 6.3rem;
    height: 3.54rem;
    margin-bottom: 0.2rem;
    .pci_img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  }
  .pci_title {
    font-size: 0.36rem;
    font-weight: 600;
    color: #000000;
    line-height: 0.44rem;
    margin-bottom: 0.2rem;
  }
  .pci_des {
    font-size: 0.32rem;
    font-weight: 400;
    color: #999999;
    line-height: 0.48rem;
    margin-bottom: 0.2rem;
  }
  .pci_more {
    font-size: 0.32rem;
    font-weight: 400;
    color: #666666;
    line-height: 0.48rem;
    text-align: right;
  }
}
</style>
