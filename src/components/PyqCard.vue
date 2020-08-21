<template>
    <div>
        <div class="own_all_type" v-if="item.dataType == '0'">
            <!-- 主题点赞部分 -->
            <div class="all_top"  v-show="showZanDate">
                <!-- 发布时间 -->
                <div class="at_time_box">
                    <a class="at_time" v-if="item.pubTime != ''" href="javascript:void(0)">
                        {{item.pubTime}}
                    </a>
                </div>
                <!-- 评论点赞数 -->
                <div class="rc_pldz_box">
                    <!-- 评论部分 -->
                    <div class="rc_pinglun_box" v-if="item.interactionNum  && item.interactionNum !='0'">
                        <div class="rpb_bgbox"></div>
                        <span>{{item.interactionNum}}</span>
                    </div>
                    <!-- 点赞 -->
                    <div class="at_zan" @click="handleZan(item.contId,item.objectType,item.praiseTimes)">
                        <div class="az_bg" :class="{ok:isPraise}" ></div>
                        <span v-if="item.praiseTimes !='0'">{{item.praiseTimes}}</span>
                    </div>
                </div>
            </div>
            <!-- 文字部分 -->
            <div class="all_word">
                <template v-if="item.topicWord&&item.topicWord.word != ''" >
                    <a class="aw_topword" :id="'vuemoblink_word'+item.topicWord.wordId" :data-moblink="'demo/a?contType=49&contId='+item.topicWord.wordId" moblink-featured >
                        {{item.topicWord.word}}
                    </a>
                </template>
                <a class="all_word_word" href="javascript:void(0)" v-html="item.content" v-if="showZanDate">{{item.content | langName(122) }}</a>
                <a class="all_word_word" v-html="getTrueContent()" v-else></a>

                <a :href="item.linkCont.link" class="all_word_link" v-if="item.linkCont.name != undefined &&item.linkCont.name!=''">
                    <span class="wl_bg"></span>
                    <span>{{item.linkCont.name}}</span>
                </a>
            </div>
            <!-- 视频部分 -->
            <div class="all_video"
                v-if="item.videoList.length>0&& item.videoList[0].url !=undefined &&item.videoList[0].url !=''">
                <video
                    x5-playsinline=""
                    webkit-playsinline=""
                    playsinline=""
                    x-webkit-airplay="allow"
                    preload="preload"
                    controls="controls"
                    :poster="item.videoList[0].coverPic"
                >
                <source
                    :src="item.videoList[0].url">
                    <div class="picv">
                        <a :href="item.videoList[0].url" class="m"></a>
                        <a :href="item.videoList[0].coverPic" alt="111"></a>
                    </div>
                </video>
            </div>

            <template v-if="item.imageList.length != 0">
                <div class="all_photo_box allphotosm" v-if="smimgClass(item.imageList)">
                    <div v-for="img in item.imageList" @click="showImg(img.url,item.imageList)" :style="{backgroundImage:'url('+img.previewPic+')'}" :key="img.url" class="pyq_img"></div>
                </div>
                <div class="all_photo_box" v-else
                    :class="{ 'allphotoml': mlimgClass(item.imageList), 'allphotolg': lgimgClass(item.imageList)}">
                    <img :src="item.imageList[0].previewPic" @click="showImg(item.imageList[0].url,item.imageList)" class="pyq_img">
                </div>
            </template>

            <!-- 超链接 -->
            <div class="link_box" v-if="item.quoteCont.content !=undefined && item.quoteCont.content !=''">
                <!-- 非圆桌问吧结构 -->
                <div class="all_link link"
                v-if="item.quoteCont.contType!=''&&item.quoteCont.contType<=3"
                >
                    <div class="link_icon"
                    :class="{articlepic:item.quoteCont.contType=='1',askpic:item.quoteCont.contType=='2',resultpic:item.quoteCont.contType=='3'}">

                    </div>
                    <div class="link_word">
                        <a class="text" :href="item.quoteCont.url | ishasUrl ">{{item.quoteCont.content | langName(39)}}</a>
                    </div>
                </div>
                <!-- 圆桌问吧结构 -->
                <div class="all_link_as link"
                v-if="item.quoteCont.contType!=''&&item.quoteCont.contType>3">
                    <a class="text_indents" :href="item.quoteCont.url">
                        <span class="title_types"
                            :class="{desk: item.quoteCont.contType== '5', ask: item.quoteCont.contType== '4'}">
                        </span>
                        {{item.quoteCont.content}}
                    </a>
                </div>
            </div>
            <vote-panel :data="item.voteObject" v-if="item.voteObject!=null&&item.voteObject!= undefined&&item.voteObject.title!=undefined"></vote-panel>
            <!-- 定位 -->
            <div class="all_area" v-if="item.location != ''">
                <div class="aa_icon">
                </div>
                <p class="aa_adress">{{item.location}}</p>
            </div>
        </div>

    </div>
</template>
<script>
// 话题词moblink contType = 49
import { pyqPraiseInterApi, ZanController } from '../util/common.js'
import VotePanel from '../components/VotePanel'
export default {
  name: 'PyqCard',
  props: {
    item: Object,
    showZanDate: Boolean // false 从帖子详情页过来不显示点赞和时间
  },
  data () {
    return {
      isPraise: false
    }
  },
  filters: {
    ishasUrl: function (url) {
      if (url == '') {
        return 'javascript:void(0)'
      } else {
        return url
      }
    },
    langName: function (value, length) { // 更多专题字数超出
      if (value.length > length) {
        value = value.substr(0, length - 1) + '...'
      }
      return value
    }
  },
  components: {
    VotePanel
  },
  mounted () {
    if (ZanController.check(this.item.contId)) {
      this.isPraise = true
    }
  },
  methods: {
    getTrueContent () {
      return this.item.content.replace(/\n/g, '<br>')
    },
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
    showImg (url, imageList) {
      this.$emit('showImg', url, imageList)
    },
    smimgClass (dom) {
      let result = false
      if (dom.length > 1) {
        result = true
      }
      return result
    },
    mlimgClass (dom) {
      let result = false
      if (dom.length < 2) {
        if (Number(dom[0].height) > Number(dom[0].width)) {
          result = true
        }
      }
      return result
    },
    lgimgClass (dom) {
      let result = false
      if (dom.length < 2) {
        if (Number(dom[0].height) < Number(dom[0].width)) {
          result = true
        }
      }
      return result
    }
  }
}
</script>
