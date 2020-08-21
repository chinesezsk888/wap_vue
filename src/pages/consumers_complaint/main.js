import Vue from 'vue'
import axios from 'axios'
import App from './App.vue'
import { getAppStyle } from '../../util/common'
Vue.prototype.axios = axios
Vue.prototype.mywindow = window
Vue.prototype.AppStyle = getAppStyle()

Vue.config.productionTip = false

new Vue({
  render: h => h(App)
}).$mount('#app')
