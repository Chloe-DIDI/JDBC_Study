SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT * 
FROM TBL_MEMBER;
--==>>
/*
1	������	010-1111-1111
2	����ȣ	010-2222-2222
3	������	010-3333-3333
4	������	010-4444-4444
*/

--�� ������ �Է� ������ ����
INSERT INTO TBL_MEMBER(SID, NAME, TEL)
VALUES(MEMBERSEQ.NEXTVAL, '������', '010-5555-5555');
--> �� �� ����
INSERT INTO TBL_MEMBER(SID, NAME, TEL) VALUES(MEMBERSEQ.NEXTVAL, '������', '010-5555-5555')
;
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


COMMIT;
--==>> Ŀ�� �Ϸ�.

-- Statement �۾� ��ü ���
SELECT *
FROM TBL_MEMBER;
--==>>
/*
1	������	010-1111-1111
2	����ȣ	010-2222-2222
3	������	010-3333-3333
4	������	010-4444-4444
5	������	010-5555-5555
*/



--�� ������ ��ü ��ȸ ������ ����
SELECT SID, NAME, TEL
FROM TBL_MEMBER
ORDER BY SID;
--> �� �� ����
SELECT SID, NAME, TEL FROM TBL_MEMBER ORDER BY SID
;


SELECT *
FROM TBL_MEMBER;
--==>>
/*
5	������	010-5555-5555
6	��ȿ��	010-6666-6666
2	����ȣ	010-2222-2222
3	������	010-3333-3333
4	������	010-4444-4444
1	������	010-1111-1111
7	�մ���	010-7777-7777
9	������	010-9999-9999
12	�չ���	010-1212-1212
13	�ּ���	010-1313-1313
14	ä����	010-1414-1414
8	��ȿ��	010-8888-8888
*/
------------------------------------------
-- �� �� �Է� �� �� ������Ʈ--


UPDATE TBL_MEMBER
SET SID = 9
WHERE SID = 10;


DELETE
FROM TBL_MEMBER
WHERE SID = 11;