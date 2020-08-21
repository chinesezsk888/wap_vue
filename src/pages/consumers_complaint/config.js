
let apiUrl = ''
let allPageHref = ''
let homePageHref = ''
let allPageId = ''
let weixinQrcode = ''

if (process.env.VUE_APP_ENV === 'development') {
  apiUrl = 'http://192.168.191.1:3000/zlbg'
  homePageHref = 'http://www.baidu.com'
  allPageId = '26888'
  allPageHref = 'http://www.baidu.com'
  weixinQrcode = '//139.196.248.235:8089/wap/resource/v3/img/cc_weixin_qrcode.png'
} else if (process.env.VUE_APP_ENV === 'testfordev') {
  apiUrl = 'consumer_complaint_data.jsp'
  homePageHref = 'http://139.196.248.235:8089/wap/v3/jsp/index.jsp'
  allPageId = '26888'
  allPageHref = 'list_' + allPageId
  weixinQrcode = '//139.196.248.235:8089/wap/resource/v3/img/cc_weixin_qrcode.png'
} else if (process.env.VUE_APP_ENV === 'production') {
  apiUrl = 'consumer_complaint_data.jsp'
  homePageHref = 'https://m.thepaper.cn/'
  allPageId = '25464'
  allPageHref = 'list_' + allPageId
  weixinQrcode = '//file.thepaper.cn/wap/v3/img/cc_weixin_qrcode.png'
}

export {
  apiUrl, allPageHref, homePageHref, allPageId, weixinQrcode
}
