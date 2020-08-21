<template>
  <div class="pyq_comment_item " :class="{pyq_comment_itemtz:item.userInfo&&item.userInfo.userLable == '题主'}">
    <a class="pyq_comment_thum" :href="item.userInfo.url">
        <img :src="item.userInfo.pic">
        <span v-if="item.userInfo.isAuth == 1" class="icon_vip"></span>
    </a>
    <div class="pyq_comment_info">
        <a :href="item.userInfo.url">
            <div class="name">{{item.userName}}</div>
            <div class="date">{{item.pubTime}}</div>
        </a>
        <div class="handle">
          <div class="zan" :class={ok:isPraise} @click="handleZan(item.commentId,item.objectType,item.praiseTimes)" >{{item.praiseTimes | zannum}}</div>
          <a class="reply" :id="'vuemoblink_'+item.commentId" :data-moblink="'demo/a?contType=48&contId='+contentId" moblink-featured>回复</a>
        </div>

    </div>
    <div class="pyq_comment_con">
        {{item.content}}
    </div>
  </div>
</template>
<script>
import { commentPraiseApi, ZanController } from '@/util/common.js'
export default {
  name: 'CommentItem',
  props: {
    item: Object,
    contentId: String
  },
  data () {
    return {
      isPraise: false
    }
  },
  filters: {
    zannum (value) {
      if (value == 0) {
        return ''
      } else {
        return value
      }
    }
  },
  mounted () {
    if (ZanController.check(this.item.commentId)) {
      this.isPraise = true
    }
  },
  methods: {
    handleZan (commentId, praiseTimes) {
      if (this.isPraise) {
        return
      }
      commentPraiseApi({ commentId, praiseTimes }, (res) => {
        if (res.resultCode == 1) {
          ZanController.save(commentId, res.praiseTimes)
          this.isPraise = true
          this.item.praiseTimes = res.praiseTimes
        }
      })
    }
  }
}
</script>
