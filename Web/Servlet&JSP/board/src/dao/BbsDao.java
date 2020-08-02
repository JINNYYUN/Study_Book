package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.BbsDto;

public class BbsDao {
	private static BbsDao dao = new BbsDao();
	
	private BbsDao() {
		DBConnection.initConnection();
	}
	
	public static BbsDao getInstance() {
		return dao;
	}
	
	public List<BbsDto> getBbsList(){
		String sql = " SELECT SEQ, EMAIL, REF, STEP, DEPTH,"
					+ " TITLE, CONTENT, WDATE,"
					+ " DEL, READCOUNT"
					+ " FROM BBS"
					+ " ORDER BY REF DESC, STEP ASC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getBbsList success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getBbsList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getBbsList success");
			
			while(rs.next()) {
			//	int i = 1;
				BbsDto dto = new BbsDto(rs.getInt(1), 
										rs.getString(2), 
										rs.getInt(3), 
										rs.getInt(4), 
										rs.getInt(5), 
										rs.getString(6), 
										rs.getString(7), 
										rs.getString(8), 
										rs.getInt(9), 
										rs.getInt(10));
				list.add(dto);
			}
			System.out.println("4/6 getBbsList sucess");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	public boolean writeBbs(BbsDto dto) {
		String sql = " INSERT INTO BBS "
				+ " (SEQ, EMAIL, REF, STEP, DEPTH, "
				+ " TITLE, CONTENT, WDATE, "
				+ " DEL, READCOUNT) "
				+ " VALUES( SEQ_BBS.NEXTVAL, ?, "
						+ "	(SELECT NVL(MAX(REF), 0)+1  FROM BBS), 0, 0, "
						+ " ?, ?, SYSDATE, "
						+ " 0, 0) "; 
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 writeBbs success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getEmail());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			System.out.println("2/6 writeBbs success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 writeBbs success");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0? true:false;
	}
	
	
	public BbsDto getBbs(int seq) {
		String sql = " SELECT SEQ, EMAIL, REF, STEP, DEPTH, "
				+ " TITLE, CONTENT, WDATE,"
				+ " DEL, READCOUNT "
				+ " FROM BBS "
				+ " WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		BbsDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getBbs success");
		
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getBbs success");
			
			psmt.setInt(1, seq);
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getBbs success");
			
			if(rs.next()) {
				int i = 1;
				dto = new BbsDto(rs.getInt(i++), 
								rs.getString(i++), 
								rs.getInt(i++), 
								rs.getInt(i++), 
								rs.getInt(i++), 
								rs.getString(i++), 
								rs.getString(i++), 
								rs.getString(i++), 
								rs.getInt(i++), 
								rs.getInt(i++));
			}
			System.out.println("4/6 getBbs success");
			
		} catch (Exception e) {
			System.out.println("getBbs fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);			
		}
		return dto;
	}
	
	public void readcount(int seq) {
		String sql = "  UPDATE BBS "
				+ "	SET READCOUNT=READCOUNT+1 "
				+ " WHERE SEQ=? ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 readcount success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);			
			System.out.println("2/6 readcount success");
			
			psmt.executeUpdate();
			System.out.println("3/6 readcount success");
			
		} catch (Exception e) {
			System.out.println("readcount fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);			
		}	
	}
	
	public boolean answer(int seq, BbsDto bbs) {
		//update > 새로운 댓글을 작성하면 step이 +1씩 증가하는 것을 세팅한다.
		String updateSql = " UPDATE BBS"
							+ " SET STEP=STEP+1"
							+ " WHERE REF= (SELECT REF FROM BBS WHERE SEQ=?)"
							+ " AND STEP > (SELECT STEP FROM BBS WHERE SEQ=?)";
		
		//insert
		String insertSql = " INSERT INTO BBS"
							+ "	(SEQ, EMAIL, "
							+ " REF, STEP, DEPTH, "
							+ " TITLE, CONTENT, WDATE, DEL, READCOUNT)"
							+ " VALUES(SEQ_BBS.NEXTVAL, ?, "
							+ " (SELECT REF FROM BBS WHERE SEQ=?),"
							+ " (SELECT STEP FROM BBS WHERE SEQ=?)+1,"
							+ " (SELECT DEPTH FROM BBS WHERE SEQ=?)+1,"
							+ " ?, ?, SYSDATE, 0, 0)";
		
		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1/6 answer success");
			
			//update
			psmt = conn.prepareStatement(updateSql);
			psmt.setInt(1, seq);	
			psmt.setInt(2, seq);
			System.out.println("2/6 answer success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 answer success");
			
			//psmt초기화
			psmt.clearParameters();
			
			//insert
			psmt = conn.prepareStatement(insertSql);
			psmt.setString(1, bbs.getEmail());
			psmt.setInt(2, seq);
			psmt.setInt(3, seq);
			psmt.setInt(4, seq);
			psmt.setString(5, bbs.getTitle());
			psmt.setString(6, bbs.getContent());
			System.out.println("4/6 answer success");
			
			count = psmt.executeUpdate();
			System.out.println("5/6 answer success");
			
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			DBClose.close(psmt, conn, null);
			System.out.println("6/6 answer success");
		}
		
		return count>0? true:false;
	}

	
	public List<BbsDto> getBbsList(String searchOption, String searchWord){
	//	String str = "%"+searchWord+"%";
		String sql = " SELECT SEQ, EMAIL, REF, STEP, DEPTH,"
					+ " TITLE, CONTENT, WDATE,"
					+ " DEL, READCOUNT"
					+ " FROM BBS";
		String sqlWord = "";
		if(searchOption.equals("TITLE")) {
			sqlWord = " WHERE TITLE LIKE '%"+searchWord+"%' AND DEL=0";
		}else if (searchOption.equals("CONTENT")) {
			sqlWord = " WHERE CONTENT LIKE '%"+searchWord+"%' AND DEL=0";
		}else if (searchOption.equals("EMAIL")) {
			sqlWord = " WHERE EMAIL LIKE '%"+searchWord+"%' AND DEL=0";
		}
		
		sql = sql + sqlWord;
		
		sql = sql + " ORDER BY REF DESC, STEP ASC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getBbsList success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getBbsList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getBbsList success");
			
			while(rs.next()) {
			//	int i = 1;
				BbsDto dto = new BbsDto(rs.getInt(1), 
										rs.getString(2), 
										rs.getInt(3), 
										rs.getInt(4), 
										rs.getInt(5), 
										rs.getString(6), 
										rs.getString(7), 
										rs.getString(8), 
										rs.getInt(9), 
										rs.getInt(10));
				list.add(dto);
			}
			System.out.println("4/6 getBbsList sucess");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		
		for (BbsDto bbsDto : list) {
			System.out.println(bbsDto.toString());
		}
		
		return list;
	}
	
	/*
	//게시글의 모든 갯수를 확인
	public int getAllBbs() {
		String sql = " SELECT COUNT(*) FROM BBS ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getBbsList success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getBbsList success");
			rs = psmt.executeQuery();
			System.out.println("3/6 getBbsList success");
			if(rs.next()) {
				len = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return len;
	}
	*/
	
	public int getAllBbs(String searchOption, String searchWord) {
		String sql = " SELECT COUNT(*) FROM BBS ";
		
		String sqlWord = "";
		if(searchOption.equals("TITLE")) {
			sqlWord = " WHERE TITLE LIKE '%"+searchWord.trim()+"%' AND DEL=0 ";
		}else if (searchOption.equals("CONTENT")) {
			sqlWord = " WHERE CONTENT LIKE '%"+searchWord.trim()+"%' AND DEL=0 ";
		}else if (searchOption.equals("EMAIL")) {
			sqlWord = " WHERE EMAIL = '"+searchWord.trim()+"' AND DEL=0 ";
		}
		
		sql= sql + sqlWord;
		
		System.out.println(sql);
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getBbsList success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getBbsList success");
			rs = psmt.executeQuery();
			System.out.println("3/6 getBbsList success");
			if(rs.next()) {
				len = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("getAllBbs fail");
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return len;
	}
	
	//결국엔 이 함수를 통해 리스트를 불러온다.
	public List<BbsDto> getBbsPagingList(String searchOption, String searchWord, int page){
		/*
		 	1. row번호
		 	2. 검색
		 	3. 정렬
		 	4. 범위 1~10
		 */
		String sql = " SELECT SEQ, EMAIL, REF, STEP, DEPTH, "
				+ " TITLE, CONTENT, WDATE, "
				+ " DEL, READCOUNT "
				+ " FROM ";
		
		//서브쿼리 문장
		sql += "(SELECT ROW_NUMBER()OVER(ORDER BY REF DESC, STEP ASC) AS RNUM, " + 
				"	SEQ, EMAIL, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, DEL, READCOUNT " + 
				" FROM BBS ";
		
		
		String sqlWord = "";
		if(searchOption.equals("TITLE")) {
			sqlWord = " WHERE TITLE LIKE '%"+searchWord.trim()+"%' AND DEL=0 ";
		}else if (searchOption.equals("CONTENT")) {
			sqlWord = " WHERE CONTENT LIKE '%"+searchWord+"%' AND DEL=0 ";
		}else if (searchOption.equals("EMAIL")) {
			sqlWord = " WHERE EMAIL LIKE '%"+searchWord+"%' AND DEL=0 ";
		}
		
		sql = sql + sqlWord;
		sql = sql + " ORDER BY REF DESC, STEP ASC) ";
		sql = sql + " WHERE RNUM >= ? AND RNUM <= ?";
		
		int start, end;
		start = 1 + 10 * page; //페이지 글의 시작 번호
		end = 10 + 10 * page;	//페이지 글의 마지막 번호
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getBbsList success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/6 getBbsList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getBbsList success");
			
			while(rs.next()) {
			//	int i = 1;
				BbsDto dto = new BbsDto(rs.getInt(1), 
										rs.getString(2), 
										rs.getInt(3), 
										rs.getInt(4), 
										rs.getInt(5), 
										rs.getString(6), 
										rs.getString(7), 
										rs.getString(8), 
										rs.getInt(9), 
										rs.getInt(10));
				list.add(dto);
			}
			System.out.println("4/6 getBbsList sucess");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		/*
		for (BbsDto bbsDto : list) {
			System.out.println(bbsDto.toString());
		}
		*/
		return list;
	}
}
