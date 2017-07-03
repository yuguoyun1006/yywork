var deptTree;
var date=new Date();
$(function(){
	$("#listtime").datetimepicker({format: 'yyyy-mm',minView:3,startView: 3, maxViewMode: 4,minViewMode:3}); // 选择日期
	deptTree=$("#listdept").dkSelectTree({
		url:"departmentController/dtree",
		Async:false,
		idField:"id",
		pidField:"pid",
		nameField:"name",
		listType:"tree",
		multiSelect:false,
		chkboxType:{ "Y": "", "N": "" },
		width : 200,
	});
	deptTree.setValue("1");
	loadAttendance($("#listdept").val(),$("#listtime").val());
});
function queryByName(){
	loadAttendance($("#listdept").val(),$("#listtime").val());
}
function loadAttendance(deptid,time){
	if(deptid==""||time==""){
		 layer.alert("请选择查询部门和时间！",{icon:2});
	}else{
		$.ajax(
		  		{
		  		data:{"deptid":deptid,"date":time},
		  		type:"get",
		  		url:"/showAttendance/getAttendance",
		  		contentType:'application/json;charset=UTF-8',
		  		dataType:'json',
		  		success:function(data){
		  			if(data["flag"]){
		  				list(data["data"]);
		  			}else{
		  				list1(data["data"]);
		  			}
		  		},
		  		error:function(data){
		  			 layer.alert("请求失败！",{icon:2});
		  		}
		  		});
	}
}
function exportXls(){
	grid.tableExport($.extend({}, {
        exportDataType: 'all', // basic, all, selected
        exportTypes: ['excel'],
        exportOptions: {}
    },{
         type: "excel",
         escape: false
     }));
}
function list1(data){
	$('#reportTable').bootstrapTable('destroy');
	grid=$('#reportTable').bootstrapTable({
		data:data,
		striped: true,	 //使表格带有条纹
		pagination: true,	//在表格底部显示分页工具栏
//		showExport:true,
//	    exportDataType: "all",//导出类型    
//	    exportTypes: ['excel'],
		pageSize:20,
		pageNumber: 1,
//		toolbarAlign: 'left',//toolbar位置  
//		buttonsAlign:'left',
		pageList: [5, 10, 15, 20, 25, 30],
		idField: "id",  //标识哪个字段为id主键
		showToggle: false,   //名片格式
		cardView: false,//设置为True时显示名片（card）布局
		showColumns: false, //显示隐藏列  
		showRefresh: false,  //显示刷新按钮
		singleSelect: true,//复选框只能选择一条记录
		search: false,//是否显示右上角的搜索框
		clickToSelect: true,//点击行即可选中单选/复选框
		height:550,
		sidePagination: "client",//表格分页的位置
//	    queryParams: {"deptid":"","name":""}, //参数
//		queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求
		toolbar: "#toolbar", //设置工具栏的Id或者class
		columns: [
                  {title: '序号',width:60,formatter:function(value,row,index){
                	  return index+1;
                  }},
	              {field: 'deptname',title: '部门名称',width:140,formatter:function(value,row,index){
	            	  if(value.length>10){
	            		  return value.substr(0 , 10)+"...";
	            	  }else{
	            		  return value;
	            	  }
	              }},
	              {field: 'name',title: '姓名',width:140,formatter:function(value,row,index){
	            	  if(value.length>10){
	            		  return value.substr(0 , 6)+"...";
	            	  }else{
	            		  return value;
	            	  }
	              }},
	              {field: 'emp_no',title: '员工编号',width:80},
	              {field: 'chuqin',title: '出勤',width:80},
	              {field: 'gongxiu',title: '公休加班',width:80},
	              {field: 'jieri',title: '节日加班',width:80},
	              {field: 'shanggangtianshu',title: '上岗天数',width:80},
	              {field: 'shangjing',title: '上井',width:80},
	              {field: 'sangjia',title: '丧假',width:80},
	              {field: 'chanjia',title: '产假',width:80},
	              {field: 'daigang',title: '待岗',width:80},
	              {field: 'chuchai',title: '出差',width:80},
	              {field: 'peixun',title: '培训',width:80},
	              {field: 'bingjia',title: '病假',width:80},
	              {field: 'shijia',title: '事假',width:80},
	              {field: 'hunjia',title: '婚假',width:80},
	              {field: 'kuanggong',title: '旷工',width:80},
	              {field: 'chidao',title: '迟到',width:80},
	              {field: 'zaotui',title: '早退',width:80},
	              {field: 'zhongtuligang',title: '中途离岗',width:80},
	              {field: 'lunxiujia',title: '轮休假',width:80},
	              {field: 'burujia',title: '哺乳假',width:80},
	              {field: 'hulijia',title: '护理假',width:80},
	              {field: 'liaoyangjia',title: '疗养假',width:80},
	              {field: 'tanqinjia',title: '探亲假',width:80},
	              ], //列
		silent: true,  //刷新事件必须设置
		formatLoadingMessage: function () {
			return "请稍等，正在加载中...";
		},
		formatNoMatches: function () {  //没有匹配的结果
			return '无符合条件的记录';
		},
	});
}
function list(data){
	$('#reportTable').bootstrapTable('destroy');
	grid=$('#reportTable').bootstrapTable({
//		url:"/departmentController/getJsonListDepartmentBySql",
//		method: 'get',
		data:data,
		striped: true,	 //使表格带有条纹
		pagination: true,	//在表格底部显示分页工具栏
//		showExport:true,
	    exportDataType: "all",//导出类型    
		pageSize:10,
		pageNumber: 1,
//		toolbarAlign: 'left',//toolbar位置  
		buttonsAlign:'left',
		pageList: [5, 10, 15, 20, 25, 30],
		idField: "id",  //标识哪个字段为id主键
		showToggle: false,   //名片格式
		cardView: false,//设置为True时显示名片（card）布局
		showColumns: false, //显示隐藏列  
		showRefresh: false,  //显示刷新按钮
		singleSelect: true,//复选框只能选择一条记录
		search: false,//是否显示右上角的搜索框
		clickToSelect: true,//点击行即可选中单选/复选框
		height:550,
		sidePagination: "client",//表格分页的位置
//	    queryParams: {"deptid":"","name":""}, //参数
//		queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求
		toolbar: "#toolbar", //设置工具栏的Id或者class
		columns: [
		          {title: '序号',width:60,formatter:function(value,row,index){
                	  return index+1;
                  }},
	              {field: 'deptname',title: '部门名称',width:140,formatter:function(value,row,index){
	            	  if(value.length>10){
	            		  return value.substr(0 , 10)+"...";
	            	  }else{
	            		  return value;
	            	  }
	              }},
	              {field: 'name',title: '姓名',width:140,formatter:function(value,row,index){
	            	  if(value.length>10){
	            		  return value.substr(0 , 6)+"...";
	            	  }else{
	            		  return value;
	            	  }
	              }},
	              {field: 'emp_no',title: '员工编号',width:80},
	              {field: 'chuqin',title: '出勤',width:80},
	              {field: 'gongxiu',title: '公休加班',width:80},
	              {field: 'jieri',title: '节日加班',width:80},
	              {field: 'zhongban',title: '夜班中班',width:80},
	              {field: 'shenban',title: '夜班深班',width:80},
	              {field: 'shanggangtianshu',title: '上岗天数',width:80},
	              {field: 'chuchai',title: '出差',width:80},
	              {field: 'peixun',title: '培训',width:80},
	              {field: 'bingjia',title: '病假',width:80},
	              {field: 'shijia',title: '事假',width:80},
	              {field: 'hunjia',title: '婚假',width:80},
	              {field: 'kuanggong',title: '旷工',width:80},
	              {field: 'chidao',title: '迟到',width:80},
	              {field: 'zaotui',title: '早退',width:80},
	              {field: 'zhongtuligang',title: '中途离岗',width:80},
	              {field: 'nianxiujia',title: '年休假',width:80},
	              {field: 'burujia',title: '哺乳假',width:80},
	              {field: 'hulijia',title: '护理假',width:80},
	              {field: 'liaoyangjia',title: '疗养假',width:80},
	              {field: 'tanqinjia',title: '探亲假',width:80},
	              {field: 'gongshangzhiliao',title: '工伤治疗',width:80},
	              {field: 'zifeixuexi',title: '自费学习',width:80},
	              {field: 'gongpaixuexi',title: '公派学习',width:80},
	              {field: 'buxiu',title: '补休',width:80},
//	              {title: '操作',field: '',align: 'center',formatter:function(value,row,index){ 
////	            	  var a = '<a  onclick="editDept(\''+ row.id + '\')">调整</a> ';  
//	                   var e = '<a  onclick="edit(\''+ row.id + '\')">编辑</a> ';  
//	                   var d = '<a  onclick="del(\''+ row.id +'\')">删除</a> ';  
//	                        return e+d;  
//	                    } 
//	                  }
	              ], //列
		silent: true,  //刷新事件必须设置
		formatLoadingMessage: function () {
			return "请稍等，正在加载中...";
		},
		formatNoMatches: function () {  //没有匹配的结果
			return '无符合条件的记录';
		},
		/*onLoadError: function (data) {
			$('#reportTable').bootstrapTable('removeAll');
		},
		onClickRow: function (row) {
			window.location.href = "/qStock/qProInfo/" + row.ProductId;
		}*/
//		onLoadSuccess:function(data){
//			debugger;
//			alert(data);
//		}
	});
}