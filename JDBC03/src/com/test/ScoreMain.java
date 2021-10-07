/* =============================
  		ScoreMain.java
==============================*/

/*
 ○ 성적 처리 프로그램 구현 → 데이터베이스 연동 → ScoreDAO, ScoreDTO 클래스 활용

	여러 명의 이름, 국어점수, 영어점수, 수학점수를 입력받아
	총점, 평균을 연산하여 내용을 출력하는 프로그램을 구현한다.
	출력 시 번호(이름, 총점 등) 오름차순 정렬하여 출력한다.

실행 예)
 
1번 학생 성적 입력(이름 국어 영어 수학) : 김진령 80 75 60
2번 학생 성적 입력(이름 국어 영어 수학) : 이윤서 100 90 80
3번 학생 성적 입력(이름 국어 영어 수학) : 송해덕 80 85 80
4번 학생 성적 입력(이름 국어 영어 수학) : .
 
----------------------------------------------------------
번호	이름	국어	영어	수학	총점	평균
----------------------------------------------------------
1	   김진령 	 80 	 75 	 60		xxx		xx.x
2	   이윤서 	 100 	 90 	 80		xxx		xx.x
3	   송해덕 	 80 	 85 	 80		xxx		xx.x
---------------------------------------------------------- 
*/


package com.test;

import java.util.Iterator;
import java.util.Scanner;

import com.util.DBConn;

public class ScoreMain
{
	public static void main(String[] args)
	{
		Scanner sc = new Scanner(System.in);
		
		try
		{
			ScoreDAO dao = new ScoreDAO();
					
			do
			{
				System.out.printf("%d번 학생 성적 입력(이름 국어 영어 수학) : ", dao.count()+1);
				String name = sc.next();
				
				if (name.equals("."))
					break;
				
				int kor = sc.nextInt();
				int eng = sc.nextInt();
				int mat = sc.nextInt();
				
				ScoreDTO dto = new ScoreDTO();
				dto.setName(name);
				dto.setKor(kor);
				dto.setEng(eng);
				dto.setMat(mat);
				
				int result = dao.add(dto);
				
			} while (true);
				
			System.out.println();
			System.out.println("----------------------------------------------------------");
			System.out.println("번호\t  이름\t 국어\t 영어\t 수학\t 총점\t 평균");
			System.out.println("----------------------------------------------------------");

			for (ScoreDTO obj : dao.lists())
				System.out.printf("%3s\t %s\t %3d\t %3d\t %3d\t %3d\t %3.2f\n"
						, obj.getSid(), obj.getName(), obj.getEng(), obj.getKor(), obj.getMat()
						, (obj.getEng() + obj.getKor() + obj.getMat())
						, (obj.getEng() + obj.getKor() + obj.getMat())/3.0);
			
		System.out.println("----------------------------------------------------------");
		
		
		} catch (Exception e) 
		{
			System.out.println(e.toString());
		}
		
		finally
		{
			try
			{
				DBConn.close();
				System.out.println("데이터베이스 연결 닫힘");
				System.out.println("프로그램 종료");
				
			} catch (Exception e)
			{
				System.out.println(e.toString());
			}
		}

	}
}



