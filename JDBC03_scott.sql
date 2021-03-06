SELECT USER
FROM DUAL;
--==>> SCOTT

--○ 실습 테이블 생성
CREATE TABLE TBL_SCORE
( SID   NUMBER
, NAME  VARCHAR2(30)
, KOR   NUMBER(3)
, ENG   NUMBER(3)
, MAT   NUMBER(3)
);
--==>> Table TBL_SCORE이(가) 생성되었습니다.

--○ 제약조건 추가(KOR, ENG, MAT 컬럼에 CK 제약조건 추기)
ALTER TABLE TBL_SCORE
ADD ( CONSTRAINT SCORE_KOR_CK CHECK (KOR BETWEEN 0 AND 100)
,     CONSTRAINT SCORE_ENG_CK CHECK (ENG BETWEEN 0 AND 100)
,     CONSTRAINT SCORE_MAT_CK CHECK (MAT BETWEEN 0 AND 100) );
--==>> Table TBL_SCORE이(가) 변경되었습니다.

--○ 시퀸스 생성
CREATE SEQUENCE SCORESEQ
NOCACHE;
--==>> Sequence SCORESEQ이(가) 생성되었습니다.

COMMIT;
--==>> 커밋 완료

DROP SEQUENCE SCORESEQ;

SELECT *
FROM TBL_SCORE;

/*
 1번 학생 성적 입력(이름 국어 영어 수학 ) : 김진령 80 75 60
 2번 학생 성적 입력(이름 국어 영어 수학 ) : 이윤서 100 90 80
 3번 학생 성적 입력(이름 국어 영어 수학 ) : 송해덕 80 85 80
*/

--○ 데이터 입력
INSERT INTO TBL_SCORE(SID, NAME, KOR, ENG, MAT) VALUES(SCORESEQ.NEXTVAL, '김진령', 80, 75, 60);
INSERT INTO TBL_SCORE(SID, NAME, KOR, ENG, MAT) VALUES(SCORESEQ.NEXTVAL, '이윤서', 100, 90, 80);
INSERT INTO TBL_SCORE(SID, NAME, KOR, ENG, MAT) VALUES(SCORESEQ.NEXTVAL, '송해덕', 80, 85, 80);

--○ 현재 생성되어있는 시퀸스 목록 확인
SELECT * FROM USER_SEQUENCES;



--○ 인원 수 확인 쿼리문 구성
SELECT COUNT(*) AS COUNT
FROM TBL_SCORE;
--> 한 줄 구성
SELECT COUNT(*) AS COUNT FROM TBL_SCORE
;


--○ 전체 리스트 조회 쿼리문 구성
SELECT *
FROM TBL_SCORE
ORDER BY 1;
--> 한 줄로 바꾸기
SELECT * FROM TBL_SCORE ORDER BY 1;

DELETE 
FROM TBL_SCORE;

UPDATE TBL_SCORE
SET sid = '3'
WHERE SID = '7';



UPDATE sid = '1'
SET TBL_SCORE
WHERE SID = '5';

