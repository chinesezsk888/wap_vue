<template>
  <div class="divine_judgement"
       v-cloak>
    <div class="dj_header_photo">
      <img class="photo"
           :src="logoPic" />
    </div>
    <div class="dj_time">
      <div class="dt_line"></div>
      <div class="dt_time">
        {{dateInfo.year}}年{{dateInfo.month}}月{{dateInfo.day}}日
      </div>
    </div>
    <!-- 评论卡片 -->
    <div class="dj_crads">
      <div class="dj_comment_card"
           v-for="item in contList"
           :key="item.commentId">
        <!-- 原文部分 -->
        <a class="origin" :href="item.objInfo | ishasUrl">
           <span class="do_word">原文 : </span>
          {{item.objInfo.name}}
        </a>
        <!-- 博主 -->
        <div class="blogger"
             v-if="item.quoteInfo.sname !== undefined && item.quoteInfo.content !== undefined">
          <p class="bg_name">{{item.quoteInfo.sname}}</p>
          <p class="bg_text">{{item.quoteInfo.content}}</p>
        </div>
        <!-- 评论 -->
        <div class="comment">
          <div class="cm_info">
            <div class="ci_left">
              <div class="head_portrait">
                <img :src="item.userInfo.pic">
              </div>
              <div class="message">
                <span>{{item.userInfo.sname}}</span>
                <div class="ms_info">
                  <p class="mi_name"
                     v-if="item.pubTime !='undefined' && item.pubTime.length > 0">{{item.pubTime}}</p>
                  <p
                    class="split_line"
                    v-if="item.userInfo.wonderfulCount.length > 0 && item.pubTime.length > 0"
                  >|</p>
                  <p class="mi_type"
                  v-if="item.userInfo.wonderfulCount !='undefined' && item.userInfo.wonderfulCount.length > 0">已封神<span class="num">{{item.userInfo.wonderfulCount}}</span>次</p>
                </div>
              </div>
            </div>
            <div class="shit_img">
              <div class="si_shenshit si_comment"
                   v-if="item.wonderfulLevel =='1' "></div>
              <div class="si_dashen si_comment"
                   v-if="item.wonderfulLevel =='2' "></div>
              <div class="si_holyshit si_comment"
                   v-if="item.wonderfulLevel =='3' "></div>
              <!-- <img src="./assets/images/holyshit.png"> -->
            </div>
          </div>
          <div class="cm_word">{{item.content}}</div>
          <div class="cm_icon"></div>
        </div>
        <!-- 更多 -->
        <div class="answer">
          <a class="app_answer"
            :id="'vuemoblink_'+(Math.floor(Math.random() * 1001))"
            :data-moblink="item.objInfo | ishaslink"

            moblink-featured>
            打开APP发表回复
          </a>
        </div>
        <!-- 分割线 -->
        <div class="dc_link"></div>
      </div>
    </div>
    <!-- 浏览更多澎友热评 -->
     <a class="dj_more"
       :id="'vuemoblink_'+renderid"
       :data-moblink="'demo/a?contType=47&contId='+renderid"
       moblink-featured>
      打开APP浏览更多澎友热评
    </a>
    <!-- 神评规则介绍 -->
    <a class="dj_rules" @click="showModal">
      <p>澎友热评规则介绍</p>
      <div class="rule_icon"></div>
    </a>
  </div>
</template>

<script>
import { getUrlKey } from '@/util/common.js'
export default {
  name: 'app',
  data () {
    return {
      logoPic: '',
      dateInfo: '',
      contList: [],
      renderid: '',
      isparise: 0
    }
  },
  watch: {},
  computed: {},
  methods: {
    render: function (url) {
      var _this = this
      _this.axios
        .get(url)
        .then(function (res) {
          _this.logoPic = res.data.pic
          _this.dateInfo = res.data.dateInfo
          _this.contList = res.data.contList
          _this.mywindow.goWxshare(res.data.shareInfo)
        })
        .catch(function (error) {
          console.log(error)
        })
    },
    showModal: function () {
      this.mywindow.showShenpingAgree()
    },
    add0: function (n) {
      return n < 10 ? '0' + n : n
    },
    getdataStr: function () {
      var time = new Date()
      var y = time.getFullYear()
      var m = time.getMonth() + 1
      var d = time.getDate()
      return y + this.add0(m) + this.add0(d)
    }
  },
  created () {
    var renderId = getUrlKey('dateStr')
    if (renderId != null) {
      this.renderid = renderId
    }
    if (renderId == null) {
      this.renderid = this.getdataStr()
    }
    this.render('wonderfulCommentsDetailsJson.jsp?dateStr=' + this.renderid)
  },
  updated () {
    this.$nextTick(function () {
      this.mywindow.vueMoblinkInit()
      this.mywindow.initHeadPanel({
        contType: 47,
        contId: this.renderid
      })
      this.mywindow.baseMobLinkInit("a[id^='moblink']")
    })
  },
  filters: {
    ishasUrl: function (obj) {
      if (obj.link === '') {
        return 'newsDetail_forward_' + obj.contId
      } else {
        return obj.link
      }
    },
    ishaslink: function (obj) {
      if (obj.link === '') {
        return 'demo/a?contType=' + obj.forwardType + '&contId=' + obj.contId + '&optType=1'
      } else {
        return 'demo/a?contType=' + obj.forwardType + '&cid=' + obj.contId + '&contId=' + obj.link + '&optType=1'
      }
    }
  }
}
</script>
