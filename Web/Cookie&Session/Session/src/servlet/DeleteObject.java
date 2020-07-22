package servlet;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/delObj")
public class DeleteObject extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		//세션은 살아있고, 안에 있는 object들만 삭제 됨
		session.removeAttribute("name");
		
		//키 값을 몰라도 답을 전부 가져올 수 있음
		Enumeration<String> enum_session = session.getAttributeNames();
		while(enum_session.hasMoreElements()) {
			String key = enum_session.nextElement();
			String value = (String)session.getAttribute(key);
		
			System.out.println(key + ":" + value);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
}
