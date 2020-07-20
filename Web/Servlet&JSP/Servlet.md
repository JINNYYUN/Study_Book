# Servlet 정리

## servlet

- 웹서버가 동적인 페이지를 제공할 수 있도록 도와주는 어플리케이션 컴포넌트로 웹 기반의 요청에 대한 동적인 처리가 가능한 하나의 클래스이다.
- 서블릿 컨테이너가(톰켓)이 web.xml에 매핑되어진 자바 파일을 Servlet으로 변환시키고, 그 Servlet을 실행하여 요청에 응답

```java
//1. HttpServlet 클래스를 상속
public class HelloServlet extends HttpServlet {
	//2. HTTP 요청 메서드인 Get방식과 Post 방식을 처리하기 위해 doGet()과 doPost()를 오버라이딩
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("get방식으로 호출");
	
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("post방식으로 호출");
	}
}
```

HTTP 요청을 처리하는 doGet( )과 doPost( )메서드가 가지고 있는 파라미터는 **HTTP요청과 응답에 대한 정보**를 모두 가지고 있다.

 `HttpServletRequest` : 클라이언트가 요청할 때 함께 전송한 데이터를 가지고 있다.

 `HttpServletResponse` : 서버에서 클라이언트로 응답할 때 필요한 데이터가 있다. (ex, 클라이언트가 요청한 HTML문서 등)

 <br>

## web.xml기본 설정

브라우저가 Java Servlet에 접근하기 위해서는 WAS(Ex. Tomcat)에 필요한 정보를 알려줘야 해당하는 Servlet을 호출할 수 있다. 이 역할을 web.xml에서 해준다.

- 배포할 Servlet이 무엇인지
- 해당 Servlet이 어떤 url에 매핑되는지

에 대한 정보를 정해진 규칙에 맞게 설정해주면 된다.

```xml
<!--aliases설정 -->
	<servlet>
	<servlet-name>HelloServlet</servlet-name> <!--서블릿 이름을 설정한다. 매핑에서의 Servlet이름과 동일해야 한다.-->
	<servlet-class>sample06.HelloServlet</servlet-class> <!--연결한 Servlet클래스를 입력한다.-->
</servlet>
<!--매핑 -->
<servlet-mapping>

	<servlet-name>HelloServlet</servlet-name> <!--위에서 지정한 이름과 같아야 한다.-->
	<url-pattern>/hello</url-pattern> <!--매핑될 URL을 지정해준다.-->
</servlet-mapping>
```

- Servlet에 `@WebServlet("/hello")` 와 같이 어노테이션을 지정하면, web.xml에 직접 매핑할 필요가 없다.

<br>

## HTML

`method=" "` : 사용할 HTTP메서드 지정

`action=" "` : form을 처리할 서버쪽 url 지정

```html
<form action="location" method="get">
	<input type="text" name="name"> 
	<input type="submit" value="get방식"> <!--버튼을 누르면 사용자가 입력한 인자들이 Servlet으로 넘어간다.-->
</form>

<form action="location" method="post">
	<input type="text" name="name">
	<input type="submit" value="post방식"> <!-- submit버튼-->
</form>
```

클라이언트가 서버로 요청을 보내는 방법인 HTTP Method에는 크게 2가지 방식이 있다.

1. **getMethod**
    - URL에 데이터를 포함시켜 요청한다. 데이터가 Header(헤더)에 포함된다.
    - 입력한 데이터가 URL뒤에 문자열로 추가되기 때문에, 민감한 정보가 있는 경우 사용하지 않는 것이 좋다. 예) `http://www.url.com/location?name=성춘향`
    - Default Method로, HTTP메서드를 지정하지 않으면 getMethod를 호출한다.
    - 전송하는 길이에 제한이 있기때문에 간단한 데이터를 URL에 넣어서 전송하는데에 사용된다.
2. **postMethod**
    - URL에 데이터를 노출하지 않고 요청한다. 데이터가 Body(바디)에 포함된다.
    - URL에 직접적으로 data가 노출되지 않기때문에 getMethod보다 보안상으로 조금 더 안전하다.
    - 메세지가 Body에 포함되어 있어 길이의 제한이 없고, URL형식에 맞춘 필요가 없기때문에 객체들의 값도 전송이 가능하다.

