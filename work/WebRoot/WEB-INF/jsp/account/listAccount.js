var deptTree1;
$(function(){
	tree("tree");
//	initAuthority();
/*	deteTree()*/
	$.ajax(
  		{
  		type:"get",
  		url:"account/listAccount1",
  		data:{"account":"","id":""},
  		dataType:'json',
  		success:function(data){
  			list(data);
  		}
  		});
});
function list(data){
$('#reportTable').bootstrapTable('destroy').bootstrapTable({
	method: 'get',
//	url: 'user/list',
	data:data,
	dataType: "json",
	striped: true,	 //使表格带有条纹
	pagination: true,	//在表格底部显示分页工具栏
	showExport:true,    //显示导出
    exportDataType: "basic",//导出类型    // basic, all, selected 
	pageSize: 10,
	pageNumber: 1,
	pageList: [10, 20, 50, 100, 200, 500],
	idField: "id",  //标识哪个字段为id主键
//	showToggle: false,   //名片格式
	cardView: false,//设置为True时显示名片（card）布局
	showColumns: false, //显示隐藏列
//	showRefresh: false,  //显示刷新按钮
//	singleSelect: true,//复选框只能选择一条记录
	search: false,//是否显示右上角的搜索框
	clickToSelect: true,//点击行即可选中单选/复选框
	sidePagination: "client",//表格分页的位置
//	queryParams: queryParams, //参数
	queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求
	toolbar: "#toolbar", //设置工具栏的Id或者class
	columns: [
	          {field: 'account',title: '账号名称'}, 
	          {field: 'auth',title: '账号角色',formatter:function(v){
	        	  if(v!=null){
	        		  var listAu=v.split("|");
		        	  var authority="";
		        	  for(var i=0;i<listAu.length;i++){
		        		  if(listAu[i]=="1"){
		        			  authority+="超级管理员,";
		        		  }else if(listAu[i]=="2"){
		        			  authority+="项目经理,";
		        		  }else if(listAu[i]=="3"){
		        			  authority+="任务记录员,";
		        		  }else if(listAu[i]=="4"){
		        			  authority+="考勤员,";
		        		  }else if(listAu[i]=="5"){
		        			  authority+="审核考勤,";
		        		  }else if(listAu[i]=="6"){
		        			  authority+="查看考勤统计,";
		        		  }else{
		        			  authority+="";
		        		  }
		        	  }
		        	  return authority.substring(0, authority.length-1);
	        	  }
	          }},
	          {field: 'create_time',title: '创建时间'},
	          {field: 'update_time',title: '修改时间'},
	          {title: '操作',field: 'id',align: 'center',formatter:function(value,row,index){  
                   var e = '<a href="javascript:edit(\''+ row.id + '\')">编辑</a> ';  
                   var d = '<a href="javascript:del(\''+ row.id +'\')">删除</a> ';  
                   var c = '<a href="javascript:update(\''+ row.id +'\')">重置</a> ';
                   var a = '<a href="javascript:getAuthority(\''+ row.account + '\',\'' + row.id +'\',\''+row.auth+'\')">角色</a> ';
                        return e+d+c+a;  
                    } 
                  }], //列
	silent: true,  //刷新事件必须设置
	formatLoadingMessage: function () {
		return "请稍等，正在加载中...";
	},
	formatNoMatches: function () {  //没有匹配的结果
		return '无符合条件的记录';
	},
	onLoadSuccess:function(data){
//		alert(data);
	}
});
}
//获取页面列表
function loadData(){
	$.ajax(
	  		{
	  		type:"get",
	  		url:"account/listAccount1",
	  		data:{"account":""},
	  		dataType:'json',
	  		success:function(data){
	  			list(data);
	  		}
	  		});
}

function loadData1(id){
	var account = "";
	$.ajax(
			{
			type:"get",
			url:"account/listAccount1",
			data:{"id":id,"account":encodeURI(account)},
			dataType:"json",
			success:function(data){
				list(data);
			}
			});
}

