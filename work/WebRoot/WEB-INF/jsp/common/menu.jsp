<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
var account="${loginAccount}";
	var auth ="${auth}"; 
$(function(){
if(isAdmin()){
$("#dept1").show();
$("#user1").show();
$("#account1").show();
}else{
$("#dept1").hide();
$("#user1").hide();
$("#account1").hide();
}

if(isManager()||isshenHe()){
$("#send1").show();
//$("#send2").show();
}else{
$("#send1").hide();
//$("#send2").hide();
}


if(isSee()){
$("#myPlan1").show();
}else{
$("#myPlan1").hide();
}
});



function isAdmin(){
var list=auth.split("|");
for(var i in list){
   if(list[i].toString()=="1"){
   return true;}
}
return false;
}



function isManager(){
var list=auth.split("|");
for(var i in list){
   if(list[i].toString()=="4"){
   return true;}
}
return false;
}

function isshenHe(){
var list=auth.split("|");
for(var i in list){
   if(list[i].toString()=="5"){
   return true;}
}
return false;
}

function isSee(){
var list=auth.split("|");
for(var i in list){
   if(list[i].toString()=="6"){
   return true;}
}
return false;
}

</script>
<div class="container-fluid" style="float:left;">
	<!-- <div class="row">
		<div class="col-md-2">
			<ul id="main-nav" class="nav nav-tabs nav-stacked" style="">
				<li class="active"><a href="javascript:;"> <i
						class="glyphicon glyphicon-th-large"></i> 首页 </a></li>
				<li id="dept1"><a href="departmentController/list"> <i
						class="glyphicon glyphicon-cog"></i> 组织管理 </a></li>
				<li id="user1"><a href="user/list"> <i
						class="glyphicon glyphicon-user"></i> 用户管理 </a></li>
				<li id="account1"><a href="account/list"> <i
						class="glyphicon glyphicon-fire"></i> 账号管理 </a></li>
				<li id="send1"><a href="sendPlanController/list"> <i
						class="glyphicon glyphicon-fire"></i> 任务分发 </a></li>
				<li id="myPlan1"><a href="plan/myplan"> <i
						class="glyphicon glyphicon-fire"></i> 我的任务 </a></li>
				<li id="allPlan1"><a href="plan/allplanlist"> <i
						class="glyphicon glyphicon-fire"></i> 所有任务 </a></li>
				<li id="context1"><a href="plan/statis"> <i
						class="glyphicon glyphicon-fire"></i> 任务统计 </a></li>
			</ul>
		</div>
	</div> -->
        <div class="row">
            <div class="col-md-2">
                <ul id="main-nav" class="nav nav-tabs nav-stacked" style="">
                    <li class="active">
                        <a href="javascript:;">
                            <i class="glyphicon glyphicon-th-large"></i>
                            	首页 		
                        </a>
                    </li>
                    <li id="dept1">
                        <a href="departmentController/list">
                            <i class="glyphicon glyphicon-cog"></i>
                            	组织管理
                        </a>
                    </li>
   					<li id="user1">
                        <a href="user/list">
                            <i class="glyphicon glyphicon-user"></i>
                          		用户管理
                        </a>
                    </li>
                    <li id="account1">
                        <a href="account/list">
                            <i class="glyphicon glyphicon-fire"></i>
                           		 账号管理
                        </a>
                    </li>
                   <!--  <li>
                        <a href="authority/list">
                            <i class="glyphicon glyphicon-fire"></i>
                           		角色管理
                        </a>
                    </li> -->
 					<li id="send1">
                        <a href="work/get">
                            <i class="glyphicon glyphicon-fire"></i>
                            	考勤
                        </a>
                    </li>
                   <!--  <li id="send2">
                        <a href="work/get1">
                            <i class="glyphicon glyphicon-fire"></i>
                            	外场考勤
                        </a>
                    </li> -->
                    <li id="myPlan1">
                        <a href="showAttendance/list">
                            <i class="glyphicon glyphicon-fire"></i>
                           		月统计
                        </a>
                    </li>
                     <li>
                        <a href="loginController/logout">
                            <i class="glyphicon glyphicon-fire"></i>
                            	退出系统
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
