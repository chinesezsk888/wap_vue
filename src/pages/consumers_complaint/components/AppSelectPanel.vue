<template>
  <div class="app_select_panel" @click.stop>
    <div class="item_list">
      <div class="item"
        :class="{select:item[propertyId] == userSelectItem[propertyId]}"
        @click="selectItem(item)"
        v-for="item in itemList"
        :key="item[propertyId]">{{item[propertyTxt]}}</div>
    </div>
    <div class="app_select_btn">
      <div @click="btn1Handle">取消</div>
      <div @click="btn2Handle">确认</div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'AppSelectPanel',
  props: {
    itemList: Array,
    propertyId: {
      type: String,
      default: 'id'
    },
    propertyTxt: {
      type: String,
      default: 'name'
    }
  },
  data () {
    return {
      userSelectItem: ''
    }
  },
  methods: {
    btn2Handle () {
      this.$emit('btn2', this.userSelectItem)
    },
    btn1Handle () {
      this.clearValue()
      this.$emit('btn1', this.userSelectItem)
    },
    selectItem (item) {
      this.userSelectItem = item
    },
    clearValue () {
      this.userSelectItem = ''
    }
  }
}
</script>
<style lang="scss">
  .app_select_panel{
    width: 100%;
    background:#FFF;
    border-radius:0.24rem 0.24rem 0px 0px;
    bottom:0;
    position: absolute;
    .item_list{
      padding:0.48rem 0.4rem 0;
      display: flex;
      flex-flow:wrap;
      justify-content: space-between;
      &::after{
        width:1.80rem;
        content:"";
      }
    }
    .item{
      width:1.80rem;
      height:0.50rem;
      border-radius:0.05rem;
      border:1px solid #C8C8C8;
      font-size:0.28rem;
      text-align: center;
      line-height: 0.5rem;
      line-height: calc(0.5rem - 1px);
      color:#333;
      margin-bottom:0.44rem;
      &.select{
        color:#00A5EB;
        border:1px solid #00A5EB;
      }
    }
  }
  .app_select_btn{
    width: 6.70rem;
    height: .72rem;
    border: 1px solid #C8C8C8;
    font-size: .32rem;
    border-radius:0.04rem;
    margin: 0 auto;
    color: #333;
    margin-bottom: 0.6rem;
    display: flex;
    justify-content: space-around;
    div{
      width:100%;
      text-align: center;
      position: relative;
      line-height: 0.72rem;
    }
    div:first-child::after{
      content: "";
      height:100%;
      width: 1px;
      position: absolute;
      background: #C8C8C8;
      right: 0;
    }
  }

  /**iphone x**/
@media (device-width: 375px) and (device-height: 812px) and (-webkit-min-device-pixel-ratio : 3){

}

</style>
