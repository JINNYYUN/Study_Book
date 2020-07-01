package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static void initConnection() {
		try {
			/*Class.forName()을 이용해서 드라이버 로드 > 객체 생성*/
			Class.forName("oracle.jdbc.driver.OracleDriver"); //forName() : 클래스의 유뮤를 파악하는 함수
			
			System.out.println("Driver Loading Success");
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
	/*어느 클래스에서나 접근이 가능하도록 한다.*/
	public static Connection getConnection() {
		Connection conn = null;
		
		try {
			/*DBMS 서버 접속*/
			conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.7.62:1521:xe", "hr", "hr");
			
			System.out.println("Oracle Connection Success!");
		} catch(SQLException e) {
			e.printStackTrace();
		}
		 
		return conn;
	}
}
