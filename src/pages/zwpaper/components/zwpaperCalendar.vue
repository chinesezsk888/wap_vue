<template>
  <div class="calendar_panel" :class="{close_begin:closeStatus}">
    <div class="title" :style="styleDate"><span class="prev" @click="calendarPrev"></span>{{dateYearMonth}}<span class="next" @click="calendarNext"></span><span class="lastpaper" @click="calendarLast">最新</span></div>
    <div class="calendar">
      <ul class='week'>
          <li>日</li><li>一</li><li>二</li><li>三</li><li>四</li><li>五</li><li>六</li>
      </ul>
      <ul class="days">
        <li v-for="value in calendarData" :key="value.day">
          <div v-if="value.day"
              :class="{ week_usable: value.nodeList,week_current:currentDay==value.day }"
            @click="showList(value.nodeList,value.day)">{{value.day}}</div>
        </li>
      </ul>
    </div>
    <div class="nodelist" v-if="nodeList.length>0">
      <div class="nodeitem" v-for="item in nodeList" :key="item.contId" @click="goDetail(item.contId,item.forwordType)" >
        {{item.name}}
      </div>
    </div>
    <div class="close" @click="closeCalendar">收起</div>
  </div>
</template>
<script>

export default {
  props: {
    bgColor: Object,
    data: Object,
    current: Object,
    newsType: String
  },
  computed: {
    dateYearMonth () { // 1999年7月
      return this.dateInfo.year + '年' + this.dateInfo.month + '月'
    },
    styleDate () {
      let result = {}
      let startColor = this.bgColor.startColor
      if (startColor) {
        let endColor = this.bgColor.endColor
        let fontColor = this.bgColor.fontColor
        result = {
          backgroundImage: 'linear-gradient(134deg, ' + startColor + ' 0%, ' + endColor + ' 100%)',
          color: fontColor
        }
      }
      return result
    }
  },
  data () {
    return {
      dateInfo: {},
      calendar: {},
      nodeList: {},
      calendarData: {},
      currentDay: 0,
      maxDateInfo: {},
      minDateInfo: {},
      currentNodeList: {},
      closeStatus: false
    }
  },
  watch: {
    dateInfo () {
      this.calendarData = this.getCalendarData()
      if (this.currentDay != 0) {
        this.nodeList = this.currentNodeList
      }
    },
    data () {
      this.dateInfo = this.data.dateInfo
      this.calendar = this.data.calendar
    }
  },
  mounted () {
    this.getPageData()
  },
  methods: {
    closeCalendar () {
      this.closeStatus = true
      this.$emit('close')
      setTimeout(() => { this.closeStatus = false }, 800)
    },
    getPageData () {
      if (this.data.resultMsg != 'success') {
        return
      }
      this.dateInfo = this.data.dateInfo // 当前日期
      this.calendar = this.data.calendar // 当前日历
      this.maxDateInfo = this.data.maxDateInfo // 最新日期
      this.minDateInfo = this.data.minDateInfo
      this.currentDay = parseInt(this.current.day) || 0
    },
    getCalendarData () {
      let result = []
      let extra = new Date(this.dateInfo.year, parseInt(this.dateInfo.month) - 1, '01').getDay() // 补充天数
      if (extra == 7) {
        extra = 0
      }
      this.extraday = extra
      let days = new Date(this.dateInfo.year, parseInt(this.dateInfo.month), 0).getDate() // 该月天数
      let dayIndex = '1'
      let maxDay = extra + days // 总共循环次数算上补充，比如1号是星期2，则需要补充星期7，星期1两个空对象
      for (let i = 0; i < maxDay; i++) {
        let temp = {}
        if (i >= extra) { // 补充空结束，放上实际数据
          for (let j = 0; j < this.calendar.length; j++) {
            if (this.calendar[j].day == dayIndex) {
              temp.nodeList = this.calendar[j].nodeList
              if (this.calendar[j].day == this.currentDay) {
                this.currentNodeList = temp.nodeList
              }
              break
            }
          }
          temp.day = dayIndex
          dayIndex++
        }
        result.push(temp)
      }
      return result
    },
    showList (nodelist, day) { // 选中日期
      this.nodeList = nodelist
      this.currentDay = day
    },
    calendarPrev () { // 上一月
      let { month, year } = this.dateInfo
      if (month == 1) {
        year--
        month = 12
      } else {
        month--
      }
      if (getTime({ year, month }) < getTime(this.minDateInfo)) {
        return
      }
      this.sendCalendar(month, year)
    },
    calendarNext () { // 下一月
      let { month, year } = this.dateInfo
      if (month == 12) {
        year++
        month = 1
      } else {
        month++
      }
      if (getTime({ year, month }) > getTime(this.maxDateInfo)) {
        return
      }
      this.sendCalendar(month, year)
    },
    sendCalendar (month, year) {
      month = formitMonth(month)
      this.$emit("getCalendar",year + month,this.newsType)
      if (year + month == this.current.year + formitMonth(this.current.month)) { // 文章相同月保留文章选择信息
        this.currentDay = parseInt(this.current.day) || 0
      } else { // 其余月选择区域置空
        this.currentDay = 0
        this.nodeList = {}
      }
    },
    calendarLast () { // 最新
      let month = formitMonth(this.maxDateInfo.month)
      this.$emit("getCalendar",this.maxDateInfo.year + month,this.newsType)
      this.currentDay = this.maxDateInfo.day // 最新需要默认选 天
    },
    goDetail (contId) {
      window.location.href = document.location.protocol + '//' + window.location.host + window.location.pathname + '?n=' + contId + '&newsType=' + this.newsType
    }
  }
}
// 月份补充0
function formitMonth (month) {
  let result = parseInt(month)
  if (result < 10) {
    result = '0' + result
  } else {
    result = '' + result
  }
  return result
}
// 已知年月获取 距今秒值用于比较
function getTime (date) {
  let { year, month } = date
  return (new Date(year, month)).getTime()
}

