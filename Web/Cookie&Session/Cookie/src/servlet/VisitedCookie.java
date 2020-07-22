package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/visitedCookie")
public class VisitedCookie extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("text/html; charset=utf-8");
		
		PrintWriter pw = resp.getWriter();
		
		pw.println("<html>");
		pw.println("<head>");
		pw.println("<title>제목</title>");
		pw.println("</head>");
		
		pw.println("<body>");

		pw.println("<p>방문회수</p>");
		
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
		
		pw.println("</body>");
		pw.println("</html>");
		
		pw.close();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}

}
