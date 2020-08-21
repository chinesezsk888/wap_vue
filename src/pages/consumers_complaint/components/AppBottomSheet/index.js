import Vue from 'vue'
import AppBottomSheet from './main.vue'

const AppBottomSheetConstructor = Vue.extend(AppBottomSheet)

const showBottomSheet = function () {
  let instance = new AppBottomSheetConstructor()
  instance.$mount()
  instance.visiable = true
  document.body.appendChild(instance.$el)
}

export default showBottomSheet
