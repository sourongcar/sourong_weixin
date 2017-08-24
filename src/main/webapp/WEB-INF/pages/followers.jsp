<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
<meta http-equiv="Content-Type"content="text/html; charset=utf-8">   
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1, user-scalable=no">
<meta name="format-detection" content="telephone=no">
    <title>下家</title>
    <link rel="Stylesheet" href="${path }/resources/css/jquery.mobile-1.4.2.min.css" /> 	
    <link rel="stylesheet" type="text/css" href="${path }/resources/js/assets/css/public.css" />
    <link rel="stylesheet" href="${path }/resources/js/assets/css/iconfont/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${path }/resources/js/assets/groupRule/css/groupRule.css" />
    <link rel="stylesheet" href="${path }/resources/css/example.css">
    <link rel="stylesheet" href="${path }/resources/css/weui.css">

</head>
<body>

<div data-role="page">
    <!--logo-->
    <div class="page__ft">
        <img src="${path }/resources/images/logo.png" />
    </div>
	<div id="divContent" data-role="content">
        
        <div id="tree"></div>
        </div>
</div>
<!--页脚-->
<div class="weui-footer weui-footer_fixed-bottom">
    <p class="weui-footer__links">
        <a href="main.html" class="weui-footer__link">搜融到家</a>
    </p>
    <p class="weui-footer__text">Copyright &copy; 2008-2016 weui.io</p>
</div>
</div>
            


</body>
</html>
    <script src="${path }/resources/js/jquery-2.1.1.min.js" ></script>
    <script src="${path }/resources/js/jquery.mobile-1.4.2.min.js" ></script>
    <script src="${path }/resources/js/jqm-tree.js" ></script>
<script type="text/javascript">
$.mobile.pushStateEnabled = false;
<c:choose>
<c:when test="${partner.length>0 }">
    $("#tree").jqmtree({
        title : '我的下家',
        collapsed: false,
        data: [
			<c:forEach items="${partner }" var="p" varStatus="status">
			{ "id": ${p.userid}, "title": "${p.nickname}"<c:if test="${p.referrerid ne user.userid}">,"pid":${p.referrerid}</c:if> }<c:if test="${status.last eq false}">,</c:if>
			</c:forEach>
        ]
    });
</c:when>
<c:otherwise>
	$("#tree")。css({textAlign:'center',fontsize:'2rem'}).text("你还没有下家");
</c:otherwise>
</c:choose>

</script>
