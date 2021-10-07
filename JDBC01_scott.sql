--JDBC ��Ŭ���� Test003�̶�

SELECT USER
FROM DUAL;
--==>> SCOTT

DROP TABLE TBL_MEMBER;
--==>> Table TBL_MEMBER��(��) �����Ǿ����ϴ�.

--�� �ǽ� ���̺� ����
CREATE TABLE TBL_MEMBER
( SID   NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
, CONSTRAINT MEMBER_SID_PK PRIMARY KEY(SID)
);
--==>> Table TBL_MEMBER��(��) �����Ǿ����ϴ�.


--�� ���� ������ �Է�
INSERT INTO TBL_MEMBER(SID, NAME, TEL) VALUES (1, '�մ���', '010-1234-6789');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_MEMBER;
--==>>
/*
1	�մ���	010-1234-6789
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--==>> ��Ŭ���� TEST003 ���� ���ư���

--�� �ڹٿ��� Test003 Ŭ���� ���� �� �ٽ� Ȯ��
SELECT * 
FROM TBL_MEMBER;
--==>>
/* --ä���� ���� Ȯ��~!
2	ä����	010-2222-2222
1	�մ���	010-1234-6789
*/


--�� �̸� �ΰ� �Ȱ����� �ΰ� �Ⱦ 1�� �̸� ȫ�浿���� ���� 
UPDATE TBL_MEMBER
SET NAME = 'ȫ�浿'
WHERE TEL = '010-1234-6789';



--�� ������ ��ȸ ������ �غ�
--<<
SELECT SID, NAME, TEL
FROM TBL_MEMBER
ORDER BY SID;
-->>
--<< ~ >> �巡�� �ؼ� ��Ŭ���� Test04 �� 32�� ����!


-----------------------Test05 ��~!!