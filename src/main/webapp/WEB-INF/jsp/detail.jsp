<!-- 帖子详情页 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="${pageContext.request.contextPath}/resources/css/jquery.Jcrop.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery.Jcrop.min.js"></script>
  	<script src="${pageContext.request.contextPath}/resources/js/imgCropUpload.js"></script>
   
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <title>${topic.title} - Jkworld </title>
    
    <style type="text/css">
    	<!-- 为段落添加换行-->
  	  .demobox{word-wrap:break-word;}
  	  
    </style>
    
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>
<div style="width: 70%;margin:1% 2% 1% 5%;float: left;">
<div class="panel panel-default" id="main" style="">
    <div class="panel-heading" style="background-color: white">
        <div>
            <div class="panel-heading" style="background-color: white">
                <a href="${pageContext.request.contextPath}/">Jkworld</a> › 主题
            </div>
            <h3>${topic.title}</h3><br/>
            <div>
                <a href="#"><span ><strong>${topic.user.username}</strong></span></a>&nbsp;&nbsp;
                <small class="text-muted">${topic.localCreateTime}&nbsp;&nbsp;&nbsp;+08:00</small>&nbsp;&nbsp;
                <small class="text-muted">阅读量：${topic.click}</small>
            </div>
        </div>

        <div style="float: right;margin-top: -100px" >
        	<img width="70px" height="70px" src="${pageContext.request.contextPath}/${topic.user.avatar} " class="img-rounded"><br>
        	<div style="margin-left: 5px">
        	
        	<c:if test="${topic.user.credit < 20}">	
	            <span class="badge">沙雕网友</span>
			</c:if>
			<c:if test="${topic.user.credit >20 && topic.user.credit <40}">
           		<span class="badge">人工智障</span>
           	</c:if>
           	<c:if test="${topic.user.credit >40 && topic.user.credit <60}">
           		<span class="badge">智慧大脑</span>
           	</c:if>
           	<c:if test="${topic.user.credit >60 && topic.user.credit <80}">
           		<span class="badge">高级沙雕</span>
           	</c:if>
           	<c:if test="${topic.user.credit >80}">
           		<span class="badge">终极沙雕</span>
           	</c:if>
        	</div>
        </div>
    </div>

    <ul class="list-group" style="width: 100%">
            <li class="list-group-item">
                ${topic.content}
            </li>
    </ul>
</div>
<c:if test="${!empty replies}">
	<div class="panel panel-default" id="main" style="">
	    <div class="panel-heading" style="background-color: white">
	        <span>
	                ${fn:length(replies)} 回复  |  <strong>最后回复时间 </strong>
	                <c:forEach items="${replies}" var="reply" varStatus="status">
						<c:if test="${status.last}">
		   				&nbsp;&nbsp; ${reply.localCreateTime}
		    			</c:if>
	    			</c:forEach>
	   		</span>
	    </div>
	
	    <ul class="list-group" style="width: 100%">
	        <!-- 遍历评论 -->
	        <c:forEach items="${replies}" var="reply">
	        <li class="list-group-item" id="replyBoder" style="height: ${reply.device}px;">
	            <div style="height: 50px">
	                <div style="float: left;width: 13%;margin-bottom: 5px">
	                    <img width="70px" height="70px" style="margin-left: 30px" src="${pageContext.request.contextPath}/${reply.user.avatar} " class="img-rounded"><br>
	                    <div style="margin-left: 35px">
	                    	<c:if test="${reply.user.credit < 20}">	
	                    		<span class="badge">沙雕网友</span>
							</c:if>
							<c:if test="${reply.user.credit >20 && reply.user.credit <40}">
	                    		<span class="badge">人工智障</span>
	                    	</c:if>
	                    	<c:if test="${reply.user.credit >40 && reply.user.credit <60}">
	                    		<span class="badge">智慧大脑</span>
	                    	</c:if>
	                    	<c:if test="${reply.user.credit >60 && reply.user.credit <80}">
	                    		<span class="badge">高级沙雕</span>
	                    	</c:if>
	                    	<c:if test="${reply.user.credit >80}">
	                    		<span class="badge">终极沙雕</span>
	                    	</c:if>
	                    </div>
	                </div>
	                <div style="width: 87%;float: left">
	                    <a href="${pageContext.request.contextPath}/user/userInfoid/${reply.replyUserId}"><strong>${reply.user.username}</strong></a>&nbsp;&nbsp;
	                    <small class="text-muted">${reply.localCreateTime}</small>
	                    <br/>
	                    <div>
	                        <p class="demobox">${reply.content}</p>
	                    </div>
	                </div>
	            </div>
	        </li>
	        </c:forEach>
	    </ul>
	</div>
</c:if>

<shiro:authenticated>
	<div class="panel panel-default" id="main" style="">
		<div class="panel-heading" style="background-color: white">
			&nbsp;&nbsp;回复
		</div>
		<div class="panel-body">
			<div class="form-group">
				<!-- 添加回复 -->
				<form action="${pageContext.request.contextPath}/reply/addReply" method="post" enctype="multipart/form-data">
					<input type="hidden" name="topicId" value="${topic.id}">
					<input type="hidden" name="replyUserId" value="${user.id}">
					<textarea class="form-control" rows="5" name="content" required="required"></textarea><br/>
					<div class="form-group">
						<label class="col-sm-1 control-label"><input type="submit" class="btn btn-default btn-sm" value="回复"></label>
						<div class="col-sm-1">
						</div>
					</div>
				</form>
			</div>

		</div>

	</div>

</shiro:authenticated>

</div>

<!-- 引入侧边栏文件 -->
<%@ include file="side.jsp"%>

<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>

</body>
</html>