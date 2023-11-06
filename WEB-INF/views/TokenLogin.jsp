<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Token Login</title>
<style type="text/css">
		*{
		    padding: 0;
		    margin: 0;
		    border: none;
		}
		.login-wrapper{
		  height: 100vh;
		  display: flex;
		  align-items: center;
		  justify-content: center;
		  background: rgba(0, 0, 0, 0.1);
		}
		.login {
		  width: 30%;
		  height: 500px;
		  background: white;
		  border-radius: 20px;
		  display: flex;
		  justify-content: center;
		  align-items: center;
		  flex-direction: column;
		}
		
		h1{
			color:#0064FF;
		    font-size: 2em;
		}
		h2{
			color:#0064FF;
		    font-size: 1em;
		}
		.memberdata{
		  border:3px solid #0064FF;
		  border-radius: 30px;
		  width: 300px;
		  height: 100px;
		  margin: 20px;
		  padding: 10px;
		  text-align: center;
		}
		#membername{
			color:#0064FF;
		    font-size: 1.5em;
		}
		
		button {
		  margin:0 5px; /* Optional margin for spacing between buttons */
		  width: 20%;
		  height: 45px;
		  border: 10px;
		  outline: none;
		  border-radius: 40px;
		  background: linear-gradient(to left, rgb(0, 51, 255), rgb(153, 204, 255));
		  color: white;
		  font-size: 1em;
		  letter-spacing: 2px;
		  position:center;
		}
		#button{
		 display: inline-block; /* Change display to inline-block */
		 width: 600px;
		 height : 60px;
		 text-align: center; /* Center align its children horizontally */
		}	
		
	</style>
</head>
<body>
<div class="login-wrapper">
<div class="login">
	<h1>Login 되었습니다.</h1>
	<h2>token login</h2><br><br>
 	
 	<div class="memberdata">
 	<p id="membername" style="display:inline;">${receivedName}</p> 회원님 환영합니다.<br>
   	회원 ID:<p id="membername" style="display:inline;">  ${receivedResult}</p><br>
   	회원 나이:<p id="membername" style="display:inline;">   ${receivedAge}</p>
    </div>
    <br><br><br>
    
    <div id="button">
    <button type="button" id="logout_btn"> Logout </button>	
 	<button type="button" id="return_btn"> main</button>	
 	<button type="button" id="token_btn"> token key<br>copy</button>
 	</div>
 	
 	
 	</div>
	</div>	
</body>
<script type="text/javascript" charset="UTF-8">
	document.getElementById("logout_btn").addEventListener("click", function() {
		 alert('로그아웃 되었습니다.');
		 const newPageURL = '/Tokenlogout.do';
	     window.location.href = newPageURL;   
	})
	
	document.getElementById("return_btn").addEventListener("click", function() {
		 alert('메인페이지로 이동합니다.');
		 
		 
		 const returnPageURL = '/return.do';
	    window.location.href = returnPageURL;   
	})
	
	document.getElementById("token_btn").addEventListener("click", function() {
		
		 var receivedToken = "${receivedToken}"; // 받아온 토큰 값
		  
		  var tempInput = document.createElement("input");
		  document.body.appendChild(tempInput);
		  
		  tempInput.value = receivedToken;
		  tempInput.select();
		  document.execCommand("Copy");
		  document.body.removeChild(tempInput);
		  
		  alert('토큰 key 값이 복사되었습니다.');
	})

</script>
	

</html>