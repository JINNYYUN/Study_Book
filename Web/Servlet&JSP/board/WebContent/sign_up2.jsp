<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>회원가입</title>
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet" />
    <!--css연결-->
    <link rel="stylesheet" href="style.css" />
    <!--script연결-->

    <!--jquery-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript"></script>
</head>

<body>
    <article class="sigin-form">
        <h2 class="page-heading">회원가입</h2>
        <form id="join_form" method="post" action="signAf.jsp">
            <div class="form-group">
                <label for="user[email]" class="form__label">Email</label>
                <input type="text" id="user_email" class="form_input" name="user[email]" placeholder="Email" />
                <p id="user_email_check-no" class="form-error hidden">이미 사용중인 이메일입니다</p>
                <p id="user_email_check-yes" class="form-error hidden">사용 가능한 이메일입니다</p>
                <p id="user_email_empty-error" class="form-error hidden">이메일을 입력해주세요</p>
                <p id="user_email-error" class="form-error hidden">형식에 맞는 이메일을 입력해주세요</p>
            </div> 
            <div class="form-group">
                <label for="user[password]" class="form__label">Password</label>
                <input type="password" id="user_password" class="form_input" name="user[password]"
                    placeholder="Password" />
                <p id="user_password-error" class="form-error hidden">6자 이상의 비밀번호를 입력해주세요</p>
            </div>
            <div class="form-group">
                <label for="user[name]" class="form__label">Name</label>
                <input type="text" id="user_name" class="form_input" name="user[name]" placeholder="Name" />
                <p id="user_name-error" class="form-error hidden">이름을 입력해주세요</p>
            </div>
            <div class="container-signinbtn">
                <button type="button" class="signinbtn" id="signinbtn">Sign-in</button>
            </div>
            <div class="sign-up">
				<a href="./login.html" class="bottom-txt border-bottom">로그인하러 가기</a>
			</div>
        </form>
    </article>
    <!--end log form -->

    <script>
        const signinBtn = document.getElementById('signinbtn');
        
		
        //각 요소별 조건 확인
        let checkemail = false;
        let checkemail_double = false;
        let checkPassword = false;
        let checkName = false;

        //이메일 검증
        function verifyEmail() {
            var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
            let input = document.getElementById('user_email').value;

            if (input == "") {
            	document.getElementById('user_email_check-yes').classList.add('hidden');
				document.getElementById('user_email_check-no').classList.add('hidden');
                document.getElementById('user_email_empty-error').classList.remove('hidden');
            }
            else if (!(regExp.test(input))) {
                // alert("이메일 형식에 맞지 않습니다.");
                //  let errorId = ;
                document.getElementById('user_email_check-yes').classList.add('hidden');
                document.getElementById('user_email_check-no').classList.add('hidden');
                document.getElementById('user_email_empty-error').classList.add('hidden')
                document.getElementById('user_email-error').classList.remove('hidden');
            }
            else {
                console.log(input);
                //alert(regExp.test(input));
                document.getElementById('user_email_check-yes').classList.add('hidden');
                document.getElementById('user_email_check-no').classList.add('hidden');
                document.getElementById('user_email_empty-error').classList.add('hidden')
                document.getElementById('user_email-error').classList.add('hidden');
                
                checkemail=true;
            }
        }
        
		//비밀번호 검증
        function verifyPassword() {
            var password = document.getElementById('user_password').value;
            console.log(password);
            if (password.length < 6) {
                document.getElementById('user_password-error').classList.remove('hidden');
            }
            else {
                document.getElementById('user_password-error').classList.add('hidden');
                checkPassword = true;
            }
        }
        
		//이름 공백 검증
        function verifyName() {
            var name = document.getElementById('user_name').value;
            if (name == "") {
                document.getElementById('user_name-error').classList.remove('hidden');
            }
            else {
                document.getElementById('user_name-error').classList.add('hidden');
                checkName = true;
            }
        }
        
        
        //이메일 중복 확인
		$(function(){
			$("#user_email").blur(function() {
//				alert("마우스 이벤트");
				verifyEmail();
				
		        if(checkemail==true){
		        	$.ajax({
						type:"post",
						url:"./emailcheck.jsp",
						data:{ "email":$("#user_email").val() },
						success:function( data ){
						//	alert("success");
						//	alert(data.trim());
							if(data.trim() == "NO"){	//이메일이 중복될 경우
								document.getElementById('user_email_check-yes').classList.add('hidden');
								document.getElementById('user_email_check-no').classList.remove('hidden');
							}else{	//이메일이 중복되지 않을 경우
								document.getElementById('user_email_check-no').classList.add('hidden');
								document.getElementById('user_email_check-yes').classList.remove('hidden');
								checkemail_double = true;
							}			
						},
						error:function(){
							alert("error");
						}
					});
				}
			});
			
			$("#user_password").blur(function() {
//				alert("마우스 이벤트");
				verifyPassword();
			});
			
			$("#user_name").blur(function() {
//				alert("마우스 이벤트");
				verifyName();
			});
			
		});
        
        //버튼 클릭시, 모든 요소가 조건에 맞으면 DB에 데이터를 저장하고 로그인 페이지로 이동한다.
		signinBtn.addEventListener("click", signinEvent);
        function signinEvent() {
            verifyEmail();
            verifyPassword();
            verifyName();
            
            //이메일, 페스워드, 이름이 조건에 맞을 때
            if(checkemail==true && checkPassword==true && checkName==true && checkemail_double==true){
            //	alert("확인");
            	document.getElementById('join_form').submit();
            }
            
            //중복된 이메일을 입력했을 때 알람
            if(checkemail== true || checkemail_double==false){
            	alert("이메일을 확인해주세요");
            }
        }
    </script>
</body>

</html>