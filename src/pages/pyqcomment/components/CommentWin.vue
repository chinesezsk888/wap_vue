<template>
    <div class="pyqcomment_win">
        <div class="pyqcomment_win_small" v-show="type==1">
          <!-- <div class="btn" @click="handleSmallBtn">发表你的看法...</div> -->
          <a class="btn" id="vuemoblink_fabiao'" :data-moblink="'demo/a?contType=48&contId='+item.contId" moblink-featured>发表你的看法...</a>
          <div class="zan" :class={ok:isPraise} @click="handleZan(item.contId,item.objectType,item.praiseTimes)">{{item.praiseTimes | shouzan}}</div>
        </div>
        <div class="pyqcomment_win_bg" @click="handleBg" v-show="type==2"></div>
        <div class="pyqcomment_win_big" v-show="type==2">
          <textarea v-model="commenttxt" placeholder="发表你的看法…" ref="textarea" type=submit @submit="handleSubmit(item.contId,item.objectType)"></textarea>
          <div class="clearfix">
            <div class="cancel_btn" @click="handleBg">取消</div>
            <div class="submit_btn" @click="handleSubmit(item.contId,item.objectType)">发表</div>
            <span class="count">{{this.commenttxt.length}}/800</span>
          </div>
        </div>
    </div>
</template>
<script>
import { pyqPraiseInterApi, pyqCommentApi, pageVisitApi, isInWeixin, ZanController } from '@/util/common.js'
export default {
  name: 'CommentWin',
  props: {
    item: Object,
    comment: Function
  },
  data () {
    return {
      type: 1, // 1普通 2评论框
      isPraise: false,
      commenttxt: '',
      isAjax: false // 正在发请求中
    }
  },
  computed: {
    submitStatus () { // 发表是否可用
      if (this.commenttxt.length == 0) {
        return false
      } else {
        return true
      }
    }
  },
  filters: {
    shouzan (value) {
      if (value == 0) {
        return '首赞'
      } else {
        return value
      }
    }
  },
  mounted () {
    if (ZanController.check(this.item.contId)) {
      this.isPraise = true
    }
  },
  methods: {
    handleZan (contId, objectType, praiseTimes) {
      if (this.isPraise) {
        return
      }
      pyqPraiseInterApi({ contId, objectType, praiseTimes }, (res) => {
        if (res.resultCode == 1) {
          if (objectType != 3) {
            ZanController.save(contId, res.praiseTimes)
          }
          this.isPraise = true
          this.item.praiseTimes = res.praiseTimes
        }
      })
    },
    handleSmallBtn () { // 点击发表你的评论  ---取消评论跳转app
      if (isInWeixin()) {
        pageVisitApi('pyq_note_detail_showCommentWinWx')
      } else {
        pageVisitApi('pyq_note_detail_showCommentWin')
      }
      if (!this.isLogin()) {
        this.type = 1
        this.mywindow.lgwdsshow()
        return
      }
      this.type = 2
      this.$nextTick(() => {
        this.$refs.textarea.focus()
      })
    },
    handleBg () {
      this.type = 1
    },
    isLogin () {
      let result = false
      if (this.mywindow.$('#isLogin').val() == 'true') {
        result = true
      }
      return result
    },
    handleSubmit (contId, objectType, commentType = 1) {
      if (this.isAjax || !this.submitStatus) {
        return
      }
      pageVisitApi('pyq_note_detail_fabiao')
      let content = this.commenttxt
      this.isAjax = true
      pyqCommentApi({ contId, objectType, commentType, content }, (res) => {
        if (res.resultCode == 1) {
          this.type = 1
          this.isAjax = false
          this.commenttxt = ''
          this.$emit('comment', '发布成功')
        } else {
          this.isAjax = false
          this.$emit('comment', res.resultMsg)
        }
      })
    }
  }
}
</script>
