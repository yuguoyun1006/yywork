<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Date date = new Date();
	Date date1=new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String pdate = sdf.format(date);
	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM");
	String pdate1 = sdf1.format(date1);
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
<script type="text/javascript"
	src="<%=basePath%>jsp/attendance/attendance.js"></script>
<script type="text/javascript"
	src="<%=basePath%>jsp/attendance/edit.js"></script>
<script type="text/javascript" src="<%=basePath%>js/form/form.json.js"></script>

<script type="text/javascript">
	basePath = "<%=basePath%>";
	var date = "<%=pdate%>";
	var pdate1 = "<%=pdate1%>";
	var user = "${userList}";
</script>
<style>
.clearfix {
	width: 20%;
}

.modal-footer {
	border-top: 1px;
	height: 125px;
}

.form-control {
	width: 100%;
}

label {
	font-weight: 100;
}

.listInput {
	position: relative;
	padding: 5px 5px 0px 5px; /**上, 右, 下, 左*/
	clear: both;
}
td{
overflow:hidden;
white-space:nowrap;
text-overflow:ellipsis;
border: 1px solid;
border-color:#DDDDDD;   
}
a{ 
font-size:15px;
}
</style>
</head>
<script>
	
	$(function() {
		/* $(".dkDate1").datetimepicker({format: 'yyyy-MM',minView:3,startView: 3, maxViewMode: 4,minViewMode:3}); // 选择日期 */
		/* $.post("login/login", function(data) {
			if (data.hasError) {
				alert("请求错误");
			} else {
				$("#welcome").text("欢迎您:" + data);
			}
		}); */
		$("#attendance_date").val(date);

	});
	function yemo(year, month) {
		var arr = document.getElementsByTagName("th");
		var arr1 = [];
		for ( var i = 0; i < 32; i++) {
			arr1.push(arr[i].innerHTML);
		}
		var arr2 = time(year, month);
		var tt = "";
		var tt1 = "";
		for ( var i = 1; i < arr1.length; i++) {
			var v = parseInt(arr1[i]);
			if ($.inArray(v, arr2) != -1) {
				tt += "#a" + i + ",";
				$("th[id='t"+i+"']").attr("bgcolor","#9BCA00");
				$("a[name='"+document.getElementById("a"+i).className+"']").html(format(""));
				//$("input[class='"+document.getElementById("a"+i).className+"']").val("");
				$("."+document.getElementById("a"+i).className).val("");
			} else {
				tt1 += "#a" + i + ",";
				$("th[id='t"+i+"']").attr("bgcolor","#FFFFFF");
				$("a[name='"+document.getElementById("a"+i).className+"']").html(format("出勤"));
				//$("input[class='"+document.getElementById("a"+i).className+"']").val("出勤");
				$("."+document.getElementById("a"+i).className).val("出勤");
			}
		}
		tt1 = tt1.substring(0, tt1.length - 1);
		//$(tt1 + ",#aa").val("出勤");
		tt = tt.substring(0, tt.length - 1);
		//$(tt).val("");
	}
	function time(y, m) {
		var tempTime = new Date(y, m, 0);
		var time = new Date();
		var saturday = new Array();
		var sunday = new Array();
		for ( var i = 1; i <= tempTime.getDate(); i++) {
			time.setFullYear(y, m - 1, i);
			var day = time.getDay();
			if (day == 6) {
				saturday.push(i);
			} else if (day == 0) {
				sunday.push(i);
			}
			;
		}
		var text = y + "年" + m + "月份" + "<br />" + "周六：" + saturday.toString()
				+ "<br />" + "周日：" + sunday.toString();
		var week = saturday.concat(sunday);
		return week;
	}
	//time(new Date().getFullYear(), new Date().getMonth() + 1);
	function work() {
		$("#listtime").addClass("dkDate1");
		$("#listtime").attr("disabled", false);
		$("#listtime").val(pdate1);
		showHidden();
		checkMonth(pdate1);
		$("#myModal").modal();
	}
	function showHidden() {
	var forms = document.getElementsByTagName("form");			
			for(var i =0;i<forms.length;i++){
				var id = $(forms[i]).attr("id");
				$(".zhongban"+id).val(null);
				$(".shenban"+id).val(null);
				$(".remark"+id).val(null);
				$("."+id).val(null);
				for(var j=0;j<31;j++){
				$("."+id+"a"+j).val(null);
				}
			};
		$("#btn").show();
		$("#btn1").hide();
		$("#btn2").hide();
		$("#btn3").hide();
		$("#btn4").hide();
	}
