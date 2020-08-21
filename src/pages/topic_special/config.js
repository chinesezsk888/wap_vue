
let apiUrl = ''

if (process.env.VUE_APP_ENV === 'development') {
  apiUrl = 'http://127.0.0.1:3000/topic'
} else if (process.env.VUE_APP_ENV === 'testfordev') {
  apiUrl = 'topicJson.jsp'
} else if (process.env.VUE_APP_ENV === 'production') {
  apiUrl = 'topicJson.jsp'
}

export {
  apiUrl
}
