<template>
  <div class="myloading">
    <div></div>
  </div>
</template>
<style lang="scss">
  .myloading{
    position: fixed;
    z-index: 10000;
    width: 100%;
    height: 100%;
    top:0;
    left:0;
    div{
      width: 0.60rem;
      height: 0.6rem;
      background: rgba(51,51,51,1);
      position: absolute;
      border-radius: 0.06rem;
      top: 50%;
      left: 50%;
      transform: translate(-50%,-50%);
      &::after{
        content:'';
        background: url("../../assets/consumers_complaint/icon_loading.png") no-repeat;
        background-size: 100%;
        position: absolute;
        animation: spinning 1.5s infinite linear;
        top:0;
        left:0;
        width:100%;
        height:100%;
      }
    }
  }
  @keyframes spinning
  {
  0%   {transform: rotate(0deg);}
  100% {transform: rotate(360deg);}
  }
</style>
