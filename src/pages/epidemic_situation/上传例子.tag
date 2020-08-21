<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="bqk.jsp"%>
<c:set var="VERSION" value="?v=6.4.1"/>
<cms:node var="channel" nodeid="${EXCELLENT_NODEID}" />
<c:set var="AD" value="${fn:split(channel.adSudoku31,',')}" scope="request"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-language" content="zh-CN" />
<meta name="Description" content="澎湃，澎湃新闻，澎湃新闻网，新闻与思想，澎湃是植根于中国上海的时政思想类互联网平台，以最活跃的原创新闻与最冷静的思想分析为两翼，是互联网技术创新与新闻价值传承的结合体，致力于问答式新闻与新闻追踪功能的实践。" />
<meta name="Keywords" content="澎湃，Paper，The Paper，热问答，新闻跟踪，政治，时政，政经，澎湃新闻，新闻，思想，原创新闻，突发新闻，独家报道，上海报业，东方早报，东方报业，上海东方报业" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="renderer" content="webkit">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=0.8, minimum-scale=0.8, maximum-scale=3.0, user-scalable=yes">
<title>申请澎湃号湃客个人_澎湃新闻-The Paper</title>
<link rel="shortcut icon" href="${resourceRoot}/img/thepaper.ico" mce_href="${resourceRoot}/img/thepaper.ico" type="image/x-icon">
<link rel="icon" href="${resourceRoot}/img/thepaper.ico" mce_href="${resourceRoot}/img/thepaper.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${resourceRoot}/css/css.css${VERSION}"/>
<link rel="stylesheet" type="text/css" href="${resourceRoot}/css/style.css${VERSION}"/>
<link rel="stylesheet" type="text/css" href="${resourceRoot}/css/news.css${VERSION}"/>
<link rel="stylesheet" type="text/css" href="${resourceRoot}/css/info.css${VERSION}"/>
<link rel="stylesheet" type="text/css" href="${resourceRoot}/css/pph_culvet_comment.css${VERSION}"/>
<%-- 裁剪头像样式文件 --%>
<link rel="stylesheet" type="text/css" href="${resourceRoot}/css/jquery.Jcrop.css"/>
<link rel="stylesheet" type="text/css" href="${resourceRoot}/css/paperhao.css"/>
<script type="text/javascript" src="${resourceRoot}/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${resourceRoot}/js/main-3.0.js${VERSION}"></script>
<script type="text/javascript" src="${resourceRoot}/js/login.js${VERSION}"></script>
<script type="text/javascript" src="${resourceRoot}/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="${resourceRoot}/js/jquery.leanModal.min.js"></script>
<%-- 裁剪头像插件 --%>
<script type="text/javascript" src="${resourceRoot}/js/ajaxFileUpload.js"></script>
<script type="text/javascript" src="${resourceRoot}/js/jquery.Jcrop.js"></script>
<script type="text/javascript" src="${resourceRoot}/js/dropwin.js"></script>
</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<cms:systemConfig key="SPARKER_CHANNEL_NODEID"  var="SPARKER_CHANNELID"/>
<div class="bdwd main clearfix pph_comment">
    <div class="main_lt" data-user="${sessionScope.userInfo}" data-type="${sessionScope.userInfo.userType}">
       <%-- 面包屑导航 --%>
        <div class="pm_bread_card">
            <a href="channel_${SPARKER_CHANNELID}">澎湃号</a>
            <span>></span>
            <a href="pph_apply.jsp?typechange=plain">申请成为澎湃号</a>
            <span>></span>
            <a href="pph_apply.jsp?typechange=paike">湃客</a>
            <span>></span>
            <a href="javascript:void(0)">个人</a>
        </div>
         <%-- 主体表单 --%>
        <form class="pm_testform" id="pm_testform">
            <p class="pm_material">基本资料</p>
            <!-- 账号名称 -->
            <div class="pm_inputbox">
                <div class="pm_it_info">
                    <p class="pm_star">*</p>
                    <p class="pm_info_type pm_account_name">账号名称</p>
                </div>
                <p class="pm_it_input">
                    <input type="text" class="pm_info_input input_from_error" name="userName" id="pm_accountname"
                        placeholder="请输入名称"  data-isauth="${sessionScope.userInfo.isAuth}">
                </p>
            </div>
            <!-- 账号头像 -->
            <div class="pm_filebox">
                <div class="pm_it_info">
                    <p class="pm_star">*</p>
                    <p class="pm_info_type pm_head_portrait">账号头像</p>
                </div>
                <div class="pm_file_input">
                    <div class="pm_add_image">
                        <div class="updateimg"></div>
                        <p class="upword">上传头像</p>
                    </div>
                    <input type="file" class="pm_inputimg input_from_error" id="pm_inputimg" name="upload" accept="image/png,image/jpeg">
                    <cms:userinfo userid="${sessionScope.userInfo.userId}" var="user" imageAddr="${portalUrl}"/>
                    <div class="pm_image_panel" data-url="${user.pic}">
                        <div class="pm_remove_img">x</div>
                        <img id="pm_showImg">
                    </div>
                    <div class="pm_add_headerimg_infor">
                        <span>头像尺寸需要大于300X300像素</span>
                        <div class="pm_sm_btnbox">
                            <div class="pm_head_portrait_filebtn pm_filebtn">上传头像</div>
                            <input type="file" class="pm_sm_inputimg input_from_error" id="pm_sm_inputimg" name="upload"
                            accept="image/png,image/jpeg">
                        </div>
                    </div>
                </div>
            </div>
            <!-- 下拉菜单1 -->
            <!-- select下拉选框中不能设置默认值 -->
            <div class="pm_dropdown">
                <p class="pm_dr_address">所属地区</p>
                <div class="pm_dr_btn">
                    <div id="pm_productText" data-area="${sessionScope.userInfo.area}">请选择</div>
                    <div class="pm_caret_box">
                        <span class="pm_caret"></span>
                    </div>
                </div>
                <ul class="pm_dropdown_menu pm_menu">
                    <li><a href="javascript:void(0)">上海</a></li>
                    <li><a href="javascript:void(0)">北京</a></li>
                    <li><a href="javascript:void(0)">安徽</a></li>
                    <li><a href="javascript:void(0)">澳门</a></li>
                    <li><a href="javascript:void(0)">河北</a></li>
                    <li><a href="javascript:void(0)">山西</a></li>
                    <li><a href="javascript:void(0)">内蒙古</a></li>
                    <li><a href="javascript:void(0)">辽宁</a></li>
                    <li><a href="javascript:void(0)">吉林</a></li>
                    <li><a href="javascript:void(0)">黑龙江</a></li>
                    <li><a href="javascript:void(0)">江苏</a></li>
                    <li><a href="javascript:void(0)">浙江</a></li>
                    <li><a href="javascript:void(0)">福建</a></li>
                    <li><a href="javascript:void(0)">江西</a></li>
                    <li><a href="javascript:void(0)">山东</a></li>
                    <li><a href="javascript:void(0)">河南</a></li>
                    <li><a href="javascript:void(0)">湖北</a></li>
                    <li><a href="javascript:void(0)">湖南</a></li>
                    <li><a href="javascript:void(0)">广东</a></li>
                    <li><a href="javascript:void(0)">广西</a></li>
                    <li><a href="javascript:void(0)">海南</a></li>
                    <li><a href="javascript:void(0)">四川</a></li>
                    <li><a href="javascript:void(0)">贵州</a></li>
                    <li><a href="javascript:void(0)">云南</a></li>
                    <li><a href="javascript:void(0)">陕西</a></li>
                    <li><a href="javascript:void(0)">甘肃</a></li>
                    <li><a href="javascript:void(0)">青海</a></li>
                    <li><a href="javascript:void(0)">西藏</a></li>
                    <li><a href="javascript:void(0)">宁夏</a></li>
                    <li><a href="javascript:void(0)">台湾</a></li>
                    <li><a href="javascript:void(0)">重庆</a></li>
                    <li><a href="javascript:void(0)">香港</a></li>
                    <li><a href="javascript:void(0)">新疆</a></li>
                </ul>
            </div>
             <!-- 创作领域 -->
            <div class="pm_dropdown_creation">
                <div class="pm_it_info pm_dr_address">
                    <p class="pm_star">*</p>
                    <p class="pm_info_type pm_main_title">创作领域</p>
                </div>
                 <input type="hidden" class="creation_check input_from_error" name="creation_check" id="creation_check">
                <div class="pm_dr_btn">
                    <div id="pdc_productText" data-create-field-id="">请选择</div>
                    <div class="pdc_caret_box">
                        <span class="pm_caret"></span>
                    </div>
                </div>
                <ul class="pm_creation_menu pm_menu">
                	<cms:systemConfig key="SPARKER_CANDIDATE_NODE_ID" var="SPARKER_CANDIDATE_NODE_ID"/>
                	<cms:systemConfig key="PORTAL_SPARKER_CREATE_FIELD_FILTER_NODEID" var="PORTAL_SPARKER_CREATE_FIELD_FILTER_NODEID"/>
                	<cms:systemConfig key="SPARKER_DEFAULT_SAVE_CONTENT_NODE_ID" var="SPARKER_DEFAULT_SAVE_CONTENT_NODE_ID"/>
                	<cms:nodenet nodeid="${SPARKER_CANDIDATE_NODE_ID}" pagesize="20" var="nodeList"/>
                	<c:forEach items="${nodeList}" var="categoryNode">
                		<c:if test="${categoryNode.nodeId != SPARKER_DEFAULT_SAVE_CONTENT_NODE_ID && !fn:contains(PORTAL_SPARKER_CREATE_FIELD_FILTER_NODEID,categoryNode.nodeId)}">
                			<li data-create-field-id="${categoryNode.nodeId}"><a href="javascript:void(0)">${fn:replace(categoryNode.name,'候选_','')}</a></li>
                		</c:if>
                	</c:forEach>
                    <li data-create-field-id=""><a href="javascript:void(0)">其他</a></li>
                </ul>
            </div>
            <!-- 账号简介 -->
            <div class="pm_textareabox">
                <div class="pm_it_info">
                    <p class="pm_star">*</p>
                    <p class="pm_info_type pm_account_name">账号简介</p>
                </div>
                <div class="pm_textarea_input">
                    <textarea type="text" class="pm_textarea input_from_error" name="pm_textarea"
                        placeholder="可填写个人介绍（身份、专业领域等、创作方向等）。该信息将向用户展示。" rows="5"></textarea>
                    <p class="pt_wordnub"><span class="pw_number">0</span>/200<p>
                </div>
            </div>
            <!-- 申请函 -->
            <div class="pm_apply_culvert">
                <div class="pm_it_info">
                    <p class="pm_star">*</p>
                    <p class="pm_info_type">申请函</p>
                </div>
                <div class="pm_culvert_input">
                    <div class="pm_add_apply_file">
                        <div class="updateimg"></div>
                        <p class="upword">上传申请函</p>
                    </div>
                    <input type="file" class="pm_culvertbox input_from_error" id="pm_culvertbox" name="pm_culvertbox"
                        multiple="multiple" accept="image/png,image/jpeg">
                    <div class="pm_culvert_panel_box">
                        <div class="pm_add_image_infor">
                            <div class="pm_updowm_box">
                                下载<a href="https://file.thepaper.cn/www/v3/img/澎湃号在线开号申请公函-湃客号个人-v2.docx" class="pm_updowm">
                                    <icon></icon>申请函模版
                                </a>填写并签字后，上传申请函的扫描件或数码照。
                            </div>
                            <div class="pm_sm_culverbox">
                                <div class="pm_sm_culverbtn pm_filebtn">上传申请函</div>
                                <input type="file" class="pm_sm_culvertipt input_from_error" id="pm_sm_culvertipt"
                                    name="pm_sm_culvertipt" multiple="multiple" accept="image/png,image/jpeg">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 作品链接 -->
            <div class="pm_opus_box">
                <div class="pm_it_info">
                    <p class="pm_star">*</p>
                    <p class="pm_info_type pm_opus_name">作品链接</p>
                </div>
                <div class="pm_textarea_input">
                    <textarea type="text" class="pm_opus input_from_error" name="pm_opus"
                        placeholder="附上以往发布内容的作品链接。该信息将用于澎湃号专业创作者认证。" rows="5"></textarea>
                    <p class="pt_opus_wordnub"><span class="pw_opus_number">0</span>/400</p>
                </div>
            </div>
            <!-- 运营者信息 -->
            <p class="pm_username_info">运营者信息</p>
            <div class="pm_inputbox">
                <div class="pm_it_info">
                    <p class="pm_star">*</p>
                    <p class="pm_info_type pm_username">运营者姓名</p>
                </div>
                <p class="pm_it_input">
                    <input type="text" class="pm_info_input input_from_error" name="operatorName" id="pm_username" placeholder="请与上传的身份证证件姓名保持一致">
                </p>
            </div>
            <div class="pm_inputbox">
                <div class="pm_it_info">
                    <p class="pm_info_type pm_username_contact">联系方式</p>
                </div>
                <div class="pm_contact_ipt">
                    <div class="pm_it_input must_info">
                        <p class="pi_star">*</p>
                        <input type="tel" class="pm_tel_input input_from_error" name="tel" id="pm_tel" placeholder="手机号">
                    </div>
                    <div class="pm_it_input">
                        <input type="text" class="pm_weixin_input input_from_error" name="weChat" id="pm_weixin" placeholder="微信">
                    </div>
                    <div class="pm_it_input">
                        <input type="text" class="pm_email_input input_from_error" name="email" id="pm_email" placeholder="邮箱">
                    </div>
                </div>
            </div>
            <!-- 身份证 -->
            <div class="pm_idcard">
                <div class="pm_it_info">
                    <p class="pm_star">*</p>
                    <p class="pm_info_type">身份证</p>
                    <input type="hidden" class="idcard_hi input_from_error" name="idcard_hi" id="idcard_hi">
                </div>
                <div>
                    <div class="up_idcard">
                        <div class="focade_idcard ui_idcard">
                            <div class="add_idcard">
                                <div class="update_idcard update_idcard_z"></div>
                                <div class="up_icon_box">
                                    <p class="up_icon"></p>
                                    <p class="upword">上传身份证正面</p>
                                </div>
                            </div>
                            <input type="file" class="idcard_ipt idcard_iptz input_from_error" id="idcard_iptz" name="idcard_ipt" accept="image/png,image/jpeg">
                            <div class="ui_idcard_img">
                                <div class="ui_remove_idcard">x</div>
                                <img id="ui_showidcard" class="ui_showidcard">
                            </div>
                        </div>
                        <div class="back_idcard ui_idcard">
                            <div class="add_idcard">
                                <div class="update_idcard update_idcard_f"></div>
                                <div class="up_icon_box">
                                    <p class="up_icon"></p>
                                    <p class="upword">上传身份证反面</p>
                                </div>
                            </div>
                            <input type="file" class="idcard_ipt idcard_iptf input_from_error" id="idcard_iptf" name="idcard_ipt" accept="image/png,image/jpeg">
                            <div class="ui_idcard_img">
                                <div class="ui_remove_idcard">x</div>
                                <img id="ui_showidcard" class="ui_showidcard">
                            </div>
                        </div>
                    </div>
                    
                    <p class="ui_info">请手持身份证拍摄（身份证正反面各一张）。勿遮挡面部，且保证身份证件上的信息清晰可见。</p>
                </div>
            </div>
            <!-- 同意协议 -->
            <div class="pm_agreement_box">
                <div class="pm_true_box"></div>
                <p>
                    <span class="pm_word">同意</span>
                    <span class="pm_agreement"><a href="javascript:void(0)">《澎湃号平台服务协议》</a></span>
                </p>
            </div>
            <!-- 提交按钮 上一步按钮 -->
            <div class="pm_btns_box">
                <button id="pm_last_page" type="button" onclick="history.go(-1)">上一步</button>
                <button id="pm_submitBtn" type="button">提交申请</button>
            </div>
        </form>
        <!-- 模态框协议 -->
        <!-- 提交成功的模态框 -->
        <div class="submit_success">
            <div class="am_shadow"></div>
            <div class="ss_true_box as_comment">
                <p class="tb_enough" onclick="goApplyHome()"></p>
                <div class="st_bgimg"></div>
                <p class="rab_title">提交成功</p>
                <p class="rab_content">审核结果预计10个工作日内通过短信通知，敬请留意</p>
                <div class="go_apply_home" onclick="goApplyHome()">确定</div>
            </div>
        </div>
        <!-- 运营者手机号必须与注册账号时绑定的手机号一致！ 请选择解决方式： -->
    <div class="tel_same_modal">
        <div class="am_shadow"></div>
        <div class="ts_same_box as_comment">
            <p class="tb_enough"></p>
            <div class="ts_changetel_box">
                <div class="tc_word_box">
                    <p class="tc_onep">运营者手机号必须与注册账号时绑定的手机号一致！</p>
                    <p class="tc_twop">请选择解决方式：</p>
                </div>
                <div class="tc_change_box">
                    <div class="tc_changeone">
                        <div class="tcc_left">
                           <div class="tc_truebox" data-way="1"></div>
                           <span class="tc_firstway"></span>
                        </div>
                        <p class="tt_recomment">推荐</p>
                    </div>
                    <div class="tc_changeone">
                        <div class="tcc_left">
                          <div class="tc_truebox" data-way="2"></div>
                          <span class="tc_sconedway"></span>
                        </div>
                    </div>
                </div>
                <div class="tc_btnbox">
                    <div class="tb_apply am_text">取消</div>
                    <div class="tb_ok am_text">确定</div>
                </div>
            </div>
        </div>
    </div>
    <!-- 提交等待中的模态框 -->
    <div class="wait_submit">
        <div class="am_shadow"></div>
        <div class="ws_gif_box as_comment">
            <div class="wb_center_box">
                <div class="wb_bggif"></div>
                <p>正在提交</p>
            </div>
        </div>
    </div> 
    <%-- <!-- 重复申请模态框 --> --%>
    <div class="repeat_apply_modal">
        <div class="am_shadow"></div>
        <div class="ram_box">
            <p class="tb_enough" onclick="goApplyPage()"></p>
            <p class="rab_title">您已提交过申请，是否重新申请？</p>
            <p class="rab_content">审核结果预计自提交日起10个工作日内通过短信通知，建议您耐心等待</p>
            <div class="rab_btnbox">
                <div class="rb_apply rb_text" onclick="goApplyPage()">取消</div>
                <div class="rb_ok rb_text" onclick="hideModal()">重新申请</div>
            </div>
        </div>
    </div>
    <div id="toTop" class="back-top"></div>
    </div>
