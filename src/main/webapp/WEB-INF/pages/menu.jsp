<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>编辑菜单</title>
    <link rel="stylesheet" href="${path }/resources/css/weui.min.css"/>
    <link rel="stylesheet" href="${path }/resources/css/example.css"/>
    <style>
        .screen {
            width: 280px;
            height: 480px;
            position: relative;
            display: inline-block;
            vertical-align: top;
            margin-right:15px;
            border: 1px solid #777;
            background-color: #f8f8f8;
        }

        .text {
            padding: 13px;
            font-size: 15px;
        }

        .head {
            background-color: #333333;
            color: white;
            margin: 0;
        }

        .nav {
            display: flex;
            position: absolute;
            z-index: 500;
            bottom: 0;
            width: 100%;
            background-color: #FAFAFA;
        }

        .nav:before {
            content: " ";
            position: absolute;
            left: 0;
            top: 0;
            right: 0;
            height: 1px;
            border-top: 1px solid #CCCCCC;
            color: #CCCCCC;
            -webkit-transform-origin: 0 100%;
            transform-origin: 0 0;
            -webkit-transform: scaleY(0.5);
            transform: scaleY(0.5);
        }

        .nav-item {
            position: relative;
            display: block;
            flex: 1;
            text-align: center;
        }

        .nav-item:active {
            background-color: #EAEAEA;
        }

        .nav-item-on {
            background-color: #EAEAEA;
        }

        .nav-item:last-child:after {
            display: none;
        }

        .nav-item:after {
            content: " ";
            position: absolute;
            right: 0;
            top: 0;
            width: 1px;
            bottom: 0;
            border-right: 1px solid #CCCCCC;
            color: #CCCCCC;
            -webkit-transform-origin: 100% 0;
            transform-origin: 100% 0;
            -webkit-transform: scaleX(0.5);
            transform: scaleX(0.5);
        }

        .nav-item-menu {
            position: relative;
            display: block;
            flex: 1;
        }

        .nav-item-menu:before {
            content: '';
            width: 0px;
            height: 0px;
            border-bottom: 10px solid #ddd;
            border-left: 10px solid transparent;
            margin: 5px;;
            position: absolute;
            bottom: 0;
            right: 0;
            display: block;
            flex: 1;
            text-align: center;
        }

        .nav-menu-item-box {
            position: absolute;
            bottom: 105%;
            left: 50%;
            transform: translateX(-50%);
            box-shadow: 0 0 15px #ccc;
            margin: 0;
            padding: 0;
            width: 100%;
            min-width: 120px;
            list-style: none;
            text-overflow: ellipsis;
            overflow: hidden;
            background-color: #FAFAFA;
        }

        .nav-item-menu .nav-menu-item-box {
            display: none;
        }

        .nav-item-menu.nav-item-menu-on .nav-menu-item-box {
            display: block;
        }

        .nav-item-menu:first-child .nav-menu-item-box {
            left: 0;
            transform: none;
        }

        .nav-item-menu:last-child .nav-menu-item-box {
            left: unset;
            right: 0;
            transform: none;
        }

        .nav-menu-item-box .nav-item {
            text-align: left;
            padding-left: 13px;
        }

        .nav-menu-item-box .nav-item-add {
            text-align: center;
        }

        .nav-item-add > .text:before, .text.nav-item-add:before {
            content: "+";
        }

        .nav-menu-item-box .nav-item:after {
            left: 0;
            top: unset;
            width: auto;
            height: 1px;
            bottom: 0;
            border-right: none;
            border-bottom: 1px solid #CCCCCC;
            -webkit-transform-origin: 100% 0;
            transform-origin: 0 100%;
            -webkit-transform: scaleY(0.5);
            transform: scaleY(0.5);
        }

        /*
        * form
        */
        .wxform {
            display: inline-block;
            flex:1;
            vertical-align: top;
        }

        /* .wxform button {
            display: inline-block;
            padding: 5px 15px;
            margin: 10px;
            border: none;
            outline: none;
            color: white;
            background-color: #0D8BBD;
        }

        .wxform label {
            display: block;
            margin: 10px 0;
        }

        .wxform label input, .wxform label select {
            margin: 0 10px;
            height: 20px;
        } */
    </style>
