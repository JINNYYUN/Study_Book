package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/hello")
public class HelloServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//쿠키 생성
		//javax.servlet.http.cookie 객체를 생성
		//Cookie cookie = new Cookie("쿠키이름","쿠키값");
		Cookie cookie = new Cookie("id", "abc123"); //쿠키는 한쌍으로 관리 됨
		
		//생성된 쿠키를 클라이언트로 전송
		resp.addCookie(cookie); //HttpServletResponse 객체의 addCookie( )메소드를 이용
		
		cookie = new Cookie("pwd", "aaaa1111");
		resp.addCookie(cookie);
		
		resp.setContentType("text/html; charset=utf-8");
		
		PrintWriter pw = resp.getWriter();
		
		pw.println("<html>");
		pw.println("<head>");
		pw.println("<title>제목</title>");
		pw.println("</head>");
		
		pw.println("<body>");

		pw.println("<a href='dispCookie'>Cookie를 표시</a>");
		
		pw.println("</body>");
		pw.println("</html>");
		
		pw.close();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, resp);
	}
	
}