</script>
<body style="width:100%;height:100%;">
	<div data-option="size:82"
		style="float:left;width:100%;height:14%;background: url('../../images/banner.png') no-repeat;background-size:100%;">
		<div
			style="position: absolute; right: 10px; top: 10px; font-size: 12px; color: #DFDFDF">
			<span id="today"></span>
		</div>
		<div
			style="position: absolute; right: 10px; top: 45px; font-size: 14px; color: #FFFFFF; font-weight: bold;">
			<span id="welcome"
				style="background: url('../../images/user.gif') no-repeat; padding: 3px 0 3px 25px"></span>&nbsp;&nbsp;
			<!-- <span id="logout" style="cursor: pointer;"><a href="http://localhost:18080/cas/logout?service=http://localhost:8080" style="color:white">退出系统</a></span> -->
		</div>
	</div>
	<div
		style="float:left;width:100%;height:86%;border-top:3px solid #00e3e3;background:#F5FFFA;">
		<div style="float:left;width:12%;height:100%;background:#AFEEEE;">
			<%@include file="../common/menu.jsp"%>
		</div>
		<div style="float:left;width:88%;height:100%;overflow-y:scroll;overflow-x:scroll;">
		<div class="input-group" style="float:left;width:25%;padding-top:5px;padding-left:10px;padding-down:5px;">
            <span class="input-group-addon">姓名</span>
            <input type="text" id="listname" class="form-control" style="width:210px;margin-left:0px;margin-top:0px">
        </div>
        <div class="input-group" style="float:left;width:45%;padding-top:5px;padding-left:-20px;padding-down:5px;">
            <span class="input-group-addon">时间</span>
            <input type="text" id="listtime11" class="form-control" value="" style="width:210px;margin-left:0px;margin-top:0px;">&nbsp;&nbsp;&nbsp;&nbsp;
           <button type="button" id="queryId" onclick="query();" class="btn btn-primary">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="button" id="addBtn" onclick="work();" class="btn btn-primary">添加</button>
        </div>
		<!-- <div class="input-group listInput">
            <span class="input-group-addon">姓名</span>
            <input type="text" id="listname" class="form-control" style="width:210px;margin-left:0px;margin-top:0px">&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="button" id="queryId" onclick="query();" class="btn btn-primary">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="button" id="addBtn" onclick="work();" class="btn btn-primary">添加</button>
        </div> -->
    <table id="table1" class="table table-bordered table-striped" style="font-size: 10px;width:100%;">
        </table>
         <div id="shuoming" style="float:left;width:100%;">
        <p>说明：出勤√,培训■,出差△,病假○,事假+,婚假※,旷工×,迟到◇,早退◆,中途离岗□,年休假▲,哺乳假⊙,护理假#,疗养假&,探亲假＊,工伤治疗▽,自费学习↓,公派学习↑,补休@,公休加班☆,节日加班★</p>
        </div>
		<div style="float:left;width:100%;">
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel">
				<div class="modal-dialog" style="width:1300px;" role="document">
					<div class="modal-content" style="width:1300px;height:650px">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">×</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">考勤</h4>
							<div class="input-group">
							<span class="input-group-addon">考勤月份</span>
            <input type="text" id="listtime" class="form-control dkDate1" value="<%=pdate1%>" style="width:210px;margin-left:0px;margin-top:0px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="button" id="btn" class="btn btn-primary" onclick="save()">保存</button>
            <button type="button" id="btn1" class="btn btn-primary" onclick="save1(999)">保存修改</button>
                <button type="button" id="btn2" class="btn btn-primary" onclick="save1(2)">审核通过</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="button" id="btn3" class="btn btn-primary" onclick="save1(3)">审核不通过</button>
            <button type="button" id="btn4" class="btn btn-primary" onclick="save1(1)">提交</button>
            </div>
            
        <p>说明：出勤√,培训■,出差△,病假○,事假+,婚假※,旷工×,迟到◇,早退◆,中途离岗□,年休假▲,哺乳假⊙,护理假#,疗养假&,探亲假＊,工伤治疗▽,自费学习↓,公派学习↑,补休@,公休加班☆,节日加班★</p>
       
						</div>
						<div class="modal-body" style="overflow-x:scroll;overflow-y:scroll;width:1295px;height:540px;">
							<div id="tb"
								style="width:1300px;height:540px;float:left;margin-left:0%;">
								<table class="table table-bordered" id="work">
									<thead>
										<tr>
											<th style="width:140px">姓名</th>
											<th id="t1">1</th>
											<th id="t2">2</th>
											<th id="t3">3</th>
											<th id="t4">4</th>
											<th id="t5">5</th>
											<th id="t6">6</th>
											<th id="t7">7</th>
											<th id="t8">8</th>
											<th id="t9">9</th>
											<th id="t10">10</th>
											<th id="t11">11</th>
											<th id="t12">12</th>
											<th id="t13">13</th>
											<th id="t14">14</th>
											<th id="t15">15</th>
											<th id="t16">16</th>
											<th id="t17">17</th>
											<th id="t18">18</th>
											<th id="t19">19</th>
											<th id="t20">20</th>
											<th id="t21">21</th>
											<th id="t22">22</th>
											<th id="t23">23</th>
											<th id="t24">24</th>
											<th id="t25">25</th>
											<th id="t26">26</th>
											<th id="t27">27</th>
											<th id="t28">28</th>
											<th id="t29">29</th>
											<th id="t30">30</th>
											<th id="t31">31</th>
											<!-- <th>中班</th>
											<th>深班</th> -->
											<th>备注</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${!empty userList }">
											<c:forEach items="${userList}" var="user">
												<form id="form1${user.id}" class="">
												<tr><input type='hidden' id='id' class="form1${user.id}" name='id' value='' />
												<input type='hidden' id='dept_id' class="dept_idform1${user.id}" name='dept_id' value='${user.dept_id}' />
												<input type='hidden' id='jobnumber' class="jobnumberform1${user.id}" name='jobnumber' value='${user.jobnumber}' />
												<input type='hidden' id='attendance_date' class="dateform1${user.id}" name='attendance_date' value="<%=pdate1%>" />
													<td style="width:50px"><div style="width:60px">
															<input type="text" id="username" name="username"
																class="nameform1${user.id}" style="width:120px;border: solid 0px"
																value="${user.username}" readonly="readonly"></input>
														</div></td>
													<td id="td1" onclick="onShowChgIssueStatusMenu('form1${user.id}a1');" style="text-again:center">
													<input id="a1" name="a1" type="hidden" class="form1${user.id}a1"/>
													<a name="form1${user.id}a1"></a>
													 <ul id="form1${user.id}a1" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td  id="td2" onclick="onShowChgIssueStatusMenu('form1${user.id}a2');" style="text-again:center">
													<input id="a2" name="a2" type="hidden" class="form1${user.id}a2"/>
													<a name="form1${user.id}a2"></a>
													 <ul id="form1${user.id}a2" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td3" onclick="onShowChgIssueStatusMenu('form1${user.id}a3');" style="text-again:center">
													<input id="a3" name="a3" type="hidden" class="form1${user.id}a3"/>
													<a name="form1${user.id}a3"></a>
													 <ul id="form1${user.id}a3" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td4" onclick="onShowChgIssueStatusMenu('form1${user.id}a4');" style="text-again:center">
													<input id="a4" name="a4" type="hidden" class="form1${user.id}a4"/>
													<a name="form1${user.id}a4"></a>
													 <ul id="form1${user.id}a4" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td5" onclick="onShowChgIssueStatusMenu('form1${user.id}a5');" style="text-again:center">
													<input id="a5" name="a5" type="hidden" class="form1${user.id}a5"/>
													<a name="form1${user.id}a5"></a>
													 <ul id="form1${user.id}a5" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td6" onclick="onShowChgIssueStatusMenu('form1${user.id}a6');" style="text-again:center">
													<input id="a6" name="a6" type="hidden" class="form1${user.id}a6"/>
													<a name="form1${user.id}a6"></a>
													 <ul id="form1${user.id}a6" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td7" onclick="onShowChgIssueStatusMenu('form1${user.id}a7');" style="text-again:center">
													<input id="a7" name="a7" type="hidden" class="form1${user.id}a7"/>
													<a name="form1${user.id}a7"></a>
													 <ul id="form1${user.id}a7" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td8" onclick="onShowChgIssueStatusMenu('form1${user.id}a8');" style="text-again:center">
													<input id="a8" name="a8" type="hidden" class="form1${user.id}a8"/>
													<a name="form1${user.id}a8"></a>
													 <ul id="form1${user.id}a8" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td9" onclick="onShowChgIssueStatusMenu('form1${user.id}a9');" style="text-again:center">
													<input id="a9" name="a9" type="hidden" class="form1${user.id}a9"/>
													<a name="form1${user.id}a9"></a>
													 <ul id="form1${user.id}a9" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td10" onclick="onShowChgIssueStatusMenu('form1${user.id}a10');" style="text-again:center">
													<input id="a10" name="a10" type="hidden" class="form1${user.id}a10"/>
													<a name="form1${user.id}a10"></a>
													 <ul id="form1${user.id}a10" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td11" onclick="onShowChgIssueStatusMenu('form1${user.id}a11');" style="text-again:center">
													<input id="a11" name="a11" type="hidden" class="form1${user.id}a11"/>
													<a name="form1${user.id}a11"></a>
													 <ul id="form1${user.id}a11" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td12" onclick="onShowChgIssueStatusMenu('form1${user.id}a12');" style="text-again:center">
													<input id="a12" name="a12" type="hidden" class="form1${user.id}a12"/>
													<a name="form1${user.id}a12"></a>
													 <ul id="form1${user.id}a12" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td13" onclick="onShowChgIssueStatusMenu('form1${user.id}a13');" style="text-again:center">
													<input id="a13" name="a13" type="hidden" class="form1${user.id}a13"/>
													<a name="form1${user.id}a13"></a>
													 <ul id="form1${user.id}a13" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td14" onclick="onShowChgIssueStatusMenu('form1${user.id}a14');" style="text-again:center">
													<input id="a14" name="a14" type="hidden" class="form1${user.id}a14"/>
													<a name="form1${user.id}a14"></a>
													 <ul id="form1${user.id}a14" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td15" onclick="onShowChgIssueStatusMenu('form1${user.id}a15');" style="text-again:center">
													<input id="a15" name="a15" type="hidden" class="form1${user.id}a15"/>
													<a name="form1${user.id}a15"></a>
													 <ul id="form1${user.id}a15" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td16" onclick="onShowChgIssueStatusMenu('form1${user.id}a16');" style="text-again:center">
													<input id="a16" name="a16" type="hidden" class="form1${user.id}a16"/>
													<a name="form1${user.id}a16"></a>
													 <ul id="form1${user.id}a16" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td17" onclick="onShowChgIssueStatusMenu('form1${user.id}a17');" style="text-again:center">
													<input id="a17" name="a17" type="hidden" class="form1${user.id}a17"/>
													<a name="form1${user.id}a17"></a>
													 <ul id="form1${user.id}a17" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td18" onclick="onShowChgIssueStatusMenu('form1${user.id}a18');" style="text-again:center">
													<input id="a18" name="a18" type="hidden" class="form1${user.id}a18"/>
													<a name="form1${user.id}a18"></a>
													 <ul id="form1${user.id}a18" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td19" onclick="onShowChgIssueStatusMenu('form1${user.id}a19');" style="text-again:center">
													<input id="a19" name="a19" type="hidden" class="form1${user.id}a19"/>
													<a name="form1${user.id}a19"></a>
													 <ul id="form1${user.id}a19" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td20" onclick="onShowChgIssueStatusMenu('form1${user.id}a20');" style="text-again:center">
													<input id="a20" name="a20" type="hidden" class="form1${user.id}a20"/>
													<a name="form1${user.id}a20"></a>
													 <ul id="form1${user.id}a20" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td21" onclick="onShowChgIssueStatusMenu('form1${user.id}a21');" style="text-again:center">
													<input id="a21" name="a21" type="hidden" class="form1${user.id}a21"/>
													<a name="form1${user.id}a21"></a>
													 <ul id="form1${user.id}a21" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td22" onclick="onShowChgIssueStatusMenu('form1${user.id}a22');" style="text-again:center">
													<input id="a22" name="a22" type="hidden" class="form1${user.id}a22"/>
													<a name="form1${user.id}a22"></a>
													 <ul id="form1${user.id}a22" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td23" onclick="onShowChgIssueStatusMenu('form1${user.id}a23');" style="text-again:center">
													<input id="a23" name="a23" type="hidden" class="form1${user.id}a23"/>
													<a name="form1${user.id}a23"></a>
													 <ul id="form1${user.id}a23" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td24" onclick="onShowChgIssueStatusMenu('form1${user.id}a24');" style="text-again:center">
													<input id="a24" name="a24" type="hidden" class="form1${user.id}a24"/>
													<a name="form1${user.id}a24"></a>
													 <ul id="form1${user.id}a24" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td25" onclick="onShowChgIssueStatusMenu('form1${user.id}a25');" style="text-again:center">
													<input id="a25" name="a25" type="hidden" class="form1${user.id}a25"/>
													<a name="form1${user.id}a25"></a>
													 <ul id="form1${user.id}a25" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td26" onclick="onShowChgIssueStatusMenu('form1${user.id}a26');" style="text-again:center">
													<input id="a26" name="a26" type="hidden" class="form1${user.id}a26"/>
													<a name="form1${user.id}a26"></a>
													 <ul id="form1${user.id}a26" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td27" onclick="onShowChgIssueStatusMenu('form1${user.id}a27');" style="text-again:center">
													<input id="a27" name="a27" type="hidden" class="form1${user.id}a27"/>
													<a name="form1${user.id}a27"></a>
													 <ul id="form1${user.id}a27" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td28" onclick="onShowChgIssueStatusMenu('form1${user.id}a28');" style="text-again:center">
													<input id="a28" name="a28" type="hidden" class="form1${user.id}a28"/>
													<a name="form1${user.id}a28"></a>
													 <ul id="form1${user.id}a28" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td29" onclick="onShowChgIssueStatusMenu('form1${user.id}a29');" style="text-again:center">
													<input id="a29" name="a29" type="hidden" class="form1${user.id}a29"/>
													<a name="form1${user.id}a29"></a>
													 <ul id="form1${user.id}a29" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td30" onclick="onShowChgIssueStatusMenu('form1${user.id}a30');" style="text-again:center">
													<input id="a30" name="a30" type="hidden" class="form1${user.id}a30"/>
													<a name="form1${user.id}a30"></a>
													 <ul id="form1${user.id}a30" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<td id="td31" onclick="onShowChgIssueStatusMenu('form1${user.id}a31');" style="text-again:center">
													<input id="a31" name="a31" type="hidden" class="form1${user.id}a31"/>
													<a name="form1${user.id}a31"></a>
													 <ul id="form1${user.id}a31" class="list-group"
																style="position:absolute;display:none;height:200px;overflow:auto;">
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('')"
																	style="padding-left: 0px;">取消</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出勤')"
																	style="padding-left: 0px;">出勤</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('培训')"
																	style="padding-left: 0px;">培训</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('出差')"
																	style="padding-left: 0px;">出差</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('病假')"
																	style="padding-left: 0px;">病假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('事假')"
																	style="padding-left: 0px;">事假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('婚假')"
																	style="padding-left: 0px;">婚假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('旷工')"
																	style="padding-left: 0px;">旷工</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('迟到')"
																	style="padding-left: 0px;">迟到</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('早退')"
																	style="padding-left: 0px;">早退</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('中途离岗')"
																	style="padding-left: 0px;">中途离岗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('年休假')"
																	style="padding-left: 0px;">年休假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('哺乳假')"
																	style="padding-left: 0px;">哺乳假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('护理假')"
																	style="padding-left: 0px;">护理假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('疗养假')"
																	style="padding-left: 0px;">疗养假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('探亲假')"
																	style="padding-left: 0px;">探亲假</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('工伤治疗')"
																	style="padding-left: 0px;">工伤治疗</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('自费学习')"
																	style="padding-left: 0px;">自费学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公派学习')"
																	style="padding-left: 0px;">公派学习</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('补休')"
																	style="padding-left: 0px;">补休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('公休')"
																	style="padding-left: 0px;">公休</a>
																</li>
																<li class='list-group-item'><a
																	href="javascript:chgIssueStatus('节日')"
																	style="padding-left: 0px;">节日</a>
																</li>
															</ul>
													</td>
													<%-- <td><input type="text" id="zhongBan"
														style="width:50px" class="zhongbanform1${user.id}" maxlength="3"
														name="zhongBan" value=""></input></td>
													<td><input type="text" id="shenBan"
														name="shenBan" style="width:50px" maxlength="3"
														class="shenbanform1${user.id}"></input></td> --%>
													<td><div style="width:160px">
															<input type="text" id="remark" name="remark" maxlength="400"
																class="remarkform1${user.id}"></input>
														</div></td>
												</tr>
												</form>
											</c:forEach>
										</c:if>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
				<table id="reportTable" style="width:100%;" class="table table-bordered table-striped"
					style="font-size:10px;">
				</table>
			<div id="dialog_simple"></div>
		</div>
		 </div>
	</div>

<div id="aa"></div>
</body>
</html>