</head>
<body>
<div style="display: flex;padding:5px">
<div class="screen">
    <h2 class="head text">cdcdcd</h2>
    <nav class="nav">
        <!--<div class="nav-item">
            <div class="text">1</div>
        </div>
        <div class="nav-item-menu">
            <div class="text nav-item">2</div>
            <ul class="nav-menu-item-box">
                <li class="text nav-item">1</li>
                <li class="text nav-item">2</li>
                <li class="text nav-item">3</li>
            </ul>
        </div>-->
        <c:forEach items="${menu.button }" var="b" >
        <c:choose>
        <c:when test="${b.sub_button.size()==0}">
        <div class="nav-item">
            <div class="text">${b.name }</div>
        </div>
        </c:when>
        <c:otherwise>
       	<div class="nav-item-menu">
           <div class="text nav-item">${b.name }</div>
           <ul class="nav-menu-item-box">
           		<c:forEach items="${b.sub_button }" var="sb">
                <li class="text nav-item">${sb.name }</li>
           		</c:forEach>
           		<c:if test="${b.sub_button.size()<5 }">
		        <li class="text nav-item nav-item-add"></li>
        		</c:if>
            </ul>
        </div>
        </c:otherwise>
        </c:choose>
        </c:forEach>
        <c:if test="${menu.button.size()<3 }">
        <div class="nav-item nav-item-add">
            <div class="text"></div>
        </div>
        </c:if>
    </nav>
</div>
<div class="wxform" style="display: none">
	<div class="weui-cells weui-cells_form">
		<div class="weui-cells__title">类型</div>
		<select id="type" class="weui-select" name="select2">
            <option value="click">点击</option>
            <option value="view">跳转</option>
            <option value="parent">菜单</option>
        </select>
		<div class="weui-cells__title">信息</div>
		<div class="weui-cell">
			<div class="weui-cell__hd"><label for="name" class="weui-label">名称</label></div>
			<div class="weui-cell__bd"><input id="name" type="text" class="weui-input"></div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd"><label for="key" class="weui-label">键值</label></div>
			<div class="weui-cell__bd"><input id="key" type="text" class="weui-input"></div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd"><label for="url" class="weui-label">链接</label></div>
			<div class="weui-cell__bd"><input id="url" type="text" class="weui-input"></div>
		</div>
		<div class="weui-flex">
		<button id="confirm" class="weui-flex-item weui-btn weui-btn_primary" style="margin:5px">确定</button>
	    <button id="delete" class="weui-flex-item weui-btn weui-btn_warn" style="margin:5px">删除</button>
	    </div>
	</div>
	
    <!-- <label>类型
        <select id="type">
            <option value="click">点击</option>
            <option value="view">跳转</option>
            <option value="parent">菜单</option>
        </select>
    </label>
    <label>名称</label>
    <label>键值<input id="key" type="text"></label>
    <label style="display: none">链接<input id="url" type="text"></label>
    <button id="confirm">确定</button>
    <button id="delete">删除</button> -->
