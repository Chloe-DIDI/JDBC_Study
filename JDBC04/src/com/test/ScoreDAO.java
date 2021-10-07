/*============================================================
   ScoreDAO.java
   
--	sql모든 쿼리문은 DAO에 있다
==============================================================*/

package com.test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.util.DBConn;

public class ScoreDAO
{ // 주요 속성 구성
	private Connection conn; // DB연결

	// 데이터베이스 연결 담당 메소드
	public Connection connection() throws ClassNotFoundException, SQLException
	{
		conn = DBConn.getConnection();
		return conn;
	}

	// 데이터 입력 담당 메소드
	public int add(ScoreDTO dto) throws SQLException
	{
		int result = 0;
		Statement stmt = conn.createStatement();
		String sql = String.format(
				"INSERT INTO TBL_SCORE(SID, NAME, KOR, ENG, MAT) VALUES(SCORESEQ.NEXTVAL, '%s', %d, %d, %d)",
				// INSERT INTO TBL_SCORE(SID, NAME, KOR, ENG, MAT)VALUES(SCORESEQ.NEXTVAL,
				// '홍길동', 90, 80, 70);
				dto.getName(), dto.getKor(), dto.getEng(), dto.getMat());
		result = stmt.executeUpdate(sql);
		stmt.close();
		return result;
	}

	// 전체 리스트 출력 담당 메소드 여러명을 반환해야하기때문에 『LISTS』
	public ArrayList<ScoreDTO> lists() throws SQLException // 입력으로 받기 때문에 넘겨줄 매개변수 없음
	{
		ArrayList<ScoreDTO> result = new ArrayList<ScoreDTO>();
		// 작업객체 생성
		Statement stmt = conn.createStatement();
		String sql = "SELECT SID, NAME, KOR, ENG, MAT" // 개행 할 때 주의
						+ ", (KOR+ENG+MAT) AS TOT" 
						+ ", (KOR+ENG+MAT)/3 AS AVG"
						+ ", RANK() OVER(ORDER BY (KOR+ENG+MAT) DESC) AS RANK" 
						+ " FROM TBL_SCORE" 
						+ " ORDER BY SID ASC";
		ResultSet rs = stmt.executeQuery(sql);
		while (rs.next())
		{
			ScoreDTO dto = new ScoreDTO();
			dto.setSid(rs.getString("SID"));
			dto.setName(rs.getString("NAME"));
			dto.setKor(rs.getInt("KOR"));
			dto.setEng(rs.getInt("ENG"));
			dto.setMat(rs.getInt("MAT"));
			dto.setTot(rs.getInt("TOT"));
			dto.setAvg(rs.getDouble("AVG"));
			dto.setRank(rs.getInt("RANK"));

			result.add(dto); // 반복이 끝나기 전에 Arraylist를 집어 넣는다
		}
		rs.close();
		stmt.close();

		return result;
	}
//////////////////////////////////////////2021-09-29 수업 끝/////////////////////////////////////////////////////
	// 이름 검색 담당 메소드 오버로딩!!											 // <-> 오버라이딩은 생성
	public ArrayList<ScoreDTO> lists(String name) throws SQLException
	{
		ArrayList<ScoreDTO> result = new ArrayList<ScoreDTO>();
		Statement stmt = conn.createStatement();
		String sql = String.format("SELECT *" 
					+ " FROM (SELECT SID, NAME, KOR, ENG, MAT" 
					+ ", (KOR+ENG+MAT) AS TOT"
					+ ", (KOR+ENG+MAT)/3 AS AVG" 
					+ ", RANK() OVER(ORDER BY (KOR+ENG+MAT) DESC) AS RANK" 
					+ " FROM TBL_SCORE)"
					+ " WHERE NAME='%s'", name);
		ResultSet rs = stmt.executeQuery(sql);
		while (rs.next())	//score DTO객체 생성
		{
			ScoreDTO dto = new ScoreDTO();	//제일 먼저 DTO에 대한 객체 생성
			dto.setSid(rs.getString("SID"));
			dto.setName(rs.getString("NAME"));
			dto.setKor(rs.getInt("KOR"));
			dto.setEng(rs.getInt("ENG"));
			dto.setMat(rs.getInt("MAT"));
			dto.setTot(rs.getInt("TOT"));
			dto.setAvg(rs.getDouble("AVG"));
			dto.setRank(rs.getInt("RANK"));

			result.add(dto);
		}
		rs.close();//result소스 반환
		stmt.close();//statement 소스 반환

		return result;
	}//end lists(String name)

