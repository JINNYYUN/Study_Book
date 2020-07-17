const loginBtn = document.getElementById('loginbtn');
let input = document.getElementById('user[email]').value;

loginBtn.addEventListener("click", loginEvent);
//loginBtn.addEventListener("submit", loginEvent);

function loginEvent() {
    input = document.getElementById('user[email]').value;
    verifyEmail();
    verifyPassword();
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
    var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

    if (!(regExp.test(input))) {
        // alert("이메일 형식에 맞지 않습니다.");
        //   let errorId = ;
        document.getElementById('user[email]-error').classList.remove('hidden');
    }
    else {
        console.log(input);
        //alert(regExp.test(input));
        document.getElementById('user[email]-error').classList.add('hidden');
    }
}

function verifyPassword() {
    var password = document.getElementById('user[password]').value;
    console.log(password);
    if (password.length < 6) {
        document.getElementById('user[password]-error').classList.remove('hidden');
    }
    else {
        document.getElementById('user[password]-error').classList.add('hidden');
    }
}