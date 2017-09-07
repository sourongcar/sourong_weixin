<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>欢迎成为合伙人</title>
</head>
<body>
<h2 style="text-align: center;font-size: 8vw">您已成为搜融合伙人</h2>
<p id="show" style="text-align: center;font-size: 4vw"></p>
</body>
<script type="text/javascript">
window.onload=function(){
	var time=3;  
	function closeWindow(){  
		window.setTimeout(closeWindow,1000);  
		if(time>0){  
		document.getElementById("show").innerHTML=time+"秒后关闭当前窗口,返回微信公众号窗口";  
		time--;  
		
		}else{  
		WeixinJSBridge.call('closeWindow'); 
		}
	}
	closeWindow();
}
</script>
</html>