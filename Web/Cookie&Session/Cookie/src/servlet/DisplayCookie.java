package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/dispCookie")
public class DisplayCookie extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=utf-8");
		
		PrintWriter pw = resp.getWriter();
		
		pw.println("<html>");
		pw.println("<head>");
		pw.println("<title>제목</title>");
		pw.println("</head>");
		
		pw.println("<body>");

			Cookie cookies[] = req.getCookies();
			
			if(cookies != null) {
				for(int i=0; i<cookies.length; i++) {
					String cookieName = cookies[i].getName();
					String value = cookies[i].getValue();
					
					pw.println("<p>"+cookieName + ":" +value+"</p>");
				}
			}
			pw.println("<a href='visitedCookie'>방문회수 확인하기</a>");
			
		pw.println("</body>");
		pw.println("</html>");
		
		pw.close();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
}