</div>
</div>
<div style="margin:5px"><button id="submit" class="weui-btn weui-btn_plain-primary">创建菜单</button></div>
</body>
<script src="${path }/resources/js/jquery-2.1.1.min.js"></script>
<script>
    $(function () {
        var menu = {button: [
<c:forEach items="${menu.button }" var="b" varStatus="bs">
{name:"${b.name }"<c:if test="${b.type ne null }">,type:"${b.type }"</c:if><c:if test="${b.key ne null }">,key:"${b.key }"</c:if><c:if test="${b.url ne null }">,url:"${b.url }"</c:if>
<c:if test="${b.sub_button.size()>0 }">,"sub_button":[
<c:forEach items="${b.sub_button }" var="sb" varStatus="sbs">
{name:"${sb.name }",type:"${sb.type }"<c:if test="${sb.key ne null }">,key:"${sb.key }"</c:if><c:if test="${sb.url ne null }">,url:"${sb.url }"</c:if>}
<c:if test="${sbs.last eq false }">,</c:if>
</c:forEach>]
</c:if>}<c:if test="${bs.last eq false }">,</c:if>
</c:forEach>
                             ]};
        var target;
        var MAX_BUTTON = 3, MAX_MENU_ITEM = 5;
        var getState, setState, STATE_NONE = 0, STATE_CREATE_BUTTON = 1, STATE_CREATE_MENU = 2, STATE_ADD_MENU_ITEM = 3,
                STATE_EDIT_BUTTON = 4, STATE_EDIT_SUBBUTTON = 5,
                STATES = [STATE_NONE, STATE_CREATE_BUTTON, STATE_CREATE_MENU, STATE_ADD_MENU_ITEM, STATE_EDIT_BUTTON, STATE_EDIT_SUBBUTTON];
        (function () {
            var state = STATE_NONE;
            getState = function () {
                return state;
            };
            setState = function (newState) {
                if (!STATES.includes(newState))
                    return;
                state = newState;
                switch (state) {
                    case STATE_NONE:
                        $(".wxform").hide();
                        break;
                    case STATE_CREATE_BUTTON:
                        $(".wxform").show();
                        $('#name,#key,#url').show().val('');
                        $("#delete").hide();
                        $('#type').val('click').trigger("change").focus().children(":last-child").show();
                        break;
                    case STATE_CREATE_MENU:
                        $(".wxform").show();
                        $("#delete").hide();
                        break;
                    case STATE_ADD_MENU_ITEM:
                        $(".wxform").show();
                        $('#name,#key,#url').show().val('');
                        $("#delete").hide();
                        $('#type').val('click').trigger("change").focus().children(":last-child").hide();
                        break;
                    case STATE_EDIT_BUTTON:
                        $(".wxform").show();
                        var btn = menu.button[target.index()];
                        $('#type').val(btn.type || "parent").trigger("change").focus().children(":last-child").show();
                        $("#delete").show();
                        $('#name').val(btn.name);
                        btn.key && ($('#key').val(btn.key));
                        btn.url && ($('#url').val(btn.url));
                        break;
                    case STATE_EDIT_SUBBUTTON:
                        $(".wxform").show();
                        var btn = menu.button[target.parents(".nav-item-menu").index()]["sub_button"][target.index()];
                        $("#delete").show();
                        $('#type').val(btn.type).trigger("change").focus().children(":last-child").hide();
                        $('#name').val(btn.name);
                        btn.key && ($('#key').val(btn.key));
                        btn.url && ($('#url').val(btn.url));
                        break;
                }
            }
        })();
        setState(STATE_NONE);
        var nav = $('.nav');
        $(".screen").on("click", ".nav>.nav-item,nav>.nav-item-menu", function (e) {
            var self = $(e.target).parent();
            if (self.is(".nav>.nav-item.nav-item-add:last-child")) {
                target = self;
                setState(STATE_CREATE_BUTTON);
            }
            else if (self.hasClass("nav-item-menu")) {
                target = self;
                setState(STATE_EDIT_BUTTON);
                if (self.hasClass("nav-item-menu-on")) {
                    self.removeClass("nav-item-menu-on");
                }
                else {
                    $(".nav-item-menu-on").removeClass("nav-item-menu-on");
                    self.addClass("nav-item-menu-on");
                }
            }
            else if (self.is(".nav>.nav-item")) {
                target = self;
                setState(STATE_EDIT_BUTTON);
                $(".nav-item-menu-on").removeClass("nav-item-menu-on");
                //self.removeClass("nav-item").addClass("nav-item-menu").addClass("nav-item-menu-on");
            }
        }).on("click", ".nav-menu-item-box>.nav-item", function (e) {
            var self = $(e.target);
            if (self.is(".nav-item.nav-item-add:last-child")) {
                target = self;
                setState(STATE_ADD_MENU_ITEM);
            }
            else {
                target = self;
                setState(STATE_EDIT_SUBBUTTON);
            }
        });
        $(".wxform #type").change(function (e) {
//            console.log(this.value);
            if (this.value == "click") {
                $("#key").parents(".weui-cell").show();
                $("#url").parents(".weui-cell").hide();
            } else if (this.value == "view") {
                $("#key").parents(".weui-cell").hide();
                $("#url").parents(".weui-cell").show();
            }
            else if (this.value == "parent") {
                $("#key").parents(".weui-cell").hide();
                $("#url").parents(".weui-cell").hide();
            }
        });
        $(".wxform #confirm").click(function (e) {
            switch (getState()) {
                case STATE_CREATE_BUTTON:
                    var val = $("#name").val();
                    if (!val || val.length == 0) {
                        alert("必须输入名称");
                        return;
                    }
                    var btn = {name: val};
                    if ($("#type").val() == "click") {
                        var val = $("#key").val();
                        if (val && val.length > 0) {
                            btn.key = val;
                            btn.type = "click";
                        }
                        else {
                            alert("必须输入键值");
                            return;
                        }
                    } else if ($("#type").val() == "view") {
                        var val = $("#url").val();
                        if (val && val.length > 0) {
                            btn.url = val;
                            btn.type = "view";
                        }
                        else {
                            alert("必须输入链接");
                            return;
                        }
                    }
                    menu.button.push(btn);
                    if ($(".nav").children().length < MAX_BUTTON) {
                        $(".nav").append(target.clone());
                    }
                    target.removeClass("nav-item-add").children('.text').text(btn.name);
                    if ($('#type').val() == "parent") {
                        $(".nav-item-menu-on").removeClass("nav-item-menu-on");
                        target.children('.text').addClass('nav-item');
                        target.removeClass("nav-item").addClass('nav-item-menu').addClass("nav-item-menu-on")
                                .append($('<div class="nav-menu-item-box"><div class="nav-item nav-item-add text"></div></div>'));
                    }
                    setState(STATE_NONE);
                    break;
                case STATE_CREATE_MENU:
                    break;
                case STATE_ADD_MENU_ITEM:
                    var val = $("#name").val();
                    if (!val || val.length == 0) {
                        alert("必须输入名称");
                        return;
                    }
                    var btn = {name: val};
                    if ($("#type").val() == "click") {
                        var val = $("#key").val();
                        if (val && val.length > 0) {
                            btn.key = val;
                            btn.type = "click";
                        }
                        else {
                            alert("必须输入键值");
                            return;
                        }
                    } else if ($("#type").val() == "view") {
                        var val = $("#url").val();
                        if (val && val.length > 0) {
                            btn.url = val;
                            btn.type = "view";
                        }
                        else {
                            alert("必须输入链接");
                            return;
                        }
                    }
                    var parent = menu.button[target.parents('.nav-item-menu').index()];
                    parent["sub_button"] || (parent["sub_button"] = []);
                    parent["sub_button"].push(btn);
                    if (target.parent().children().length < MAX_MENU_ITEM) {
                        target.after(target.clone());
                    }
                    target.removeClass("nav-item-add").text(btn.name);
                    setState(STATE_NONE);
                    break;
                case STATE_EDIT_BUTTON:
                    var btn = menu.button[target.index()];
                    btn.name = $("#name").val();
                    target.children('.text').text(btn.name);
                    if ($('#type').val() == 'parent') {
                        delete btn.type, delete btn.key, delete btn.url;
                        if (target.hasClass('nav-item')) {
                            target.children('.text').addClass('nav-item');
                            target.removeClass("nav-item").addClass('nav-item-menu').addClass("nav-item-menu-on")
                                    .append($('<div class="nav-menu-item-box"><div class="nav-item nav-item-add text"></div></div>'));
                        }
                    } else {
                        delete btn['sub_button'];
                        if ($("#type").val() == "click") {
                            btn.key = $("#key").val();
                            btn.type = "click";
                            delete btn.url;
                        } else if ($("#type").val() == "view") {
                            btn.url = $("#url").val();
                            btn.type = "view";
                            delete btn.key;
                        }
                        if (target.hasClass('nav-item-menu')) {
                            target.children('.text').removeClass('nav-item');
                            target.addClass("nav-item").removeClass('nav-item-menu').removeClass("nav-item-menu-on")
                                    .children(".nav-menu-item-box").remove();
                        }
                    }
                    setState(STATE_NONE);
                    break;
                case STATE_EDIT_SUBBUTTON:
                    var btn = menu.button[target.parents(".nav-item-menu").index()]["sub_button"][target.index()];
                    btn.name = $("#name").val();
                    target.text(btn.name);
                    if ($("#type").val() == "click") {
                        btn.key = $("#key").val();
                        btn.type = "click";
                        delete btn.url;
                    } else if ($("#type").val() == "view") {
                        btn.url = $("#url").val();
                        btn.type = "view";
                        delete btn.key;
                    }
                    setState(STATE_NONE);
                    break;
            }
        });
        $(".wxform #delete").click(function (e) {
            switch (getState()) {
                case STATE_EDIT_BUTTON:
                    var i = target.index();
                    if (target.is(":last-child")) {
                        target.addClass('nav-item-add').children('.text').text('');
                    }
                    else {
                        if (menu.button.length == MAX_BUTTON) {
                            $('.nav').append('<div class="nav-item nav-item-add"><div class="text"></div></div>');
                        }
                        target.remove();
                    }
                    menu.button.splice(i, 1);
                    setState(STATE_NONE);
                    break;
                case STATE_EDIT_SUBBUTTON:
                    var parent = menu.button[target.parents('.nav-item-menu').index()], i = target.index();
                    if (target.is(":last-child")) {
                        target.addClass('nav-item-add').text('');
                    }
                    else {
                        if (parent['sub_button'].length == MAX_MENU_ITEM) {
                            target.parent().append('<div class="nav-item nav-item-add text"></div>');
                        }
                        target.remove();
                    }
                    parent['sub_button'].splice(i, 1);
                    setState(STATE_NONE);
                    break;
            }
        });
        $("#submit").click(function (e) {
        	$.ajax({
        		url:'createmenu.action',
        		type:'post',
        		data:{menu:JSON.stringify(menu)},
        		dataType:'json',
        		success:function(data){
					if(data=='success')
        				alert('提交成功');
					else
						alert('提交失败');
        		},
        		error:function(){
        			alert('提交失败');
        		}
        	});
        });
        window.menu = menu;
    });
</script>
</html>