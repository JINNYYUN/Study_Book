package main;

import java.util.List;

import db.DBConnection;
import dto.UserDto;
import jdbc.SelectTest;

public class mainClass {
	public static void main(String[] args) {
		DBConnection.initConnection();
		
		SelectTest st = new SelectTest();
		/*
		String id = "abc";
		UserDto dto = st.search(id);
		if(dto != null) {
			System.out.println(dto.toString());
		}
		else {
			System.out.println("등록되어 있지 않은 id입니다.");
		}
		
		id = "bcd";
		dto = st.select(id);
		
		if(dto != null) {
			System.out.println(dto.toString());
		}
		else {
			System.out.println("등록되어 있지 않은 id입니다.");
		}
		*/
		List<UserDto> list = st.getUserList();
		for (UserDto user : list) {
			System.out.println(user.toString());
		}
	}
}