</div>

<jsp:include page="bottom.jsp"></jsp:include>
<script type="text/javascript" src="${resourceRoot}/js/rd.js${VERSION}"></script>
<script>
    $(function () {
     initLogin();
    // 申请函的文件转过后
    var picArr = [];
    // 申请函的文件没转换过
    var newpicArr = [];
    // 证件凭证的文件转过后
    var certificateArr = [];
    // 证件凭证的文件没转换过
    var newcertificateArr = [];  
    //记录文件的数量
    //账号名称同步
    synName();
    //1.编写表单验证函数validform，在验证按钮注册按钮点击事件内调用验证函数对象
    function validform(formId) {
        /*关键在此增加了一个return，返回的是一个validate对象，这个对象有一个form方法，返回的是是否通过验证*/
        return $(formId).validate({
            ignore: "",
            rules: {
                userName: {
                    required: true,
                    length_true: true,
                   isauthod_true: true
                },
                upload: {
                    checkimg_true: true,
                },
                pm_textarea: {
                    required: true,
                },
                mainBodyName: {
                    required: true,
                },
                pm_sm_certificate: {
                    certificate_true: true,
                },
                pm_sm_culvertipt: {
                    culvert_true: true,
                },
                pm_opus: {
                    required: true,
                },
                operatorName: {
                    required: true,
                },
                tel: {
                    required: true,
                    number: true
                    // isMobile:true
                },
                email: {
                    email: true
                },
                 weChat: {
                    weixin_true: true
                },
                idcard_hi: {
                    idcard_true: true
                },
                pm_textarea: {
                    required: true,
                    maxlength: 200
                },
                creation_check: {
                    creation_true: true
                }
            },

            messages: {
                userName: {
                    required: '必填',
                },
                pm_textarea: {
                    required: '必填',
                },
                pm_opus: {
                    required: '必填',
                },
                mainBodyName: {
                    required: '必填',
                },
                operatorName: {
                    required: '必填',
                },
                tel: {
                    required: '必填',
                    number: "手机号格式不正确"
                },
                email: {
                    email: "邮件格式不正确"
                },
                pm_textarea: {
                    required: '必填',
                    maxlength: "最多200字，请修改"
                }
            },
            errorPlacement: function (error, element) {
                // 更改错误提示位置在输入框下面
                var p = $("<p />").append(error);
                p.appendTo(element.parent());
            },
        });

    }
    // 账户名称的校验
    $.validator.addMethod("length_true", function (value,element) {
        function strlen(str){ 
            var len = 0; 
            for (var i=0; i<str.length; i++) { 
                var c = str.charCodeAt(i); 
                //单字节加1 
                if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) { 
                len++; 
                } 
                else { 
                len+=2; 
                } 
            } 
            return len; 
        }
        var lengstr=strlen(value)
        if(lengstr>3 && lengstr<21) {
        return true
        }
    }, "只能输入4-20个英文字符或者2-10个汉字");
     // username的认证无法修改的校验提示
    $.validator.addMethod("isauthod_true", function () {
        console.log($('#pm_accountname').attr("data-isauth"))
         if($('#pm_accountname').attr("data-isauth") =='1') {
            
             var inputName = $("#pm_accountname").val();
            
             var bindName = $(".userhdinfo2_name").text();
             
             if(inputName == bindName) {
                return true
             }
         }else {
             return true
         }
    }, "认证用户不允许修改账户名称");
    // 自定义校验(在上传头像的校验中inputimg或sm_inputimg只要有值就通过校验)
    $.validator.addMethod("checkimg_true", function () {
        return typeof ($("#pm_showImg").attr("src")) !== "undefined";
    }, "必填");
    // 上传凭证的校验
    $.validator.addMethod("certificate_true", function () {
        return typeof ($("#pm_showCertificate").attr("src")) !== "undefined";
    }, "必填(最多上传10个文件)");
    // 上传申请函的校验
    $.validator.addMethod("culvert_true", function () {
        return typeof ($("#pm_culvertImg").attr("src")) !== "undefined";
    }, "必填(最多上传10个文件)");
    // 微信的格式要求
    $.validator.addMethod("weixin_true", function (value,element) {
        return this.optional(element) || /^[a-zA-Z0-9_-][a-zA-Z0-9_-]{5,19}$/.test(value);
    }, "微信格式不正确");
    // 校验身份证
    $.validator.addMethod("idcard_true", function () {
        return typeof ($(".idcard_iptz").siblings(".ui_idcard_img").find("#ui_showidcard").attr("src")) !== "undefined" && typeof ($(".idcard_iptf").siblings(".ui_idcard_img").find("#ui_showidcard").attr("src")) !== "undefined";
        // return typeof($("#ui_showidcard").attr("src")) !=="undefined";
    }, "必填");
    // 下拉菜单的检验
    $.validator.addMethod("creation_true", function () {
        if($("#pdc_productText").html() !="请选择"){
            return true
        }
    }, "必填")
    //2.以上部分已经实现匿名函数的作用，下面通过普通按钮#submitBtn的点击事件实现表单验证：
     // 防止用户重复提交表单
    function disabledTi(event,options){
        $("#pm_submitBtn").attr({"disabled":"disabled"});
        var needtime = 3;
        var interval = setInterval(function(){
            needtime--;
            if(needtime <= 0) {
                $("#pm_submitBtn").removeAttr("disabled");
                clearInterval(interval);
                return 0;
            };
        }, 1000);
        event.preventDefault();
    }
    $("#pm_submitBtn").on("click", function (event) {
        var login = subLogin();
        if(login == 'nouser') {
            lgwdsshow();
        }else if(login == 'hasuser') {
            $(".main_lt").leanModal({closeButton: ".modal_close", title: '错误提示', content: '您的账号已是澎湃号，请勿重复申请'});
        }else {
            submitForm()
        }
    });
    function submitForm() {
        disabledTi(event);
        if ($(".pm_true_box").hasClass("true")) {
        
            if (validform("#pm_testform").form()) {
                //通过表单验证，以下编写自己的代码
                $(".error").parent('p').siblings("input").removeClass("from_error");
                var formData = new FormData($("#pm_testform")[0]);
                getsendformInfo(formData)
                // 没有手机号改绑的模态框跳出，和改绑的功能
                sendajax(formData)
            } else {
                showredBtn()
                //校验不通过，什么都不用做，校验信息已经正常显示在表单上
                $(".pm_sm_btnbox").css("opacity", "1");
                $(".pm_sm_certificatebox").css("opacity", "1");
                $(".pm_sm_culverbox").css("opacity", "1");
                //  校验不通过的input框边框呈现红色
                $(".error").each(function () {
                    if ($(this).css('display') == "none") {
                        $(this).parent('p').siblings("input").removeClass("from_error")
                    } else {
                        $(this).parent('p').siblings("input").addClass("from_error")
                    }
                })
                //校验不通过，让校验失败的input框出现在可视区域内
                showErroe()
            }
        } else {
            // alert("请同意用户协议");
            showAgree()
            event.preventDefault();
        }
    }
    // 3.1头像同步
         ishanImg()
    // 3.2inputimg上传头像，头像显示
    $(".pm_file_input").on("change","#pm_inputimg", function () {
        var pm_inputimg = $("#pm_inputimg")[0];
        var file = pm_inputimg.files[0];
        if ($(file).length) {
            pphShowHeader("pm_inputimg",function(url){
                $("#pm_showImg").attr("src",url);
                 // 为了防止change事件失效
                $("#pm_inputimg").val("");
            });
            // 上传文件的input隐藏
            $(this).hide();
            // 上传文件的大按钮隐藏
            $(".pm_add_image").hide();
            // 头像的显示框显示
            $(".pm_image_panel").show();
            // 上传文件的小按钮显示
            $(".pm_sm_btnbox").css("opacity", "1");
            // 当用input框穿头像时，将pm_image_panel设为空
            $('.pm_image_panel').attr("data-url","");
            // 提示报错隐藏
            $("#pm_inputimg-error").hide();
            // 只要头像框有图片，图像提示就消失
            isShowTip()
        }
    })
    // 4.sm_inputimg上传头像，头像显示
    $(".pm_sm_btnbox").on("change","#pm_sm_inputimg",function () {
        pphShowHeader("pm_sm_inputimg",function(url){
               $("#pm_showImg").attr("src",url);
               // 为了防止change事件失效
               $("#pm_sm_inputimg").val("");
        });
        // 上传文件的input隐藏
        $("#pm_inputimg").hide();
        // 上传文件的大按钮隐藏
        $(".pm_add_image").hide();
        // 头像的显示框显示
        $(".pm_image_panel").show();
        // pm_inputimg框文件清空
        $('#pm_inputimg').val("");
        // 当用input框穿头像时，将pm_image_panel设为空
        $('.pm_image_panel').attr("data-url","");
        // 只要头像框有图片，图像提示就消失
        isShowTip()
    })
    // 5.点击image_panel头像显示的框隐藏，上传文件的input和大按钮显示，上传文件的小按钮隐藏
    $(".pm_remove_img").on("click", function () {
        removeimg();
    })
    // 6.下拉菜单实现select下拉框的功能：点击下拉菜单以外的部分，下拉菜单收起
    $(".pm_dropdown").on("click",".pm_caret_box",function(e){
            $('.pm_dropdown_menu').show();
            $('.pm_creation_menu').hide();
            stopPropagation();
    });
    $(".pm_dropdown_creation").on("click",".pdc_caret_box",function(e){
        $('.pm_creation_menu').show();
        $('.pm_dropdown_menu').hide();
        stopPropagation();
    });
    //点击除p元素以外隐藏下拉
    $(document).bind("click",function(){
        $("ul.pm_dropdown_menu").hide();
        $("ul.pm_creation_menu").hide();
    });
    //7.1判断pm_productText中的data-area是否有值
    ishasText()
    // 7.2点击下拉菜单中的选项，是按钮的内容为所选的选项内容
    changeMenu($('.pm_dropdown_menu'),$('#pm_productText'));
    changeMenu($('.pm_creation_menu'),$('#pdc_productText'));
    // 8.申请函的部分
    // 点击pm_culvertbox上传证件，图像显示
    $("#pm_culvertbox").on("change", function () {
        var pm_culvertbox = $("#pm_culvertbox")[0]
        var files = pm_culvertbox.files
        // 遍历添加上传的文件
        // for(var i = 0; i < files.length; i++){
        //     newpicArr.unshift(files[i]);
        // }

        if ($(files).length) {
            $(this).hide();
            $(".pm_add_apply_file").hide();
            $(".pm_culvert_panel_box").css("width", "648px")
            // 上传文件的小按钮显示
            $(".pm_sm_culverbox").css("opacity", "1");
            // 添加文件
            $(files).each(function (i, item) {
                // 上限10
                if (i < 10) {
                    var fileReader = new FileReader();
                    fileReader.readAsDataURL(item);
                    fileReader.onload = function (e) {
                        var picSrc = this.result;
                        $(".pm_culvert_panel_box").prepend('<div class="pm_culvert_panel"><div class="pm_remove_culver">x</div><img id="pm_culvertImg" src="' + picSrc + '"></div>');
                    }
                    picArr.unshift(fileReader);
                     //遍历添加上传的申请函与picArr同步
                    newpicArr.unshift(files[i]);
                }
            })
            var addnum = picArr.length;
            fitWidth(addnum);
        }
    })
    //9.点击pm_sm_culvertipt上传证件，图像显示
    $("#pm_sm_culvertipt").on("change", function () {
        var pm_sm_culvertipt = $("#pm_sm_culvertipt")[0]
        var files = pm_sm_culvertipt.files;
        // 遍历添加上传的文件
        // for(var i = 0; i < files.length; i++){
        //     newpicArr.unshift(files[i]);
        // }

        $("#pm_culvertbox").hide();
        $(".pm_add_apply_file").hide();
        $(".pm_culvert_panel_box").css("width", "648px");
        var filesLength = $(files).length;
        $(files).each(function (i, item) {
            var fileReader = new FileReader();
            fileReader.readAsDataURL(item);
             //遍历添加上传的申请函与picArr同步
             picArr.unshift(fileReader);
            newpicArr.unshift(files[i]);

            fileReader.onload = function (e) {
                var picSrc = this.result;
                $(".pm_culvert_panel_box").prepend('<div class="pm_culvert_panel"><div class="pm_remove_culver">x</div><img id="pm_culvertImg" src="' + picSrc + '"></div>');
                if (filesLength == i + 1) {
                    var addnum = picArr.length;
                    if (addnum > 10) {
                        var morenum = addnum - 10;
                        picArr.splice(addnum - morenum, morenum)
                        //遍历添加上传的申请函与picArr同步
                        newpicArr.splice(addnum - morenum, morenum)
                        var removenum = morenum + 1;
                        $(".pm_culvert_panel:nth-last-child(-n+" + removenum + ")").remove();
                        fitWidth(picArr.length);
                    } else {
                        fitWidth(addnum);
                    }
                }
            }

        })
    })
    // 10.删除申请函
    $(".pm_culvert_panel_box").on("click", ".pm_remove_culver", function () {
        $(this).parent().remove();
        // 获取对应的img的src
        var imgSrc = $(this).siblings('img').attr("src");
        //遍历picArr数组删除对应的项(如何防止有你重复的)
        removeArr(picArr, imgSrc, newpicArr)
        //动态设置add_image_infor的宽
        // var removenum = picArr.length;
        var removenum = $(".pm_culvert_panel_box .pm_culvert_panel").length;
        fitWidth(removenum);
        showCulverIpt();
    })
    // 11.点击pm_certificate_ipt上传证件，图像显示
    $("#pm_certificate_ipt").on("change", function () {
        var pm_certificate_ipt = $("#pm_certificate_ipt")[0]
        var files = pm_certificate_ipt.files;

        // 遍历添加上传的文件
        // for(var i = 0; i < files.length; i++){
        //     newcertificateArr.unshift(files[i]);
        // }
        if ($(files).length > 0) {
            $(this).hide();
            // 上传文件的大按钮隐藏
            $(".pm_add_certificate").hide();
            $(".pm_certificate_panel_box").css("width", "648px")
            // 上传文件的小按钮显示
            $(".pm_sm_certificatebox").css("opacity", "1");
            // 添加文件
            $(files).each(function (i, item) {
                // 上限10
                if (i < 10) {
                    var fileReader = new FileReader();
                    fileReader.readAsDataURL(item);
                    fileReader.onload = function (e) {
                        var certifiSrc = this.result;
                        $(".pm_certificate_panel_box").prepend('<div class="pm_certificate_panel"><div class="pm_remove_certificate">x</div><img id="pm_showCertificate" src="' + certifiSrc + '"></div>');
                    }
                    certificateArr.unshift(fileReader);
                    //遍历添加上传的文件与certificateArr同步
                    newcertificateArr.unshift(files[i]);
                }
            })
            // 动态设置pm_add_image_infor的宽
            var addmorenum = certificateArr.length;
            certifiWidth(addmorenum);
        }
    })
    // 12.点击pm_sm_inputcertificate上传证件，图像显示
    $("#pm_sm_inputcertificate").on("change", function () {
        var pm_sm_inputcertificate = $("#pm_sm_inputcertificate")[0]
        var files = pm_sm_inputcertificate.files;

        // 遍历添加上传的文件
        // for(var i = 0; i < files.length; i++){
        //     newcertificateArr.unshift(files[i]);
        // }
        // 上传文件的input隐藏
        $("#pm_certificate_ipt").hide();
        // 上传文件的大按钮隐藏
        $(".pm_add_certificate").hide();
        $(".pm_certificate_panel_box").css("width", "648px")
        var filesLength = $(files).length;
        // 添加文件
        $(files).each(function (i, item) {
            var fileReader = new FileReader();
            fileReader.readAsDataURL(item);
           
             //遍历添加上传的文件与certificateArr同步
            certificateArr.unshift(fileReader);
            newcertificateArr.unshift(files[i]);

            fileReader.onload = function (e) {
                var certifiSrc = this.result;
                $(".pm_certificate_panel_box").prepend('<div class="pm_certificate_panel"><div class="pm_remove_certificate">x</div><img id="pm_showCertificate" src="' + certifiSrc + '"></div>');
                if (filesLength = i + 1) {
                    var addnum = certificateArr.length;
                    if (addnum > 10) {
                        var morenum = addnum - 10;
                        certificateArr.splice(addnum - morenum, morenum)
                        //遍历添加上传的文件与certificateArr同步
                        newcertificateArr.splice(addnum - morenum, morenum)
                        var removenum = morenum + 1;
                        $(".pm_certificate_panel:nth-last-child(-n+" + removenum + ")").remove();
                        // 动态设置pm_add_certifi_infor的宽
                        certifiWidth(certificateArr.length);
                    } else {
                        // 动态设置pm_add_certifi_infor的宽
                        certifiWidth(addnum);
                    }
                }
            }
        })
    })
    // 13.删除凭证
    $(".pm_certificate_panel_box").on("click", ".pm_remove_certificate", function () {
        $(this).parent().remove();
        // 获取对应的img的src
        var imgSrc = $(this).siblings('img').attr("src");
        removeArr(certificateArr, imgSrc, newcertificateArr)
        //动态设置apm_add_image_infor的宽
        // var removenum = certificateArr.length;
        var removenum = $(".pm_certificate_panel_box .pm_certificate_panel").length;
        certifiWidth(removenum);
        showCertificateIpt();
    })
    // 14.身份证上传
    $(".idcard_ipt").on("change", function () {
        var file = this.files[0];
        if ($(file).length > 0) {
            var fileReader = new FileReader();
            var $idcard_img = $(this).siblings(".ui_idcard_img").find("img")
            fileReader.readAsDataURL(file);
            fileReader.onload = function (e) {
                base64Code = this.result;
                $idcard_img.attr("src", base64Code);
            }
            $(this).hide();
            $(this).siblings(".add_idcard").hide();
            $(this).siblings(".ui_idcard_img").show();
        }
    })
    // 15.删除身份证上传
    $(".ui_remove_idcard").on("click", function () {
        $(this).parent(".ui_idcard_img").hide();
        $(this).parent(".ui_idcard_img").siblings('input').show();
        $(this).parent(".ui_idcard_img").siblings('input').val("");
        $(this).parent(".ui_idcard_img").siblings('.add_idcard').show();
        $(this).siblings('img').removeAttr("src")
    })
    
    // 16.点击同意框，出现对号
    $(".pm_true_box").on("click", function () {
        $(this).toggleClass("true");

    })
    // 17. 实现字体的长度匹配
    // 账号简介实现字体的长度匹配
        textareaLength($(".pm_textarea"),$(".pw_number"));
        IetextareaLength($(".pm_textarea"),$(".pw_number"));
        // 作品链接实现字体的长度匹配
        textareaLength($(".pm_opus"),$(".pw_opus_number"));
        IetextareaLength($(".pm_opus"),$(".pw_opus_number"));
    // 协议模态框部分
    // 18.点击pm_agreement.协议模态框出现
    $(".pm_agreement").on("click",function(){
        // $(".agreement_modal").show()
        showAgree()
       
    })

// <!-- 运营者手机号必须与注册账号时绑定的手机号一致！ 请选择解决方式： -->
    // 22.点击tb_enough模态框消失
    $(".tb_enough").on('click',function(){
        $(".tel_same_modal").hide();
    })
    //  23.点击小框出现对勾
    $('.tc_truebox').on('click',function(){
        $(this).toggleClass("true");
         $(this).parent().parent().siblings().find('.tc_truebox').removeClass("true");
    })
    // 24.点击取消按钮，模态框隐藏
    $(".tb_apply").on('click',function(){
        $(".tel_same_modal").hide();
    })
    //25.点击确认按钮，模态框隐藏
    $(".tb_ok").on('click',function() {
         $(".tel_same_modal").hide();
        var dataWay = $(".ts_changetel_box .true").attr('data-way');
        if(dataWay == '1') {
             NewLg.modifyphoneshow();
        }
        if(dataWay == '2') {
            registerwdsshow();
        }
    }) 
    //26. 账号名称同步的登入的账号名称
    function synName() {
        var username = $(".userhdinfo2_name").text();
        $("#pm_accountname").val(username);
    }
    //27.头像同步
    function ishanImg() {
        var hasheaderPic = $('.pm_image_panel').attr("data-url");
        if(hasheaderPic!=''){
            $('.pm_image_panel').show();
            $('.pm_add_image').hide();
            $(".pm_sm_btnbox").css('opacity',1);
            $('.pm_image_panel img').attr('src',hasheaderPic)
        }
    }
    // 动态设置culvert_panel_box下的add_image_infor的宽
    function fitWidth(num) {
        var number = num % 4;
        var boxWidth = $(".pm_culvert_panel_box").width();
        var remainWidth = boxWidth - 168 * number;
        $(".pm_add_image_infor").width(remainWidth);
        if(num%4 === 3) {
            $(".pm_add_image_infor").width('648px');
        }
    }
    function certifiWidth(num) {
        var number = num % 4;
        var boxWidth = $(".pm_certificate_panel_box").width();
        var remainWidth = boxWidth - 168 * number;
        $(".pm_add_certifi_infor").width(remainWidth);
        if(num%4 === 3) {
            $(".pm_add_certifi_infor").width('648px');
        }
    }
    function showCulverIpt() {
        if ($(".pm_culvert_panel_box .pm_culvert_panel").length === 0) {
            $('#pm_culvertbox').show();
            $('#pm_culvertbox').val("");
            $(".pm_add_apply_file").show();
            $(".pm_sm_culverbox").css("opacity", "0");
            $(".pm_culvert_panel_box").removeAttr("style");
            $(".pm_add_image_infor").removeAttr("style");
        }
    }
    function showCertificateIpt() {
        if ($(".pm_certificate_panel_box .pm_certificate_panel").length === 0) {
            $('#pm_certificate_ipt').show();
            $('#pm_certificate_ipt').val("");
            $(".pm_add_certificate").show();
            $(".pm_sm_certificatebox").css("opacity", "0");
            $(".pm_certificate_panel_box").removeAttr("style");
            $(".pm_add_certifi_infor").removeAttr("style");
        }
    }
    function removeimg() {
        $(".pm_image_panel").hide();
        $(".pm_sm_btnbox").css("opacity", "0");
        $(".pm_add_image").show();
        $("#pm_inputimg").show();
        $("#pm_inputimg").val(""); 
        $(".pm_image_panel img").removeAttr("src");
    }
    function isShowTip() {
        var hasImg = $("#pm_showImg").context.URL;
        if (hasImg) {
            $("#pm_sm_inputimg-error").hide();
        }
    }
    //  数组中删除被删的元素(避免了重复的)
    function removeArr(Arr, imgsrc, arr) {
        var newArr = []
        Arr.forEach(function (item, index) {
            if (item.result == imgsrc) {
                newArr.push(index)
            }
        })
        Arr.splice(newArr[0], 1)
        arr.splice(newArr[0], 1)
    }
      // 用户协议的模态框
     //神评弹框
    function getAgree(){
        var agreement="";
        $.ajax({
            type: "get",
            url: "pph_agreement.html",
            timeout: 30000,
            dataType: "html",
            async:false,
            success: function (data) {
                 agreement = " <div class=\"lg_wds_agreement\"  id=\"agreementtxt\">"+data+"</div>";
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                
            }
        });
        return agreement;
    }
    function showAgree(){
        var shenAgree  = getAgree();
        var html =  "<div class=\"agreement_modal \">"
                    +"<div class=\"am_shadow\"></div>"
                    +"<div class=\"artcle_box as_comment\">"
                    +"<p class=\"am_enough\">X</p>"
                    +"<div class=\"am_artcle\">"
                    +shenAgree
                    +"<div class=\"am_btnbox\">"
                    +"<div class=\"am_apply am_text\">取消</div>"
                    +"<div class=\"am_ok am_text\">同意</div>"
                    +"</div></div></div></div>"
                  
        $(document.body).append(html);
        // 18.点击am_enough，协议模态框隐藏
        $(".am_enough").on("click",function(){
            $(".agreement_modal").hide()
        })
        // 19.点击am_apply，协议模态框隐藏 
        $(".am_apply").on("click",function(){
            $(".agreement_modal").hide()
        })
        // 20.点击同意按钮，协议模态框隐藏 ，同意框，出现对号
        $(".am_ok").on("click",function(){
            $(".agreement_modal").hide()
            $(".pm_true_box").addClass("true")
        })
    }
    // 作品链接字体的长度匹配
    function textareaLength(textarea,dom) {
        textarea.on("input",function(){
            var wordlength = $(this).val().length;
            dom.html(wordlength)
        })
    }
    // 兼容IE
    function IetextareaLength(textarea,dom) {
        textarea.on("propertychange",function(){
            var wordlength = $(this).val().length;
            dom.html(wordlength)
        })
    }
    function initLogin() {
        $.ajax({
            url:"/www/checkCanApply.msp",
            type:"get",
            dataType:'json',
            success: function (data) {
                if(data.resultCode == 2) {
                   lgwdsshow();
                   banclick($(".new_lg .close"));
                }
                if(data.resultCode == 3){
                  $(".repeat_apply_modal").show();
                }
                if(data.resultCode == 4) {
                 $(".main_lt").leanModal({closeButton: ".modal_close", title: '错误提示', content: '您的账号已是澎湃号，请勿重复申请'});
                }
            },
            error: function(e) {
                $("#pm_submitBtn").leanModal({closeButton: ".modal_close", title: '错误提示', content: '服务器繁忙，请稍后再试'});
            }
        })
    }
         // 禁止点击关闭按钮
    function banclick(dom) {
        // var closebtn = $(".new_lg .close");
        dom.removeAttr("onclick");
    }
   
    function subLogin() {
         var dataUser = $('.main_lt').attr("data-user");
         var userType = $('.main_lt').attr("data-type");
         if(!dataUser) {
            return "nouser"
         }
        if (userType && userType != '' && (userType == 0 || userType== 1)) {
            return "hasuser"
        } 
    }
     // 阻止冒泡事件
    function stopPropagation(e) {        
        //取消事件冒泡
        var e=arguments.callee.caller.arguments[0]||event; 
        if (e && e.stopPropagation) {
        // this code is for Mozilla and Opera
        e.stopPropagation();
        } else if (window.event) {
        // this code is for IE
        window.event.cancelBubble = true;
        }
    }  
    // 下拉菜单是否有值
    function ishasText() {
        var erea = $("#pm_productText").attr('data-area');
        if(erea!='') {
            $("#pm_productText").text(erea);
            $("#pm_productText").css('color','black');
        }
    }
    // 下拉菜单的选中
    function changeMenu(perentdom,finddom) {
        perentdom.on("click","li",function() {
            //获取内容
            var txt = $(this).text();
            //将内容赋值给span
            finddom.text(txt);
            finddom.css('color','black');
            // ul消失
            if(finddom.attr('id') == 'pdc_productText'){
            	finddom.attr("data-create-field-id",$(this).data("create-field-id"));	
            }
            perentdom.hide();
        })
    }

    function getsendformInfo(formData) {
        // 添加下拉菜单的值
        formData.append("area",$("#pm_productText").text())
        formData.append("createFieldId",$("#pdc_productText").data("create-field-id"));
        // 添加发布内容
        formData.append("message",$(".pm_textarea").val())
        // 添加要传递的申请函
        getinputFile(formData,newpicArr,"applyLetterImages")
        // 添加要传递的证件凭证
        getinputFile(formData,newcertificateArr,"certificateImages")
        // 添加作品链接
        formData.append("worksLink",$(".pm_opus").val())
        // 添加要传递的idImages，身份证（不是比传的，没有传世，为空）
        if($("#idcard_iptz")[0].files[0] == undefined){
            formData.append("idImages","");
        }else{
            formData.append("idImages",$("#idcard_iptz")[0].files[0]);
        }
        if($("#idcard_iptf")[0].files[0]== undefined ){
            formData.append("idImages","");
        }else{
            formData.append("idImages",$("#idcard_iptf")[0].files[0]);
        }
         // 添加创作领域
        formData.append("createField",$("#pdc_productText").html())
        // 添加澎湃号的类型
        formData.append("userType",0) //用户类型 0-湃客个人  1-媒体 2-政务 4-湃客机构
        // 用户同意用户协议
        formData.append("agreement",'1')
        
    }
    // 获取input文件的函数
    function getinputFile(info,arr,inputname) {
        for(var i = 0; i < arr.length; i++){
            info.append( inputname, arr[i]);
        }
    }
    function sendajax(info) {
        $.ajax({
            url:"/www/pphApply.msp",
            type:"POST",
            data:info,
            contentType: false,
            processData: false,
            beforeSend: function() {
                $(".wait_submit").show();
            },
            success: function (data) {
            
                if(data.resultCode == 1){
                  $('.submit_success').show();
                } else if(data.resultCode == 2) {
                    showTelmodal()
                }else {
                $("#pm_submitBtn").leanModal({
                    closeButton: ".modal_close", 
                    title: '提示', 
                    content: data.resultMsg, 
                    });
                }
            
            },
            error: function (e) {
                $("#pm_submitBtn").leanModal({closeButton: ".modal_close", title: '错误提示', content: '服务器繁忙，请稍后再试'});
            },
            complete: function() {
                $(".wait_submit").hide();
            }
        })
    }
    // 当填写的手机号与登录的账号绑定的手机号不一致时,模态框跳出
    function showTelmodal() {
        var inputTel = Number($("#pm_tel").val());
        var bindTel = Number($('#pm_tel').attr("data-mobile"));
        if(inputTel!=bindTel) {
            var firstwayText = "将当前登录账号的手机号改绑至"+inputTel;
            var sconedwayText = "使用"+inputTel+"注册新账号并申请澎湃号";
            $('.tel_same_modal .tc_firstway').text(firstwayText);
            $(".tel_same_modal .tc_sconedway").text(sconedwayText);
            $('.tel_same_modal').show();
        }
    }
    // 页面中要是有pm_sm_inputimg-error和pm_sm_culvertipt-error对应的input父级框有红色边框
    function showredBtn() {
        if($('.pm_sm_inputimg-error').css('display') == "none"){
            $('.pm_add_image').removeClass('from_error_big')
        }else {
            $('.pm_add_image').addClass('from_error_big')
        }
        if($(".pm_sm_culvertipt-error").css('display') == "nine"){
            $(".pm_add_apply_file").removeClass('from_error_big')
        }else {
            $('.pm_add_apply_file').addClass('from_error_big')
        }
         if($("#pdc_productText").html()=="请选择") {
            $("#pdc_productText").parent().addClass("from_error_big");
        }else {
            $("#pdc_productText").parent().removeClass("from_error_big");
        }
    }
    //校验不通过，让校验失败的input框出现在可视区域内
    function showErroe() {
        var error = $(".input_from_error.error")[0];
        console.log($(".input_from_error.error")[0])
        var swHeight=$(window).height();
        var mTop=error.parentNode.offsetTop;
        var errorHeight = error.parentNode.offsetHeight;
        $(window).scrollTop(mTop-errorHeight-100)
        // 当申请函校验错误是时的情况
        if($(error).hasClass( 'pm_sm_culvertipt')) {
        $(window).scrollTop(swHeight-50)
        }
    }
})
 // 提交成功，跳转页面
function goApplyHome() {
    $('.submit_success').hide();
    location.href = "channel_${SPARKER_CHANNELID}";
}
 // 点击重复申请按钮
function hideModal() {
    $(".repeat_apply_modal").hide();
}
// 点击x和取消按钮，模态框消失
function goApplyPage() {
    $(".repeat_apply_modal").hide();
    location.href = "channel_${SPARKER_CHANNELID}";
}
</script>

</body>
</html>