package sample06;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.ObjectDto;

public class HelloServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		String sAge = req.getParameter("age"); //문자로 넘어 옴
		
		System.out.println("name: "+ name);
		System.out.println("Age: "+ sAge);
		
		int age=0;
		if(sAge==null || sAge.trim().equals("")) {
			resp.sendRedirect("index.hrml");
		}else {
			age=Integer.parseInt(sAge);
		}
		
		String fruits[] = req.getParameterValues("fruit");
		
		for (int i = 0; i < fruits.length; i++) {
			System.out.println(fruits[i]);
		}

		
		/*ResultServlet으로 이동*/
		/*방법 1. Redirect방식*/
	//	resp.sendRedirect("result");

		
		/*방법2. forward방식*/
		//데이터 모으기
		ObjectDto dto = new ObjectDto(name, age, fruits);
		
		req.setAttribute("myfruit", dto);
		
		req.getRequestDispatcher("result").forward(req,resp);
		
		/*snedRedirect*/
	//	resp.sendRedirect("result?name=" + name + "&age=" +age+"&fruit="+fruits[]);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	}
	
}
