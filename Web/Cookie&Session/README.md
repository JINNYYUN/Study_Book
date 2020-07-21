# Cookie & Session

HTTP의 비연결성(Connectionless)과 비상태성(Stateless)을 보완하여 서버가 클라이언트를 식별하게 해주는 것이 **쿠키**와 **세션**이다.

- 비연결성(Connectionless) : 클라이언트의 요청을 응답을 받으면 그 연결을 끊어 버리는 특징
- 비상태성(Stateless) : 통신이 끝나면 상태를 유지하지 않는 특징

<br>

## Cookie

- 클라이언트(브라우저)에서 관리되는 정보
- 서버가 클라이언트에 저장하는 정보이다.
- 유효 시간 명시 가능 > 한 번 유효 시간이 정해지면 브라우저를 끄더라도 인증이 유지된다.
- Key 와 Value로 구성되어 있으며, String형태로 이용 가능

**쿠키 생성**

클라이언트가 페이지를 요청하면, 서버에서 쿠키를 생성한 뒤, HTTP헤더에 쿠키를 포함시켜 응답한다. 

```java
//쿠키 생성
//javax.servlet.http.cookie 객체를 생성
Cookie cookie = new Cookie("id", "abc123"); //쿠키는 한쌍으로 관리 됨
//Cookie cookie = new Cookie("쿠키이름","쿠키값");

//생성된 쿠키를 클라이언트로 보낸다.
resp.addCookie(cookie); // HttpServletResponse 객체의 addCookie( ) 메소드를 이용
```

`setMaxAge( )` 

- 쿠키 유효시간 설정. 설정하지 않으면 브라우저를 종료하는 시점에 쿠키가 사라진다.
- `60*60*24*365` *쿠키 유지 기간 1년, `60*60`*(1시간), `60*60*24`(하루), 음수->브라우저를 닫을 때 쿠키를 없애라

`setPatch("/경로")` : 지정된 경로와 그것의 하위 경로의 요청에만 클라이언트로부터 쿠키가 전송된다.

 `setDomain()` : 도메인 설정(다른 서버에서도 읽어 들일 수 있다.)


<br>

**쿠키 가져오기**

클라이언트에서 쿠기가 존재하면 요청을 할 때 HTTP헤더에 쿠키를 함께 보내서 요청을 한다. 서버는 클라이언트로부터 전송된 쿠키를 읽어들여 정보를 처리한다.

```java
//쿠키 읽기
Cookie cookies[] = req.getCookies(); //HttpServletRequest 객체의 getCookies() 메소드를 이용해 쿠키를 읽어온다.
//해당 사이트에 저장되어 있는 모든 쿠키를 Cookie 배열로 얻는다

//쿠키 이름과 값 얻기
if(cookies != null) { //쿠키가 존재하는지 확인
	for(int i=0; i<cookies.length; i++) {
		String cookieName = cookies[i].getName(); //Cookie객체의 getName()메소드로 쿠키의 이름 추출
		String value = cookies[i].getValue(); //Cookie객체의 getValue()메소드로 쿠키의 값 추출
	}
}
```

<br>

**방문 횟수 기록**

```java
//쿠키 읽기
Cookie cookies[] = req.getCookies();
Cookie visitedCookie = null;

//쿠키가 존재하면(널이 아니면)
if(cookies !=null) {
	// visited쿠키가 존재하는지 확인한다(검색)
	for (int i = 0; i < cookies.length; i++) {
		if(cookies[i].getName().contentEquals("visited")) {
			visitedCookie = cookies[i];	//visited쿠키를 얻는다.
			break; //찾았으면 탈출
		}
	}
	
	 //visitedCookie가 존재하면 == 이미 방문했었을 경우
	if(visitedCookie !=null) { 
		int count = Integer.parseInt(visitedCookie.getValue())+1;//현재 방문까지 더하기 위해 1을 추가한다.
		pw.println("<p>"+count+"번째 방문입니다");
		
		//cookie값을 갱신
		visitedCookie.setValue(count+""); //쿠키의 값
		visitedCookie.setMaxAge(60); 	//60*60*24*365-> 쿠키 유지 기간 1년, 60*60(1시간), 60*60*24(하루), 음수->브라우저를 닫을 때 쿠키를 없애라
		resp.addCookie(visitedCookie);//갱신된 값을 저장
		
	}else { //찾지 못하면 == 첫번째 방문일 경우
		pw.println("<p>첫번째 방문입니다</p>");
		//방문 횟수를 계산할 "visited" 쿠기 생성
		Cookie newCookie = new Cookie("visited", "1");
		resp.addCookie(newCookie);
	}
	
}else {
	
}
```

**cookie활용 예**

- ID저장, 로그인 상태 유지
- 쇼핑몰 장바구니 기능



참고

[https://opentutorials.org/module/3569/21214](https://opentutorials.org/module/3569/21214)

[https://devuna.tistory.com/23](https://devuna.tistory.com/23)
