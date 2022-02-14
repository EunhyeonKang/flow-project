<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="#">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/Flow.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<title>플로우 개발자 과제</title>
</head>
<body>
	<div id="container">
		<div id="header">
			<h1>개발자 - 플로우 과제</h1>
		</div>
		<div id="content">
			<div>
				<hr />
				<h3>
					<b>◎파일 확장자 차단</b>
				</h3>
				<hr color="black" />
				<div id="text">
					<p>파일 확장자에 따라 특정 형식의 파일을 첨부하거나 전송하지 못하도록 제한</p>
					<div id="fix">
						<span>고정 확장자</span> <span><c:forEach items="${extension}"
								var="e">
								<c:if test="${e.ex_type eq 'f'}">
									<c:if test="${e.ex_status eq 1}">
										<input type="checkbox" id="checkFix" value="${e.ex_name}"
											onClick="check(this)" checked />
										<c:out value="${e.ex_name}" />
									</c:if>
									<c:if test="${e.ex_status eq 0}">
										<input type="checkbox" id="checkFix" onClick="check(this)"
											value="<c:out value='${e.ex_name}' />" />
										<c:out value="${e.ex_name}" />
									</c:if>
								</c:if>
							</c:forEach> </span>

					</div>
					<div id="custom">
						<div id="checkCustom">
							<span>커스텀 확장자</span> <span> <input type="text"
								placeholder="확장자 입력" />
								<button id='inputExtension'>+ 추가</button>
							</span>
						</div>
						<div id="textAreaCustom">
							<span id="customCount"></span>
						</div>
					</div>
					<div id="files">
						<form id="fileForm">
							<input type="file">
							<button id="fileUploadPath" type="button" class='btn btn-default'>확인</button>
						</form>
						<span id="chkMsg"></span>
					</div>
				</div>
			</div>
		</div>
		<div id="footer">
			<p></p>
		</div>
	</div>
</body>

<script type="text/javascript">
	function check(event){
		var checkCur = event.value;
		var tmp=1;
		if(event.checked==true){
			tmp =1;
		}else{
			tmp =0;
		}
		$.ajax({
	        url:'/updateExtension.do',
	        type:'post',
	        data:{
	        	checkCur:checkCur,
	        	tmp,tmp
	        },
	        success:function(data){
	           	alert('체크를 변경하였습니다.');
	        },
	        error:function(){
	            alert("error");
	        } 
	    }); 
	}
	$("#inputExtension").click(function(){
		var custom = $(this).parent().children('input').val();
		var customLength = (custom.length) ;
		if( custom == "" ){
			alert ( "확장자를 입력해주세요!" )
			custom.value="";
			return false;
		}
		else{
			var eng_check = /^[A-za-z]/g;
			if (eng_check.test(custom)){
			if( customLength < 2 || customLength > 20 ){
				alert('확장자의 최대 입력길이는 20자리입니다!');
				custom.value="";	
 				return false;
			}
		}
		else{
			alert("영어만 입력할 수 있습니다!");
			custom.value="";
			return false;
		}
			
		}
		var extensionName = $(this).parent().children('input').val();
		var extensionCount = $("#textAreaCustom").children('span').length-1;
		if( extensionCount <= 200){
			 $.ajax({
			        url:'/insertExtension.do',
			        type:'post',
			        data:{
			        	ex_name:extensionName,
			        	ex_type : 'c'
			        },
			        success:function(data){
			        	if(data<0){
							alert('이미 등록된 확장자입니다!');
							false;
						}
						else if(data==0){
							alert('고정 확장자입니다. 위 체크박스에서 설정해주세요!');
							false;
						}
						else{
							$("#textAreaCustom").append(
									"<span id='customs'>"+
										"<span id='"+ data +"' name='eName'>"+ extensionName +"</span>"+
										"<button id='xButton' onClick='deleteVal()'>X</button>"+
									"</span>"	
							);
							$("#customCount").text($("#textAreaCustom").children('span').length-1).append("/200"); 
						}
			        },
		        error:function(){
		            alert("error");
		        }
		    });
		 }else{
			 alert('커스텀 확장자는 최대 200개까지 차단 가능합니다!')
		 }
	}) 
	function deleteVal(){
		var deleteVal = $("#customs").find('span:eq(0)')[0].id;
		var extension = $("#customs");
		 $.ajax({
		        url:'/deleteExtension.do',
		        type:'post',
		        data:{deleteVal:deleteVal},
		        success:function(data){
		        	if(data>0){
		        		extension.remove();
		        		$("#customCount").text($("#textAreaCustom").children('span').length-1).append("/200"); 
		        	}else{
		        		alert("삭제를 실패했습니다.");
		        	}
		        },
		        error:function(){
		              alert("삭제를 실패했습니다.");
		        }
		    });
	};
	$("#fileUploadPath").click(function(e) {
		e.preventDefault();
		var file = $(this).prev('input').val();
		if(file==""){
			alert('확인할 파일을 등록하세요!');
		}else{
			//파일명 자르기
			var fileValues = file.split("\\");
			//확장자명 자르기
			var fileExtension = fileValues[fileValues.length-1].split(".")[1];
			console.log(fileExtension);
			$.ajax({
				url : "/extensionNameCheck.do",
				type : "post",
				data : {
					fileExtension : fileExtension
				},
				error:function(e){
	               console.log(e);
	            },
				success : function(data) {
					if(data!=0){
						 $('#chkMsg').html("해당 파일은 업로드 불가능합니다."); 
					}else{
						 $('#chkMsg').html("해당 파일은 업로드 가능합니다."); 
					}
				}
			});
		}
	});  
	</script>
</html>