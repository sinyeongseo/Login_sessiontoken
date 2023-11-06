<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>SessionLogin</title>
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
	<h2>session login</h2><br><br>
	
 	<div class="memberdata">
 	<p id="membername" style="display:inline;">${receivedName}</p> 회원님 환영합니다.<br>
   	회원 ID:<p id="membername" style="display:inline;">  ${receivedId}</p><br>
   	회원 나이:<p id="membername" style="display:inline;">   ${receivedAge}</p>

    </div>
     <div id="sessiondata_result">
    
    </div><br><br><br>
    
    <div id="button">
    <button type="button" id="logout_btn"> Logout </button>
 	<button type="button" id="return_btn"> main</button>	
 	<button type="button" id="sessiondata_btn">남은 시간</button>	
 	</div>
 	
 	
 	</div>
	</div>
</body>
 
<script type="text/javascript" charset="UTF-8">
	
	document.getElementById("logout_btn").addEventListener("click", function() {
		 alert('로그아웃 되었습니다.');
		 const newPageURL = '/logout.do';
         window.location.href = newPageURL;   
	})
	document.getElementById("return_btn").addEventListener("click", function() {
		 alert('메인페이지로 이동합니다.');
		 const returnPageURL = '/return.do';
         window.location.href = returnPageURL;   
	})
	
	document.getElementById('sessiondata_btn').addEventListener('click', function() {
    fetch('/sessiondata.do')
      .then(response => response.text())
      .then(data => {
        console.log(data); // 서버에서 받은 데이터를 콘솔에 출력
        // 결과를 원하는 곳에 출력할 수 있도록 설정
        document.getElementById('sessiondata_result').textContent = data;
      })
      .catch(error => {
        console.error('An error occurred:', error);
      });
	
	});
		
	function checkSession() {
		var url="/checksession.do"
	    fetch(url) // 세션 유효성을 확인하는 엔드포인트를 호출
	      .then(response => response.json())
	      .then(data => {
	        if (data.sessionExpired) {
	            alert("세션이 만료되어 자동 로그아웃되었습니다.");
	            window.location.href = '/logout.do'; // 로그아웃 엔드포인트로 이동
	        }
	      })
	      .catch(error => {
	        console.error('An error occurred:', error);
	      });
	}
	setInterval(checkSession, 5000); // 일정 간격으로 세션을 확인

</script>
 	
</body>
</html>
