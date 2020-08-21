import Vue from 'vue'
import axios from 'axios'
import App from './App.vue'
import X2js from 'x2js' // xml数据处理插件
Vue.config.productionTip = false
Vue.prototype.axios = axios
Vue.prototype.mywindow = window
Vue.prototype.$x2js = new X2js()

new Vue({
  render: h => h(App)
}).$mount('#app')
