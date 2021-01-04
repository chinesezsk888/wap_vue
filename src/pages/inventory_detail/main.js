import Vue from 'vue'
import axios from 'axios'
import App from './App.vue'
Vue.config.productionTip = false
Vue.prototype.axios = axios
Vue.prototype.mywindow = window

new Vue({
  render: h => h(App)
}).$mount('#app')
