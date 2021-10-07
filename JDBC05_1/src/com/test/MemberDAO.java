package com.test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.util.DBConn;

public class MemberDAO
{
	private Connection conn; //DB연결
	
	// 데이터베이스 연결 담당 메소드
	public Connection connection()
	{
		conn = DBConn.getConnection();
		return conn;
	}
	
	// 직원 데이터 입력 메소드
	public int add(MemberDTO dto) throws SQLException
	{
		int result = 0;
		Statement stmt = conn.createStatement();
		String sql = String.format("INSERT INTO TBL_EMP(EMP_ID, EMP_NAME, SSN, IBSADATE, CITY_ID, TEL, BUSEO_ID, JIKWI_ID, BASICPAY, SUDANG) "
				+ "VALUES (EMPSEQ.NEXTVAL, '%s', '%s', '%s', '%d', '%s', '%d', '%d', '%d', '%d')"
				, dto.getEmp_name(), dto.getSsn(), dto.getIbsadate(), dto.getCity_id(),dto.getTel()
				, dto.getBuseo_id(), dto.getJikwi_id(), dto.getBasicpay(), dto.getSudang());
		result = stmt.executeUpdate(sql);
		stmt.close();
		return result;
	}
	
	//직원 인원수 메소드
	public int memberCount() throws SQLException
	{
		int result = 0;
		
		conn = DBConn.getConnection();
		Statement stmt = conn.createStatement();
		String sql = "SELECT COUNT(*) AS COUNT FROM TBL_EMP";
				
		ResultSet rs = stmt.executeQuery(sql);
		
		if (rs.next())
		{
			result = rs.getInt("COUNT");
			
			rs.close();
			stmt.close();
			
			return result;
		}
		return result;
			
	}

	// 직원 전체 출력 담당 메소드
	public ArrayList<MemberDTO> lists (int num) throws SQLException 
	{
		ArrayList<MemberDTO> result = new ArrayList<MemberDTO>();
		
	
		Statement stmt = conn.createStatement();
		String sql = String.format("SELECT EMP_ID, EMP_NAME, SSN"
				+ ", IBSADATE, CITY_NAME, TEL, BUSEO_NAME, JIKWI_NAME, BASICPAY, SUDANG, ((BASIC*12)+SUDANG)AS SAL"
				+ " FROM EMPVIEW ORDER BY %s");

		// 쿼리문 실행
		ResultSet rs = stmt.executeQuery(sql);
		
		// ResultSet 처리 → 반복문 구성
		while (rs.next()) // --> ArrayList 에 적재할 MemberDTO 구성
		{
			MemberDTO dto = new MemberDTO();
			dto.setEmp_id(rs.getInt("EMP_ID"));  
			dto.setEmp_name(rs.getString("EMP_NAME"));
			dto.setSsn(rs.getString("SSN"));
			dto.setIbsadate(rs.getString("IBSADATE"));
			dto.setCity_name(rs.getString("CITY_NAME"));
			dto.setTel(rs.getString("TEL"));
			dto.setBuseo_name(rs.getString("BUSEO_NAME"));
			dto.setJikwi_name(rs.getString("JIKWI_NAME"));
			dto.setBasicpay(rs.getInt("BASICPAY"));
			dto.setSudang(rs.getInt("SUDANG"));
			dto.setSal(rs.getString("SAL"));
			

			result.add(dto); // 반복이 끝나기 전에 Arraylist를 집어 넣는다
		}
		rs.close();
		stmt.close();

		return result;
	}

		// 직원 검색 출력(사번/이름/부서/직위)
		public ArrayList<MemberDTO> searchLists(String key, String value) throws SQLException
		{
			ArrayList<MemberDTO> result = new ArrayList<MemberDTO>();
			Statement stmt = conn.createStatement();
			String sql = String.format("SELECT EMP_ID, EMP_NAME, SSN"
					+ ", TO_CHAR(IBSADATE, 'YYYY-MM-DD') AS IBSADATE"
					+ ", CITY_NAME, TEL, BUSEO_NAME, JIKWI_NAME, BASICPAY"
					+ ", SUDANG, PAY" 
					+ " FROM EMPVIEW"
					+ " WHERE %s = '%s'", key, value);
			
			// 쿼리문 실행
			ResultSet rs = stmt.executeQuery(sql);
			
			// ResultSet 처리 → 반복문 구성
			while (rs.next()) // --> ArrayList 에 적재할 MemberDTO 구성
			{
				MemberDTO dto = new MemberDTO();
				dto.setEmp_id(rs.getInt("EMP_ID"));
				dto.setEmp_name(rs.getString("EMP_NAME"));
				dto.setSsn(rs.getString("SSN"));
				dto.setIbsadate(rs.getString("IBSADATE"));
				dto.setCity_name(rs.getString("CITY_NAME"));
				dto.setTel(rs.getString("TEL"));
				dto.setBuseo_name(rs.getString("BUSEO_NAME"));
				dto.setJikwi_name(rs.getString("JIKWI_NAME"));
				dto.setBasicpay(rs.getInt("BASICPAY"));
				dto.setSudang(rs.getInt("SUDANG"));
				dto.setSal(rs.getString("SAL"));
				
				
				
				result.add(dto); //--> ArrayList 에 적재
			}
			rs.close();
			stmt.close();
			
			return result;
		}//end searchLists()
		
