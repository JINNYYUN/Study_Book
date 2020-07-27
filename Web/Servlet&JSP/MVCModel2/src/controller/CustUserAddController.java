package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CustUserDao;
import dto.CustUserDto;

@WebServlet("/adduser")
public class CustUserAddController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String work = req.getParameter("work");
		
		if(work.equals("addView")) {
			resp.sendRedirect("custuseradd.jsp"); //페이지 이동만 하니깐, Redirect방식
		}
		else if(work.equals("other")) {
			
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String work = req.getParameter("work");
		if(work.equals("dataSave")) {
			String id = req.getParameter("id");
			String name = req.getParameter("name");
			String address = req.getParameter("address");
			
			System.out.println("id: "+id + "name: "+name + "address: "+address);
			
			//DB insert
			CustUserDao dao = CustUserDao.getInstance();
			dao.addCustUser(new CustUserDto(id, name, address));
			
			//list로 이동
			resp.sendRedirect("list");
		}
	}

}
