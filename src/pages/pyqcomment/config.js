
let apiUrl = ''

if (process.env.VUE_APP_ENV === 'development') {
  apiUrl = 'http://192.168.191.1:3000/pyqtz'
} else if (process.env.VUE_APP_ENV === 'testfordev') {
  apiUrl = 'pyq_note_detail_data.jsp'
} else if (process.env.VUE_APP_ENV === 'production') {
  apiUrl = 'pyq_note_detail_data.jsp'
}

export {
  apiUrl
}
