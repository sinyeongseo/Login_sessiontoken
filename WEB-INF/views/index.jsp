<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>SessionLogin | TokenLogin</title>
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
		.login_id {
		  margin-top: 20px;
		  width: 80%;
		}
		
		.login_id input {
		  width: 100%;
		  height: 20px;
		  border-radius: 30px;
		  margin-top: 10px;
		  padding: 0px 20px;
		  border: 1px solid lightgray;
		  outline: none;
		}
		
		.login_pw {
		  margin-top: 20px;
		  width: 80%;
		}
		
		.login_pw input {
		  width: 100%;
		  height: 20px;
		  border-radius: 30px;
		  margin-top: 10px;
		  padding: 0px 20px;
		  border: 1px solid lightgray;
		  outline: none;
		}
		
		.submit {
		  margin-top: 20px;
		  width: 90%;
		}
		
		#login_btn {
		  width: 100%;
		  height: 50px;
		  border: 10px;
		  outline: none;
		  border-radius: 40px;
		  background: linear-gradient(to left, rgb(000, 051, 255), rgb(153, 204, 255));
		  color: white;
		  font-size: 1.2em;
		  letter-spacing: 2px;
		}
		</style>
</head>
<body>
	<div class="login-wrapper">
	 <div class="login">
	<h1>Login</h1>
 	<form  id="loginForm" encType="UTF-8">
 		<br>
 			<div class="login_id">
 			<input type="text" name="user_id" id="user_id" placeholder="ID"/>
 			</div>
 			<div class="login_pw">
 			<input type ="text" name="user_pw" id="user_pw" placeholder="PASSWORD"/>
 			</div>
 			<br>
 			
 			<input type ="radio" name="loginck" id="sessionlogin" value="session"/> session login<br>
 		
 		
 			<input type ="radio" name="loginck" id="tokenlogin" value="token"/> token login <br><br>
 			
 			<div class="submit">
 			<button type="button" id="login_btn" class="btnon off-button"> 로그인 </button>
 			</div>
 	</form>
 	 </div>
	</div>
<script type="text/javascript" charset="UTF-8">

	//로그인 버튼을 누를 경우
	document.getElementById("login_btn").addEventListener("click", function() {
	    var id = document.getElementById("user_id").value;
	    var pw = document.getElementById("user_pw").value;
	    var value = document.querySelector('input[name="loginck"]:checked').value;
	    
	    if (value === "session") { //라디오버튼 세션에 체크일 경우
            url = "/SessionLogin.do";
           	SessionLogin(id, pw, url);
        } else if (value === "token") { //라디오버튼 토큰에 체크일 경우
            url = "/TokenLogin.do";
            TokenLogin(id, pw, url);
        } else {
            console.error("Invalid value for loginck:", value);
            return;
        }
	    // JavaScript 함수 호출
	})

 function SessionLogin(id, pw, url) {
			
            var params = "user_id=" + encodeURIComponent(id) +
                         "&user_pw=" + encodeURIComponent(pw);
            fetch(url, {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: params
            })
            .then(function(response) {
                if (!response.ok) {
                	console.log("error");
                    throw new Error('Network response was not ok.');
                };
                return response.json(); // JSON으로 파싱하여 promise 객체를 반환
            })
            .then(function(data) {  
            	  const userIdInput = document.getElementById("user_id");
            	  const userPwInput = document.getElementById("user_pw");
            	  
            	  //null 값이 넘어왔을 경우(회원이 아닐 경우)
            	if(data.age==null && data.name==null && data.id == null){
            		   alert('회원이 아닙니다. 다시 로그인해주세요.');
            		   
            		   userIdInput.value = ""; // ID 입력 필드 초기화
            	       userPwInput.value = ""; // PASSWORD 입력 필드 초기화
            	}
            	else{ //값이 넘어왔을 경우 (회원일 경우)
            	  const queryParams = new URLSearchParams();
                  queryParams.append('id', data.id);
                  queryParams.append('name', data.name);
                  queryParams.append('age', data.age);

                  alert("로그인 되었습니다");
                  //세션 로그인 화면으로 넘어감
                  const newPageURL = '/MoveLogin.do?' + queryParams.toString();
                  window.location.href = newPageURL;       
            	}
            })
            .catch(function(error){
                console.error('Error:', error); // 오류 처리
            });
            
	}
	
function TokenLogin(id, pw, url){
		
		var params = "user_id=" + encodeURIComponent(id) +
	     "&user_pw=" + encodeURIComponent(pw);
		
		fetch(url, {
		  method: 'POST',
		  headers: {
	          "Content-Type": "application/x-www-form-urlencoded"
	      },
	      body: params
		})
		.then(response => response.json())
		.then(data => {
			  const userIdInput = document.getElementById("user_id");
        	  const userPwInput = document.getElementById("user_pw");
        	  //data가 넘어왔을 경우(회원일 경우)
		  if (data.result !== null) {
		    console.log('Login successful! Token:', data.result);
		    var result = data.result
		    alert("로그인 되었습니다");
		    //TokenLoginAfter 함수 호출
		    TokenLoginAfter(id,result);
		    // data가 안넘어왔을 경우(회원이 아닐경우)
		  } else {
			alert('회원이 아닙니다. 다시 로그인해주세요.');
			
   		   	userIdInput.value = ""; // ID 입력 필드 초기화
   	       	userPwInput.value = ""; // PASSWORD 입력 필드 초기화  
		  }
		})
		.catch(error => {
		  console.error('An error occurred:', error);
		});
} 

function TokenLoginAfter(id,result){
	
	var url = "/LoginAfter.do";
	var params = "user_id=" + encodeURIComponent(id) +
     "&token=" + encodeURIComponent(result);
	 
	fetch(url, {
		  method: 'POST',
		  headers: {
	          "Content-Type": "application/x-www-form-urlencoded"
	      },
	      body: params
		})
		.then(response => response.json())
		.then(data => {
			//data를 받아와서 토큰 로그인 화면으로 이동
			  const queryParams = new URLSearchParams();
              queryParams.append('name', data.name);
              queryParams.append('age', data.age);
			  queryParams.append('result',data.result)
			  queryParams.append('token',result)
              const newPageURL = '/TokenMoveLogin.do?' + queryParams.toString();
              window.location.href = newPageURL;  
		})
		.catch(error => {
		  console.error('An error occurred:', error);
		});	
}

	
	
</script>
 	
</body>
</html>
