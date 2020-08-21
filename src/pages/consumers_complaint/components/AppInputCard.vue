<template>
  <div class="app_input_card" :class="{error:error}" @click="inputCardClick">
    <div class="input_title">
      <div class="input_label">{{title}}<span v-if="required" class="input_required"></span></div>
      <div class="input_count">{{num}}/{{count}}</div>
    </div>
    <input v-if="type==0" type="text" v-model="value" ref="input" @focus="inputFocus" @blur="inputBlur">
    <textarea v-if="type==1"  v-model="value" ref="textarea" @focus="inputFocus" @blur="inputBlur"></textarea>
    <span class="app_input_placeholder" v-html="placeholder" v-show="placeholderStatus" @click="placeholderClick"></span>
  </div>

</template>
<script>

function UCBlurDeal () {
  var ua = navigator.userAgent.toLowerCase()
  if (/iphone|ipad|ipod/.test(ua)) {
    if (ua.indexOf('ucbrowser') > -1 || ua.indexOf('micromessenger') > -1) {
      document.getElementsByClassName('mypopup')[0].style.position = 'fixed'
      document.getElementsByClassName('mybody')[0].style.display = 'block'
    }
  }
}

export default {
  name: 'AppInputCard',
  props: {
    title: String,
    placeholder: String,
    required: Boolean,
    count: Number,
    error: Boolean,
    type: {
      type: Number,
      default: 0
    }
  },
  data () {
    return {
      value: '',
      placeholderStatus: true
    }
  },
  watch: {
    value () {
      if (this.value.length > this.count) {
        this.value = this.value.substr(0, this.count)
      }
      this.$emit('getValue', this.value)
    }
  },
  computed: {
    num () {
      return this.value.length
    }
  },
  methods: {
    inputFocus () {
      this.placeholderStatus = false
      // 苹果uc浏览器 position: fixed;处理
      var ua = navigator.userAgent.toLowerCase()
      if (/iphone|ipad|ipod/.test(ua)) {
        if (ua.indexOf('ucbrowser') > -1 || ua.indexOf('micromessenger') > -1) {
          document.getElementsByClassName('mypopup')[0].style.position = 'absolute'
          document.getElementsByClassName('mybody')[0].style.display = 'none'
        }
      }
    },
    inputBlur () {
      if (this.value == '') {
        this.placeholderStatus = true
      } else {
        this.placeholderStatus = false
      }
      UCBlurDeal()
    },
    inputCardClick () {
      if (this.type == 0) {
        this.$refs.input.focus()
      } else {
        this.$refs.textarea.focus()
      }
    },
    placeholderClick () {
      if (this.type == 0) {
        this.$refs.input.focus()
      } else {
        this.$refs.textarea.focus()
      }
    },
    clearValue () {
      this.value = ''
      this.placeholderStatus = true
      UCBlurDeal()
    }
  }
}
</script>
<style lang="scss">
  .app_input_card{
    position: relative;
    padding:0.22rem 0.3rem;
    background: #fff;
    &.error{
      border:1px solid #D0021B;
    }
    .input_title{
      display: flex;
      justify-content: space-between;
      border-bottom: 1px solid #C8C8C8;
      margin-bottom: 0;
      padding-bottom: 0.08rem;
      font-size:0.28rem;
      color:#333;
    }
    .input_count{
      font-size:0.24rem;
      color:#666;
    }
    .input_label{
      position: relative;
    }
    textarea,
    input{
      border: 0;
      padding: 0;
      margin-top: 0.1rem;
      width: 100%;
      line-height:0.40rem;
      font-size: 0.28rem;
      font-family: "Microsoft Yahei";
    }
    .app_input_placeholder{
      position: absolute;
      left:0.3rem;
      top:0.83rem;
      font-size:0.28rem;
      color:#999;

    }
  }
  .input_required{
    width:0.14rem;
    height:0.14rem;
    background:url(~@/assets/consumers_complaint/input_required.png) no-repeat ;
    background-size:100%;
    position: absolute;
    top:0;
    right: -0.16rem;
  }
</style>
