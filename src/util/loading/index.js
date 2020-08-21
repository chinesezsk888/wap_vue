import Vue from 'vue'
import main from './main.vue'

const Loading = Vue.extend(main)
let instance = new Loading()

const showLoading = function () {
  instance.$mount()
  document.body.appendChild(instance.$el)
}
const hideLoading = function () {
  instance.$el.parentNode.removeChild(instance.$el)
  instance.$destroy()
}

const loading = {
  show: showLoading,
  hide: hideLoading
}

export default loading
