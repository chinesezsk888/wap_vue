<template>
  <div class="pyq_comment_header clearfix">
      <a :href="item.url">
        <div class="thum">
            <img :src="item.pic">
            <span class="icon_vip" v-if="item.isAuth==1"></span>
        </div>
        <div class="author_infor">
            <div>
                <span class="name">{{item.sname}}</span><span class="label" v-if="item.userLable!=''">{{item.userLable}}</span>
            </div>
            <div class="date">{{getDate()}}</div>
        </div>
      </a>
      <a class="link_app" id="vuemoblink_ch"  :data-moblink="'demo/a?contType=31&contId='+item.userId+'&optType='+item.userType" moblink-featured >通过APP关注</a>
  </div>
</template>
<script>
export default {
  name: 'MyHeader',
  props: {
    item: Object,
    pubTime: String
  },
  methods: {
    getDate () {
      if (this.item.isAuth == 0) {
        return this.pubTime
      } else {
        return this.item.perDesc
      }
    }
  }
}
</script>
