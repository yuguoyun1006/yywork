$(function(){
	$(".dkDate").datetimepicker({format: 'yyyy-mm-dd',minView:2}); // 选择日期
	$.post("work/worklist",{},function(data){
		list(data);
	});
	$("#listtime11").datetimepicker({format: 'yyyy-mm',minView:3,startView: 3, maxViewMode: 4,minViewMode:3}); // 选择日期
	$(".dkDate1").datetimepicker({format: 'yyyy-mm',minView:3,startView: 3, maxViewMode: 4,minViewMode:3}).on("changeMonth", function(ev){
		var month = new Date(ev.date.valueOf()).getMonth()+1;
		var year = new Date(ev.date.valueOf()).getFullYear();
		var rn = year.toString().substring(2,4);
//		$("#attendace_date").val(new Date(ev.date.valueOf()).getFullYear()+""+new Date(ev.date.valueOf()).getMonth()+1);
		if(rn%4==0){
			if(month==1||month==3||month==5||month==7||month==8||month==10||month==12){
				$("#t29,#t30,#t31,#td29,#td30,#td31,#aa").show();
//				$("#a29,#a30,#a31,#aa").val("出勤");
//				$("#a29,#aa").val("出勤");
				yemo(year,month);
			}else if(month==2){
				$("#td30,#td31,#t30,#t31,#aa").hide();
				$("#t29,#td29").show();
				yemo(year,month);
				$("#a30,#a31,#aa").val("");
			}else{
				$("#td29,#td30,#t29,#t30,#aa").show();
				$("#td31,#aa,#t31,#aa").hide();
				yemo(year,month);
				$("#a31,#aa").val("");
			}
			
		}else{
			if(month==1||month==3||month==5||month==7||month==8||month==10||month==12){
				$("#td29,#td30,#td31,#t29,#t30,#t31,#aa").show();
//				$("#a29,#a30,#a31,#aa").val("出勤");
				yemo(year,month);
			}else if(month==2){
				$("#t29,#t30,#t31").hide();
				$("#td29,#td30,#td31,#aa").hide();
				yemo(year,month);
				$("#a29,#a30,#a31,#aa").val("");
			}else{
				$("#td29,#td30,#t29,#t30,#aa").show();
				$("#td31,#aa,#t31,#aa").hide();
				yemo(year,month);
				$("#a31,#aa").val("");
			}
		}
	});
});
var status = [
                "出勤", "培训", "出差","病假","事假","婚假","旷工","迟到",
                "早退","中途离岗","公休加班用","节日加班用","年休假","哺乳假",
                "护理假","疗养假","探亲假","工伤治疗","自费学习","公派学习","补休"
        ];

function isShenHe(){
	var list=auth.split("|");
	for(var i=0;i<list.length;i++){
		if(list[i].toString()=="5")
			return true;
	}
	return false;
}


var currIssueId; //记录触发菜单时的记录的ID
/**触发、弹出菜单*/
function onShowChgIssueStatusMenu(issueId){   
	menuIssueStatus=$("#"+issueId);
    currIssueId = issueId;
    //alert(issueId);
    var $td = $('.'+issueId).parent();
    var x = $td.offset().left;
    var y = $td.offset().top + $td.height();
    menuIssueStatus.css({"display":"block"});//重新定位菜单的显示位置
    $("body").bind("mousedown", onBodyMouseDown);
}
 
/**页面事件响应函数，在菜单外面的页面位置点击鼠标，可以关闭菜单*/
function onBodyMouseDown(event){
    //鼠标点击事件不是发生在tree或者tree的下级dom中
    if (!(event.target.name == currIssueId || $(event.target).parents("#"+currIssueId).length>0)) { 
        hideRMenu();//treeMenuDept.css({"display" : "none"});
    }
}
/**隐藏菜单*/
function hideRMenu() {
    menuIssueStatus.css("display","none");
    $("body").unbind("mousedown", onBodyMouseDown); 
}
 
