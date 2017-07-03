<%@page import="org.apache.log4j.helpers.DateTimeDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
/* String id = request.getParameter("id"); */
%>

<!DOCTYPE HTML>
<html style="width:100%;height:100%;">
  <head>
    <base href="<%=basePath%>">
    <title>考勤统计</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@include file="../common/base.jsp"%>
	<script type="text/javascript" src="<%=basePath%>jsp/showAttendance/listAttendance.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/form/form.json.js"></script>
	<script type="text/javascript">
	var basePath = "<%=basePath%>";
	</script>
  </head>
  <script>
  $(function(){
	$.post("login/login",function(data){
			if(data.hasError){
				alert("请求错误");
			}else{
				$("#welcome").text("欢迎您:"+data);
			}
		});
	});
  </script>
  <style>
  .listInput{
	/* position:relative; */
	padding: 5px 5px 0px 5px;   /**上, 右, 下, 左*/
	 clear: both;
}

  </style>
  <body style="width:100%;height:100%;">
 <!--  <div style="float:left;width:100%;height:17%;">
  </div> -->
  <div data-option="size:82" style="float:left;width:100%;height:14%;background: url('../../images/banner.png') no-repeat;background-size:100%;">
				<div style="position: absolute; right: 10px; top: 10px; font-size: 12px; color: #DFDFDF">
					<span id="today"></span>
				</div>
				<div style="position: absolute; right: 10px; top: 45px; font-size: 14px; color: #FFFFFF; font-weight: bold;">
					<span id="welcome" style="background: url('../../images/user.gif') no-repeat; padding: 3px 0 3px 25px"></span>&nbsp;&nbsp;<!-- <span id="logout" style="cursor: pointer;"><a href="http://localhost:18080/cas/logout?service=http://localhost:8080" style="color:white">退出系统</a></span> -->
				</div>
			</div>
  <div style="float:left;width:100%;height:86%;border-top:3px solid #00e3e3;background:#F5FFFA;">
  <div style="float:left;width:12%;height:100%;background:#AFEEEE;">
  <%@include file="../common/menu.jsp"%>
  </div>
<!--   <div id="toolbar" style="margin-top:10px">
            <select id="selector" class="form-control" style="width:130px" id="export">
                <option value="">导出当前页</option>
                <option value="all">导出所有数据</option>
                <option value="selected">导出选择数据</option>
            </select>
     </div> -->
  <div style="float:left;width:88%;height:100%;overflow-y:scroll;">
  <div style="float:left;width:100%;overflow-x:scroll;">
		<div class="input-group" style="float:left;width:25%;padding-top:5px;padding-left:10px;padding-down:5px;">
            <span class="input-group-addon">部门名称</span>
            <input type="text" id="listdept" class="form-control" style="width:210px;margin-left:0px;margin-top:0px;">
        </div>
        <div class="input-group" style="float:left;width:45%;padding-top:5px;padding-left:-20px;padding-down:5px;">
            <span class="input-group-addon">时间</span>
            <input type="text" id="listtime" class="form-control" value="${nowDate}" style="width:210px;margin-left:0px;margin-top:0px;">&nbsp;&nbsp;&nbsp;&nbsp;
          <button type="button" id="queryId" onclick="queryByName();" class="btn btn-primary">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
          <button type="button" id="queryId" onclick="exportXls();" class="btn btn-primary">导出excel</button>
        </div>
    <table id="reportTable" class="table table-bordered table-striped" style="font-size: 10px;width:2400px;">
        </table>
        </div>
			</div>
	</div>
  </body>
</html>
