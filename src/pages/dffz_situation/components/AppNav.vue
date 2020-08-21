<template>
  <div class="nav_panel" :class="{showmenu:menuShow}">
    <div class="nav_bg" v-show="menuShow" @click="menuBtnHandle"></div>
    <div class="nav_scroll">
      <ul ref="scrollFather">
        <li v-for="item in itemList" :class="{on:item[propertyId]==selectId}" :key="item[propertyId]" @click="setSelect(item)">
          {{item[propertyTxt]}}
        </li>
      </ul>
      <div class="menu_btn" ref="menuBtn" @click="menuBtnHandle"><span :class="{show:!menuShow,close:menuShow}"></span></div>
    </div>
<transition name="fade">
    <ul class="nav_list" v-show="menuShow">
      <li v-for="item in (itemList.slice(1))" class="nav_item" :class="{on:item[propertyId]==selectId}" :key="item[propertyId]" @click="selectList(item)">
        {{item[propertyTxt]}}
      </li>
    </ul>
</transition>
  </div>
</template>
<script>
import { getStyle } from '@/util/common.js'
export default {
  name: 'AppNav',
  props: {
    itemList: Array,
    propertyId: {
      type: String,
      default: 'id'
    },
    propertyTxt: {
      type: String,
      default: 'name'
    },
    defaultSelectId: {
      type: String,
      default: '0'
    }
  },
  data () {
    return {
      menuShow: false,
      selectId: this.defaultSelectId, // 选中Id
      translateX: 0, // 滚动距离
      menuBtnWidth: 0, // 菜单按钮宽度
      ulWidth: 0, // ul宽度
      scrollWidth: 0, // 可以滚动区域
      scrollX: 0, // 触碰移动距离
      initPageFlag: false
    }
  },
  updated () {
    this.$nextTick(() => {
      if (!this.initPageFlag) {
        this.setUlWidth()
        this.initTouchEvent()
        this.initPageFlag = true
      }
      this.setTranslateX()
    })
  },
  methods: {
    menuBtnHandle () {
      this.menuShow = !this.menuShow
      this.$emit('showPanel', this.menuShow)
    },
    touchstart (event) {
      // event.preventDefault();
      this.scrollX = event.touches[0].clientX
    },
    touchend () {
      // event.preventDefault();
      if (this.translateX > 0) { // 滚动边界控制
        this.$refs.scrollFather.style.transform = 'translate(0px)'
        this.translateX = 0
      }
      if (this.translateX < 0 && Math.abs(this.translateX) > this.scrollWidth) {
        this.translateX = 0 - this.scrollWidth
        this.$refs.scrollFather.style.transform = 'translate(' + this.translateX + 'px)'
      }
    },
    touchmove () {
      event.preventDefault()
      let scrollStep = this.scrollX - event.touches[0].clientX
      if (scrollStep > 0) { // 左滑动
        if (Math.abs(this.translateX) < this.scrollWidth) {
          this.translateX = this.translateX - Math.abs(scrollStep)
          this.$refs.scrollFather.style.transform = 'translate(' + this.translateX + 'px)'
        }
      } else { // 右滑动
        if (this.translateX < 0) {
          this.translateX = this.translateX + Math.abs(scrollStep)
          this.$refs.scrollFather.style.transform = 'translate(' + this.translateX + 'px)'
        }
      }
      this.scrollX = event.touches[0].clientX
    },
    setSelect (item) {
      if (this.selectId != item[this.propertyId]) {
        this.selectId = item[this.propertyId]
        this.$emit('selectNav', item[this.propertyId])
      }
    },
    selectList (item) {
      if (this.selectId != item[this.propertyId]) {
        this.setSelect(item)
        this.menuShow = false
      } else {
        this.menuBtnHandle()
      }
    },
    getDomWidth (dom) {
      return dom.clientWidth + parseInt(getStyle(dom, 'marginRight'))
    },
    initTouchEvent () {
      this.$refs.scrollFather.addEventListener('touchstart', this.touchstart, { passive: false })
      this.$refs.scrollFather.addEventListener('touchend', this.touchend, { passive: false })
      this.$refs.scrollFather.addEventListener('touchmove', this.touchmove, { passive: false })
    },
    setUlWidth () {
      // 计算ul宽度
      let li = this.$refs.scrollFather.childNodes
      let width = 0
      for (let i = 0; i < li.length; i++) {
        let dom = li[i]
        width += this.getDomWidth(dom)
      }
      width = width + 20
      this.$refs.scrollFather.style.width = width + 'px'
      this.ulWidth = width
      this.menuBtnWidth = parseInt(getStyle(this.$refs.menuBtn, 'width'))
      this.scrollWidth = this.ulWidth - document.body.clientWidth + this.menuBtnWidth
    },
    setTranslateX () { // 设置初始滚动
      let liWidth = 0
      let li = this.$refs.scrollFather.childNodes
      for (let i = 0; i < li.length; i++) {
        let dom = li[i]
        if (dom.className.indexOf('on') >= 0) {
          break
        }
        liWidth += this.getDomWidth(dom)
      }
      // 调整默认滚动位置
      this.translateX = 0 - liWidth // 移动到最左端
      this.translateX = this.translateX + parseInt(document.body.clientWidth / 2) // 移动到中间
      this.translateX = this.translateX - this.menuBtnWidth
      if (this.translateX < 0 && Math.abs(this.translateX) < this.scrollWidth) {
        this.$refs.scrollFather.style.transform = 'translate(' + this.translateX + 'px)'
      }
      if (this.translateX < 0 && Math.abs(this.translateX) > this.scrollWidth) { // 最右边出现
        this.$refs.scrollFather.style.transform = 'translate(' + (0 - this.scrollWidth) + 'px)'
      }
      if (this.translateX > 0) { // 滚动边界控制
        this.$refs.scrollFather.style.transform = 'translate(0px)'
        this.translateX = 0
      }
    }
  }
}
</script>
<style lang="scss">
  .nav_panel{
    position: relative;
    width: 100%;
    z-index: 10;
    &.showmenu{
      position: absolute;
      height: 100rem;
    }
  }
  .nav_bg{
    width:100%;
    height:100%;
    position: absolute;
    top:0;
    left:0;
    background:rgba(19,19,19,0.5);
  }
  .nav_list{
    position: absolute;
    top: 0.9rem;
    left: 0;
    background: rgba(255,255,255,1);
    width: 100%;
    z-index: 100;
    display: flex;
    flex-wrap: wrap;
    border-top: 1px solid #f0f0f0;
    &::after{
      width:1.80rem;
      content:"";
    }
  }
  .nav_item{
    cursor: pointer;
    font-size:0.28rem;
    width:20%;
    height:0.72rem;
    border-radius:0.05rem;
    line-height: .72rem;
    text-align: center;
    position: relative;
    &.on{
      color:#00A5EB;
    }
    &::after{
      display: inline-block;
      clear: both;
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      width: 100%;
      height: 1px;
      background:#f0f0f0;
    }
    &::before{
      display: inline-block;
      clear: both;
      content: '';
      position: absolute;
      right: 0;
      top: 0;
      width: 1px;
      height: 100%;
      background:#f0f0f0;
    }
    &:nth-child(5n-5) {
      &::before {
        height: 0;
      }
    }
  }
  .nav_scroll{
    width:100%;
    height:0.90rem;
    background:#fff;
    position: relative;
    overflow: hidden;
    ul{
      white-space: nowrap;
      overflow: hidden;
      height: 100%;
      padding-left: 0.32rem;
      padding-right:1.26rem;
      transition: all 0.2s;
    }
    li{
      cursor: pointer;
      display: inline-block;
      font-size:0.3rem;
      color:#666;
      height: 100%;
      line-height: 0.9rem;
      margin-right:0.6rem;
      position: relative;
      &.on{
        color:#00A5EB;
        &::after{
          content:"";
          width:0.56rem;
          height:0.04rem;
          background:linear-gradient(315deg,rgba(0,136,255,1) 0%,rgba(0,197,255,1) 100%);
          position: absolute;
          bottom: 0px;
          left: 50%;
          transform: translate(-50%);
        }
      }
    }
    .menu_btn{
      cursor: pointer;
      position: absolute;
      right:0;
      top:0;
      width:1rem;
      height:0.9rem;
      background: #fff;
      display: flex;
      .show{
        width:0.40rem;
        height: 0.32rem;
        display: block;
        background:url(~@/assets/epidemic_situation/icon_menu.png) no-repeat;
        background-size: 100%;
        margin: auto;
      }
      .close{
        width: 0.32rem;
        height: 0.32rem;
        display: block;
        background:url(~@/assets/epidemic_situation/icon_close.png) no-repeat;
        background-size: 100%;
        margin: auto;
      }
    }
  }
</style>
