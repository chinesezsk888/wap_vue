<template>
  <div class="pyq_comment" v-cloak>
    <div class="pyq_loading" v-show="isLoading"></div>
    <template v-if="resultCode == 5">
      <div class="pyq_comment_empty">
        <div class="empty_img"></div>
        <div class="txt">帖子已下线</div>
      </div>
    </template>
    <template  v-if="resultCode == 1">
      <MyHeader :item="userInfo" :pubTime="content.pubTime"></MyHeader>
      <div class="nomargin">
        <PyqCard :item="content" @showImg="SwiperImgShow"  :showZanDate="false"></PyqCard>
      </div>
      <a class="link_btn" id="vuemoblink_more" :data-moblink="'demo/a?contType=52&contId=-12'" @click="sendPv('pyq_note_detail_more')" moblink-featured >打开澎湃新闻APP，看澎友圈更多热议</a>
      <div class="pyq_comment_line"></div>
      <div class="pyq_comment_label">评论</div>
      <div v-if="commentList.length>0">
        <template v-for="item in commentList" >
          <CommentItem :item="item" :key="item.commentId" :contentId="content.contId"></CommentItem>
        </template>
      </div>
      <div class="pyq_comment_empty" v-else>
        <div class="empty_img"></div>
        <div class="txt">暂时还没有评论</div>
        <div class="btn" @click="handleEmpty">发表评论</div>
      </div>
      <a v-if="noteCommentNum>3" id="vuemoblink_morec" class="link_btn" @click="sendPv('pyq_note_detail_morecomment')" :data-moblink="'demo/a?contType=48&contId='+content.contId" moblink-featured >打开澎湃新闻APP，看全部评论</a>
      <CommentWin :item="content"  ref="footwin" @comment="CommentHandle"></CommentWin>
    </template>
    <SwiperImg :imgList="winImgArray" :index="winImgIndex" :class="{show:winImgflag}"  @close="SwiperImgClose"></SwiperImg>
  </div>
</template>
<script>
import { getUrlKey2, pageVisitApi } from '@/util/common.js'
import CommentItem from './components/CommentItem'
import MyHeader from './components/MyHeader'
import PyqCard from '@/components/PyqCard'
import CommentWin from './components/CommentWin'
import SwiperImg from '@/components/SwiperImg'
import msgAlert from '@/util/message'
import { apiUrl } from './config.js'
export default {
  name: 'app',
  data () {
    return {
      commentList: [], // 评论列表
      content: {}, // 帖子内容
      resultCode: -1,
      resultMsg: '',
      userInfo: {}, // 发帖人用户信息
      noteCommentNum: 0, // 实际评论数量
      isLoading: true,
      winImgArray: [], // 图片预览集合
      winImgUrl: '',
      winImgIndex: '-1',
      winImgflag: false, // 图片播放控件显示隐藏
      userId: '',
      errorMsg: ''
    }
  },
  components: {
    CommentItem, MyHeader, PyqCard, CommentWin, SwiperImg
  },
  created () {
    this.sendPv('pyq_note_detail_visit')
    this.getPageData()
  },
  updated () {
    this.mywindow.initHeadPanel({
      contType: 48,
      contId: this.content.contId
    })
    this.mywindow.baseMobLinkInit("a[id^='moblink']")
    this.mywindow.vueMoblinkInit()
  },
  methods: {
    CommentHandle (msg) {
      msgAlert(msg)
      this.getPageData()
    },
    sendPv (name) {
      pageVisitApi(name)
    },
    getImgIndex () {
      let result = -1
      for (let [key, value] of new Map(this.winImgArray.map((value, key) => [key, value]))) {
        if (value == this.winImgUrl) {
          result = key
        }
      }
      return result
    },
    SwiperImgShow (url) {
      this.winImgUrl = url
      this.winImgIndex = this.getImgIndex()
      this.winImgflag = true
    },
    SwiperImgClose () {
      this.winImgUrl = ''
      this.winImgflag = false
    },
    getImageUrl (imageList) {
      let winImgArrayTemp = []
      if (imageList) {
        for (let j = 0; j < imageList.length; j++) {
          var img = imageList[j]
          if (img && img.url) {
            winImgArrayTemp.push(img.url)
          }
        }
      }
      return winImgArrayTemp
    },
    handleEmpty () {
      this.$refs.footwin.handleSmallBtn()
    },
    addData (res) {
      let resp = res.data
      this.resultCode = resp.resultCode
      if (resp.resultCode == 1) {
        if (typeof (this.content.userInfo) != 'undefined') { // 有数据则表示要局部刷新评论
          this.commentList = resp.commentList
        } else {
          let headMobStr = 'demo/a?contType=48&contId=' + resp.content.contId
          this.mywindow.initHeaderMob(headMobStr)
          this.commentList = resp.commentList
          this.content = resp.content
          this.userInfo = this.content.userInfo
          this.resultMsg = resp.resultMsg
          this.noteCommentNum = resp.noteCommentNum
          this.userId = this.userInfo.userId
          /*
          let winImgArrayTemp = this.getImageUrl(resp.content.imageList);
          this.winImgArray =  this.winImgArray.concat(winImgArrayTemp);
          */
          this.winImgArray = this.getImageUrl(resp.content.imageList)
        }
      } else {
        console.log('请稍后重试' + resp.resultMsg)
      }
    },
    getPageData (url = apiUrl) {
      let c = getUrlKey2()
      if (c && c != '') {
        url += '?c=' + c
      }
      this.axios.get(url)
        .then(res => {
          this.addData(res)
          this.isLoading = false
        })
        .catch(() => {
          console.log('请稍后重试')
        })
    }
  }
}
</script>