function queryParams(params) {  //配置参数
		var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
			pageSize: params.pageSize,   //页面大小
			pageNumber: params.pageNumber,  //页码
			orderNum : $("#orderNum").val() 
		};
		return temp;
	}
var setting = {
		view: {
			showLine: true,
			addDiyDom: addDiyDom
		},
		data: {
			simpleData: {
				enable: true,
				idKey:"id", 
	            pIdKey:"pid", 
			}
		},
		callback: {
			onClick: onClick,  
		}

	};
function addDiyDom(treeId, treeNode) {  
    var spaceWidth = 5;  
    var switchObj = $("#" + treeNode.tId + "_switch"),  
    icoObj = $("#" + treeNode.tId + "_ico");  
    switchObj.remove();  
    icoObj.before(switchObj);  

    if (treeNode.level > 1) {  
        var spaceStr = "<span style='display: inline-block;width:" + (spaceWidth * treeNode.level)+ "px'></span>";  
        switchObj.before(spaceStr);  
    }  
    var spantxt=$("#" + treeNode.tId + "_span").html();  
    if(spantxt.length>10){  
        spantxt=spantxt.substring(0,17)+"...";  
        $("#" + treeNode.tId + "_span").html(spantxt);  
    } 
} 

function onClick(event, treeId, treeNode, clickFlag) {  
	//点击树传入参数
	$("#listaccount").val(null);
	loadData1(treeNode.id); //获取树的id
}

/** 刷新页面 */  
/*function refresh() {  
    $('#reportTable').bootstrapTable('refresh',{url:"account/listAccount1"});  
} */
/** 刷新页面 */ 
function ref(){
	$('#reportTable').bootstrapTable('destroy');
	$.ajax(
	  		{
	  		type:"get",
	  		url:"account/listAccount1",
	  		data:{"account":""},
	  		dataType:'json',
	  		success:function(data){
	  			list(data);
	  		}
	  		});
}
var ztree;
function tree(id){
$.ajax({
	url:'departmentController/dtree',
	type:'get',
	data:{"id":1},
	dataType:'json',
	success:function(data){
		ztree=$.fn.zTree.init($("#"+id), setting, data);
		var nodes=ztree.getNodes();
		ztree.selectNode(nodes[0]);
		ztree.expandNode(nodes[0]);
	},
	 error:function(data) {
            alert("加载菜单出错");
        }
});
}
/**
 * 删除账户信息
 * @param id
 */
function edit(id){
	$.ajax({
		url:'account/get',
		type:'get',
		dataType:'json',
		data:{"id":id},
		success:function(data){
			data.birthday = dateUtils.getFormatDateFromTimes(data.birthday);
			$("#form1").json2form({'data':data});
			$("#myModal").modal();
		},
		 error : function(data) {
			 layer.alert("获取数据失败",{icon:2});
	        }
	});
}

function updatetime(id){
	$.ajax({
		url:'account/time',
		type:'get',
		dataYype:'json',
		data:{"id":id
		},
	success:function(data){
		layer.alert("保存成功",{icon:1});
		loadData();
		$("#myModal").modal('hide');
		ref();
	},
	error : function(data){
		layer.alert("保存失败",{icon:2});
		ref();
	}
	});
}

/**
 * 修改账户信息
 */
function upda(){
	var obj = $("#form1").form2json();
//	var jsonstr = JSON.stringify(obj);
	if(obj.account==null||obj.account.length==0){
		layer.alert("账号不能为空！",{icon:2});
		return ;
	}else if(obj.password==null||obj.password.length==0){
		layer.alert("密码不能为空！",{icon:2});
		return ;
	}else{
		$.ajax({
			url:'account/edit',
			type:'post',
			data:{"id":obj.id,
				"account":obj.account,
				 "password":obj.password
				},
			dataType:'json',
			success:function(data){
				if(data.id=="1"){
					layer.alert("该账号已存在!",{icon:2});
					}else{
					layer.alert("保存成功",{icon:1});
					loadData();
					$("#myModal").modal('hide');
					ref();
					}
			},
			error : function(data){
				layer.alert("保存失败",{icon:2});
				ref();
				updatetime(id)
			}
		});
	}
}

