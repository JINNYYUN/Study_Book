package main;

import db.DBConnection;
import jdbc.DeleteTest;

public class mainClass {
	public static void main(String[] args) {
		DBConnection.initConnection();
		
		DeleteTest ut = new DeleteTest();
		
		String id = "abc";
		
		boolean b = ut.Delete(id);
		if(b == true) {
			System.out.println("정상적으로 수정되었습니다.");
		}
	}
}
