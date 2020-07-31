package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;

public class MemberDao {
	private static MemberDao dao = new MemberDao();
	
	private MemberDao() {
		DBConnection.initConnection();
	}
	public static MemberDao getInstance() {
		return dao;
	}
	
	//
	public boolean getEmail(String email) {
	//	email 확인 -> true/false 
		String sql = " SELECT EMAIL FROM MEMBER "
				+ " WHERE EMAIL=? ";
	//	String sql = " SELECT COUNT(*) FROM MEMBER "	// 이렇게 할 수도 있음
	//				+ " WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		boolean findemail = false;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getId success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getId success");
			
			psmt.setString(1, email.trim());
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getId success");
			
			if(rs.next()) {		// 찾았다
				findemail = true;
			}			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getEmail fail");
		}finally {
			DBClose.close(psmt, conn, rs);			
		}
			
		return findemail;
	}
	
	public boolean addMember(MemberDto dto) {
		// 회원가입의 데이터 -> DB
		String sql = " INSERT INTO MEMBER "
				+ "	(EMAIL, PWD, NAME, AUTH) "
				+ " VALUES(?, ?, ?, 3) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 addMember success");
				
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 addMember success");
			
			psmt.setString(1, dto.getEmail());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			
			count = psmt.executeUpdate();
			System.out.println("3/6 addMember success");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("addMember fail");
		} finally {
			DBClose.close(psmt, conn, null);			
		}
		
		return count>0?true:false;
	}
	
	public MemberDto login(String email, String pwd) {
		String sql = " SELECT EMAIL, NAME, AUTH"
					+ " FROM MEMBER "
					+ " WHERE EMAIL=? AND PWD=?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 login success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			psmt.setString(2, pwd);
			System.out.println("2/6 login success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 login success");
			
			if(rs.next()) {
				String user_email = rs.getString(1);
				String name = rs.getString(2);
				int auth = rs.getInt(3);
				
				dto = new MemberDto(user_email, null, name, auth);
			}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("login fail");
		}finally {
			
		}
		
		return dto;
	}
}
