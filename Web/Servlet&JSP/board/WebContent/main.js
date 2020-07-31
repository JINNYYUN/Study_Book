const loginBtn = document.getElementById('loginbtn');
loginBtn.addEventListener("click", loginEvent);
//loginBtn.addEventListener("submit", loginEvent);

function loginEvent() {
    verifyEmail();
    verifyPassword();
    document.getElementById('frm').setAttribute('action', 'loginAf.jsp').submit();
    //var check = true;
    // alert(input);
}

/*
function showError(input) {
    // 커스텀 오류 메시지 UI
    document.querySelector('#user[email]-error') = getMessage(input.validity);
}
*/
/*
input.addEventListener('invalid', (e) => {
    // 브라우져 툴팁 숨김
    e.preventDefault();
})*/

//이메일 검증
function verifyEmail() {
    let input = document.getElementById('user_email').value;
    var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

    if (input == "") {
        document.getElementById('user_email_empty-error').classList.remove('hidden');
    }
    else if (!(regExp.test(input))) {
        // alert("이메일 형식에 맞지 않습니다.");
        //   let errorId = ;
        document.getElementById('user_email_empty-error').classList.add('hidden')
        document.getElementById('user_email-error').classList.remove('hidden');
    }
    else {
        console.log(input);
        //alert(regExp.test(input));
        document.getElementById('user_email_empty-error').classList.add('hidden')
        document.getElementById('user_email-error').classList.add('hidden');
    }
}

function verifyPassword() {
    var password = document.getElementById('user_password').value.replace(/ /gi, "");
    console.log(password);
    if (password.length < 6) {
        document.getElementById('user[password]-error').classList.remove('hidden');
    }
    else {
        document.getElementById('user[password]-error').classList.add('hidden');
    }
}