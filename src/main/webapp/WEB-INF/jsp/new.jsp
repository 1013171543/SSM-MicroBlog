<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <!-- rich text-->
    <script src="${pageContext.request.contextPath}/resources/js/jquery.slim.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap4.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/wangEditor.min.js" type="text/javascript"></script>
    <title>创作新主题 › Genesis </title>
</head>
<script>
    $(document).ready(function(){
    	function submitValidate(flag){
            return flag;
        }
        $("#replyForm").submit(function () {
            if($("#title").val()==''){
                alert("请填写标题！");
                return submitValidate(false);
            }else {
                var ifSubmit=confirm("确定发表该主题吗?");
                if (ifSubmit == true){

                }else {
                    return submitValidate(false);
                }
            }
        })

    });
</script>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>

    <div style="width: 70%;margin:1% 2% 1% 5%;float: left;">
    <div class="panel panel-default" id="main" style="">
        <div class="panel-heading" style="background-color: white">
            <a href="/">Jkworld</a> › 创作新主题
        </div>

        <div class="panel-body">
            <form action="${pageContext.request.contextPath}/topic/addTopic" method="post" id="replyForm">
            	<input type="text" hidden="hidden" name="userId" value="${user.id}">
                <div class="form-group">
                    <label for="title">主题标题</label>
                    <input type="text" class="form-control" id="title" name="title" placeholder="请输入主题标题" required="required">
                </div>

<%--                <div class="form-group">
                    <label for="content">正文</label>
                    <textarea class="form-control" rows="10" id="content" name="content" required="required"></textarea>
                </div>--%>

                <div class="form-group">
                    <label for="div1">内容</label>
                    <div id="div1"></div>
                    <!-- display area-->
                    <textarea id="content" name="content" style="display: none"></textarea>
                </div>

                <div class="form-group">
                    <label for="tab">板块</label><br/>
                    <div class="col-sm-10" style="width: 40%;margin-left:-16px;">
                        <select class="form-control" id="tab" name="tab">
                            <c:forEach items="${tabs}" var="tab">
                            <option value="${tab.id}">${tab.tabName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div><br/>
                <br/>
                <input type="submit" class="btn btn-primary" value="发布主题" id="replyForm">
            </form>
            <%-- rich text --%>
            <script type="text/javascript">
                var E = window.wangEditor
                var editor = new E('#div1')
                var $text1 = $('#content')
                editor.customConfig.onchange = function (html) {
                    // 监控变化，同步更新到 textarea
                    $text1.val(html)
                }
                editor.create()
                // 初始化 textarea 的值
                $text1.val(editor.txt.html())
            </script>
        </div>
    </div>

</div>


    <div class="panel panel-default" id="sidebar2" style="width: 20%;margin:1% 2% 1% 0%;float: right">
        <div class="panel-heading" style="background-color: white;text-align: center">
            友情提示
        </div>
        <ul class="list-group" style="width: 100%">
            <li class="list-group-item">
                <h5>社区原则</h5>
                <p>
                    请不要发布违法、色情、暴力有关的文章与链接，共同营造良好社区环境。
                </p>
            </li>

            <li class="list-group-item">
                <h5>联系管理</h5>
                <p>
        技术问题请联系qq：1013171543，欢迎大家前来交流技术问题。
                </p>
            </li>
        </ul>
    </div>


    <div class="panel panel-default" id="sidebar1" style="width: 20%;margin:1% 2% 1% 0%;float: right">
    <div class="panel-heading" style="background-color: white;text-align: center">
        本站作者的一些碎碎念
    </div>
    <ul class="list-group" style="width: 100%">
        <li class="list-group-item">
            <h5>如果您是一位学生</h5>
            <p>
                请不要把时间浪费在游戏上，多一些时间学习，多一些时间跟家人沟通。
            </p>
        </li>

        <li class="list-group-item">
            <h5>如果您已在工作</h5>
            <p>
                请记住工作只是生活的一部分，请不要忽略了家人的感受，多一些时间陪陪家人，家人需要你的陪伴。
            </p>
        </li>
    </ul>
</div>


<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>
</body>
</html>
