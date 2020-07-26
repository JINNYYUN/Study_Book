package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.CustUserDto;

public class CustUserDao {
	
	private static CustUserDao dao = new CustUserDao();
	
	public CustUserDao() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("OracleDriver load Success");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static CustUserDao getInstance() {
		return dao;
	}
	
	public List<CustUserDto> getCustUserList(){
		String sql = "SELECT ID, NAME, ADDRESS"
					+ " FROM  CUSTUSER"
					+ " ORDER BY ID DESC";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CustUserDto> list = new ArrayList<CustUserDto>();
		
		try {
			conn= this.getConnection();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				String id = rs.getString("ID");
				String name = rs.getString("name");
				String address = rs.getString("ADDRESS");
				
				list.add(new CustUserDto(id, name, address));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			this.close(conn, psmt, rs);
		}
		
		return list;
	}
	
	public boolean addCustUser(CustUserDto dto) {
		String sql = "INSERT INTO CUSTUSER(ID, NAME, ADDRESS)"
					+ " VALUES(?,?,?)";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = this.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getAddress());
			
			count=psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(conn,psmt,null);
		}
		
		return count>0?true : false;
	}
	
	
	public CustUserDto searchCustUser(String id) {
		String sql = "SELECT ID, NAME, ADDRESS"
					+ " FROM CUSTUSER"
					+ " WHERE ID=?";	
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		CustUserDto cdto = null;
		
		try {
			conn = this.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			
			rs=psmt.executeQuery();
			
			if(rs.next()) {
				String _id = rs.getString(1);	// ID
				String _name = rs.getString(2);	// NAME
				String _address = rs.getString(3);// ADDRESS
				
				cdto = new CustUserDto(_id, _name, _address);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(conn,psmt,rs);
		}
		
		return cdto;
	}
	
	public boolean updateCustUser(CustUserDto dto) {
		String sql = "UPDATE CUSTUSER"
				+ "	SET ADDRESS=?"
				+ " WHERE ID = ?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = this.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getAddress());
			psmt.setString(2, dto.getId());
			
			count=psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(conn, psmt, null);
		}
		
		return count>0? true: false;
	}
	/*
	public boolean deleteCustUser(String id) {
		String sql = "DELETE "
				+ "	FROM CUSTUSER"
				+ " WHERE ID = ?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = this.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			
			count=psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(conn, psmt, null);
		}
		
		return count>0? true: false;
	}*/
	
	public boolean deleteCustUsers(String ids[]) {
		String sql = "DELETE "
				+ "	FROM CUSTUSER"
				+ " WHERE ID = ?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count[] = new int[ids.length];
		
		try {
			conn=getConnection();
			conn.setAutoCommit(false); //이클립스의 autoCommit기능을 해지한다.
			
			psmt = conn.prepareStatement(sql);
			
			for(int i=0; i <ids.length; i++) {
				psmt.setString(1, ids[i]);
				
				psmt.addBatch(); //한번에 배치하기 위해 쿼리 문을 쌓아두는 것	
			}
			
			count = psmt.executeBatch(); //한 번에 처리한다.
			
			conn.commit();
			
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}finally {
				try {
					conn.setAutoCommit(true);
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				close(conn,psmt, null);
			}
		}
		
		boolean isS = true;
		for(int i = 0; i<count.length; i++) {
			if(count[i] !=-2) {	//-1=정상종료
				isS = false;
				break;
			}
		}
		return isS;
	}
	
	
	public Connection getConnection() throws SQLException  {
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "hr";
		String password = "hr";
		
		Connection conn = DriverManager.getConnection(url, user, password);
		
		return conn;
	}
	
	public void close(Connection conn, PreparedStatement psmt, ResultSet rs) {
		try {
			if(conn!=null) {
				conn.close();
			}
			if(psmt!=null) {
				psmt.close();
			}
			if(rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}		
	}
}
