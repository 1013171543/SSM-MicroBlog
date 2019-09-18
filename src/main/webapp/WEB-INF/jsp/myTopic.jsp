<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <title>Jkworld › MyTopic</title>
    <style type="text/css">
    
	    #pageTips{
	    	margin-left: 530px;
	    }
	    #naviTips{
	    	margin-left: 550px;
	    	margin-left: 550px;
	    }
    </style>
    <script type="text/javascript">
    $(document).ready(function(){
    	function del(){
            var del=confirm("您确定要删除此条记录？");
            if(del==true){
                 
            	alert(1);
            }else{
                return false;
            }
        }
        $("button[name='delete']").bind("click",function(){
    		return del();
    	});
    	
    });
    
    </script>
    <style type="text/css">
	    h1{
			text-align: center;			
		}
		table {
				width: 660px;
		}
		p{
			margin-left: 180px;
		}
    </style>
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
        <h1>我的帖子</h1>
			<table align="center" class="table-striped table-bordered table-hover">
		    	<tr style="text-align:center">
		    		<td>板块</td>
		    		<td>名称</td>
		    		<td>日期</td>
		    		<td>操作</td>
		  		</tr>
		  		<c:forEach var="topic" items="${userTopics}">
		  			<tr style="text-align:center">
		  				<td>${topic.tab.tabName}</td>
		  				<td>${topic.title}</td>
		  				<td>${topic.localCreateTime}</td>
		  				<td><button name="delete">删除</button></td>
		  			</tr>
		  		</c:forEach>
		    
		    
		    </table>
		    <div class="row">
        <!--文字信息-->
        <div class="col-md-6" id="pageTips">
        		    当前第 ${pageInfo.pageNum} 页.总共 ${pageInfo.pages} 页.一共 ${pageInfo.total} 条记录
        </div>
 
        <!--点击分页-->
        <div class="col-md-6" id="naviTips">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    
                    <li><a href="${pageContext.request.contextPath}/user/myTopic.action?id=${user.id}&&starPage=1">首页</a></li>
                    
                    <!--上一页-->
                    <li>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <a href="${pageContext.request.contextPath}/user/myTopic.action?id=${user.id}&&starPage=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">«</span>
                            </a>
                        </c:if>
                    </li>
 
                    <!--循环遍历连续显示的页面，若是当前页就高亮显示，并且没有链接-->
                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                        <c:if test="${page_num == pageInfo.pageNum}">
                            <li class="active"><a href="#">${page_num}</a></li>
                        </c:if>
                        <c:if test="${page_num != pageInfo.pageNum}">
                            <li><a href="${pageContext.request.contextPath}/user/myTopic.action?id=${user.id}&&starPage=${page_num}">${page_num}</a></li>
                        </c:if>
                    </c:forEach>
 
                    <!--下一页-->
                    <li>
                        <c:if test="${pageInfo.hasNextPage}">
                            <a href="${pageContext.request.contextPath}/user/myTopic.action?id=${user.id}&&starPage=${pageInfo.pageNum+1}"
                               aria-label="Next">
                                <span aria-hidden="true">»</span>
                            </a>
                        </c:if>
                    </li>
                    
                    <li><a href="${pageContext.request.contextPath}/user/myTopic.action?id=${user.id}&&starPage=${pageInfo.pages}">尾页</a></li>
                </ul>
            </nav>
        </div>
 
    </div>
        </div>
    </div>
</div>

<!-- 引入侧边栏文件 -->
<%@ include file="side.jsp"%>

<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>

</body>
</html>