function edit(date){
	$("#listtime").removeClass("dkDate1");
	$("#listtime").attr("disabled","disabled");
	$("#btn1").show();
	$("#btn").hide();
	$("#btn2").hide();
	$("#btn3").hide();
	$("#btn4").hide();
	date = new Date(parseInt(date)).Format("yyyy-MM");
	$.ajax({
		url:'work/getWork',
		data:{"date":date},
		success:function(data){
			checkMonth(date);
			var forms = document.getElementsByTagName("form");			
			for(var i =0;i<data.length;i++){
				var id = $(forms[i]).attr("id");
				$(".jobnumber"+id).val(data[i]['emp_no']);
				$(".dept_id"+id).val(data[i]['dept_id']);
				$(".name"+id).val(data[i]['name']);
				$(".date"+id).val(new Date(data[i]['attendance_date']).Format('yyyy-MM'));
				$("#listtime").val(new Date(data[i]['attendance_date']).Format('yyyy-MM'));
//				$(".zhongban"+id).val(data[i]['zhong_ban']);
//				$(".shenban"+id).val(data[i]['shen_ban']);
				$(".remark"+id).val(data[i]['remark']);
				$(".lx"+id).val(data[i]['day_work']);
				$("."+id).val(data[i]['id']);
				for(var j = 1;j<=31;j++){
					$("."+id+"a"+j).val(data[i]['a'+j]);
					$("a[name='"+id+"a"+j+"']").html(format(data[i]['a'+j]));
				}
			};
			$("#myModal").modal();
		},
		 error : function(data) {
			 layer.alert("获取数据失败",{icon:2});
	        }
	});
}
function edit1(date){
	$("#listtime").removeClass("dkDate1");
	$("#listtime").attr("disabled","disabled");
	date = new Date(parseInt(date)).Format("yyyy-MM");
	$.ajax({
		url:'work/getWork',
		data:{"date":date},
		success:function(data){
			$("#btn").hide();
			$("#btn1").hide();
			$("#btn2").show();
			$("#btn3").show();
			$("#btn4").hide();
			checkMonth(date);
			var forms = document.getElementsByTagName("form");			
			for(var i =0;i<data.length;i++){
				var id = $(forms[i]).attr("id");
				$(".jobnumber"+id).val(data[i]['emp_no']);
				$(".dept_id"+id).val(data[i]['dept_id']);
				$(".name"+id).val(data[i]['name']);
				$(".date"+id).val(new Date(data[i]['attendance_date']).Format('yyyy-MM'));
				$("#listtime").val(new Date(data[i]['attendance_date']).Format('yyyy-MM'));
//				$(".zhongban"+id).val(data[i]['zhong_ban']);
//				$(".shenban"+id).val(data[i]['shen_ban']);
				$(".remark"+id).val(data[i]['remark']);
				$(".lx"+id).val(data[i]['day_work']);
				$("."+id).val(data[i]['id']);
				for(var j = 1;j<=31;j++){
					$("."+id+"a"+j).val(data[i]['a'+j]);
					$("a[name='"+id+"a"+j+"']").html(format(data[i]['a'+j]));
				}
			};
			$("#myModal").modal();
		},
		 error : function(data) {
			 layer.alert("获取数据失败",{icon:2});
	        }
	});
}
function edit2(date){
	$("#listtime").removeClass("dkDate1");
	$("#listtime").attr("disabled","disabled");
	date = new Date(parseInt(date)).Format("yyyy-MM");
	$.ajax({
		url:'work/getWork',
		data:{"date":date},
		success:function(data){
			$("#btn").hide();
			$("#btn1").hide();
			$("#btn2").hide();
			$("#btn3").hide();
			$("#btn4").show();
			checkMonth(date);
			var forms = document.getElementsByTagName("form");			
			for(var i =0;i<data.length;i++){
				var id = $(forms[i]).attr("id");
				$(".jobnumber"+id).val(data[i]['emp_no']);
				$(".dept_id"+id).val(data[i]['dept_id']);
				$(".date"+id).val(new Date(data[i]['attendance_date']).Format('yyyy-MM'));
				$("#listtime").val(new Date(data[i]['attendance_date']).Format('yyyy-MM'));
				$(".name"+id).val(data[i]['name']);
//				$(".zhongban"+id).val(data[i]['zhong_ban']);
//				$(".shenban"+id).val(data[i]['shen_ban']);
				$(".remark"+id).val(data[i]['remark']);
				$(".lx"+id).val(data[i]['day_work']);
				$("."+id).val(data[i]['id']);
				for(var j = 1;j<=31;j++){
					$("."+id+"a"+j).val(data[i]['a'+j]);
					$("a[name='"+id+"a"+j+"']").html(format(data[i]['a'+j]));
				}
			};
			$("#myModal").modal();
		},
		 error : function(data) {
			 layer.alert("获取数据失败",{icon:2});
	        }
	});
}
function save1(status){
	if(checkNum($("#zhongBan").val())&&checkNum($("#shenBan").val())){
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
			obj.dayWork=$(".lx"+id).val();
			obj.zhongBan="";
			obj.shenBan="";
			obj.remark=$(".remark"+id).val();
			for(var j = 1;j<=31;j++){
				obj["a"+j]=$("."+id+"a"+j).val();
			}
			obj.status=status;
			jsonstr+= JSON.stringify(obj)+",";
		}
		jsonstr=jsonstr.substring(0, jsonstr.length-1)+"]";
		$.ajax({
			url:'work/add',
			data:{"attendance":jsonstr},
			type:'post',
			success:function(data){
				if(data==true){
					layer.alert("操作成功",{icon:1}); 
					$("#myModal").modal('hide');
					history.go(0);
				}else{
					layer.alert("保存失败",{icon:2});
					return ;
				}
			}
		});
		
	}else{
		layer.alert("夜班请填数字",{icon:2});
		return ;
	}
			
}
//function save2(date){
//	date = $(".dkDate1").val();
//	var forms = document.getElementsByTagName("form");
//	for(var i = 0;i<forms.length;i++){
//		debugger;
//		var obj = $(forms[i]).form2json();
//		obj.attendance_date=$("#listtime").val();
//		var jsonstr = JSON.stringify(obj);
//		$.ajax({
//			url:'work/check',
//			data:{"status":2,"date":date},
//			type:'post',
//			success:function(data){
//				if(data!=0){
//				}else{
//					layer.alert("保存失败",{icon:2});
//					return ;
//				}
//			}
//		});
//	}
//	layer.alert("保存成功",{icon:1}); 
//	$("#myModal").modal('hide');
//	history.go(0);
//
//
//}
function save3(date){
	date = $(".dkDate1").val();
	var forms = document.getElementsByTagName("form");
	for(var i = 0;i<forms.length;i++){
		var obj = $(forms[i]).form2json();
		obj.attendance_date=$("#listtime").val();
		var jsonstr = JSON.stringify(obj);
		$.ajax({
			url:'work/check',
			data:{"status":3,"date":date},
			type:'post',
			success:function(data){
				if(data==true){
				}else{
					layer.alert("保存失败",{icon:2});
					return ;
				}
			}
		});
	}
	layer.alert("保存成功",{icon:1}); 
	$("#myModal").modal('hide');
	history.go(0);


}