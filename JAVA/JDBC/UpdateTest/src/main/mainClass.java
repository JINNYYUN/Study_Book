package main;

import db.DBConnection;
import jdbc.UpdateTest;

public class mainClass {
	public static void main(String[] args) {
		DBConnection.initConnection();
		
		UpdateTest ut = new UpdateTest();
		
		String id = "abc";
		int age = 23;
		
		boolean b = ut.Update(id, age);
		if(b == true) {
			System.out.println("정상적으로 수정되었습니다.");
		}
	}
}
