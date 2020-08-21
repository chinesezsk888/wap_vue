<template>
  <div class="ad_panel" v-if="banner!=''">
    <a class="ad_link" :href="link" @click="clickHandle"><img :src="banner"></a>
  </div>
</template>
<script>
export default {
  name: 'zwpaperAditem',
  props: {
    url: String
  },
  data () {
    return {
      banner: '',
      link: '',
      clickMonitor: ''
    }
  },
  created () {
    this.getData()
  },
  methods: {
    getData () {
      this.axios.get(this.url)
        .then(res => {
          let data = this.$x2js.xml2js(res.data)
          if (data && data.link) {
            this.banner = this.httpToSlash(data.link.creative)
            this.link = this.httpToSlash(data.link.click)
            this.clickMonitor = this.httpToSlash(data.link.clickMonitor)
          }
        }).catch(() => {
          console.log('请稍后重试')
        })
    },
    httpToSlash (url) { // 将 http://或者https:// 转为//
      if (typeof (url) != 'undefined') {
        if (url.indexOf('https:') === 0) {
          url = url.replace('https:', '')
        } else if (url.indexOf('http:') === 0) {
          url = url.replace('http:', '')
        }
      } else {
        url = ''
      }
      return url
    },
    clickHandle () {
      let url = this.httpToSlash(this.clickMonitor)
      this.axios.get(url)
        .then(() => {

        }).catch(() => {
          console.log('请稍后重试')
        })
    }
  }

}
</script>
<style lang="scss">
.ad_panel{
  padding:0 0.4rem;
  background: #fff;
  position: relative;
  margin:0.2rem;
.ad_link{
  width:100%;
}
.ad_link img{
  width:100%;
}
.label{
  position: absolute;
  border: 1px solid #AFAFAF;
  height:0.34rem;
  width:0.6rem;
  color: #AFAFAF;
  text-align: center;
  font-size: 0.16rem;
  top:0.2rem;
  right:0.6rem;
}
}
@media screen and (max-width: 360px){
  .ad_panel .label{
    height: .4rem;
    width: .7rem;
  }
}
</style>
