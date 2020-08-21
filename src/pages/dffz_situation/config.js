
let apiUrl = ''
let govPageHref = ''
let govPageId = ''
if (process.env.VUE_APP_ENV === 'development') {
  apiUrl = 'http://10.10.4.70:8892/wap/v6/jsp/user_suggestions_data.jsp?interactionType=1&categoryId=0'
  // apiUrl = 'http://localhost:3000/localDev'
  govPageId = '26256'
  govPageHref = 'channel_' + govPageId
} else if (process.env.VUE_APP_ENV === 'testfordev') {
  apiUrl = 'user_suggestions_data.jsp?interactionType=1'
  govPageId = '26256'
  govPageHref = 'channel_' + govPageId
} else if (process.env.VUE_APP_ENV === 'production') {
  apiUrl = 'user_suggestions_data.jsp?interactionType=1'
  govPageId = '27392'
  govPageHref = 'channel_' + govPageId
}

export {
  apiUrl, govPageHref, govPageId
}
