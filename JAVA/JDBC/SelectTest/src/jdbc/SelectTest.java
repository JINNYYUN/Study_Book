package jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.UserDto;

public class SelectTest {
	// 1개의 Data를 취득하는 방법 1
	public UserDto search(String id) {
		String sql = "SELECT ID, NAME, AGE, JOINDATE"
				+ " FROM USERTEST"
				+ " WHERE ID = '"+ id + "' ";
		System.out.println("sql:" +sql);
		
		Connection conn = DBConnection.getConnection();
		Statement stmt = null;
		
		//ResulSet은 executeQuery() 메소드에서 실행된 select 문의 결과값을 가지고 있는 객체
		ResultSet rs = null;
		UserDto dto = null;
		
		try {
			//Statement 객체를 생성하려면 Connection 객체가 제공하는 createStatement( ) 메소드를 사용 > preparedStatdment도 있음
			stmt = conn.createStatement();
			
			//executeQuery( ) 메소드가 반환하는 ResultSet은 select한 결과값을을 가지고 있다.
			rs = stmt.executeQuery(sql);
			
			
			//next()다음에 레코드가 있는지 판단하여 없으면 false, 있으면 true를 반환하 다음에 커서를 다음 레코드로 이동
			if(rs.next()) { //데이터가 있는 경우
				String _id = rs.getString("ID"); //USERTEST 테이블에 있는 컬럼 명
				String _name = rs.getString("name");
				int _age = rs.getInt("age");
				String _joindate = rs.getString("joindate");
				
				dto = new UserDto(_id, _name, _age, _joindate);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(stmt, conn, rs);
		}
		
		return dto;
	}
	
	// 1개의 Data를 취득하는 방법 2
	public UserDto select(String id) {
		String sql = "SELECT ID, NAME, AGE, JOINDATE"
				+ " FROM USERTEST"
				+ " WHERE ID = ? ";
		System.out.println("sql:" +sql);
		
		Connection conn = DBConnection.getConnection();
		//
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		UserDto dto = null;
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);	//query에서 ?부분에 해당하는 Data
			
			rs=psmt.executeQuery();
			
			if(rs.next()) {
				dto = new UserDto();
				
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setAge(rs.getInt("age"));
				dto.setJoindate(rs.getString("joindate"));
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return dto;
	}
	
	//다수의 Data 취득
	public List<UserDto> getUserList(){
		String sql = "SELECT ID, NAME, AGE, JOINDATE"
				+ " FROM USERTEST";
		
		Connection conn = DBConnection.getConnection();
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<UserDto> list = new ArrayList<UserDto>();
		
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			//데이터가 있는지 확인하고 계속해서 반복한다.
			while(rs.next()) {
				String id = rs.getString("id");
				String name = rs.getString("name");
				int age = rs.getInt("age");
				String joindate = rs.getString("joindate");
				
				UserDto dto = new UserDto(id, name, age, joindate);
				
				//list뒤에 추가하자!
				list.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return list;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
