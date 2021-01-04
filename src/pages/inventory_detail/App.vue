<template>
  <div class="py_list_page">
    <div class="list_icon_box">
       <div class="list_icon"></div>
    </div>
    <div class="user_info">
      <a :href="userInfo.url">
        <img class="ui_img" :src="userInfo.pic">
      </a>
      <p class="ui_name">{{userInfo.sname}}</p>
      <p class="ui_title">{{listname}}</p>
      <p class="ui_des">{{listSummary}}</p>
    </div>
    <div class="py_card">
      <div v-for="(item,index) in pyCardList" :key='index+"listitem"' class="listitem">
        <listItem
        :title="item.name"
        :summary="item.summary"
        :img-url="item.pic"
        :detail-link="item.href"
        ></listItem>
      </div>
    </div>
    <!-- <a href="javascript:void(0);" ref="moblinkList" id="moblink_py_list" class="py_list_gomob" moblink-featured>打开APP，阅读体验更佳</a> -->
    <a class="py_list_gomob"
       :id="'vuemoblink_'+inventoryId"
       :data-moblink="'demo/a?contType=61&contId='+inventoryId"
       moblink-featured>
      打开APP，阅读体验更佳
    </a>
  </div>
</template>

<script>
import listItem from './components/listItem'
import { apiUrl } from './config.js'
import { getUrlKey } from '@/util/common.js'
export default {
  data(){
    return {
      userInfo: {},
      pyCardList: [],
      shareTitle: '',
      shareSummary: '',
      sharePic: '',
      listname: '',
      listSummary: '',
      inventoryId: ''
    }
  },
  components: {
    listItem
  },
  updated () {
    this.$nextTick(function () {
      this.mywindow.vueMoblinkInit()
      this.mywindow.initHeadPanel({
        contType: 61,
        contId: this.inventoryId
      })
      this.mywindow.baseMobLinkInit("a[id^='moblink']")
      })
    },
  methods:{
    getPageData(url) {
      let inventoryId = getUrlKey('inventoryId')
      let addUrl = url
      if (inventoryId && inventoryId !='') {
        addUrl += '?inventoryId=' + inventoryId
      }
      this.axios.get(addUrl)
      .then(res => {
        let resp = res.data
        this.userInfo = resp.inventory.userInfo
        this.pyCardList = resp.inventory.contList
        this.listname = resp.inventory.name
        this.listSummary = resp.inventory.summary
        this.shareTitle = resp.inventory.shareTitle
        this.shareSummary = resp.inventory.shareSummary
        this.sharePic = resp.inventory.sharePic
        this.inventoryId = resp.inventory.inventoryId
        this.mywindow.wxShare({
          title: this.shareTitle,
          desc: this.shareSummary,
          link: this.mywindow.location.href,
          img: this.sharePic
        })
      }).catch(() => {
        console.log('请稍后重试')
      })
    }
  },
  created(){
    this.getPageData(apiUrl)
    // this.userInfo = jsonList.inventory.userInfo
    // this.pyCardList = jsonList.inventory.contList
  }
}
</script>
<style lang="scss">
* {
  padding: 0;
  margin: 0;
}
ul,ol,li {
  list-style: none;
}
a {
  text-decoration: none;
}
.py_list_page {
  width: 100%;
  min-height: 100%;
  background: #F8F9F9;
  padding-top: 1.32rem;
  .list_icon_box {
    width: 100%;
    height: 0.66rem;
    padding: 0 0.3rem;
    position: relative;
    box-sizing: border-box;
     .list_icon {
      position: absolute;
      width: 0.84rem;
      height: 0.66rem;
      background: url(~@/assets/inventory_detail/pl_icon.png) center no-repeat;
      background-size: 100% 100%;
      right: 0.7rem;
      bottom: 0.14rem;
    }
  }
  .list_icon_box::before {
    content: '';
    clear: both;
    display: inline-block;
    position: absolute;
    width: 5.72rem;
    height: 0.04rem;
    background: linear-gradient(270deg, #00A5EB 0%, #000000 30%, #000000 100%);
    left: 0.3rem;
    top: 0;
  }
  .list_icon_box::after {
    content: '';
    clear: both;
    display: inline-block;
    position: absolute;
    right: 0.3rem;
    top: 0;
    width: 0.4rem;
    height: 0.04rem;
    background: #000000;
  }
  .user_info {
    width: 100%;
    margin:  0.26rem auto 0;
    padding: 0 0.9rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    box-sizing: border-box;
    margin-bottom: 0.6rem;
    a {
      display: inline-block;
      width: 1.6rem;
      height: 1.6rem;
      border-radius: 0.3rem;
      margin-bottom: 0.1rem;
      .ui_img {
        width: 100%;
        height: 100%;
        border-radius: 0.3rem;
      }
    }
    .ui_name {
      font-size: 0.28rem;
      font-weight: 400;
      color: #000000;
      line-height: 0.34rem;
      margin-bottom: 0.2rem;
    }
    .ui_title {
      font-size: 0.4rem;
      font-weight: 600;
      color: #000000;
      line-height: 0.448rem;
      margin-bottom: 0.1rem;
    }
    .ui_des {
      font-size: 0.24rem;
      font-weight: 400;
      color: #999999;
      line-height: 0.285rem;
      text-align: center;
    }
  }
  .py_card {
    width: 100%;
    background: #F8F9F9;
    box-shadow: 0 -0.06rem 0.1rem -0.04rem rgba(222, 228, 230, 0.6);
    border-radius: 0.2rem;
    padding: 0.6rem 0.6rem 0;
    margin-bottom: 0.9rem;
    box-sizing: border-box;
    .listitem {
      margin-bottom: 0.62rem;
    }
  }
  .py_list_gomob {
    display: block;
    width: 6.5rem;
    height: 0.9rem;
    background: linear-gradient(140deg, #00CBF7 0%, #00A5EB 100%);
    margin: 0 auto 0.8rem;
    font-size: 0.36rem;
    font-weight: 400;
    color: #FFFFFF;
    display: flex;
    align-items: center;
    justify-content: center;
  }
}
</style>
