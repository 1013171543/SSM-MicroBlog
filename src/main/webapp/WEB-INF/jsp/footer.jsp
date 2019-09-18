<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
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
<footer class="footer">
    <div class="container">
    这些年我一直提醒自己一件事情，千万不要自己感动自己。大部分人看似的努力，不过是愚蠢导致的。
        <br/><br/><br/>
        <p>极客世界</p>
    </div>
    <div class="info">
        <p style="text-align: center;font-size: 16px; margin-left: -45px;">统计信息</p>
        <ul >
            <li>会员数:<strong>&nbsp;&nbsp;${usersNum}</strong></li>
            <li>话题数:<strong>&nbsp;&nbsp;${topicsNum}</strong></li>
        </ul>
    </div>
    <div class="info">
        <p style="text-align: center;font-size: 16px; margin-left: -50px;">友情链接</p>
        <ul >
            <li><a href="/">Github</a></li>
            <li><a href="/">Segmentfault</a></li>
            <li><a href="/">v2ex</a></li>
        </ul>
    </div>
    <div class="info" >
        <p style="text-align: center;font-size: 16px; margin-left: -50px;">其他信息</p>
        <ul >
            <li><a href="/">关于本站</a></li>
            <li><a href="/">联系我们</a></li>
        </ul>
    </div>
</footer>
</body>
</html>