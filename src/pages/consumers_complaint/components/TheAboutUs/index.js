import Vue from 'vue'
import AboutUs from './main.vue'

const AboutUsConstructor = Vue.extend(AboutUs)

const showAboutUs = function (scrollTop) {
  let instance = new AboutUsConstructor()
  instance.$mount()
  instance.visiable = true
  instance.scrollTop = scrollTop
  document.body.appendChild(instance.$el)
}

export default showAboutUs