### servlet에 HTML코드 넣기

```java
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("HelloServlet doGet");
	
		createHTML("GET방식", req, resp);		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("HelloServlet doPost");
		
		createHTML("POST방식", req, resp);		
	}	
	
	public void createHTML(String methodType, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		
		String name = req.getParameter("name");
		System.out.println("name:" + name);
		
		//HTTP응답 헤더를 작성
		//PrintWriter위에 작성해야 한다.
		resp.setContentType("text/html; charset=utf-8");
		
		//브라우저에 출력할 메시지
		PrintWriter pw = resp.getWriter();
		
		pw.println("<html>");
		pw.println("<head>");
		pw.println("<title>제목</title>");
		pw.println("</head>");
		
		pw.println("<body>");
		
		pw.println("<h1>Hello Servlet</h1>");
		pw.println("<p>" + methodType + "</p>");
		
		pw.println("<h3>name:" + name + "</h3>");
				
		pw.println("</body>");
		
		pw.println("</html>");		
		
		pw.close();
		
	}

}
```

이와 같이 Servlet을 통해 브라우저에 나타낼 화면을 입력할 경우, pw.println()을 하나씩 입력해줘야 하고, 자동완성도 사용할 수 없다..! 이처럼 Servlet으로 응답 페이지를 보여주는 것은 비효율적이기 때문에, HTML 문서에 Java 코드를 넣을 수 있는 **JSP(JAVA Server Page)**를 이용한다. 모든 요청은 Servlet으로 받고 클라이언트에게 보여줄 View는 JSP로 작성하는 것! (JSP는 MVC패턴에서 View에 해당한다)

<br>

## Redirect와 forward

현재 작업중인 페이지에서 다른 페이지로 이동하기 위한 페이지 전환 기능

1. **Rediret방식**
    - 외부 내부 상관없이 이동할 수 있다(다른 도메인 주소로도 이동이 가능)
    - 웹 브라우저는 URL을 지시된 주소로 바꾸고 그 주소로 이동한다. 새로운 페이지에서는 request, response객체가 새롭게 생성된다.
    - 구현

        HttpServletRequest객체에서 제공하는 sendRedirect( )메서드 호출한다.

        ```java
        resp.sendRedirect("result");
        ```

2. **forward방식**
    - 동일한 web container 내부에서만 이동이 가능하다.
    - request, response객체를 모두 다 전달하기 때문에 이동된 페이지(서블릿)에서도 request와 response객체를 파리미터로 받아서 처리할 수 있다.
    - 요청을 처리하다가 추가적인 처리를 같은 웹 어플리케이션 안에 있는 다른 서블릿이나 JSP에 위임하여 처리하는 경우 자주 사용
    - 구현

        RequestDispatcher객체를 생성한 후, 디스패처 객체에서 제공하는 forward()메서드를 호출해야 한다.

        디스팩처 객체를 생성하기 위해서는 HttpServletRequest 객체에서 제공하는 getRequestDispatcher( ) 팩토리 메소드를 이용해 디스패처 객체를 리턴 받을 수 있다.

        ```java
        RequestDispatcher dispatcher = req.getRequestDispatcher("/result"); 
        //web.xml에 지정한 서블릿이름(<servlet-namte>)으로 지정하거나, 경로를 지정한다.
        dispatcher.forward(req, resp);
        ```

        ```java
        req.getRequestDispatcher("result").forward(req,resp);
        ```

시스템(session, DB)에 변화가 생기는 요청(로그인, 회원가입, 글쓰기)의 경우 redirect방식으로 응답하는 것이 바람직하며, 시스템에 변화가 생기지 않는 단순 조회(리스트보기, 검색)의 경우 forward방식으로 응답하는 것이 바람직하다.

### 참고

[https://victorydntmd.tistory.com/148](https://victorydntmd.tistory.com/148)

[https://mangkyu.tistory.com/14](https://mangkyu.tistory.com/14)

[https://gmlwjd9405.github.io/2018/10/29/web-application-structure.html](https://gmlwjd9405.github.io/2018/10/29/web-application-structure.html)

[https://doublesprogramming.tistory.com/63](https://doublesprogramming.tistory.com/63)