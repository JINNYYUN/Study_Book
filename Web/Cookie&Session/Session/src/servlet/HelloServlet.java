package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/hello")
public class HelloServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=utf-8");
		
		PrintWriter pw = resp.getWriter();
		
		pw.println("<html>");
		pw.println("<head>");
		pw.println("<title>제목</title>");
		pw.println("</head>");
		
		pw.println("<body>");

		HttpSession session = req.getSession(false);
		/*
		  	getSession(false);
		  	session Object가 존재하면, 현재 HttpSession을 반환한다.
		  	존재하지 않으면, null을 반환한다.
		  	
		  	getSession(true)
		  	session Object가 존재하면, 현재 HttpSession을 반환한다.
		  	존재하지 않으면 새로 생성한다.
		  	디폴트 값
		 */
		
		if(session == null) {
			session = req.getSession(true);	//저장이 되어 있는 부분
			session.setMaxInactiveInterval(30); //365*24*60*60 세션 시간 설정
			session.setAttribute("visited", "1"); //세션의 속성 설정
			pw.println("<p>첫번째 방문입니다</p>");
		}
		else {	//세션이 있으면
			String visited = (String)session.getAttribute("visited"); //return 값이 Object이다.
			int count = Integer.parseInt(visited);
			
			count++;
			
			pw.println("<p>"+count+"번 째 방문입니다</p>");
			session.setAttribute(visited, count+"");
		}
		
	//	pw.println("<a href='dispCookie'>Cookie를 표시</a>");
		
		pw.println("</body>");
		pw.println("</html>");
		
		pw.close();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}

}
