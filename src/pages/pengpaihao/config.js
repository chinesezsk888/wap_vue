
let apiUrl = ''

if (process.env.VUE_APP_ENV === 'development') {
  apiUrl = 'http://127.0.0.1:3000/pengpaihao'
} else if (process.env.VUE_APP_ENV === 'testfordev') {
  apiUrl = 'pphCategoryContList.jsp'
} else if (process.env.VUE_APP_ENV === 'production') {
  apiUrl = 'pphCategoryContList.jsp'
}

export {
  apiUrl
}
