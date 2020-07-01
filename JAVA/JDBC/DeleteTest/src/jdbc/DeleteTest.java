package jdbc;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import db.DBClose;
import db.DBConnection;

public class DeleteTest {
	public boolean Delete(String id) {
		String sql = " DELETE FROM USERTEST "
				+ " WHERE ID = '" + id +"' ";
		System.out.println("sql:" + sql);
		
		Connection conn = DBConnection.getConnection();
		Statement stmt = null;
		
		int count = 0;
		
		try {
			/*Statement 객체를 생성하려면 Connection 객체가 제공하는 createStatement( ) 메소드를 사용*/
			stmt = conn.createStatement();
			
			//executeUpdate( ) 메소드가 반환하는 숫자값은 SQL문이 실행된(update,delete,insert) 후 영양받은 레코드의 개수
			count = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(stmt, conn, null);
		}
		
		return count>0 ? true : false;
	}
}
