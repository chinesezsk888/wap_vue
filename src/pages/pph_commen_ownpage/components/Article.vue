<template>
   <div class="om_relese_card" v-if="item.dataType == '1'">
        <div class="rc_msg">
            <!-- 发布时间 -->
            <div class="rm_type_time">
                <a class="rt_type commen"
                v-if="item.matrixUser != '' && item.matrixUser.sname != undefined && item.matrixUser.sname !=''"
                    :href="item.matrixUser.url"
                    target="_blank"
                    >
                    {{item.matrixUser.sname | showSname}}
                </a>
                <p class="rt_time commen" v-if="item.pubTime != undefined && item.pubTime != ''">{{item.pubTime}}</p>
            </div>
            <!-- 评论点赞数 -->
            <div class="rc_pldz_box">
                <!-- 评论部分 -->
                <div class="rc_pinglun_box" v-if="item.interactionNum  && item.interactionNum !='0'">
                    <div class="rpb_bgbox"></div>
                    <span>{{item.interactionNum}}</span>
                </div>
              <!-- 点赞数 -->
                <div class="at_zan" @click="handleZanArtice(item.closePraise,item.contId)">
                    <div class="az_bg" :class="{ok:isPraise}" ></div>
                    <!-- <span v-if="item.praiseTimes !='0'">{{item.praiseTimes}}</span> -->
                    <span v-if="showPraiseTimes(item.closePraise,item.praiseTimes)">{{item.praiseTimes}}</span>
                </div>
            </div>
        </div>
        <div class="rc_image_text">
            <a :href="item.contId | newDateil" target="_blank">
                <div class="it_img" v-if="item.pic != undefined && item.pic !=''">
                    <img :src="item.pic">
                    <WaterMark :item="item"></WaterMark>
                </div>
                <div class="it_arctile">
                   {{item.content}}
                </div>
            </a>
        </div>
    </div>
</template>

<script>
import WaterMark from '@/components/WaterMark'
import { articlePraiseApi, ZanController } from '@/util/common.js'
export default {
  name: 'Article',
  components: {
    WaterMark
  },
  props: {
    item: Object
  },
  data () {
    return {
      isPraise: false
    }
  },
  mounted () {
    if (ZanController.check(this.item.contId)) {
      this.isPraise = true
    }
  },
  methods: {
    showPraiseTimes: function (closeparise, parisetime) {
      if ((closeparise && closeparise == 1) || parisetime == '0') {
        return false
      } else {
        return true
      }
    },
    handleZanArtice: function (closePraise, contId) {
      if (this.isPraise || closePraise == 1) {
        return
      }
      articlePraiseApi({ contId }, (res) => {
        if (res.resultCode == 1) {
          this.isPraise = true
          this.item.praiseTimes = res.voteTimes
        }
      })
    }
  },
  filters: {
    newDateil: function (id) {
      return 'newsDetail_forward_' + id
    },
    showSname: function (val) {
      if (val.length > 8) {
        var newVal = val.slice(0, 8) + '...'
        return newVal
      } else {
        return val
      }
    }
  }
}
</script>