	// 번호 검색 담당 메소드
	public ArrayList<ScoreDTO> lists(int sid) throws SQLException	//메소드 오버로딩: 클래스 내에 같은 이름의 메소드를 여러개 선언 
																	//번호검색을 하면 한명의 학생 정보가 보여지겠지만 전체를 담아???
																	//『ArrayList<ScoreDTO>』
	{
		ArrayList<ScoreDTO> result = new ArrayList<ScoreDTO>();
		Statement stmt = conn.createStatement();
		String sql = String.format("SELECT *" 
							+ " FROM (SELECT SID, NAME, KOR, ENG, MAT" 
				+ ", (KOR+ENG+MAT) AS TOT"
				+ ", (KOR+ENG+MAT)/3 AS AVG" 
				+ ", RANK() OVER(ORDER BY (KOR+ENG+MAT) DESC) AS RANK" 
				+ " FROM TBL_SCORE)"
				+ " WHERE SID=%d", sid);
		ResultSet rs = stmt.executeQuery(sql);
		while (rs.next())
		{
			ScoreDTO dto = new ScoreDTO();
			dto.setSid(rs.getString("SID"));
			dto.setName(rs.getString("NAME"));
			dto.setKor(rs.getInt("KOR"));
			dto.setEng(rs.getInt("ENG"));
			dto.setMat(rs.getInt("MAT"));
			dto.setTot(rs.getInt("TOT"));
			dto.setAvg(rs.getDouble("AVG"));
			dto.setRank(rs.getInt("RANK"));

			result.add(dto);
		}
		rs.close();
		stmt.close();

		return result;

	}//end lists(int sid)

	// 인원 수 확인 담당 메소드
	public int count() throws SQLException	//int[인원수] 넘겨 받을 거 매개변수 없음  
	{
		int result = 0;
		Statement stmt = conn.createStatement();
		String sql = "SELECT COUNT(*) AS COUNT FROM TBL_SCORE";
		ResultSet rs = stmt.executeQuery(sql);
		while (rs.next())							//==>>if (rs.next())
			result = rs.getInt("COUNT");			//==>>rs.getInt(1)
		rs.close();
		stmt.close();

		return result;
	}

	// 데이터 수정 담당 메소드 [modify]
	public int modify(ScoreDTO dto) throws SQLException	//『int sid를 넘기기때문에』
														// 매개변수는 행 전체를 이름 영어 국어 수학을 수정 『ScoreDTO dto』(★)check!!
	{
		int result = 0;
		Statement stmt = conn.createStatement();
		String sql = String.format("UPDATE TBL_SCORE" + " SET NAME='%s', KOR=%d, ENG=%d, MAT=%d WHERE SID=%s",//sid는 넘버형태,set name은 『''』로 구성
				dto.getName(), dto.getKor(), dto.getEng(), dto.getMat(), dto.getSid());
		result = stmt.executeUpdate(sql);
		stmt.close();
			//result set은 안씀!
		return result;

	}

	// 데이터 삭제 담당 메소드
	public int remove(int sid) throws SQLException
	{
		int result = 0;
		Statement stmt = conn.createStatement();
		String sql = String.format("DELETE FROM TBL_SCORE WHERE SID=%d", sid);
		result = stmt.executeUpdate(sql);
		stmt.close();

		return result;
	}

	// 데이터베이스 연결 종료 담당 메소드
	public void close() throws SQLException
	{
		DBConn.close();
	}

}