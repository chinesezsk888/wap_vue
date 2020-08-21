import Vue from 'vue'
import axios from 'axios'
import App from './App.vue'
// import './pyq_ownpage.css'

Vue.prototype.axios = axios

Vue.prototype.mywindow = window

Vue.config.productionTip = false

new Vue({
  render: h => h(App)
}).$mount('#app')
