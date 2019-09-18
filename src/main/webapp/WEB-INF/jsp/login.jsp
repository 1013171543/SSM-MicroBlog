<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登录 - Genesis</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

	<script type="text/javascript">
		$(document).ready(function(){
			var path = "${pageContext.request.contextPath}";
			$("#loginButton").click(function(){
				
				var url= path+"/user/login";

				var username = $("#username").val();
				var password = $("#password").val();
				var remenber =false;

				if($("input[type='checkbox']").is(':checked')){
				    remenber =true;
                }

				var loginJson = {"username":username,"password":password,"remenber":remenber};
				
				$(this).load(url,loginJson,function(data){	

					var jsondata = eval("("+data+")");
					if(jsondata.serverState==0){
						alert("用户名不存在或者密码错误");
					}else{
						alert("登陆成功");
						window.location.replace(path+"/");
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
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>

<div class="panel panel-default" id="login" style="width: 20%;margin-left: 40%;margin-top: 5%;margin-bottom: 5%">
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title">登录</h3>
    </div>
    <div class="panel-body">
        <div class="form-group">
            <label for="username">用户名</label>
            <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名" required="required">
        </div>
        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码" required="required">
        </div>
        <div class="checkbox text-left">
            <label>
                <input type="checkbox" id="remenber" name="remenber">记住密码
            </label>
            <a style="margin-left: 30%" href="#">忘记密码?</a>
        </div>

        <button id="loginButton" class="btn btn-success btn-block">登录</button>
        

    </div>
</div>

<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>
</body>
</html>