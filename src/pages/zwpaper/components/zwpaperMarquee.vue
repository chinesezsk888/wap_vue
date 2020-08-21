<template>
  <div class="marquee">
    <div class="msg_panel" ref="msgpanel">
      <div ref="msg" class="msg">{{msg}}</div>
    </div>
    <div class="_msg" ref="_msg">{{msg}}</div>
  </div>
</template>
<script>
export default {
  name: 'zwpaperMarquee',
  props: {
    msg: String
  },
  methods: {
    move () {
      let fatherWidth = this.$refs.msgpanel.offsetWidth
      let width = this.$refs._msg.offsetWidth
      this.$refs.msg.style.width = (width + 10) + 'px'
      let distance = 0
      setInterval(() => {
        distance = distance - 1
        if (-distance >= width) {
          distance = fatherWidth
        }
        this.$refs.msg.style.transform = 'translateX(' + distance + 'px)'
      }, 50)
    }
  },
  mounte () {
    this.move()
  }
}
</script>
<style lang="scss">
.marquee{
  font-size:inherit;
.msg_panel{
  overflow: hidden;
  width:100%;
  font-size:inherit;
}
.msg{
  text-align: left;
  white-space: nowrap;
  font-size:inherit;
}
._msg{
  position: absolute;
  z-index: -10;
  font-size:inherit;
  top:-99999px;
  left:-99999px;
}
}
</style>