/**
 * 重置密码
 */
function update(id){
	
	layer.confirm('你确定要重置密码？', 
			{icon: 3, title:'提示'}, function(){  

        $.ajax({  
            url:'account/upda', 
            data:{"id":id},
            success:function(data){  
                if(data.hasError){ 
                	alert(data.hasError);
                }else{ 
                	layer.alert("重置成功",{icon:1}); 
                	ref();
                	
                }  
            }
           
        })  
      }); 

}

//弹出框
function getAuthority(account,id,authority){
	var item=document.getElementsByTagName("input");
	for(var i=0;i<item.length;i++){
		if(item[i].id.indexOf("auth_of_replace_id")!=-1){
				item[i].parentNode.removeChild(item[i]);
		}
	}
	$("#auth_of_replace_id1").remove();
	$("#auth_of_replace_id1_ztree_cont_wh").remove();
	$("#auth").show();
	$("#auth").attr("class","form-control1");
	deptTree1=$("#auth").dkSelectTree({
		url:"authority/listAuthority",
		Async:false,
		idField:"id",
//		pidField:"id",
		nameField:"authority",
		listType:"tree",
		multiSelect:true,
		chkboxType:{ "Y": "", "N": "" },
		width : 200,
		height:100
	});
	deptTree1.setValue(authority);
	$('#username').val(account);
	$('#accountId').val(id);
	$('#authModal').modal('show');
	
}

//获取权限列表
function initAuthority(){
	$.ajax({  
		type:'get',
        url:'authority/listAuthority', 
        success:function(data){  
            if(data.hasError){ 
            	alert(data.hasError);
            }else{ 
            	var tempAjax;
            	$.each(data,function(i,n){
                    tempAjax += "<option value='"+n.id+"'>"+n.authority+"</option>";
                 });
            	$('#authority').append(tempAjax);
            }  
        }
	}); 
}

function updateAuthority(){
	var obj = $("#form2").form2json();
	layer.confirm('确认选择的角色？', 
			{icon: 3, title:'提示'}, function(){  
				
        $.ajax({  
        	type:'post',
            url:'account/updateAuthority', 
            data:{"accountId":obj.accountId,
            	"authority":obj.auth},
            dataType:'json',
            success:function(data){  
                if(data.hasError){ 
                	layer.alert("保存失败",{icon:2}); 
                }else{ 
                	layer.alert("保存成功",{icon:1});
					$("#myModal").modal('hide');
					$('#authModal').modal('hide');
					ref();
                } 
            }
        })  
      }); 
}

//初始化数据
function clearForm(){
	$("#id").val(null);
	$("#account").val(null);
	$("#password").val(null);
	$("#deleteTag").val(null);
	$("#loginAccount").val(null);
	$("#createTime").val(null);
	$("#updateTime").val(null);
}
/** 
 * 删除数据 
 */  
function del(id) {  
    	layer.confirm('确定要删除所选数据？', 
    			{icon: 3, title:'提示'}, function(){  

            $.ajax({  
                url:'account/delete', 
                data:{"id":id},
                success:function(data){  
                    if(data.hasError){ 
                    	alert(data.hasError);
                    }else{ 
                    	layer.alert("删除成功",{icon:1}); 
                    	refresh();  
                    	ref();
                    }  
                }
               
            })  
          });  
}  

/*
 * 根据账户名称查询
 */
function query(){
	//获取输入框数据
	var account = $("#listaccount").val();
	var node=ztree.getSelectedNodes();
	var deptid;
	if(node.length>0&&node[0]!=null){
		deptid=node[0].id;
	}
	$.ajax({
	  		data:{"account":encodeURI(account),"id":deptid}, //传入输入框数据
	  		type:"get",
	  		url:"account/listAccount1",
	  		contentType:'application/json;charset=UTF-8',
	  		dataType:'json',
	  		success:function(data){
	  			list(data);
	  		},
	  		error:function(data){
	  			 layer.alert("查询错误",{icon:2});
	  		}
	  		});
}


