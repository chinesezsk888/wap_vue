module.exports = {
  outputDir: process.env.outputDir,
  publicPath: '/wap/v3/',
  filenameHashing: false,
  productionSourceMap: false,
  pages: {
    pengpaihao: {
      entry: './src/pages/pengpaihao/main.js',
      template: './src/pages/pengpaihao/index.html',
      filename: 'pengpaihao.html'
    },
    divine_judgement: {
      entry: './src/pages/divine_judgement/main.js',
      template: './src/pages/divine_judgement/index.html',
      filename: 'divine_judgement.html'
    },
    pph_commen_ownpage: {
      entry: './src/pages/pph_commen_ownpage/main.js',
      template: './src/pages/pph_commen_ownpage/index.html',
      filename: 'pph_commen_ownpage.html'
    },
    pyqcomment: {
      entry: './src/pages/pyqcomment/main.js',
      template: './src/pages/pyqcomment/index.html',
      filename: 'pyqcomment.html'
    },
    example: {
      entry: './src/example/message/main.js',
      template: './src/example/message/index.html',
      filename: 'example.html'
    },
    consumers_complaint: {
      entry: './src/pages/consumers_complaint/main.js',
      template: './src/pages/consumers_complaint/index.html',
      filename: 'consumers_complaint.html'
    },
    epidemic_situation: {
      entry: './src/pages/epidemic_situation/main.js',
      template: './src/pages/epidemic_situation/index.html',
      filename: 'epidemic_situation.html'
    },
    index: {
      entry: './src/pages/index/main.js',
      template: './src/pages/index/index.html',
      filename: 'index1.html'
    },
    topic_special: {
      entry: './src/pages/topic_special/main.js',
      template: './src/pages/topic_special/index.html',
      filename: 'topic_special.html'
    },
    zwpaper: {
      entry: './src/pages/zwpaper/main.js',
      template: './src/pages/zwpaper/index.html',
      filename: 'zwpaper.html'
    },
    video_detail: {
      entry: './src/pages/video_detail/main.js',
      template: './src/pages/video_detail/index.html',
      filename: 'video_detail.html'
    },
    dffz_situation: {
      entry: './src/pages/dffz_situation/main.js',
      template: './src/pages/dffz_situation/index.html',
      filename: 'dffz_situation.html'
    },
    inventory_detail : {
      entry: './src/pages/inventory_detail/main.js',
      template: './src/pages/inventory_detail/index.html',
      filename: 'inventory_detail.html'
    }
  },
  configureWebpack: config => {
    if (process.env.VUE_APP_ENV != 'development') {
      config.optimization.splitChunks.cacheGroups.vendors.name = 'vue_vendors'
      config.optimization.splitChunks.cacheGroups.common.minSize = 100000
      config.optimization.splitChunks.cacheGroups.vendors.minSize = 100000
      config.optimization.splitChunks.minSize = 100000
    }
  },
  chainWebpack: config => {
    config.module
      .rule('images')
      .use('url-loader')
      .loader('url-loader')
      .tap(options => Object.assign(options, { limit: 20000 }))
  }
}
