<template>
  <div>
    <button @click="buttonHandle">测试弹出框</button>
  </div>
</template>
<script>
import msg from '../../util/message'
import loading from '../../util/loading'
export default {
  name: 'app',
  methods: {
    buttonHandle () {
      msg('msg弹出了')
      loading.show()
      setTimeout(() => {
        loading.hide()
      }, 1000)
    }
  }
}
</script>
