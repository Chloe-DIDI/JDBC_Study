SELECT USER
FROM DUAL;
--==>> SCOTT

--�� �ǽ� ���̺� ����
CREATE TABLE TBL_SCORE
( SID   NUMBER
, NAME  VARCHAR2(30)
, KOR   NUMBER(3)
, ENG   NUMBER(3)
, MAT   NUMBER(3)
);
--==>> Table TBL_SCORE��(��) �����Ǿ����ϴ�.

--�� �������� �߰�(KOR, ENG, MAT �÷��� CK �������� �߱�)
ALTER TABLE TBL_SCORE
ADD ( CONSTRAINT SCORE_KOR_CK CHECK (KOR BETWEEN 0 AND 100)
,     CONSTRAINT SCORE_ENG_CK CHECK (ENG BETWEEN 0 AND 100)
,     CONSTRAINT SCORE_MAT_CK CHECK (MAT BETWEEN 0 AND 100) );
--==>> Table TBL_SCORE��(��) ����Ǿ����ϴ�.

--�� ������ ����
CREATE SEQUENCE SCORESEQ
NOCACHE;
--==>> Sequence SCORESEQ��(��) �����Ǿ����ϴ�.

COMMIT;
--==>> Ŀ�� �Ϸ�

DROP SEQUENCE SCORESEQ;

SELECT *
FROM TBL_SCORE;

/*
 1�� �л� ���� �Է�(�̸� ���� ���� ���� ) : ������ 80 75 60
 2�� �л� ���� �Է�(�̸� ���� ���� ���� ) : ������ 100 90 80
 3�� �л� ���� �Է�(�̸� ���� ���� ���� ) : ���ش� 80 85 80
*/

--�� ������ �Է�
INSERT INTO TBL_SCORE(SID, NAME, KOR, ENG, MAT) VALUES(SCORESEQ.NEXTVAL, '������', 80, 75, 60);
INSERT INTO TBL_SCORE(SID, NAME, KOR, ENG, MAT) VALUES(SCORESEQ.NEXTVAL, '������', 100, 90, 80);
INSERT INTO TBL_SCORE(SID, NAME, KOR, ENG, MAT) VALUES(SCORESEQ.NEXTVAL, '���ش�', 80, 85, 80);

--�� ���� �����Ǿ��ִ� ������ ��� Ȯ��
SELECT * FROM USER_SEQUENCES;



--�� �ο� �� Ȯ�� ������ ����
SELECT COUNT(*) AS COUNT
FROM TBL_SCORE;
--> �� �� ����
SELECT COUNT(*) AS COUNT FROM TBL_SCORE
;


--�� ��ü ����Ʈ ��ȸ ������ ����
SELECT *
FROM TBL_SCORE
ORDER BY 1;
--> �� �ٷ� �ٲٱ�
SELECT * FROM TBL_SCORE ORDER BY 1;

DELETE 
FROM TBL_SCORE;

UPDATE TBL_SCORE
SET sid = '3'
WHERE SID = '7';



UPDATE sid = '1'
SET TBL_SCORE
WHERE SID = '5';
