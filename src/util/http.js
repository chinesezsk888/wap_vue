import axios from 'axios'
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded'

const sendHttp = {
  pageVisit (name = 'downloadApp') { // pagevisit
    axios({
      method: 'get',
      url: 'statClick.jsp',
      params: {
        type: name
      }
    })
      .catch(function (error) {
        console.log('pageVisit error ' + error)
      })
  },
  commentPraise (params, success) { // 评论点赞
    axios({
      method: 'post',
      url: '/wap/commentPraise.msp',
      params: {
        commentId: params.commentId,
        origPraiseNum: params.praiseTimes
      }
    }).then(function (res) {
      if (success) success(res.data)
    })
      .catch(function (error) {
        console.log('praise error ' + error)
      })
  },
  pyqPraiseInter (params, success) { // 互动点赞
    axios({
      method: 'post',
      url: '/wap/notePraise.msp',
      params: {
        c: params.contId,
        ot: params.objectType,
        origPraiseNum: params.praiseTimes
      }
    }).then(function (res) {
      if (success) success(res.data)
    })
      .catch(function (error) {
        console.log('praise error ' + error)
      })
  },
  pyqComment (params, success) { // 朋友圈评论
    axios({
      method: 'post',
      url: '/wap/comment.msp',
      params: {
        c: params.contId,
        ot: params.objectType,
        commentType: params.commentType,
        content: params.content
      }
    }).then(function (res) {
      if (success) success(res.data)
    })
      .catch(function (error) {
        console.log('pyqComment error ' + error)
      })
  },
  articlePraise: function (params, success) { // 文章卡片点赞
    axios({
      method: 'post',
      url: '/wap/addVote.msp',
      params: {
        contentId: params.contId
      }
    }).then(function (res) {
      if (success) success(res.data)
    })
      .catch(function (error) {
        console.log('pyqComment error ' + error)
      })
  }
}
export default sendHttp
