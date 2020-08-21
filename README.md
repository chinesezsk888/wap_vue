##页面说明
pages/pengpaihao pp号首页
pages/divine_judgement APP神评分享页 无入口
pages/pph_commen_ownpage pp号详情页（朋友圈页面）
pages/pyqcomment 朋友圈评论详情页
pages/yiyu_topic 专栏未使用--采用jquery混合vue方式，实际代码不是这里。直接在jsp中
pages/topic_special 专题详情页
pages/consumers_complaint 质量报告
pages/epidemic_situation 抗疫情建言 其中 ReplyPanelOri.vue 是传统回调地狱版本，废弃
pages/zwpaper 早晚报
pages/video_detail wap六周年视频详情热门推荐
##css
为了部署方便 将css独立出来。因此css源码没有在vue项目中而是在jsp的相关目录

从consumers_complaint 质量报告项目之后css源码放在vue项目中

```
  "buildtest": "vue-cli-service build --mode test",   打包测试环境 css与js 不会进行拆分

  "buildprod": "vue-cli-service build --mode prod",   打包正式环境 css与js 不会进行拆分

  "buildlocal": "vue-cli-service build --mode local",  打包本地环境--css与js 会进行拆分
```


todo---使用Tree-Shaking进行优化
----参考 https://juejin.im/post/5a4dc842518825698e7279a9
----参考 https://segmentfault.com/a/1190000016330896


