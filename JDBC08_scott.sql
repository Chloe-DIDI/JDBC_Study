SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT *
FROM TBL_MEMBER
ORDER BY SID;
--==>>
/*
1	������	010-1111-1111
2	����ȣ	010-2222-2222
3	������	010-3333-3333
4	������	010-4444-4444
5	������	010-5555-5555
6	��ȿ��	010-6666-6666
7	�մ���	010-7777-7777
8	��ȿ��	010-8888-8888
9	������	010-9999-9999
10	�չ���	010-1010-1010
11	�ּ���	010-1100-1100
12	ä����	010-1212-1212
*/


--�� CallableStatement �ǽ��� ���� ���ν��� �ۼ�
--   ���ν��� �� : PRC_MEMBERINSERT
--   ���ν��� ��� : TBL_MEMBER ���̺��� �����͸� �Է��ϴ� ���ν���

CREATE OR REPLACE PROCEDURE PRC_MEMBERINSERT
( VNAME IN  TBL_MEMBER.NAME%TYPE
, VTEL  IN  TBL_MEMBER.TEL%TYPE
)
IS
    -- �ֿ� ���� ����
    VSID    TBL_MEMBER.SID%TYPE;
BEGIN

    -- ���� SID �� �ִ밪 ������
    SELECT NVL(MAX(SID), 0) INTO VSID
    FROM TBL_MEMBER;
    
    -- ������ �Է�
    INSERT INTO TBL_MEMBER(SID, NAME, TEL)
    VALUES((VSID+1), VNAME, VTEL);
   
    -- Ŀ��
    COMMIT;

END;
--==>> Procedure PRC_MEMBERINSERT��(��) �����ϵǾ����ϴ�.


--�� ������ ���ν��� �׽�Ʈ(Ȯ��)
EXEC PRC_MEMBERINSERT('���±�', '010-3733-7202');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.


--�� ���̺� ��ȸ
SELECT *
FROM TBL_MEMBER
ORDER BY SID;
--==>>
/*
1	������	010-1111-1111
2	����ȣ	010-2222-2222
3	������	010-3333-3333
4	������	010-4444-4444
5	������	010-5555-5555
6	��ȿ��	010-6666-6666
7	�մ���	010-7777-7777
8	��ȿ��	010-8888-8888
9	������	010-9999-9999
10	�չ���	010-1010-1010
11	�ּ���	010-1100-1100
12	ä����	010-1212-1212
13	���±�	010-3733-7202
*/


--�� Test001 ���� �� Ȯ��
SELECT *
FROM TBL_MEMBER
ORDER BY SID;
--==>> 
/*
1	������	010-1111-1111
2	����ȣ	010-2222-2222
3	������	010-3333-3333
4	������	010-4444-4444
5	������	010-5555-5555
6	��ȿ��	010-6666-6666
7	�մ���	010-7777-7777
8	��ȿ��	010-8888-8888
9	������	010-9999-9999
10	�չ���	010-1010-1010
11	�ּ���	010-1100-1100
12	ä����	010-1212-1212
13	���±�	010-3733-7202
14	�����	010-6857-1996
15	������	010-4434-2587
16	������	010-4780-9592
*/


--�� CallableStatement �ǽ��� ���� ���ν��� �ۼ�
--   ���ν��� �� : PRC_MEMBERSELECT
--   ���ν��� ��� : TBL_MEMBER ���̺��� �����͸� �о���� ���ν���
--   �� ��SYS_REFCURSOR�� �ڷ����� �̿��Ͽ� Ŀ�� �ٷ��
CREATE OR REPLACE PROCEDURE PRC_MEMBERSELECT
( VRESULT   OUT SYS_REFCURSOR

) 
IS
BEGIN
    OPEN VRESULT FOR
        SELECT SID, NAME, TEL
        FROM TBL_MEMBER
        ORDER BY SID;
    
    --CLOLSE VRESULT;
    --���� Ŀ���� ������ �޴� �ʿ��� ���� ���ϹǷ� ���� �ʴ´�.
END;
--==>> Procedure PRC_MEMBERSELECT��(��) �����ϵǾ����ϴ�.

















