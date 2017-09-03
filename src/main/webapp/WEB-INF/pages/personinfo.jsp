<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>完善个人信息</title>
    <link rel="stylesheet" href="${path }/resources/css/weui.min.css"/>
    <link rel="stylesheet" href="${path }/resources/css/example.css"/>
</head>
<body  ontouchstart>
<div class="page__ft">
    <img src="${path }/resources/images/logo.png" />
</div>
<div class="weui-cells__title">请完善您的个人信息</div>
<!--完善信息的表单-->
<div class="weui-cells weui-cells_form">
    <div class="weui-cell" id="name_input">
        <div class="weui-cell__hd"><label class="weui-label">姓名</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input" id="username" onclick="refreshName()" placeholder="请尽量填写您的真实姓名" value="${user.username.replace("先生","").replace("女士","")}" onblur="checkName(this.value)"/>
        </div>
        <div class="weui-cell__ft" > <i class="weui-icon-warn"></i></div>
    </div>
    <div class="weui-cells__tips" id="name_err" style="display: none;">姓名长度为2-4个字符</div>

    <div class="weui-cell" id="phone_input">
        <div class="weui-cell__hd">
            <label class="weui-label">手机号</label>
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input" id="userphone" type="tel" onclick="refreshNum()" placeholder="请输入您的手机号" value="${user.userphone }" onblur="checkPhoneNum(this.value)"/>
        </div>
        <div class="weui-cell__ft" > <i class="weui-icon-warn"></i></div>
    </div>
    <div class="weui-cells__tips" id="phone_err" style="display: none;">请输入有效的手机号码</div>

    <div class="weui-cells__title">请选择您的性别</div>
    <div class="weui-cells weui-cells_radio">
        <label class="weui-cell weui-check__label" for="male">
            <div class="weui-cell__bd">
                <p>男</p>
            </div>
            <div class="weui-cell__ft">
                <input type="radio" class="weui-check" name="radio1" id="male"<c:if test='${user.username.endsWith("先生") or user eq null}'> checked="checked"</c:if>/>
                <span class="weui-icon-checked"></span>
            </div>
        </label>
        <label class="weui-cell weui-check__label" for="female">

            <div class="weui-cell__bd">
                <p>女</p>
            </div>
            <div class="weui-cell__ft">
                <input type="radio" name="radio1" class="weui-check" id="female"<c:if test='${user.username.endsWith("女士") }'> checked="checked"</c:if>/>
                <span class="weui-icon-checked"></span>
            </div>
        </label>
    </div>


    <div class="weui-btn-area">
        <button type="submit" onclick="checkSubmit()" class="weui-btn weui-btn_primary" href="javascript:" id="showTooltips">确定</button>
    </div>

</div>
<!--完善信息表单结束-->
<!--确认弹框-->
<div class="js_dialog" id="iosDialog1" style="display: none;">
    <div class="weui-mask"></div>
    <div class="weui-dialog">
        <div class="weui-dialog__hd"><strong class="weui-dialog__title">是否确认提交</strong></div>
        <div class="weui-dialog__ft">
            <a id="confirm" data-openid="${openid }" href="javascript:;" class="weui-dialog__btn weui-dialog__btn_default">确认</a>
            <a href="javascript:;" class="close weui-dialog__btn weui-dialog__btn_primary">取消</a>
        </div>
    </div>
</div>
<div class="js_dialog" id="successDialog" style="display: none;">
    <div class="weui-mask"></div>
    <div class="weui-dialog">
        <div class="weui-dialog__hd"><strong class="weui-dialog__title">修改成功</strong></div>
        <div class="weui-dialog__ft">
            <a href="javascript:close();" class="close weui-dialog__btn weui-dialog__btn_primary">确定</a>
        </div>
    </div>
</div>
<!--页脚-->
<div style="margin-top:30px;" class="weui-footer">
    <p class="weui-footer__links">
        <a href="http://www.sourongdaojia.net/" class="weui-footer__link">搜融到家</a>
    </p>
    <p class="weui-footer__text">Copyright &copy; www.sourongdaojia.net</p>
</div>
</body>
<script src="${path }/resources/js/jquery-2.1.1.min.js"></script>
<script src="${path }/resources/js/personinfo.js"></script>
<script type="text/javascript">
    $(function(){
        var $tooltips = $('.js_tooltips');

        $('#showTooltips').on('click', function(){
            if ($tooltips.css('display') != 'none') return;

            // toptips的fixed, 如果有`animation`, `position: fixed`不生效
            $('.page.cell').removeClass('slideIn');

            $tooltips.css('display', 'block');
            setTimeout(function () {
                $tooltips.css('display', 'none');
            }, 2000);
        });
        $("#confirm").click(function(){
        	$.ajax({
        		url:"${path}/weixin/editinfo.action",
        		type:"post",
        		data:{phone:$("#userphone").val(),
        			name:$("#username").val()+($(":radio:checked").attr("id")=='male'?'先生':'女士'),
        			openid:$(this).data("openid")},
    			dataType:'json',
    			success:function(data){
    				if(data=="success")
					WeixinJSBridge.call('closeWindow');
    				else
    					alert("请求失败");
    			},
    			error:function(){
    				alert("请求失败");
    			}
        	});
            $('#iosDialog1').css('display','none');
        });
        $('.js_dialog .close').click(function(){
        	$(this).parents(".js_dialog").css('display','none');
        })
    });

    /*
     * 提交表单时的弹框
     * */
    function displayDialog(){
        $('#iosDialog1').css('display','block');
    }
    /*
     * 表单检验无误且不为空时才可以提交表单
     * */
    function checkSubmit(){
        var name = $('#username').val();
        var phone = $('#userphone').val();
        if(checkName(name)&&checkPhoneNum(phone)&&name!=""&&phone!=""){
            displayDialog();
        }
    }
</script>
</html>
