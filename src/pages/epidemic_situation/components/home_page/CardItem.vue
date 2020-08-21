<template>
  <div class="card_item">
    <div class="userinfo clearfix">
      <img class="thum" :src="item.userInfo.pic">
      <div class="infor">
        <div class="name">{{name}}</div>
        <div class="extra_infor">{{item.create_time}} · {{item.area}}</div>
      </div>
    </div>
    <div class="complaint_panel">
      <div class="title">{{item.title}}</div>
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
</template>
<script>
import AppTxtFold from './AppTxtFold'
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
    },
    response () {
      return this.item.response.replace(/\n/g, '<br>')
    }
  },
  components: {
    AppTxtFold
  }
}
</script>
<style  lang="scss">
  .epidemic_situation {
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
        width:0.60rem;
        height:0.60rem;
        border-radius: 50%;
        float:left;
        margin-right:0.1rem;
      }
      .infor{
        float:left;
        width:6rem;
        margin-top: -0.04rem;
      }
      .name{
        color:#333;
        font-size:0.28rem;
      }
      .extra_infor{
        color:#666;
        font-size:0.26rem;
      }
    }

    .response_panel,
    .complaint_panel{
      padding-left:0.7rem;
      position: relative;
    }
    .response_panel{
      padding-top:0.30rem;
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
      font-size:0.32rem;
      line-height:0.40rem;
      color:#000;
      margin-bottom:0.16rem;
      font-weight: 700;
    }
    .description{
      display:block;
      font-size:0.32rem;
      line-height:0.40rem;
      color:#666;
      margin-bottom:0.27rem;
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
        top: 0.38rem;
        width:0.6rem;
        height:0.32rem;
        background:url(~@/assets/epidemic_situation/label_respon.png) no-repeat;
        background-size:100%;
      }
    }
  }

</style>
