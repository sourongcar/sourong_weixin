<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>验证身份</title>
    <link rel="stylesheet" href="${path }/resources/css/weui.min.css"/>
    <link rel="stylesheet" href="${path }/resources/css/example.css"/>
</head>
<body  ontouchstart>
<div class="page__ft">
    <img src="${path }/resources/images/logo.png" />
</div>
<div class="weui-cells__title">填写账号密码</div>
<!--完善信息的表单-->
<form method="post" action="menu.action" class="weui-cells weui-cells_form">
    <div class="weui-cell" id="name_input">
        <div class="weui-cell__hd"><label class="weui-label">账号</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input" name="account" id="username" onclick="refreshName()" placeholder="账号" onblur="checkName(this.value)"/>
        </div>
    </div>
    <div class="weui-cells__tips" id="name_err" style="display: none;">姓名长度为2-4个字符</div>

    <div class="weui-cell" id="phone_input">
        <div class="weui-cell__hd">
            <label class="weui-label">密码</label>
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input" name="password" id="userphone" type="password" onclick="refreshNum()" placeholder="密码" onblur="checkPhoneNum(this.value)"/>
        </div>
    </div>
    <div class="weui-cells__tips" id="phone_err" style="display: none;">请输入有效的手机号码</div>

    <div class="weui-btn-area">
        <button type="submit" onclick="return checkSubmit()" class="weui-btn weui-btn_primary" href="javascript:" id="showTooltips">确定</button>
    </div>

</form>
<!--完善信息表单结束-->
<!--确认弹框-->
<div class="js_dialog" id="iosDialog1" style="display: none;">
    <div class="weui-mask"></div>
    <div class="weui-dialog">
        <div class="weui-dialog__hd"><strong class="weui-dialog__title">是否确认提交</strong></div>
        <div class="weui-dialog__ft">
            <a id="confirm" href="javascript:;" class="weui-dialog__btn weui-dialog__btn_default">确认</a>
            <a id="close" href="javascript:;" class="weui-dialog__btn weui-dialog__btn_primary">取消</a>
        </div>
    </div>
</div>
<!--页脚-->
<div class="weui-footer  weui-footer_fixed-bottom">
    <p class="weui-footer__links">
        <a href="http://www.sourongdaojia.net/" class="weui-footer__link">搜融到家</a>
    </p>
    <p class="weui-footer__text">Copyright &copy; www.sourongdaojia.net</p>
</div>
</body>
<script src="${path }/resources/js/jquery-2.1.1.min.js"></script>
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
        if(name!=""&&phone!=""){
        	/* $.ajax({
        		url:"menu.action",
        		type:"post",
        		data:{password:$("#userphone").val(),account:$("#username").val()},
    			dataType:'json',
    			success:function(data){
    				if(data=="success")
						location="createmenu.action";
    				else
    					alert("账号或密码错误");
    			},
    			error:function(){
    				alert("请求失败");
    			}
        	}); */
        	return true;
        }
        else
        	return false;
    }
</script>
</html>