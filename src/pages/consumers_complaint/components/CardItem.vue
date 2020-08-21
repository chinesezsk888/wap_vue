<template>
  <div class="card_item">
    <div class="userinfo clearfix">
      <img class="thum" :src="item.userInfo.pic">
      <div class="name">{{name}} · {{item.pubTime}}</div>
      <span :class="{icon_replyed:item.status==3,icon_resolve:item.status==4}"></span>
    </div>
    <div class="complaint_panel">
      <div class="title">{{item.title}}</div>
      <div class="complaint_obj"><span>投诉对象：</span>{{item.complaintObject}}</div>
      <app-txt-fold
        class="description"
        :txt="description"
      ></app-txt-fold>
      <div class="lable hot_label" v-if="item.lable=='置顶'"></div>
    </div>
    <div v-if="item.quoteCont&&item.quoteCont.content">
      <div class="extra_news" @click="extraHandle">
        <img class="news_thum" :src="item.quoteCont.pic" v-if="item.quoteCont.pic">
        <div class="news_title"><b>澎湃跟踪报道：</b>{{item.quoteCont.content}}</div>
      </div>
    </div>
    <template v-else>
      <div v-if="item.response!=''" class="response_panel">
        <app-txt-fold
          class="description"
          :txt="setDescription()"
        ></app-txt-fold>
        <div class="lable response_label"></div>
      </div>
    </template>

  </div>
</template>
<script>
import AppTxtFold from './AppTxtFold'
import { sendH5APP } from '@/util/common.js'
export default {
  name: 'CardItem',
  props: {
    item: Object
  },
  computed: {
    name () {
      if (this.item.userInfo.name.length > 12) {
        return this.item.userInfo.name.substr(0, 12) + '...'
      } else {
        return this.item.userInfo.name
      }
    },
    description () {
      return this.item.description.replace(/\n/g, '<br>')
    }
  },
  components: {
    AppTxtFold
  },
  methods: {
    setDescription () {
      let result = ''
      if (this.item.responseObject != '') {
        result = this.item.responseObject + '：' + this.item.response
      } else {
        result = this.item.response
      }
      result = result.replace(/\n/g, '<br>')
      return result
    },
    extraHandle () {
      if (this.AppStyle == 0) {
        this.mywindow.location.href = this.item.quoteCont.url
      } else {
        let H5APPStr = this.item.quoteCont.forwardType + '|' + this.item.quoteCont.contId
        sendH5APP(H5APPStr)
      }
    }
  }
}
</script>
<style  lang="scss">
  .consumers_complaint {
    .card_item{
      padding:0.4rem 0.3rem;
      margin-bottom:0.4rem;
      background: #fff;
      box-shadow:0px 0px  0.20rem 0px rgba(233,239,245,1);

    }
    .card_item:nth-child(1){
      margin-top:0.94rem;
      box-shadow:0px 2px 0.20rem 0px rgba(233,239,245,1);
    }
    .userinfo{
      position: relative;
      margin-bottom:0.24rem;
      .thum{
        width:0.50rem;
        height:0.50rem;
        border-radius: 50%;
        float:left;
        margin-right:0.2rem;
      }
      .name{
        float:left;
        width:4.86rem;
        line-height: 0.5rem;
        color:#666;
        font-size:0.24rem;
      }
    }

    .icon_replyed{
      width:1.3rem;
      height:0.42rem;
      background: url(~@/assets/consumers_complaint/status_replyed.png) no-repeat;
      background-size:100%;
      display:block;
      position: absolute;
      right: -0.3rem;
    }
    .icon_resolve{
      width:1.3rem;
      height:0.4rem;
      background: url(~@/assets/consumers_complaint/status_resolve.png) no-repeat;
      background-size:100%;
      display:block;
      position: absolute;
      right: -0.3rem;
    }
    .response_panel,
    .complaint_panel{
      padding-left:0.7rem;
      position: relative;
    }
    .response_panel{
      padding-top:0.32rem;
      &::before{
        content: "";
        display: block;
        width: 6.2rem;
        width:calc(100% - 0.7rem);
        background: #C8C8C8;
        height: 1px;
        position: absolute;
        top: 0;
        right: 0;
      }
    }
    .title{
      font-size:0.30rem;
      line-height:0.40rem;
      color:#000;
      margin-bottom:0.16rem;
      font-weight: 700;
    }
    .complaint_obj{
      color:#666;
      font-size:0.24rem;
      line-height:0.30rem;
      margin-bottom:0.3rem;
    }
    .complaint_obj span{
      color:#00A5EB;
      font-size: 0.24rem;
    }
    .description{
      display:block;
      font-size:0.28rem;
      line-height:0.40rem;
      color:#333;
      margin-bottom:0.32rem;
      font-weight: 400;
      div{
        font-size:0.28rem;
      }
    }
    .lable{
      position: absolute;
      left: 0;
      &.hot_label{
        top:0.06rem;
        width:0.6rem;
        height:0.31rem;
        background:url(~@/assets/consumers_complaint/label_zhiding.png) no-repeat;
        background-size:100%;
      }
      &.response_label{
        top: 0.38rem;
        width:0.6rem;
        height:0.31rem;
        background:url(~@/assets/consumers_complaint/label_respon.png) no-repeat;
        background-size:100%;
      }
    }

    .extra_news{
      width: 6.90rem;
      padding: 0.26rem 0.3rem;
      background: rgba(243,244,246,0.75);
      border-radius: 0.06rem;
      display: flex;
      justify-content: space-between;
    }
    .news_thum{
      width:1.60rem;
      height:0.90rem;
    }
    .news_title{
      color:#333;
      width:4.48rem;
      font-size:0.28rem;
      line-height:0.40rem;
    }
  }

</style>
