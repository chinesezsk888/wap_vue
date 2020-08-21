<template>
  <div class="vote__panel">
    <div class="vote__title">{{data.title}}</div>
    <div class="vote__count">{{data.voteNum}}人参与</div>
    <div class="vote__itemlist" :class="{'vote__itemlist--select':selectOptionId!=-1}" ref="voteList">
      <div class="vote__item" :class="{'vote__item--select':selectOptionId==item.optionId}" v-for="item in data.optionList" :key="item.optionId" @click="addVote(item.optionId,1)">
        <div class="vote__item__con__bg">{{item.name}}</div>
        <div class="vote__item__con">{{item.name}}<span class="vote__item__percent">{{votePercentListAction[item.optionId]}}</span></div>
        <div class="vote__item__bg" :style="{width:votePercentList[item.optionId]}"></div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'VotePanel',
  props: {
    data: Object
  },
  data () {
    return {
      voteCountList: {}, // 记录投票数
      votePercentList: {}, // 记录投票百分比
      votePercentListAction: {}, // 展示数据，用来做变化效果
      selectOptionId: -1,
      saved: false// 客户端保存是否投票过，投票过不能继续投
    }
  },
  created () {
    this.resetVote()
    let saveOptionId = this.checkIsSave()
    if (saveOptionId != '-1') {
      // 直接展示
      this.addVote(saveOptionId, 0)
      this.saved = true
    }
  },
  methods: {
    resetVote () { // 重置投票
      let optionList = this.data.optionList
      for (let item of optionList) {
        this.voteCountList[item.optionId] = item.voteCount
        this.votePercentListAction[item.optionId] = 0
      }
    },
    getVoteStorage () { // 获取storage中投票数据
      let wlstorage = window.localStorage
      let voteStorageStr = wlstorage.getItem('voteStorage') || '{}'
      let voteStorage = JSON.parse(voteStorageStr)
      return voteStorage
    },
    checkIsSave () { // 判断当前投票是否保存，若存在则返回选项id
      let voteStorage = this.getVoteStorage()
      let optionId = voteStorage[this.data.voteId] || '-1'
      return optionId
    },
    saveVote (optionId) { // 投票保存storage中，key 投票id value 选项id
      let voteStorage = this.getVoteStorage()
      let voteId = this.data.voteId
      voteStorage[voteId] = optionId
      let voteStorageStr = JSON.stringify(voteStorage)
      window.localStorage.setItem('voteStorage', voteStorageStr)
    },
    getMaxVoteOptionId () { // 获取投票数最多的选项Id
      let maxVoteCount = -1
      let maxOptionId = -1
      for (let optionId in this.voteCountList) {
        let voteCount = parseInt(this.voteCountList[optionId])
        if (maxVoteCount < voteCount) {
          maxVoteCount = voteCount
          maxOptionId = optionId
        }
      }
      return maxOptionId
    },
    voteAnimate () { // 百分比动画
      let that = this
      let perActionIndex = 1
      let perActionTimer = setInterval(() => {
        let tempObject = {}
        for (let optionId in that.votePercentList) {
          if (perActionIndex == 9) {
            tempObject[optionId] = that.votePercentList[optionId]
          } else {
            let voteCount = parseInt(that.votePercentList[optionId])
            tempObject[optionId] = Math.round(voteCount / 10 * perActionIndex) + '%'
          }
        }
        that.votePercentListAction = tempObject
        perActionIndex++
        if (perActionIndex == 10) {
          clearInterval(perActionTimer)
          perActionTimer = null
        }
      }, 40) // 400好秒运行10次变化 因此变化间隔时间为400/10
    },
    changePercent (maxOptionId) { // 最大值采用1-其他计算
      let otherTotalPer = 0 // 排除最大值其余比例和
      for (let optionId in this.voteCountList) {
        let voteCount = parseInt(this.voteCountList[optionId])
        if (maxOptionId != optionId) {
          let bl = Math.round(voteCount / this.data.voteNum * 100)
          if (voteCount != 0 && bl == 0) {
            bl = 1
          }
          this.votePercentList[optionId] = bl + '%'
          otherTotalPer += bl
        }
      }
      this.votePercentList[maxOptionId] = (100 - otherTotalPer) + '%'
    },
    sendAjax (optionId, success, error) {
      this.axios({
        method: 'post',
        url: '/wap/addContentNoteVote.msp',
        params: {
          optionId: optionId,
          voteId: this.data.voteId
        }
      }).then(res => {
        if (res.data.resultCode == 1) {
          if (success) success()
        }
      })
        .catch(() => {
          if (error) error()
        })
    },
    dealAdd (optionId, newVote) {
      this.voteCountList[optionId] = newVote
      let maxOptionId = this.getMaxVoteOptionId()
      this.changePercent(maxOptionId)
      this.voteAnimate()
      this.saveVote(optionId)
    },
    addVote (optionId, num) {
      if (this.saved) {
        return
      }
      if (this.selectOptionId == -1) {
        this.data.voteNum = parseInt(this.data.voteNum) + num
      }
      this.resetVote()
      this.selectOptionId = optionId
      let newVote = parseInt(this.voteCountList[optionId]) + num
      this.saved = true
      var that = this
      if (num != 0) { // 为零设置初始状态不需要发请求
        this.sendAjax(optionId, function () {
          that.dealAdd(optionId, newVote)
        }, function () {
          that.saved = false
        })
      } else {
        that.dealAdd(optionId, newVote)
      }
    }
  }
}
</script>
<style lang="scss">
  .vote__panel,.vote__panel *{box-sizing:border-box}
  .vote__panel{
    width:100%;
    background:#F6F6F6;
    padding:0.4rem 0.2rem 0.56rem;
    margin-bottom:0.6rem;
    line-height: 0.4rem;
  }
  .vote__title{
    font-size:0.32rem;
    line-height:0.42rem;
    color:#000;
    padding-left:0.54rem;
    position: relative;
    &::before{
      content:"";
      position: absolute;
      top:0;
      left:0;
      background: url("../assets/vote/vote_icon.png") no-repeat;
      width:0.44rem;
      height:0.44rem;
      background-size:100%;
    }
  }
  .vote__count{
    font-size:0.20rem;
    color:#666;
    padding-left:0.78rem;
    position: relative;
    span{
      font-size:0.20rem;
    }
    &::before{
      content:"";
      position: absolute;
      top: 0.1rem;
      left:0.54rem;
      background: url("../assets/vote/fire.png") no-repeat;
      width:0.20rem;
      height:0.20rem;
      background-size:100%;
    }
  }
  .vote__itemlist{
    margin-top:0.22rem;
  }
  .vote__item{
    height:auto;
    width:100%;
    min-height: 0.8rem;
    background: #FFF;
    color:#333;
    font-size:0.30rem;
    margin-bottom:0.02rem;
    box-sizing: content-box;
    position: relative;
  }
  .vote__item__con{
    width: 100%;
    height:100%;
    font-size:0.3rem;
    padding: 0.18rem 1.16rem 0.2rem 0.54rem;
    z-index: 10;
    position: absolute;
    top: 0;
    left: 0;
  }
  .vote__item__bg{
    width:0px;
    height:100%;
    position: absolute;
    top:0;
    left:0;
    z-index: 5;
    background: #eceeee;
    transition: width 0.4s;
  }
  .vote__item--select{
    color:#00A5EB;
    border:1px solid #00A5EB;
    transform: translate(-1px);
    .vote__item__percent{
      color:#00A5EB;
    }
    .vote__item__bg{
      background: #F2FBFF;
    }
  }
  .vote__itemlist--select{
    .vote__item__percent{
      display: block;
    }
    .vote__item__bg{
      display: block;
    }
  }
  .vote__item__percent{
    position: absolute;
    top: 50%;
    transform: translate(0,-50%);
    right:0.3rem;
    font-size:0.28rem;
    color:#333;
    display:none;
  }
  .vote__item__con__bg{
    width: 100%;
    height:100%;
    font-size:0.3rem;
    padding: 0.18rem 1.16rem 0.2rem 0.54rem;
    visibility: hidden;
  }
</style>
