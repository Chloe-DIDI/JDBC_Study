
// ▶ DB 연결
// ▶ 인원 수 확인
// ▶ 데이터 입력 
// ▶ 리스트 전체 조회 (총점, 평균까지)
package com.test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.util.DBConn;

public class ScoreDAO
{
	private Connection conn;
	
	// 생성자 형태로 DB객체 연결
	public ScoreDAO()
	{
		conn = DBConn.getConnection();
	}
	
	// 인원수 확인 메소드
	public int count() throws SQLException
	{
		// 결과값 변수
		int result = 0;
		
		Statement stmt = conn.createStatement();
		
		// 쿼리문 준비
		String sql = "SELECT COUNT(*) AS COUNT FROM TBL_SCORE";
		
		// 쿼리문 실행
		ResultSet rs = stmt.executeQuery(sql);
		
		if(rs.next())
			result = rs.getInt("COUNT");
		
		// 사용한 리소스 반납
		rs.close();
		stmt.close();
		
		return result;
	}
	
	
	// 데이터 입력 메소드
	public int add(ScoreDTO dto) throws SQLException
	{
		int result = 0;
		
		Statement stmt = conn.createStatement();
	
		//쿼리문 준비
		String sql = String.format("INSERT INTO TBL_SCORE(SID, NAME, KOR, ENG, MAT)"
								+ " VALUES(SCORESEQ.NEXTVAL, '%s', %d, %d, %d)"
								, dto.getName(), dto.getKor(), dto.getEng(), dto.getMat());
	
		result = stmt.executeUpdate(sql);
		
		// 리소스 반납
		stmt.close();
		
		return result;		
	
	}//end add()
	
	
	public ArrayList<ScoreDTO> lists() throws SQLException
	{
		ArrayList<ScoreDTO> result = new ArrayList<ScoreDTO>();
		
		Statement stmt = conn.createStatement();
		
		//쿼리문 준비
		String sql = "SELECT SID, NAME, KOR, ENG, MAT"
				 + " FROM TBL_SCORE ORDER BY 1";
	
		ResultSet rs = stmt.executeQuery(sql);
		
		while (rs.next())
		{
			ScoreDTO dto = new ScoreDTO();
			
			dto.setSid(rs.getString(1));
			dto.setName(rs.getString(2));
			dto.setKor(rs.getInt(3));
			dto.setEng(rs.getInt(4));
			dto.setMat(rs.getInt(5));
			
			result.add(dto);
		}
			
		rs.close();
		stmt.close();
		
		return result;
	}
	
	public void close()
	{
		DBConn.close();
	}
	
}
