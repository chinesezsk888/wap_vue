
import jsonList from './json'
let apiUrl = ''
if (process.env.VUE_APP_ENV === 'development') {
  apiUrl = jsonList
} else if (process.env.VUE_APP_ENV === 'testfordev') {
  apiUrl = 'pengyou_inventory_details.jsp'
} else if (process.env.VUE_APP_ENV === 'production') {
  apiUrl = 'pengyou_inventory_details.jsp'
}

export {
  apiUrl
}
