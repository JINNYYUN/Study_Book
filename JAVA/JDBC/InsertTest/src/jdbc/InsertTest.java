package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import db.DBClose;
import db.DBConnection;

public class InsertTest {
	public InsertTest(){
		/*try {
			//Class.forName()을 이용해서 드라이버 로드 > 객체 생성
			Class.forName("oracle.jdbc.driver.OracleDriver"); //forName() : 클래스의 유뮤를 파악하는 함수
			
			System.out.println("Driver Loading Success");
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} */
		
	}
	/*
	public Connection getConnection() {
		Connection conn = null;
		
		try {
			//DBMS 서버 접속
			conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.7.62:1521:xe", "hr", "hr");
			
			System.out.println("Oracle Connection Success!");
		} catch(SQLException e) {
			e.printStackTrace();
		}
		 
		return conn;
	}*/
	
	/*db에 데이터를 넣는다.*/
	public int insertData(String id, String name, int age) {
		
		//Query -> String
		String sql = " INSERT INTO USERTEST(ID, NAME, AGE, JOINDATE)"
					+ " VALUES('"+id + "','" + name + "',"+ age + ", SYSDATE)";
		
		System.out.println("sql:" + sql);
		
		/**/
		//Connection conn = this.getConnection();
		Connection conn = DBConnection.getConnection();
		Statement stat = null;
		
		int count = 0;	//몇 개가 변경되었는지 확인

		//현재 상태를 얻어온다.
		try {
			stat = conn.createStatement();
			
			//SQL문을 실행하기 위해 Statement 객체에서 제공되는 메소드
			count = stat.executeUpdate(sql);
			
			System.out.println("성공적으로 추가 되었습니다.");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("데이터가 추가되지 않았습니다.");
		} finally {
			DBClose.close(stat, conn, null);
		}		
		return count;
	}
}