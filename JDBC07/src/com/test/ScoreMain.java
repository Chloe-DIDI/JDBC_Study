/*========================
 * ScoreMain.java
 *    
 *    --main에서 오류가 sql 있을때 95% DAO에서 에러가 나는것이다
 *    --
 ========================*/
/*
 * ○성적 처리-> 데이터 베이스 연동 (데이터 베이스 연결 및 액션 처리)
 * 				ScoreDTO클래스 활용 (속성만 존재하는 클래스 , getter/setter구성)
 * 				ScoreDAO 클래스 활용 (데이터베이스 액션 처리)
 * 				Process클래스 활용 (단위 기능 구성)
 * 
 
 ※ 단, 모든 작업 개체는 PreparedStatement 를 활용한다.
 
 * 여러명의 이름,국어점수,영어점수, 수학점수를 입력 받아
 * 총점,평균, 석차 등을 계산하여 출력하는 프로그램을 구현한다
 * ※ 서브 메뉴구성 -> Process클래스 활용
 * 
 * ===[성적처리]====
 * 1.성적입력
 * 2.성적 전체 출력
 * 3.이름 검색 출력
 * 4.성적 수정
 * 5.성적 삭제
 * =================
 * >> 선택(1~5,-1 종료) : 1
 * 
 * 7번 학생 석적 입력(이름 국어 영어 수학) : 이다영 50 60 70
 * 성적 입력이 완료되었습니다
 * 
 * 8번 학생 석적 입력(이름 국어 영어 수학) : 이지영 80 80 80
 * 성적 입력이 완료되었습니다
 * 
 * 9번 학생 석적 입력(이름 국어 영어 수학) :.
 * 
 * ===[성적처리]====
 * 1.성적입력
 * 2.성적 전체 출력
 * 3.이름 검색 출력
 * 4.성적 수정
 * 5.성적 삭제
 * ================= 
 * >> 선택 (1~5,-1 종료) : 2
 * 전체 인원 : 8명
 * 번호 이름 국어 영어 수학 총점 평균 석차
 * 1
 * 2
 * 3
 * 4				...
 * 5
 * 6
 * 7
 * 8
 * 
 * ===[성적처리]====
 * 1.성적입력
 * 2.성적 전체 출력
 * 3.이름 검색 출력
 * 4.성적 수정
 * 5.성적 삭제
 * ================= 
 * >> 선택 (1~5,-1 종료) : -1
 * 
 * 프로그램이 종료 되었습니다.
 */




package com.test;

import java.util.Scanner;

public class ScoreMain
{
	public static void main(String[] args)
	{
		ScoreProcess prc = new ScoreProcess();
		Scanner sc = new Scanner(System.in);
		
		do
		{
			System.out.println();
			System.out.println("====[ 성적 처리 ]====");
			System.out.println("1. 성적 입력");
			System.out.println("2. 성적 전체 출력");
			System.out.println("3. 이름 검색 출력");
			System.out.println("4. 성적 수정");
			System.out.println("5. 성적 삭제");
			System.out.println("=====================");
			System.out.print(">> 선택(1~5, -1종료) :");
			String menus = sc.next();
			
			try
			{
				int menu = Integer.parseInt(menus);
				
				if (menu == -1)
				{
					System.out.println();
					System.out.println("프로그램이 종료되었습니다.");
					return;
				}
				
				switch (menu)
				{
					case 1:
						// 성적 입력 기능 수행
						prc.sungjukInsert();
						break;
					case 2:
						// 성적 전체 출력 기능 수행
						prc.sungjukSelctAll();
						break;
					case 3:
						// 이름 검색 출력 기능 수행
						prc.sungjukSearchName();
						break;
					case 4:
						// 성적 수정 기능 수행
						prc.sungjukUpdate();
						break;
					case 5:
						// 성적 삭제 기능 수행
						prc.sungjukDelete();
						break;
				}
				
			} catch (Exception e)
			{
				System.out.println(e.toString());
			}
			
		} while (true);
		
	
	}
}
