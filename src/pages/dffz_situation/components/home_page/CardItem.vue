<template>
  <div class="card_item">
    <div class="card_item_con">
      <div class="userinfo clearfix">
        <img class="thum" :src="item.userInfo.pic">
        <div class="infor">
          <div class="name">{{name}} · {{item.create_time}}</div>
        </div>
      </div>
      <div class="complaint_panel">
        <div class="title">{{item.title}}</div>
        <div class="extra_infor"><i>{{item.interactionClassify}}-{{item.messagesDomain}}</i> · {{item.area}}</div>
        <app-txt-fold
          class="description"
          :txt="description"
        ></app-txt-fold>
        <div class="lable hot_label" v-if="item.lable=='置顶'"></div>
      </div>
      <div v-if="item.response && item.response!=''" class="response_panel">
        <app-txt-fold
          class="description"
          :txt="response"
        ></app-txt-fold>
        <div class="lable response_label"></div>
      </div>
    </div>
  </div>
</template>
<script>
import AppTxtFold from './AppTxtFold'
export default {
  name: 'CardItem',
  data () {
    return {
      type: 1, // 1普通 2跟帖
      commenttxt: ''
      // isAjax: false // 正在发请求中
    }
  },
  props: {
    item: Object
    // comment: Function
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
    },
    response () {
      return this.item.response.replace(/\n/g, '<br>')
    },
    submitStatus () { // 发表是否可用
      if (this.commenttxt.length == 0) {
        return false
      } else {
        return true
      }
    }
  },
  components: {
    AppTxtFold
  },
  directives: {
    focus: function (el) {
      el.focus()
    }
  }
}
</script>
<style  lang="scss">
  .epidemic_situation {
    .card_item_con{
      padding:0.5rem 0.5rem 0.6rem 0.3rem;
    }
    .card_item{
      background: #fff;
      margin-bottom:0.2rem;
      box-shadow:0px 0px  0.20rem 0px rgba(233,239,245,1);
    }
    .card_item:nth-child(1){
      margin-top:0.94rem;
      box-shadow:0px 2px 0.20rem 0px rgba(233,239,245,1);
    }
    .follow_talk{
      font-size:0.28rem;
      color:#999;
      border-top:1px solid #D8D8D8;
      text-align: center;
      padding:0.3rem 0 0.2rem;
      cursor: pointer;
    }
    .userinfo{
      position: relative;
      margin-bottom:0.28rem;
      display: flex;
      align-items: center;
      .thum{
        width:0.54rem;
        height:0.54rem;
        border-radius: 50%;
        margin-right:0.16rem;
      }
      .infor{
        width:6rem;
        margin-top: -0.04rem;
      }
      .name{
        color:#333;
        font-size:0.28rem;
      }
    }

    .response_panel,
    .complaint_panel{
      padding-left:0.7rem;
      position: relative;
    }
    .complaint_panel{
      .extra_infor{
        color:#666;
        font-size:0.24rem;
        margin-bottom: 0.2rem;
        i{
          color:#00A5EB;
          font-style: normal;
        }
      }
    }
    .response_panel{
      padding-top:0.20rem;
      margin-top: 0.4rem;
      &::before{
        content: "";
        display: block;
        width: 6.2rem;
        width:calc(100% - 0.7rem);
        background: #f0f0f0;
        height: 1px;
        position: absolute;
        top: 0;
        right: 0;
      }
    }
    .title{
      font-size:0.32rem;
      line-height:0.40rem;
      color:#000;
      margin-bottom:0.2rem;
      font-weight: 500;
    }
    .description{
      display:block;
      font-size:0.32rem;
      line-height:0.40rem;
      color:#666;
      font-weight: 400;
    }
    .lable{
      position: absolute;
      left: 0;
      &.hot_label{
        top:0.06rem;
        width:0.6rem;
        height:0.32rem;
        background:url(~@/assets/epidemic_situation/label_zhiding.png) no-repeat;
        background-size:100%;
      }
      &.response_label{
        top: 0.25rem;
        width:0.6rem;
        height:0.32rem;
        background:url(~@/assets/epidemic_situation/label_respon.png) no-repeat;
        background-size:100%;
      }
    }
    .follow__poater {
      width: 100%;
      height: 100%;
      position: fixed;
      top: 0;
      left:0;
      z-index: 99;
      .nav_bg {
        width: 100%;
        height: 100%;
        background:rgba(19,19,19,0.5);
        z-index: 99;
      }
      .clearfix {
        width:100%;
        height: 2.04rem;
        background:rgba(255,255,255,1);
        position: absolute;
        bottom: 0;
        left: 0;
        padding: 0.68rem 0.3rem 0.2rem;
        z-index: 999;
        textarea {
          width: 100%;
          height: 0.6rem;
          background:rgba(248,249,249,1);
          box-shadow:-0.02rem -0.02rem 0.04rem 0 rgba(197,197,197,0.5);
          opacity:0.85;
          border:none;
          margin-bottom: 0.2rem;
          font-size: 0.3rem;
        }
        .count {
          text-align: right;
          span {
            &:nth-child(1) {
              font-size:0.24rem;
              font-weight:normal;
              color:rgba(51,51,51,1);
              line-height:0.28rem;
              margin-right: 0.2rem;
            }
            &:nth-child(2) {
              font-size: 0.3rem;
              font-weight:normal;
              color:rgba(153,153,153,1);
              line-height:0.36rem;
            }
          }
        }
      }
    }
  }

</style>