/**点击一个菜单项的响应函数。可以向后台发起请求，更改数据*/
function chgIssueStatus(issueStatus){
    hideRMenu();
    $("a[name='"+currIssueId+"']").html(format(issueStatus));
    $("."+currIssueId).val(issueStatus);
//    var url = basePath + "rest/base/issueHandler/updateIssueStatus";
//    $.post(url, {"issueId":currIssueId, "issueStatus":issueStatus,"responsibleUserId":loginUserId},function(data){
//        if(data.hasError){
//            alert(data.errorMessage);
//        }else{
//            grid1.reload();
//        }
//    } );
}



function checkMonth(date){
	if(date!=""){
		var year=parseInt(date.substring(0,4));
		var month=parseInt(date.substring(5));
		var rn=parseInt(year.toString().substring(2,4));
		if(rn%4==0){
			if(month==1||month==3||month==5||month==7||month==8||month==10||month==12){
				$("#t29,#t30,#t31,#td29,#td30,#td31,#aa").show();
//				$("#a29,#a30,#a31,#aa").val("出勤");
//				$("#a29,#aa").val("出勤");
				yemo(year,month);
			}else if(month==2){
				$("#td30,#td31,#t30,#t31,#aa").hide();
				$("#t29,#td29").show();
				yemo(year,month);
				$("#a30,#a31,#aa").val("");
			}else{
				$("#td29,#td30,#t29,#t30,#aa").show();
				$("#td31,#aa,#t31,#aa").hide();
				yemo(year,month);
				$("#a31,#aa").val("");
			}
			
		}else{
			if(month==1||month==3||month==5||month==7||month==8||month==10||month==12){
				$("#td29,#td30,#td31,#t29,#t30,#t31,#aa").show();
//				$("#a29,#a30,#a31,#aa").val("出勤");
				yemo(year,month);
			}else if(month==2){
				$("#t29,#t30,#t31").hide();
				$("#td29,#td30,#td31,#aa").hide();
				yemo(year,month);
				$("#a29,#a30,#a31,#aa").val("");
			}else{
				$("#td29,#td30,#t29,#t30,#aa").show();
				$("#td31,#aa,#t31,#aa").hide();
				yemo(year,month);
				$("#a31,#aa").val("");
			}
		}
	}
}
function dyn(id){
	var selects=document.getElementsByName("");
	var nat = document.getElementById (id);
    for ( var i = 0; i < status.length; i++)
    {
        var option = document.createElement ('option');
        option.value = status[i];
        var txt = document.createTextNode (status[i]);
        option.appendChild (txt);
        nat.appendChild (option);
    }
}
function query(){
	var queryUser=$("#listname").val();
	var queryTime=$("#listtime11").val();
	$.post("work/worklist",{"user":queryUser,"time":queryTime},function(data){
		list(data);
	});
}
function checkNum(str){
	if(str==""||str==null){
		return true;
	}else{
		if(!isNaN(str)){
			return true;
		}
	}
	return false;
}
function save(){
	if(checkNum($("#zhongBan").val())&&checkNum($("#shenBan").val())){
		$.ajax({
			url:'work/isTime',
			data:{"date":$("#listtime").val(),"deptid":$("#dept_id").val()},
			type:'post',
			success:function(data){
				if(data){
					var forms = document.getElementsByTagName("form");
					var jsonstr="[";
					for(var i = 0;i<forms.length;i++){
						var id = $(forms[i]).attr("id");
						var obj={};
						obj.id=$("."+id).val();
						obj.dept_id=$(".dept_id"+id).val();
						obj.jobnumber=$(".jobnumber"+id).val();
						obj.attendance_date=$("#listtime").val();
						obj.username=$(".name"+id).val();
						obj.dayWork="";
						obj.zhongBan=$(".zhongban"+id).val();
						obj.shenBan=$(".shenban"+id).val();
						obj.remark=$(".remark"+id).val();
						for(var j = 1;j<=31;j++){ 
							obj["a"+j]=$("."+id+"a"+j).val();
						}
						jsonstr+= JSON.stringify(obj)+",";
					}
					jsonstr=jsonstr.substring(0, jsonstr.length-1)+"]";
					$.ajax({
						url:'work/add',
						data:{"attendance":jsonstr},
						type:'post',
						success:function(data){
							if(data==true){
								layer.alert("添加成功",{icon:1}); 
								$("#myModal").modal('hide');
								history.go(0);
							}else{
								layer.alert("保存失败",{icon:2});
								return ;
							}
						}
					});
				}else{
					layer.alert("一月只能考核一次",{icon:2});
				}
			}
		});
	}else{
		layer.alert("夜班请填数字",{icon:2});
		return ;
	}
}
var table;
function list(data){
    table=$('#reportTable').bootstrapTable('destroy').bootstrapTable({
	method: 'get',
//  url: 'user/list',
	data:data,
	dataType: "json",
	striped: true,	 // 使表格带有条纹
	pagination: true,	// 在表格底部显示分页工具栏
//	showExport:true,    //显示导出
//  exportDataType: $(this).val(),//导出类型    // basic, all, selected 
// 'json', 'xml', 'png', 'csv', 'txt', 'sql', 'doc', 'excel', 'powerpoint', 'pdf' //pdf png需要另外引js
	exportTypes: ['excel'],
	toolbarAlign: 'left',//toolbar位置  
	pageSize: 10,	// 每页显示条数
	pageNumber: 1,  // 当前页码
	pageList: [10, 20, 50, 100, 200, 500], //每页显示条数
	idField: "id",  // 标识哪个字段为id主键
	cardView: false,// 设置为True时显示名片（card）布局
	showColumns: false, // 显示隐藏列
	height:500,
	search: false,// 是否显示右上角的搜索框
	clickToSelect: true,// 点击行即可选中单选/复选框
	sidePagination: "client",// 表格分页的位置
	queryParamsType: "limit", // 参数格式,发送标准的RESTFul类型的参数请求
	toolbar: "#toolbar", // 设置工具栏的Id或者class
	columns: [{title: '操作',field: 'id',align: 'center',width:'100',formatter:function(value,row,index){  
        var e = '<a href="javascript:edit(\''+ row.attendance_date + '\')">编辑</a> ';  
        var d = '<a href="javascript:del(\''+ row.id +'\')">删除</a> '; 
        var f = '<a href="javascript:edit1(\''+ row.attendance_date + '\')">审核</a> ';
        var h = '<a href="javascript:edit2(\''+ row.attendance_date + '\')">修改</a> '; 
        var g = '<a href="javascript:edit2(\''+ row.attendance_date + '\')">提交</a> '; 
        $(".dkDate1").val(new Date(row.attendance_date).Format('yyyy-MM'));
        var m = '<a href="javascript:void(0)" style="color:##5ACF00">已通过</a> '; 
        switch(row.status){
        case "0":
        	return e+d+g;
        case "1": 
        	if(isShenHe()){
        		return e+d+f;
        	}else{
        		return e+d;
        	}
        	break;
        case "2":return m;break;
        case "3":
        	return e+d+h;
        	break;
        default:
        	return e+d+g;
        	break;
        }
         } 
       },{field: 'status',title: '审核状态',width:'60',formatter:function(value,row,index){
     	  switch(value){
     	  case "0":return '未提交';break;
    	  case "1":return '未审核';break;
    	  case "2":return '通过';break;
    	  case "3":return '不通过';break;
    	  default:return '未提交';break;
    	  }
      }}, 
	          {field: 'name',title: '姓名',width:'100'}, 
	          {field: 'attendance_date',title: '年月份',width:'90',formatter:function(value){
	        	  return new Date(value).Format('yyyy-MM');
	          }}, 
	          {field: 'emp_no',title: '工号',width:'90'},
	          {field: 'a1',title: '1',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a2',title: '2',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a3',title: '3',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a4',title: '4',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a5',title: '5',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a6',title: '6',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a7',title: '7',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a8',title: '8',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a9',title: '9',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a10',title: '10',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a11',title: '11',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a12',title: '12',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a13',title: '13',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a14',title: '14',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a15',title: '15',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a16',title: '16',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a17',title: '17',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a18',title: '18',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a19',title: '19',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a20',title: '20',width:'40',formatter:function(value){
	        	  return  format(value);
	          }},
	          {field: 'a21',title: '21',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a22',title: '22',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a23',title: '23',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a24',title: '24',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a25',title: '25',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a26',title: '26',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a27',title: '27',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a28',title: '28',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a29',title: '29',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a30',title: '30',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	          {field: 'a31',title: '31',width:'40',formatter:function(value){
	        	  return format(value);
	          }},
	        /*  {field: 'attendance_date',title: '考勤日期',formatter:function(a,b,c){
	        	  return new Date(a).Format('yyyy-MM-dd');
	          }},*/
//	          {field: 'zhong_ban',title: '中班',width:'60'},
//	          {field: 'shen_ban',title: '深班',width:'60'},
	          {field: 'remark',title: '备注',width:'140'},
	          ], // 列
	silent: true,  // 刷新事件必须设置
	formatLoadingMessage: function () {
		return "请稍等，正在加载中...";
	},
	formatNoMatches: function () {  // 没有匹配的结果
		return '无符合条件的记录';
	},
	onLoadSuccess:function(data){
// alert(data);
	}
});
}
/** 刷新页面 */ 
function ref(){
	$('#reportTable').bootstrapTable('destroy');
	$.ajax(
	  		{
	  		type:"get",
	  		url:"work/worklist",
	  		data:{},
	  		dataType:'json',
	  		success:function(data){
	  			list(data);
	  		}
	  		});
}
/**
 * 删除数据
 */  
