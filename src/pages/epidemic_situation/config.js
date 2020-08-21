
let apiUrl = ''
let govPageHref = ''
let govPageId = ''
if (process.env.VUE_APP_ENV === 'development') {
  apiUrl = 'http://127.0.0.1:3000/yiqing'
  govPageId = '26256'
  govPageHref = 'channel_' + govPageId
} else if (process.env.VUE_APP_ENV === 'testfordev') {
  apiUrl = 'epidemic_situation_data.jsp'
  govPageId = '26256'
  govPageHref = 'channel_' + govPageId
} else if (process.env.VUE_APP_ENV === 'production') {
  apiUrl = 'epidemic_situation_data.jsp'
  govPageId = '27392'
  govPageHref = 'channel_' + govPageId
}

export {
  apiUrl, govPageHref, govPageId
}
