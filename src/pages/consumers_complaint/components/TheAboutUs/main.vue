<template>
<transition name="fade" @after-leave="removeDom">
  <div class="about_us_win" v-show="visiable"  @click="close">
    <div class="panel" @click.stop>
      <div class="header">关注我们 <span class="close" @click="close"></span></div>
      <div class="content">
        <div class="weibo">
          <div class="logo"></div>
          <div>微博关注</div>
          <div><b>“澎湃质量报告”</b></div>
          <a class="weibo_btn" href="https://weibo.com/u/6556957754">点击此处</a>
        </div>
        <div class="weixin">
          <div class="logo"></div>
          <div>微信请搜索</div>
          <div><b>“澎湃质量报告”</b></div>
          <div class="weixin_qrcode">
            <p>{{msg1}}</p>
            <img :src="qrCodeImg"
              v-if="appStyle==2"
              @touchstart="qrcodeChangan"
              @touchend="emptyQrcodeChanganTime"
            >
            <img :src="qrCodeImg" v-else>
            <p>{{msg2}}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</transition>
</template>
<script>
import { isInWeixin } from '@/util/common.js'
import showBottomSheet from '../AppBottomSheet'
import { weixinQrcode } from '../../config.js'

export default {
  name: 'AboutUs',
  props: {
    visiable: Boolean,
    scrollTop: {
      type: Number,
      default: 0
    }
  },
  data () {
    return {
      qrcodeChanganTimer: null,
      msg1: '',
      msg2: '',
      qrCodeImg: weixinQrcode,
      appStyle: this.AppStyle
    }
  },
  mounted () {
    if (isInWeixin()) {
      this.msg1 = '或长按扫二维码'
    } else {
      this.msg1 = '或长按保存二维码'
      this.msg2 = '去微信扫一扫'
    }
  },
  methods: {
    emptyQrcodeChanganTime () {
      clearTimeout(this.qrcodeChanganTimer)
    },
    qrcodeChangan () { // 长按二维码
      clearTimeout(this.Loop)
      this.qrcodeChanganTimer = setTimeout(function () {
        showBottomSheet()
      }.bind(this), 1000)
    },
    close () {
      this.visiable = false
    },
    removeDom () {
      this.$destroy()
      this.$el.parentNode.removeChild(this.$el)
      document.body.style.height = 'auto'
      document.body.style.overflow = 'auto'
      document.documentElement.scrollTop = this.scrollTop
      document.body.scrollTop = this.scrollTop
    }
  }
}
</script>
<style lang="scss">
  .about_us_win {
    width: 100%;
    height: 100%;
    position: fixed;
    background: rgba(19,19,19,0.5);
    top: 0;
    left: 0;
    z-index: 1000;
    .panel{
      width:5.90rem;
      height:5.44rem;
      background:#fff;
      border-radius:0.24rem;
      position: absolute;
      top:50%;
      left:50%;
      transform: translate(-50%,-50%);
    }
    .header{
      font-size:0.32rem;
      color:#333;
      border-bottom:1px solid #C8C8C8;
      height: 0.8rem;
      text-align: center;
      line-height: 0.8rem;
      position: relative;
      margin-top: 0;
    }
    .close{
      position: absolute;
      display: block;
      background:url(~@/assets/consumers_complaint/icon_close.png) no-repeat;
      top: 0;
      right: 0;
      background-position: center;
      width: 0.98rem;
      height: 0.86rem;
      background-size: 0.18rem;
    }
    .content{
      display: flex;
      &>div{
        width:50%;
        color:#333;
        font-size:0.24rem !important;
        text-align: center;
        position: relative;
        &:first-child::after{
          content: "";
          width: 1px;
          height: 4.64rem;
          background: #C8C8C8;
          position: absolute;
          right: 0;
          top: 0;
        }
      }
      .logo{
        margin: 0 auto;
        width:1.1rem;
        height:1.3rem;
        background-size:100%;
        background-repeat: no-repeat;
        margin-top:0.38rem;
        margin-bottom:0.13rem;
      }
    }
    .weibo{
      .logo{
        background-image: url(~@/assets/consumers_complaint/cc_icon_weibo.png) ;
      }
    }
    .weibo_btn{
      display: block;
      width:1.80rem;
      height:0.50rem;
      background:linear-gradient(315deg,rgba(0,136,255,1) 0%,rgba(0,197,255,1) 100%);
      border-radius:0.26rem;
      font-size:0.28rem;
      color:#FFF;
      text-align: center;
      line-height: 0.5rem;
      margin:0 auto;
      margin-top:0.74rem;
    }
    .weixin{
      .logo{
        background-image: url(~@/assets/consumers_complaint/cc_icon_weixin.png) ;
      }
    }
    .weixin_qrcode{
      margin-top:0.14rem;
      font-size:0.18rem;
      color:#333;
      p{
        transform: scale(0.9)
      }
      img{
        width:1.24rem;
        height:1.24rem;
      }
    }
  }
</style>