function del(id) {  
    	layer.confirm('确定要删除所选数据？', {icon: 3, title:'提示'}, function(){  
            $.ajax({  
                url:'work/del', 
                data:{"id":id},
                success:function(data){  
                    if(data.hasError){ 
                    	alert(data.hasError);
                    }else{ 
                    	layer.alert("删除成功",{icon:1}); 
                    	ref();  
                    }  
                }
               
            }); 
          });  
} 
//function edit1(id){
//	$.ajax({
//		url:'work/getWork',
//		data:{"id":id},
//		success:function(data){
//			$("#btn").hide();
//			$("#btn1").hide();
//			$("#btn2").show();
//			$("#btn3").show();
//			$("#form1"+id).json2form({'data':data});
//			$("#mor_status").val(data.mor_status);
//			$("#after_status").val(data.after_status);
//			$("#myModal").modal();
//		},
//		 error : function(data) {
//			 layer.alert("获取数据失败",{icon:2});
//	        }
//	});
//}
//function edit(id){
//	$.ajax({
//		url:'work/getWork',
//		data:{"id":id},
//		success:function(data){
//			$("#form1"+id).json2form({'data':data});
//			$("#mor_status").val(data.mor_status);
//			$("#after_status").val(data.after_status);
//			$("#myModal").modal();
//		},
//		 error : function(data) {
//			 layer.alert("获取数据失败",{icon:2});
//	        }
//	});
//}
function format(value){
	if(value=="出勤"){
		return "√";
	}
	if(value=="培训"){
		return "■";
	}
	if(value=="出差"){
		return "△";
	}
	if(value=="病假"){
		return "○";
	}
	if(value=="事假"){
		return "+";
	}
	if(value=="婚假"){
		return "※";
	}
	if(value=="旷工"){
		return "×";
	}
	if(value=="迟到"){
		return "◇";
	}
	if(value=="早退"){
		return "◆";
	}
	if(value=="中途离岗"){
		return "□";
	}
	if(value=="年休假"){
		return "▲";
	}
	if(value=="哺乳假"){
		return "⊙";
	}
	if(value=="护理假"){
		return "#";
	}
	if(value=="疗养假"){
		return "&";
	}
	if(value=="探亲假"){
		return "＊";
	}
	if(value=="工伤治疗"){
		return "▽";
	}
	if(value=="自费学习"){
		return "↓";
	}
	if(value=="公派学习"){
		return "↑";
	}
	if(value=="补休"){
		return "@";
	}
	if(value=="节日"){
		return "★";
	}
	if(value==""||value==""){
		return "";
	}
	if(value=="公休"){
		return "☆";
	}else{
		return "";
	}
	
}
Date.prototype.Format = function (fmt) { // author: meizz
    var o = {
        "M+": this.getMonth() + 1, // 月份
        "d+": this.getDate(), // 日
        "h+": this.getHours(), // 小时
        "m+": this.getMinutes(), // 分
        "s+": this.getSeconds(), // 秒
        "q+": Math.floor((this.getMonth() + 3) / 3), // 季度
        "S": this.getMilliseconds() // 毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};