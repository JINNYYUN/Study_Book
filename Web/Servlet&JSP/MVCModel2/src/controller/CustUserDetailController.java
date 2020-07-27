package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CustUserDao;
import dto.CustUserDto;

@WebServlet("/detail")
public class CustUserDetailController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String work = req.getParameter("work");
		String id = req.getParameter("id");
		
		CustUserDao dao = CustUserDao.getInstance();
		
		CustUserDto cdto = dao.searchCustUser(id);
		
		req.setAttribute("userDetail", cdto); //객체 챙기고 세팅
		
		if(work.equals("detailView")) {
			forward("custuserdetail.jsp", req, resp); //이동
		}else if(work.equals("userUpdate")) {
			forward("custuserupdate.jsp", req, resp); //이동
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
	public void forward(String link, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dis = req.getRequestDispatcher(link);
		dis.forward(req, resp);
	}
}
