<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>生成海报页面</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link rel="stylesheet" href="${path }/resources/css/example.css">
    <link rel="stylesheet" href="${path }/resources/css/weui.css">
</head>

<body>
<div class="page__bd page__bd_spacing">
    <div class="weui-flex">
        <div class="weui-flex__item"><div class="placeholder"></div></div>
    </div>

    <!--logo-->
    <div class="page__ft">
        <img src="${path }/resources/images/logo.png" />"D:/eclipse/workspace/sourong_weixin-1/WEB-INF/pages/followers.jsp"
    </div>
<!--文字-->
    <div >
        <article class="weui-article" style="padding: 0 0;">
            <section>
                <p id="info" style="text-align: center"></p>
            </section>
        </article>
    </div>
<fieldset style="width: 90%;margin:0 auto;line-height: 0">
    <div class="panel1" id="demo" style="">
		<img id="qrcode" src="${path }/weixin/poster/proxy.action?target=${qrimg }"  style="display:none;">
		<img id="head" src="${path }/weixin/poster/proxy.action?target=${headimg }"  style="display:none;">
		<img id="temp" src="/img/${poster }"  style="display:none;">
		<img id="out" style="width:100%">
		<canvas width="480" height="800" style="width:100%;display:none" id="canvas"></canvas>
    </div>
</fieldset>
    <!--页脚-->
    <div class="weui-footer style="margin-top:5vw">
        <p class="weui-footer__links">
            <a href="http://www.sourongdaojia.net/" class="weui-footer__link">搜融到家</a>
        </p>
    <p class="weui-footer__text">Copyright &copy; www.sourongdaojia.net</p>
    </div>
</body>
<script src="${path }/resources/js/jquery-2.1.1.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	var canvas=$("#canvas")[0];
	var qrcode=$("#qrcode")[0];
	var head=$("#head")[0];
	var temp=$("#temp")[0];
	var out=$("#out")[0];
	var ctx = canvas.getContext('2d');
	try{
		ctx.drawImage(temp,0,0);
		ctx.drawImage(qrcode,120,480,240,240);
		ctx.drawImage(head,210,570,60,60);
		var url = canvas.toDataURL("image/png");
		out.src=url;
		$('#info').text('二维码已生成,长按复制分享即可');
	}
	catch(e){
		$('#info').text('二维码生成失败，请重试');
	}
}
</script>
</html>
