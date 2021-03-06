SELECT USER
FROM DUAL;
--==>> SCOTT

TRUNCATE TABLE TBL_MEMBER;
--==>> Table TBL_MEMBER이(가) 잘렸습니다.

CREATE SEQUENCE MEMBERSEQ
NOCACHE;
--==>> Sequence MEMBERSEQ이(가) 생성되었습니다.

--○ 데이터 입력 쿼리문 구성
INSERT INTO TBL_MEMBER(SID, NAME, TEL) VALUES(MEMBERSEQ.NEXTVAL, '김진희', '010-1111-1111')
; --▶ 세미콜론 밑에 놨두기 이렇게
--==>> 1 행 이(가) 삽입되었습니다.


--○ 인원 수 확인 쿼리문 구성
SELECT COUNT(*) AS COUNT
FROM TBL_MEMBER;
--==>> 1
--> 한 줄 구성 
SELECT COUNT(*) AS COUNT FROM TBL_MEMBER
;

--○ 전체 리스트 조회 쿼리문 구성
SELECT CO, NAME, TEL
FROM TBL_MEMBER
ORDER BY SID;
--> 한 줄 구성 
SELECT CO, NAME, TEL FROM TBL_MEMBER ORDER BY SID;
;
