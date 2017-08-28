<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>成为合伙人</title>
    <link rel="stylesheet" href="${path }/resources/css/example.css">
    <link rel="stylesheet" href="${path }/resources/css/weui.css">
</head>
<!--logo-->
<div class="page__ft">
    <img src="${path }/resources/images/logo.png" />
</div>

<!--<div style="margin-top: 1px">
<article class="weui-article">

        <h2 class="title" style="text-align: center"></h2>
        <section>
            <textarea style="width:300px;height:100px;">
                《合伙人相关条款》
            </textarea>
        </section>
</article>
</div>-->

<fieldset style="width: 300px;height: 430px;margin: 0 auto">
    <div class="panel1 weui-flex" id="demo">
        <br class="_panel-box" >
            <div class="item" style="text-align: center">《合伙人相关条款》</div>
            <div style="text-align: center">何以解忧 唯有暴富</div></br>
        </div>
    </div>
</fieldset>




<div><!--
<label for="weuiAgree" class="weui-agree">
    <input id="weuiAgree" type="checkbox" class="weui-agree__checkbox"/>
            <span class="weui-agree__text">
                阅读并同意<a href="javascript:void(0);">《相关条款》</a>
            </span>
</label>-->

<div class="weui-btn-area">
    <button class="weui-btn weui-btn_primary"  id="showIOSDialog2" data-openid="${openid }" >同意</button>
</div>
</div>

<!--页脚-->
<div class="weui-footer">
    <p class="weui-footer__links">
        <a href="http://www.sourongdaojia.net/" class="weui-footer__link">搜融到家</a>
    </p>
    <p class="weui-footer__text">Copyright &copy; www.sourongdaojia.net</p>
</div>


<!--成功弹窗-->
<div class="js_dialog" id="iosDialog2" style="display: none;">
    <div class="weui-mask"></div>
    <div class="weui-dialog">
        <div class="weui-dialog__bd">恭喜你成为搜融合伙人</div>
        <div class="weui-dialog__ft">
            <a href="javascript:;" class="weui-dialog__btn weui-dialog__btn_primary">返回</a>
        </div>
    </div>
</div>

<script src="${path }/resources/js/jquery-1.10.2.js"></script>
<script type="text/javascript" src="${path }/resources/js/xb_scroll.js"></script>
<script src="${path }/resources/js/zepto.min.js"></script>

<script src="${path }/resources/js/example.js"></script>
<script type="text/javascript">
    $(function(){
        var $iosDialog2 = $('#iosDialog2');

        $('.weui-dialog__btn').on('click', function(){
            $(this).parents('.js_dialog').fadeOut(200);
        });

        $('#showIOSDialog2').on('click', function(){
			$.ajax({
				url:"${path}/weixin/update.action",
				dataType:'json',
				data:{openid:$(this).data('openid')},
				success:function(data){
					if(data=="success")
						$iosDialog2.fadeIn(200);
					else
						alert("请求失败");
				},
				error:function(){
					alert("请求失败");
				}
			});
            //
        });
    });
   </script>


<script>
    /*固定高度*/
    $("#demo").xb_scroll();

    function elemAdd()
    {
        $(".panel1 ._panel-box").append("<div class='item'>info for add</div>")
    }

    function elemRemove()
    {
        $(".panel1 ._panel-box .item").last().remove();
    }


    /*最大高度*/
    $("#demo2").xb_scroll({"isMaxHeight":true});
    function elemAdd2()
    {
        $(".panel2 ._panel-box").append("<div class='item'>info for add</div>")
    }

    function elemRemove2()
    {
        $(".panel2 ._panel-box .item").last().remove();
    }
</script>

</html>