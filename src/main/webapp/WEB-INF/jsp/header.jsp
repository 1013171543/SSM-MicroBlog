<!-- 页眉部分 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header>
    <nav class="navbar navbar-default" role="navigation" style="background-color: white">
        <div class="container-fluid" style="margin-left: 10%">
            <div class="navbar-header">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">Jkworld</a>
            </div>
            <div>

                <!--向左对齐-->
                <ul class="nav navbar-nav navbar-left">
                    <li <c:if test="${tab.tabNameEn == 'tech'}">
                            class="active" </c:if>><a href="${pageContext.request.contextPath}/tab/${type}tech">技术</a>
                    </li>
                    <li <c:if test="${tab.tabNameEn == 'play'}">class="active"
                        </c:if>><a href="${pageContext.request.contextPath}/tab/${type}develop">开发</a></li>
                    <li <c:if test="${tab.tabNameEn == 'creative'}">class="active"
                        </c:if>><a href="${pageContext.request.contextPath}/tab/${type}communicate">交流</a></li>
                    <li <c:if test="${tab.tabNameEn == 'jobs'}">class="active"
                         </c:if>><a href="${pageContext.request.contextPath}/tab/${type}help">求助</a></li>
                    <li <c:if test="${tab.tabNameEn == 'deals'}">class="active"
                        </c:if>><a href="${pageContext.request.contextPath}/tab/${type}deal">交易</a></li>
                </ul>

                <shiro:notAuthenticated>
                    <!--未登陆-->
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <p class="navbar-text"><a href="${pageContext.request.contextPath}/forword/toLogin">登录</a></p>
                        </li>
                        <li>
                            <p class="navbar-text"><a href="${pageContext.request.contextPath}/forword/toRegist">注册</a></p>
                        </li>
                    </ul>
                </shiro:notAuthenticated>

                <shiro:authenticated>
                    <!--已登陆-->
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <p class="navbar-text"><a href="${pageContext.request.contextPath}/">首页</a></p>
                        </li>
                        <li>
                            <p class="navbar-text" id="displayName" style="margin-right: -10px;">用户：</p>
                            <p class="navbar-text">
                                <strong>
                                    <a href="${pageContext.request.contextPath}/user/userInfoid/${user.id}">
                                    <shiro:principal></shiro:principal>
                                    </a>
                                </strong>
                            </p>
                        </li>
                        <li>
                            <p class="navbar-text"><a href="javascript:signout_confirm();">退出</a></p>
                        </li>
                    </ul>

                </shiro:authenticated>
            </div>
        </div>
    </nav>


</header>
<script>
    function signout_confirm()
    {
        var r=confirm("确定退出?");
        if (r==true)
        {
            //使用shiro退出登录
            window.location.href="${pageContext.request.contextPath}/user/quit";
        }
        else
        {

        }
    }
</script>