</script>
<style lang="scss">
.calendar_panel{
  position: absolute;
  top: 0;
  z-index: 10;
  background: #fff;
  &.show_calendar{
    animation: show 0.8s;
    opacity: 1;
  }
  .title{
    width:100%;
    height:0.86rem;
    font-size: 0.34rem;
    color: #FFF;
    text-align: center;
    background-image: linear-gradient(45deg, #3385DB 0%, #9889CE 100%);
    line-height: 0.86rem;
    position: relative;
  }
  .calendar{
    padding:0.3rem 0.3rem 0.5rem;
  }
  .calendar{
    color: #999;
  }
  .calendar ul{
    display:flex;
    flex-wrap: wrap;
  }
  .week{
    color: #999;
  }
  .week_usable{
    color:#000;
  }
  .week_usable.week_current:after{
    content: " ";
    display: block;
    position: absolute;
    background: #00A5EB;
    width: 0.54rem;
    height: 0.54rem;
    border-radius: 50%;
    z-index: -1;
    top: 50%;
    left: 50%;
    transform: translate(-50%,-50%);
  }
  .week_current{
    position: relative;
    color:#fff;
  }
  .calendar li{
    width:0.98rem;
    height: 0.60rem;
    line-height: 0.60rem;
    text-align: center;
    font-size: 0.28rem;
  }
  .nodelist{
    background: #F6F6F6;
    padding: 0.3rem 0.3rem 0.46rem;
  }
  .nodeitem{
    padding:0.3rem;
    font-size: 0.36rem;
    background: #fff;
    color: #000;
    margin-bottom:0.3rem;
  }
  .next{
    width:0.14rem;
    height:0.26rem;
    display: inline-block;
    background:url(~@/assets/zwpaper/zw_tri.png) no-repeat;
    background-size: 100%;
    margin-left: 0.3rem;
  }
  .prev{
    width:0.14rem;
    height:0.26rem;
    display: inline-block;
    background:url(~@/assets/zwpaper/zw_tri.png) no-repeat;
    background-size: 100%;
    margin-right: 0.3rem;
    transform: rotate(180deg);
  }
  .lastpaper{
    position: absolute;
    right: 0.3rem;
    top: 0;
    font-size: .34rem;
  }
  .close{
    position: absolute;
    bottom:0.2rem;
    left: 50%;
    transform: translate(-50%);
    font-size: 0.2rem;
    color: rgb(0, 165, 235);
  }
  .close_begin{
    animation: close 0.8s;
    opacity: 0;
  }
}
  @keyframes show
  {
    from {opacity: 0;}
    to {opacity: 1;}
  }
  @keyframes close
  {
    from {opacity: 1;}
    to {opacity: 0;}
  }
</style>
