import Vue from 'vue'
import Main from './main.vue'

let MessageConstructor = Vue.extend(Main)

const Message = function (msg) {
  let instance = new MessageConstructor({
    propsData: {
      msg: msg
    }
  })
  instance.$mount()
  instance.visiable = true
  document.body.appendChild(instance.$el)
  setTimeout(() => {
    instance.visiable = false
  }, 2400)
}
export default Message
