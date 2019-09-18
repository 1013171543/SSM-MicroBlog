<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Jkworld ›设置</title>
    <!-- jscrop -->
    <link href="${pageContext.request.contextPath}/resources/css/jquery.Jcrop.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery.Jcrop.min.js"></script>
  	<script src="${pageContext.request.contextPath}/resources/js/imgCropUpload.js"></script>
   
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    
    
    <style type="text/css">
    	 body {
            font-size: 16px;
            font-family:"Microsoft YaHei",Arial, Helvetica, sans-serif
        }
        *,
        *:before,
        *:after {
            -webkit-box-sizing: border-box;
               -moz-box-sizing: border-box;
                -ms-box-sizing: border-box;
                    box-sizing: border-box;
        }

        .crop-picker-wrap {
            position: relative;
            width: 100px;
            height: 30px;
            overflow: hidden;
        }
        .crop-picker {
            width: 100%;
            height: 100%;
            line-height: 1;

            -webkit-appearance: none;
            margin: 0;
            border: none;
            border-radius: 5px;
            padding: 9px 0;
            background-color: #1ab2ff;

            color: #fff;            
            cursor: pointer;
        }
        .crop-picker-file {
            position: absolute;
            top: 0;
            right: 0;
            height: 100%;
            opacity: 0;
            cursor: pointer;
            filter: alpha(opacity=0);
        }

        .crop-wrapper {
            display: inline-block;
            min-width: 750px;
            margin: 10px 0;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 5px 2px #ccc;
        }

        .crop-container {
            font-size: 0;
        }

        .crop-container img[src=""] {
            visibility: hidden;
        }

        .crop-area-wrapper,
        .crop-preview-wrapper {
            display: inline-block;
            vertical-align: top;
        }
        .crop-area-wrapper {
            width: 500px;
            height: 400px;
        }
        .crop-preview-wrapper {
            width: 200px;
            height: 200px;
            margin-left: 28px;
            overflow: hidden;
        }
        .crop-preview-container {
            position: relative;
            overflow: hidden;
        }
        .crop-operate {
            text-align: center;
            margin: 10px 0;
        }
        .crop-save,
        .crop-cancel {
            display: inline-block;
            vertical-align: middle;

            width: 150px;
            height: 50px;
            line-height: 50px;

            -webkit-appearance: none;
            margin: 0 5px;
            border: none;
            border-radius: 5px;
            background-color: #1ab2ff;

            color: #fff;
            cursor: pointer;
        }
        .crop-hidden {
            display: none;
        }
    </style>
    <script type="text/javascript">
       $(document).ready(function(){
    	   
    	   
    	   
    	   var path = "${pageContext.request.contextPath}";
    	   
    	   Crop.init({
               id: 'TCrop',
               /* 上传路径 */
               url: path+'/user/cutImg',
               /* 允许上传的图片的后缀 */
               allowsuf: ['jpg', 'jpeg', 'png', 'gif'],
               /* JCrop参数设置 */
               cropParam: {
                   minSize: [300, 300],          // 选框最小尺寸
                   maxSize: [300, 300],        // 选框最大尺寸
                   allowSelect: true,          // 允许新选框
                   allowMove: true,            // 允许选框移动
                   allowResize: true,          // 允许选框缩放
                   dragEdges: true,            // 允许拖动边框
                   onChange: function(c) {},   // 选框改变时的事件，参数c={x, y, x1, y1, w, h}
                   onSelect: function(c) {}    // 选框选定时的事件，参数c={x, y, x1, y1, w, h}
               },
               /* 是否进行裁剪，不裁剪则按原图上传，默认进行裁剪 */
               isCrop: true,
               /* 图片上传完成之后的回调，无论是否成功上传 */
               onComplete: function(data) {
            	//剪切完成后，关闭剪切框
				console.log('upload complete!');
               	$(".crop-picker-wrap").removeClass("crop-hidden");
               	$(".crop-wrapper").addClass("crop-hidden");
               	//显示上传的文件名称                	
					var obj = document.getElementById("file");
					var len = obj.files.length;
					for (var i = 0; i < len; i++) {
						var temp = obj.files[i].name;
						
						if(temp.length<7){
							$(".crop-picker").html(temp);
						}else{
							$(".crop-picker").html("已选择图片");
						}
					}
					//获取图片名称
					var returnJson = eval("("+data+")");
					$("#photo").val(returnJson.imgName);
					alert(returnJson.imgName);
               }
           });
    	   
    	 //检验手机号码输入是否合法
   		 $("#tel").focusout(function(){
   			
   			var phone = $(this).val();
  				if(!(/^1[34578]\d{9}$/.test(phone))){ 

  					$("#phoneTips").html("<font color='red'>请输入正确的手机号码</font>");
  			    	$("#sub").attr("disabled","disabled");

  			        return false; 
  			    } else{

  			    	$("#phoneTips").html("<font color='green'>输入正确</font>");
  			    	$("#sub").removeAttr("disabled");
  			
  			    }
   		});
    	 
       });
    </script> 
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>

<div style="width: 70%;margin:1% 2% 1% 5%;float: left;">
    <div class="panel panel-default" id="main" style="">
        <div class="panel-heading" style="background-color: white">
            <a href="/">Jkworld</a> › 设置
        </div>

        <div class="panel-body">
                <form class="form-horizontal" role="form" action="${pageContext.request.contextPath}/user/updateUser" enctype="multipart/form-data">
                	<!-- 用户的id -->
                	<input hidden="hidden" value="${user.id}" name="id">
                	<!-- 用户的头像地址 -->
                	<input hidden="hidden" id="photo" name="photo">
                    <div class="form-group">
	                    <label class="col-sm-2 control-label">头像</label>
	                    <div class="col-sm-3" id="TCrop">
	                        <input type="file" name="filePhoto" id="filesToUpload" multiple="multiple" id="filePhoto"/>
                    	</div>
              		</div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">手机号：</label>
                        <div class="col-sm-3">
                        	<input type="tel" name="tel" required="required" id="tel" value="${user.phoneNum}" class="form-control"><br>
                        	<span id="phoneTips"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-3">
                            <input type="text" name="username" required="required" id="username" value="${user.username}" class="form-control" disabled="disabled"><br>
                        	<span id="usernameTips"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-3">
                       		<input type="email" name="email" required="required" id="email" value="${user.email}" class="form-control"> 
                        </div>
                    </div>
                    
                     <div class="form-group">
                        <label class="col-sm-2 control-label"><button class="btn btn-success" type="submit" id="sub">修改</button></label>
                    </div>
                </form>
        </div>
    </div>
</div>
<!-- 引入侧边栏文件 -->
<%@ include file="side.jsp"%>

<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>

</body>
</html>