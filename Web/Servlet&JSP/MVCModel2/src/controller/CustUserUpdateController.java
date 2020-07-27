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

@WebServlet("/update")
public class CustUserUpdateController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		String name = req.getParameter("name");
		String address = req.getParameter("address");
		
		System.out.println("id: "+id + "name: "+name + "address: "+address);
		
		//DB insert
		CustUserDao dao = CustUserDao.getInstance();
		boolean updateCheck = dao.updateCustUser(new CustUserDto(id, name, address));
		
		CustUserDto cdto = dao.searchCustUser(id);
		req.setAttribute("userDetail", cdto); //객체 챙기고 세팅
		
		if(updateCheck==true) {
			forward("custuserdetail.jsp", req, resp);
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
