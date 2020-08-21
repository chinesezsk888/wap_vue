let apiUrl = ''
if (process.env.VUE_APP_ENV === 'development') {
  apiUrl = 'http://localhost:3000/wapVideoDetailRelated'
} else if (process.env.VUE_APP_ENV === 'testfordev') {
  apiUrl = 'getHotVideo.jsp'
} else if (process.env.VUE_APP_ENV === 'production') {
  apiUrl = 'getHotVideo.jsp'
}

export {
  apiUrl
}
