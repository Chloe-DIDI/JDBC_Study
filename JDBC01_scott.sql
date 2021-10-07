--JDBC 이클립스 Test003이랑

SELECT USER
FROM DUAL;
--==>> SCOTT

DROP TABLE TBL_MEMBER;
--==>> Table TBL_MEMBER이(가) 삭제되었습니다.

--○ 실습 테이블 생성
CREATE TABLE TBL_MEMBER
( SID   NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
, CONSTRAINT MEMBER_SID_PK PRIMARY KEY(SID)
);
--==>> Table TBL_MEMBER이(가) 생성되었습니다.


--○ 샘플 데이터 입력
INSERT INTO TBL_MEMBER(SID, NAME, TEL) VALUES (1, '손다정', '010-1234-6789');
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_MEMBER;
--==>>
/*
1	손다정	010-1234-6789
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--==>> 이클립스 TEST003 으로 돌아가기

--○ 자바에서 Test003 클래스 실행 후 다시 확인
SELECT * 
FROM TBL_MEMBER;
--==>>
/* --채지윤 들어간거 확인~!
2	채지윤	010-2222-2222
1	손다정	010-1234-6789
*/


--▶ 이름 두개 똑같은거 인거 싫어서 1번 이름 홍길동으로 변경 
UPDATE TBL_MEMBER
SET NAME = '홍길동'
WHERE TEL = '010-1234-6789';



--○ 데이터 조회 쿼리문 준비
--<<
SELECT SID, NAME, TEL
FROM TBL_MEMBER
ORDER BY SID;
-->>
--<< ~ >> 드래그 해서 이클립스 Test04 에 32줄 복붙!


-----------------------Test05 끝~!!