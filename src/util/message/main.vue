<template>
<transition name="fade" @after-leave="close">
  <div class="my_msg" v-show="visiable">{{msg}}</div>
</transition>
</template>
<script>
export default {
  name: 'MyMsg',
  props: {
    msg: String,
    visiable: Boolean
  },
  methods: {
    close () {
      this.$destroy()
      this.$el.parentNode.removeChild(this.$el)
    }
  }
}
</script>
