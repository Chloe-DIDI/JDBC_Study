/*===========================
 	Test001.java
============================*/

package com.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

import com.util.DBConn;

public class Test001
{
	public static void main(String[] args)
	{
		try
		{
			Connection conn = DBConn.getConnection();
			
			if (conn != null)
			{
				System.out.println("데이터베이스 연결 성공~!!!");
				
				try
				{
					/*
					 *																					<< -- Statement 작업 객체 사용>>
					// Statement 작업 객체 생성
					Statement stmt = conn.createStatement();
					
					String sql = "INSERT INTO TBL_MEMBER(SID, NAME, TEL)"
							+ " VALUES(MEMBERSEQ.NEXTVAL, '정효진', '010-5555-5555')";
					//쿼리문 준비
					int result = stmt.executeUpdate(sql);
					
					if (result>0)
						System.out.println("데이터 입력 성공~!!!");
					
					stmt.close();
					DBConn.close();
					*/

												//<< Statement 작업 객체 사용(SQL 위치 상단으로 변경 후)>>
												//insert할때 상단으로 입력하든 상관없다 『Statement 작업객체 생성 위 아래 상관 없이 값이 똑같이 들어온다』
					/*
					String sql = "INSERT INTO TBL_MEMBER(SID, NAME, TEL)"
							+ " VALUES(MEMBERSEQ.NEXTVAL, '손다정', '010-6666-6666')";
					// Statement 작업 객체 생성
					Statement stmt = conn.createStatement();
					
					//쿼리문 준비
					int result = stmt.executeUpdate(sql);
					
					if (result>0)
						System.out.println("데이터 입력 성공~!!!");
					
					stmt.close();
					DBConn.close();
					*/
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					
					// PreparedStatement SQL 쿼리문부터 생성
					String sql = "INSERT INTO TBL_MEMBER(SID, NAME, TEL)"
							+ " VALUES(MEMBERSEQ.NEXTVAL, ?, ?)";
					
					// PreparedStatement 작업 객체 생성
					PreparedStatement pstmt = conn.prepareStatement(sql);		//전처리 됨!!
					
					// IN 매개변수 넘겨주기
					pstmt.setString(1, "박효빈");
					pstmt.setString(2, "010-7777-7777");
					
					int result = pstmt.executeUpdate();
					
					if (result>0)
						System.out.println("데이터 입력 성공~!!!");
					
					pstmt.close();
					DBConn.close();
					
				} catch (Exception e)
				{
					System.out.println(e.toString());
				}
				
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
	}
}