		// 지역 리스트 조회
		public ArrayList<String> searchCity() throws SQLException
		{
			// 반환할 결과값 변수 선언 및 초기화
			ArrayList<String> result = new ArrayList<String>();
			
			// Statement 객체 생성
			Statement stmt = conn.createStatement();
			
			// 쿼리문 준비
			String sql = "SELECT CITY_NAME FROM TBL_CITY";
			
			// 쿼리문 실행
			ResultSet rs = stmt.executeQuery(sql);
			
			// ResultSet 처리 → 반복문 구성 → ArrayList 에 데이터 적재(삽입)
			while (rs.next())
				result.add(rs.getString("CITY_NAME"));
			
			// 리소스 반납
			rs.close();
			stmt.close();
			
			// 최종 결과값 반환
			return result;
		}//end searchCity()
		
		// 부서 검색
		public ArrayList<String> searchBuseo() throws SQLException
		{
			ArrayList<String> result = new ArrayList<String>();
			Statement stmt = conn.createStatement();
			String sql = "SELECT BUSEO_NAME FROM TBL_BUSEO";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next())
			 result.add(rs.getString("BUSEO_NAME"));
			rs.close();
			stmt.close();
			
			return result;
			
		}//end searchBuseo()
		
		// 직위 검색
		public ArrayList<String> searchJikwi() throws SQLException
		{
			ArrayList<String> result = new ArrayList<String>();
			Statement stmt = conn.createStatement();
			String sql = "SELECT JIKWI_NAME FROM TBL_JIKWI";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next())
				result.add(rs.getString("JIKWI_NAME"));
			rs.close();
			stmt.close();

			return result;

		}//end searchJikwi()
		
		// 직위에 따른 최소 기본급 검색
		public int searchBasicPay(String jikwi) throws SQLException
		{
			int result = 0;
			Statement stmt = conn.createStatement();
			String sql = String.format
					("SELECT MIN_BASICPAY FROM TBL_JIKWI WHERE JIKWI_NAME = '%s'", jikwi);
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next())
				result = rs.getInt("MIN_BASICPAY");
			rs.close();
			stmt.close();
			
			return result;
		}//end searchBasicPay()
		
		// 직원 수정
		public int modify(MemberDTO dto) throws SQLException
		{
			int result = 0;
			Statement stmt = conn.createStatement();
			
			System.out.println(dto.getSsn());
			
			String sql = String.format("UPDATE TBL_EMP SET EMP_NAME='%s'"
					+ ", SSN='%s', IBSADATE=TO_DATE('%s', 'YYYY-MM-DD')"
					+ ", CITY_ID=(SELECT CITY_ID FROM TBL_CITY WHERE CITY_NAME ='%s')"
					+ ", TEL='%s'"
					+ ", BUSEO_ID=(SELECT BUSEO_ID FROM TBL_BUSEO WHERE BUSEO_NAME = '%s')"
					+ ", JIKWI_ID=(SELECT JIKWI_ID FROM TBL_JIKWI WHERE JIKWI_NAME = '%s')"
					+ ", BASICPAY=%d, SUDANG=%d WHERE EMP_ID = %d"
					, dto.getEmp_name(), dto.getSsn(), dto.getIbsadate()
					, dto.getCity_name(), dto.getTel(), dto.getBuseo_name()
					, dto.getJikwi_name(), dto.getBasicpay(), dto.getSudang()
					, dto.getEmp_id());
			result = stmt.executeUpdate(sql);
			stmt.close();
			
			return result;	
		}//end modify()
		
		// 직원 삭제
		public int remove(int empId) throws SQLException
		{
			int result = 0;
			Statement stmt = conn.createStatement();
			String sql = String.format("DELETE FROM TBL_EMP WHERE EMP_ID=%d", empId);
			result = stmt.executeUpdate(sql);
			stmt.close();
			
			return result;
		}//end remove()

		public ArrayList<String> searchCity1()
		{
			// TODO Auto-generated method stub
			return null;
		}

	}

