package main;

import db.DBConnection;
import jdbc.InsertTest;

public class mainClass {
	public static void main(String[] args) {
		DBConnection.initConnection();
		
		InsertTest it = new InsertTest();
		
		int count = it.insertData("asd", "정수동", 26);
		if(count==1) {
			System.out.println("데이터가 추가되었습니다.");
		}
	}
}
