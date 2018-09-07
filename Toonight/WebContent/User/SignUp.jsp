<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*"%>
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원가입</title>
	<link rel="stylesheet" href="../css/style2.css" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
</head>
<body>			
			<script>
				window.onload = function() {
					document.getElementById("isCheck").value = "false";
					document.getElementById("checkId").onclick = function() {
						var sid = document.getElementById("id").value;
						if (sid == null || sid.length == 0) {
							alert("아이디를 입력하고 검사하세요");
						} else {
							window
								.open("CheckId.jsp?id=" + sid, "",
									"width=300 height=300");
						}
					}
					
					document.getElementById("SignUpForm").onsubmit=function(){
						var isCheck=document.getElementById("isCheck").value;
						if(isCheck != "true"){
							alert("아이디 중복체크를 하지 않았습니다.");
						    return false;
						}
						return true;
					}
					//id 란에 포커스가 오면 중복체크를 다시 하도록 isCheck의 값을 변경
					document.getElementById("id").onblur = function() {
						document.getElementById("isCheck").value = "false";
					}
				}
			</script>
			<div id="content">
			<div id="login">
				<FORM class="login_form" ID="SignUpForm" ACTION=SignUpProcess.jsp Method=POST>
				<img src="../Images/signup_logo.png" class="login_logo">
				
				<div class="input-group mb-3">
					<input style="border:none; border-bottom:1px solid;" type="hidden" id="isCheck" /> 
					<INPUT type="text" class="form-control"  aria-label="Recipient's username" aria-describedby="button-addon2" id="id" NAME=id placeholder="아이디" required>
					 <div class="input-group-append">
					<button class="btn btn-outline-secondary" type="button" id="checkId" >중복확인</button>
					</div>
				</div>
				<div class="form-group">
					<INPUT class="form-control" TYPE=PASSWORD NAME=password id="password" placeholder="비밀번호" required>
				</div>
				<div class="form-group">
					<INPUT class="form-control" TYPE=TEXT NAME=name id="name" placeholder="이름" required >
				</div>
				
				<div class="custom-file">
					<input type="file" name="image" class="custom-file-input" id="customFile">
					<label class="custom-file-label" for="customFile">프로필 이미지</label>
					
				</div>
				<br><br>
				<div style="text-align:center">
				<INPUT TYPE="SUBMIT" class="btn btn-secondary btn-sm" VALUE='회원가입'> 
				<INPUT TYPE="RESET" class="btn btn-secondary btn-sm" VALUE='초기화'>
				</div>
				</FORM>
				</div>
			</div>
		
</body>
</html>