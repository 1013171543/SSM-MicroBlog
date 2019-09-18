<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <title>Jkworld › <c:if test="${!empty user}">${userInfo.username}</c:if></title>
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>

<div style="width: 70%;margin:1% 2% 1% 5%;float: left;">
    <div class="panel panel-default" id="main" style="">
        <div class="panel-heading" style="background-color: white">
            <a href="${pageContext.request.contextPath}/resources/jsp/category.jsp">Jkworld</a> › ${user.username}
        </div>

        <div class="panel-body">
            <c:if test="${!empty userInfo}">
            <form class="form-horizontal" role="form">
                <div style="margin-left: 17%">
                
                </div><br/>
                
                <div class="form-group">
                    <label class="col-sm-2 control-label">头像</label>
                    <div class="col-sm-10">
                        <img width="60px" height="60px" src="${pageContext.request.contextPath}/${userInfo.avatar}" class="img-rounded">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">ID</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${userInfo.id}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">用户名</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${userInfo.username}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Email</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${userInfo.email}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">注册时间</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${userInfo.localCreateTime}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">积分</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${userInfo.credit}</p>
                    </div>
                </div>
                <c:if test="${empty flag}">
                	<div class="form-group">
                    <label class="col-sm-2 control-label">
                    	<!-- <input type="button" value="修改信息" class="btn btn-info"> -->
                    	<a href="${pageContext.request.contextPath}/forword/toEditUser/${user.id}">修改信息</a>
                    </label>
                    <div class="col-sm-10">
                       <input type="button" value="成为会员" class="btn btn-primary form-control-static">
                    </div>
                    
                </div>
                
                </c:if>
                
            </form>
            </c:if>
        </div>
    </div>
</div>

<!-- 引入侧边栏文件 -->
<%@ include file="side.jsp"%>

<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>

</body>
</html>