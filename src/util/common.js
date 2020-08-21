import sendHttp from './http'

// ?name=a
function getUrlKey (name) {
  return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.href) || ['', ''])[1].replace(/\+/g, '%20')) || null
}


// user_interaction_3333
function getUrlKey2 () {
  let pathname = window.location.pathname
  var index = pathname.lastIndexOf('/')
  let dizhi = pathname.substring(index + 1, pathname.length)
  let index2 = dizhi.lastIndexOf('_')
  let result = false
  if (index2 !== -1) {
    result = dizhi.substring(index2 + 1, dizhi.length)
  }
  return result
}

// 点赞防重复
const ZanController = {
  wlstorage: window.localStorage || null,
  initZan: function (zanArray, callback) {
    for (var zani = 0; zani < zanArray.length; zani++) {
      var obj = zanArray.eq(zani)
      var id = obj.attr('id')
      var zanNum = this.check(id)
      if (zanNum) {
        if (callback) callback(obj, zanNum)
      }
    }
  },
  save: function (str, zanNum) {
    var id = 'zan' + str
    var zanArray = []// 处理前
    var tempArray = []
    if (this.wlstorage) {
      zanArray = this.wlstorage.getItem('zanArray')
      if (zanArray != null && typeof zanArray !== 'undefined') {
        tempArray = zanArray.split(',')
        if (tempArray.length > 500) {
          var delId = tempArray.shift()
          this.wlstorage.removeItem(delId)
        }
      }
      tempArray.push(id)
      zanArray = tempArray.join(',')
      this.wlstorage.setItem('zanArray', zanArray)
      this.wlstorage.setItem(id, zanNum)
    }
  },
  check: function (str) {
    var id = 'zan' + str
    if (this.wlstorage && this.wlstorage.getItem(id) != null) {
      return this.wlstorage.getItem(id)
    } else {
      return false
    }
  }
}

export const getStyle = function (dom, style) {
  let currentStyle = document.defaultView.getComputedStyle(dom, '')
  return dom.style[style] || currentStyle ? currentStyle[style] : null
}
export const getAppStyle = function () { // 判断是否是APP
  let result = 0
  let isInIosApp = window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.thepaperNewsClicked
  let isInAndroidApp = window.thepaper && window.thepaper.newsClicked
  if (isInIosApp) { // ios
    result = 1
  } else if (isInAndroidApp) { // android
    result = 2
  }
  return result
}
const H5APPConfig = {
  thePaperParam: 'thepaper|'
}
export const sendH5APP = function (str) { // 判断是否是APP
  let isInIosApp = window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.thepaperNewsClicked
  let isInAndroidApp = window.thepaper && window.thepaper.newsClicked
  var appLink = H5APPConfig.thePaperParam + str
  console.log(str)
  if (isInIosApp) { // ios
    window.webkit.messageHandlers.thepaperNewsClicked.postMessage(appLink)
  } else if (isInAndroidApp) { // android
    window.thepaper.newsClicked(appLink)
  }
}
export const isInWeixin = function () { // 判断是否在微信
  let wx = navigator.userAgent.toLowerCase()
  if (wx.match(/MicroMessenger/i) === 'micromessenger') {
    return true
  } else {
    return false
  }
}
// app下载方法
export const downloadForApp = function (data) {
  if (getAppStyle() === 2) { // android
    window.thepaper.downloadInfo(data)
  } else {
    window.webkit.messageHandlers.downloadInfo.postMessage(data)
  }
}

const pageVisitApi = sendHttp.pageVisit
const pyqCommentApi = sendHttp.pyqComment
const pyqPraiseInterApi = sendHttp.pyqPraiseInter
const commentPraiseApi = sendHttp.commentPraise
const articlePraiseApi = sendHttp.articlePraise

export {
  ZanController,
  pageVisitApi,
  pyqCommentApi,
  pyqPraiseInterApi,
  commentPraiseApi,
  articlePraiseApi,
  getUrlKey2,
  getUrlKey
}
