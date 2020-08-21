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
      <div @click="btn2Handle" style="color:#00A5EB;">确认</div>
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
    bottom:0;
    position: absolute;
    .item_list{
      padding:0.48rem 0.4rem 0;
      display: flex;
      flex-flow:wrap;
      justify-content: space-between;
      border-bottom:1px solid #D8D8D8;
      &::after{
        width:1.80rem;
        content:"";
      }
      &::before{
        content:"";
        position: absolute;
        width:1px;
        height:100%;
        height: calc(100% - 0.34rem);
        left: 50%;
        top: 0;
        background: #D8D8D8;
      }
    }
    .item{
      cursor: pointer;
      width:3rem;
      height:0.50rem;
      font-size:0.32rem;
      text-align: center;
      line-height: 0.5rem;
      line-height: calc(0.5rem - 1px);
      color:#333;
      margin-bottom:0.44rem;
      &.select{
        color:#00A5EB;
      }
    }
  }
  .app_select_btn{
    width: 100%;
    height: .72rem;
    font-size: .32rem;
    margin: 0 auto;
    margin-bottom:0.34rem;
    color: #333;
    display: flex;
    justify-content: space-around;
    border-bottom: 1px solid #D8D8D8;
    div{
      cursor: pointer;
      width:100%;
      text-align: center;
      position: relative;
      line-height: 0.72rem;
    }
  }

  /**iphone x**/
@media (device-width: 375px) and (device-height: 812px) and (-webkit-min-device-pixel-ratio : 3){

}

</style>
