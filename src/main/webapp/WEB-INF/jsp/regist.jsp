<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
 	
    <meta charset="UTF-8">
    <title>注册 - Jkworld</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    var countdown=60; 
    
	function sendemail(){
	    var obj = $("#getPhoneToken");
	    settime(obj); 
	    }
	function settime(obj) { //发送验证码倒计时
	    if (countdown == 0) { 
	        obj.attr('disabled',false); 
	        obj.val("免费获取验证码");
	        countdown = 60; 
	        return;
	    } else { 
	        obj.attr('disabled',true);
	        obj.val("重新发送(" + countdown + ")");
	        countdown--; 
	    } 
	setTimeout(function() { 
	    settime(obj); }
	    ,1000); 
	}   
    
    
    	$(document).ready(function(){
    		
    		var path = "${pageContext.request.contextPath}";
    		
    		//更换手机验证码
    		$("#createImgToken").click(function(){
    			//随机更改action的参数
    			this.src = this.src +"?"+new Date().getTime();
    		});
    		
    		//检验手机号码输入是否合法
    		$("#tel").focusout(function(){
    			
    			var phone = $(this).val();
   				if(!(/^1[34578]\d{9}$/.test(phone))){ 

   					$("#phoneTips").html("<font color='red'>请输入正确的手机号码</font>");
   			    	$("#getPhoneToken").attr("disabled","disabled");
   			        return false; 
   			    } else{

   			    	$("#phoneTips").html("<font color='green'>输入正确</font>");
   			    	$("#getPhoneToken").removeAttr("disabled");
   			    }
    		});
    		
    		
    		//使用ajax检查用户名称是否可以被注册
    		$("#username").focusout(function(){
    			
    			var username = $(this).val();
   				var url = path+"/check/checkUser";
   				var json ={"username":username};
				$(this).load(url,json,function(data){	
					
					var jsondata = eval("("+data+")");
					
					if(jsondata.serverState==1){
						$("#usernameTips").html("<font color='green'>恭喜你，该用户名可注册</font>");
						$("#signup").removeAttr("disabled");
					}else{
						$("#usernameTips").html("<font color='red'>对不起，该用户名已被注册</font>");
	   			    	$("#signup").attr("disabled","disabled");
	   			        return false; 
					}
				});
   				
    		});
    		
    		
    		//使用Ajax发送手机信息
			$("#getPhoneToken").click(function(){
				
				var url= path+"/user/createPhoneToken";
				//获取手机号码
				var tel = $("#tel").val();
				//获取用户写入的图片验证码
				var imgToken = $("#imgToken").val();
				
				var rigistJson = {"tel":tel,"imgToken":imgToken};
				
				$(this).load(url,rigistJson,function(data){	
					
					var jsondata = eval("("+data+")");
					
					if(jsondata.tokenState==1){
						sendemail();
						
					}else{
						alert("请输入正确的验证码");
					}
					
				});
			});
    		
    	});
    </script>
    <style>
        li {list-style-type:none;}
        html, body {
            height: 100%;
            font-size: 14px;
            color: #525252;
            font-family: NotoSansHans-Regular,AvenirNext-Regular,arial,Hiragino Sans GB,"Microsoft Yahei","Hiragino Sans GB","WenQuanYi Micro Hei",sans-serif;
            background: #f0f2f5;
        }
        .footer {
            background-color: #fff;
            margin-top: 22px;
            margin-bottom: 22px;
            width: 100%;
            padding-top: 22px;
            color: #8A8A8A;
            display: block;
            height: 200px;
            border: 1px ;
            clear:both
        }

        .container {
            margin-right: 5%;
            margin-left: 5%;
            padding-left: 15px;
            padding-right: 15px;
            width: 40%;
            float: left;
        }
        .info {
            margin-right: 5%;
            width: 10%;
            float: left;
        }
        a{
            color: #8A8A8A;
            cursor: pointer;
        }
    </style>
</head>
<body>

<c:if test="${registState==0}">
	<script type="text/javascript">
		alert("手机验证码错误,ok?????!!!");
	</script>
</c:if>
<c:if test="${registState==1}">
	<script type="text/javascript">
		alert("都说了，用户名已存在，不要用科技手段好吗？答应我");
	</script>
</c:if>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>

<div class="panel panel-default" id="login" style="width: 55%;margin-left: 10%;margin-top: 5%;margin-bottom: 5%" >
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title">注册</h3>
    </div>
    <div class="panel-body">
        <form action="${pageContext.request.contextPath}/user/regist.action" method="post" id="signupForm" class="form-horizontal" role="form" style="margin-left: 5%">
            <div class="form-group" >
                <label class="col-sm-2 control-label">用户名</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input type="text" class="form-control" id="username" name="username" required="required">
           			<span id="usernameTips"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">密码</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input type="password" class="form-control" id="password" name="password" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">电子邮件</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input type="email" class="form-control" id="email" name="email" required="required">
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">验证码</label>
                <div class="col-sm-10" style="width: 40%;">
                    <div class="row">
                    	<div class="col-sm-4"><img src="${pageContext.request.contextPath}/user/createImgToken"  alt="看不清楚换一张" id="createImgToken"></div>
                    	<div class="col-sm-4"><input type="text"  class="form-control" id="imgToken" required="required" placeholder="图片验证码"></div>
                    	
                    </div>
                </div>
            </div>
            
            
            <div class="form-group">
                <label class="col-sm-2 control-label">手机验证码</label>
                <div class="col-sm-10" style="width: 40%;">
                    <div class="row">
                    	<div class="col-sm-6"><input type="text"  class="form-control" id="phoneToken" name="phoneToken" required="required" placeholder="手机验证码"></div>
                    	<div class="col-sm-2"><input type="button" value="获取验证码" class="btn btn-primary" id="getPhoneToken"></div>
                    </div>
                </div>
            </div>

		
            <div class="form-group">
                <label class="col-sm-2 control-label">手机号</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input type="tel" class="form-control" id="tel" name="phoneNum" required="required">
                    <p class="form-control-static" id="phoneTips"></p>
                </div>
            </div>
            <input type="submit" class="btn btn-default" id="signup" style="margin-left: 17%" value="注册">
        </form>
    </div>
</div>


<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>

<script>
    function submitValidate(flag){
        return flag;
    }
    $("#signupForm").submit(function () {
        if($("#username").val()==''||$("#password").val()==''||$("#email").val()==''||$("#tel").val()==''){
            alert("请将注册信息填写完整！");
            return submitValidate(false);
        }else {

        }
    })
</script>
</body>
</html>