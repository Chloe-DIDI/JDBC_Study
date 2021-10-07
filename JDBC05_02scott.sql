SELECT USER
FROM DUAL;
--==>> SCOTT


--○ 쿼리문 준비

--[1] 직원 정보 입력
--1. 지역 리스트 조회 쿼리문
SELECT CITY_NAME
FROM TBL_CITY;
--> 한 줄 구성
SELECT CITY_LOC FROM TBL_CITY
;

--2. 부서 리스트 조회 쿼리문
SELECT BUSEO_NAME
FROM TBL_BUSEO;
--> 한 줄 구성
SELECT BUSEO_NAME FROM TBL_BUSEO
;

--3. 직위 리스트 조회 쿼리문
SELECT JIKWI_NAME
FROM TBL_JIKWI;
--> 한 줄 구성
SELECT JIKWI_NAME FROM TBL_JIKWI
;

--4. 최소 기본급 조회 쿼리문
SELECT MIN_BASICPAY
FROM TBL_JIKWI
WHERE JIKWI_NAME = '부장';
--> 한 줄 구성
SELECT MIN_BASICPAY FROM TBL_JIKWI WHERE JIKWI_NAME = '부장'
;



--▼
SELECT CITY_ID FROM TBL_CITY WHERE CITY_NAME='서울'; -->> 이거 숫자로 나오기때문에 그냥 CITYNAME이아니라 저렇게 길게 작성.
--==>>1
-- 부서랑 직위도 같은 이유
SELECT BUSEO_ID FROM TBL_BUSEO WHERE BUSEO_NAME='개발부'; -->> 1
SELECT JIKWI_ID FROM TBL_JIKWI WHERE JIKWI_NAME='대리'; -->> 8
--5. 데이터(직원 정보) 입력 쿼리문
INSERT INTO TBL_EMP(EMP_ID, EMP_NAME, SSN, IBSADATE, CITY_ID, TEL, BUSEO_ID, JIKWI_ID, BASICPAY, SUDANG)
VALUES (EMPSEQ.NEXTVAL, '정미화', '940403-2234567', TO_DATE('2010-11-11', 'YYYY-MM-DD')
        , (SELECT CITY_ID FROM TBL_CITY WHERE CITY_NAME='서울')
        , '010-8743-1000'
        , (SELECT BUSEO_ID FROM TBL_BUSEO WHERE BUSEO_NAME='개발부')
        , (SELECT JIKWI_ID FROM TBL_JIKWI WHERE JIKWI_NAME='대리')
        , 2200000
        , 2000000);
--> 한 줄 구성
INSERT INTO TBL_EMP(EMP_ID, EMP_NAME, SSN, TO_DATE('2010-11-11', 'YYYY-MM-DD'), CITY_ID, TEL, BUSEO_ID, JIKWI_ID, BASICPAY, SUDANG) VALUES (EMPSEQ.NEXTVAL, '정미화', '940403-2234567', TO_DATE('2010-11-11', 'YYYY-MM-DD'), (SELECT CITY_ID FROM TBL_CITY WHERE CITY_NAME='서울'), '010-8743-1000', (SELECT BUSEO_ID FROM TBL_BUSEO WHERE BUSEO_NAME='개발부'), (SELECT JIKWI_ID FROM TBL_JIKWI WHERE JIKWI_NAME='대리'), 2200000, 2000000)
;
--==>> 1 행 이(가) 삽입되었습니다.


--○ 커밋
COMMIT;
--==>> 커밋 완료.

--6. 전체 직원수 출력 쿼리문
SELECT COUNT(*) AS COUNT
FROM TBL_EMP;
--> 한 줄 구성
SELECT COUNT(*) AS COUNT FROM TBL_EMP;
--==>> 61


--[7]
--7. 검색 직원 수 출력 쿼리문 (사번/이름/부서/직위)
SELECT COUNT(*) AS COUNT
FROM TBL_EMP
--WHERE EMP_ID=1001;
--WHERE EMP_NAME;'정미화'

--7. 검색 직원 리스트 조회 쿼리문 (사번/이름/부서/직위)
SELECT COUNT(*) AS COUNT
FROM EMPVIEW
--WHERE EMP_ID=1001;
--WHERE EMP_NAME='정미화';
--WHERE BUSEO_NAME='개발부';
--WHERE JIKWI_NAME='대리';
--> 한 줄 구성
SELECT COUNT(*) AS COUNT FROM EMPVIEW
*/

--<<우리가 조회해야 할 항목들이 잘 보이는지 확인!>>
-- 사번 이름 주민번호 입사일 지역 전화번호 부서 직위 최소기본급 기본급 수당 급여
SELECT E.EMP_ID, E.EMP_NAME, E.SSN, TO_CHAR(E.IBSADATE,'YYYY-MM-DD') AS IBSADATE
     , C.CITY_NAME, E.TEL, B.BUSEO_NAME, J.JIKWI_NAME
     , J.MIN_BASICPAY, E.BASICPAY, E.SUDANG
     , (E.BASICPAY + E.SUDANG) AS PAY
FROM TBL_EMP E, TBL_CITY C, TBL_BUSEO B, TBL_JIKWI J
WHERE E.CITY_ID = C.CITY_ID
  AND E.BUSEO_ID = B.BUSEO_ID
  AND E.JIKWI_ID = J.JIKWI_ID;
--ORDER BY E.EMP_ID ASC;        -- 사번 정렬
--ORDER BY E.EMP_NAME ASC;      -- 이름 정렬
--ORDER BY B.BUSEO_NAME ASC;    -- 부서 정렬
--ORDER BY J.JIKWI_NAME ASC;    -- 직위 정렬
--ORDER BY PAY DESC;            -- 급여 내림차순 정렬

--※
/* 왜 이렇게 작성해야 하는건가? ▼
TO_CHAR(E.IBSADATE,'YYYY-MM-DD') AS IBSADATE
→ 그냥 E.IBSADATE 하면 결과문 추출할 때 날짜 시 분 초 까지 나올 수 있기 때문에
   TO_CHAR로 아예 형식을 지정해서 해주는게 좋다*/


--7-1. 뷰 생성(empview)
CREATE OR REPLACE VIEW EMPVIEW
AS

SELECT E.EMP_ID, E.EMP_NAME, E.SSN, TO_CHAR(E.IBSADATE,'YYYY-MM-DD') AS IBSADATE
     , C.CITY_NAME, E.TEL, B.BUSEO_NAME, J.JIKWI_NAME
     , J.MIN_BASICPAY, E.BASICPAY, E.SUDANG
     , (E.BASICPAY + E.SUDANG) AS PAY
FROM TBL_EMP E, TBL_CITY C, TBL_BUSEO B, TBL_JIKWI J
WHERE E.CITY_ID = C.CITY_ID
  AND E.BUSEO_ID = B.BUSEO_ID
  AND E.JIKWI_ID = J.JIKWI_ID;
--==>> View EMPVIEW이(가) 생성되었습니다.
--==>>
/* SELECT ~ J.JIKWI_ID; 드래그해서 확인하면 ↓ 이렇게 뜬다.
1001	홍길동	771212-1022432	1998-10-11	서울	011-2356-4528	기획부	부장	2450000	2610000	200000	2810000
1002	이순신	801007-1544236	2000-11-29	경기	010-4758-6532	총무부	사원	1650000	1320000	200000	1520000
1003	이순애	770922-2312547	1999-02-25	인천	010-4231-1236	개발부	부장	2450000	2550000	160000	2710000
1004	김정훈	790304-1788896	2000-10-01	전북	019-5236-4221	영업부	대리	1800000	1954200	170000	2124200
1005	한석봉	811112-1566789	2004-08-13	서울	018-5211-3542	총무부	사원	1650000	1420000	160000	1580000
1006	이기자	780505-2978541	2002-02-11	인천	010-3214-5357	개발부	과장	2260000	2265000	150000	2415000
1007	장인철	780506-1625148	1998-03-16	제주	011-2345-2525	개발부	대리	1800000	1250000	150000	1400000
1008	김영년	821011-2362514	2002-04-30	서울	016-2222-4444	홍보부	사원	1650000	950000	145000	1095000
1009	나윤균	810810-1552147	2003-10-10	경기	019-1111-2222	인사부	사원	1650000	840000	220400	1060400
1010	김종서	751010-1122233	1997-08-08	부산	011-3214-5555	영업부	부장	2450000	2540000	130000	2670000
1011	유관순	801010-2987897	2000-07-07	서울	010-8888-4422	영업부	사원	1650000	1020000	140000	1160000
1012	정한국	760909-1333333	1999-10-16	강원	018-2222-4242	홍보부	사원	1650000	880000	114000	994000
1013	조미숙	790102-2777777	1998-06-07	경기	019-6666-4444	홍보부	대리	1800000	1601000	103000	1704000
1014	황진이	810707-2574812	2002-02-15	인천	010-3214-5467	개발부	사원	1650000	1100000	130000	1230000
1015	이현숙	800606-2954687	1999-07-26	경기	016-2548-3365	총무부	사원	1650000	1050000	104000	1154000
1016	이상헌	781010-1666678	2001-11-29	경기	010-4526-1234	개발부	과장	2260000	2350000	150000	2500000
1017	엄용수	820507-1452365	2000-08-28	인천	010-3254-2542	개발부	사원	1650000	950000	210000	1160000
1018	이성길	801028-1849534	2004-08-08	전북	018-1333-3333	개발부	사원	1650000	880000	123000	1003000
1019	박문수	780710-1985632	1999-12-10	서울	017-4747-4848	인사부	과장	2260000	2300000	165000	2465000
1020	유영희	800304-2741258	2003-10-10	전남	011-9595-8585	자재부	사원	1650000	880000	140000	1020000
1021	홍길남	801010-1111111	2001-09-07	경기	011-9999-7575	개발부	사원	1650000	875000	120000	995000
1022	이영숙	800501-2312456	2003-02-25	전남	017-5214-5282	기획부	대리	1800000	1960000	180000	2140000
1023	김인수	731211-1214576	1995-02-23	서울		영업부	부장	2450000	2500000	170000	2670000
1024	김말자	830225-2633334	1999-08-28	서울	011-5248-7789	기획부	대리	1800000	1900000	170000	2070000
1025	우재옥	801103-1654442	2000-10-01	서울	010-4563-2587	영업부	사원	1650000	1100000	160000	1260000
1026	김숙남	810907-2015457	2002-08-28	경기	010-2112-5225	영업부	사원	1650000	1050000	150000	1200000
1027	김영길	801216-1898752	2000-10-18	서울	019-8523-1478	총무부	과장	2260000	2340000	170000	2510000
1028	이남신	810101-1010101	2001-09-07	제주	016-1818-4848	인사부	사원	1650000	892000	110000	1002000
1029	김말숙	800301-2020202	2000-09-08	서울	016-3535-3636	총무부	사원	1650000	920000	124000	1044000
1030	정정해	790210-2101010	1999-10-17	부산	019-6564-6752	총무부	과장	2260000	2304000	124000	2428000
1031	지재환	771115-1687988	2001-01-21	서울	019-5552-7511	기획부	부장	2450000	2450000	160000	2610000
1032	심심해	810206-2222222	2000-05-05	전북	016-8888-7474	자재부	사원	1650000	880000	108000	988000
1033	김미나	780505-2999999	1998-06-07	서울	011-2444-4444	영업부	사원	1650000	1020000	104000	1124000
1034	이정석	820505-1325468	2005-09-26	경기	011-3697-7412	기획부	사원	1650000	1100000	160000	1260000
1035	정영희	831010-2153252	2002-05-16	인천		개발부	사원	1650000	1050000	140000	1190000
1036	이재영	701126-2852147	2003-08-10	서울	011-9999-9999	자재부	사원	1650000	960400	190000	1150400
1037	최석규	770129-1456987	1998-10-15	인천	011-7777-7777	홍보부	과장	2260000	2350000	187000	2537000
1038	손인수	791009-2321456	1999-11-15	부산	010-6542-7412	영업부	대리	1800000	2000000	150000	2150000
1039	고순정	800504-2000032	2003-12-28	경기	010-2587-7895	영업부	대리	1800000	2010000	160000	2170000
1040	박세열	790509-1635214	2000-09-10	경북	016-4444-7777	인사부	대리	1800000	2100000	130000	2230000
1041	문길수	721217-1951357	2001-12-10	충남	016-4444-5555	자재부	과장	2260000	2300000	150000	2450000
1042	채정희	810709-2000054	2003-10-17	경기	011-5125-5511	개발부	사원	1650000	1020000	200000	1220000
1043	양미옥	830504-2471523	2003-09-24	서울	016-8548-6547	영업부	사원	1650000	1100000	210000	1310000
1044	지수환	820305-1475286	2004-01-21	서울	011-5555-7548	영업부	사원	1650000	1060000	220000	1280000
1045	홍원신	690906-1985214	2003-03-16	전북	011-7777-7777	영업부	사원	1650000	960000	152000	1112000
1046	허경운	760105-1458752	1999-05-04	경남	017-3333-3333	총무부	부장	2450000	2650000	150000	2800000
1047	산마루	780505-1234567	2001-07-15	서울	018-0505-0505	영업부	대리	1800000	2100000	112000	2212000
1048	이기상	790604-1415141	2001-06-07	전남		개발부	대리	1800000	2050000	106000	2156000
1049	이미성	830908-2456548	2000-04-07	인천	010-6654-8854	개발부	사원	1650000	1300000	130000	1430000
1050	이미인	810403-2828287	2003-06-07	경기	011-8585-5252	홍보부	대리	1800000	1950000	103000	2053000
1051	권영미	790303-2155554	2000-06-04	서울	011-5555-7548	영업부	과장	2260000	2260000	104000	2364000
1052	권옥경	820406-2000456	2000-10-10	경기	010-3644-5577	기획부	사원	1650000	1020000	105000	1125000
1053	김싱식	800715-1313131	1999-12-12	전북	011-7585-7474	자재부	사원	1650000	960000	108000	1068000
1054	정상호	810705-1212141	1999-10-16	강원	016-1919-4242	홍보부	사원	1650000	980000	114000	1094000
1055	정한나	820506-2425153	2004-06-07	서울	016-2424-4242	영업부	사원	1650000	1000000	104000	1104000
1056	전용재	800605-1456987	2004-08-13	인천	010-7549-8654	영업부	대리	1800000	1950000	200000	2150000
1057	이미경	780406-2003214	1998-02-11	경기	016-6542-7546	자재부	부장	2450000	2520000	160000	2680000
1058	김신제	800709-1321456	2003-08-08	인천	010-2415-5444	기획부	대리	1800000	1950000	180000	2130000
1059	임수봉	810809-2121244	2001-10-10	서울	011-4151-4154	개발부	사원	1650000	890000	102000	992000
1060	김신애	810809-2111111	2001-10-10	서울	011-4151-4444	개발부	사원	1650000	900000	102000	1002000
1061	정미화	940403-2234567	2010-11-11	서울	010-8743-1000	개발부	대리	1800000	2200000	2000000	4200000
*/


--7-2. 검색 직원 수 조회 쿼리문 (사번/이름/부서/직위)
SELECT COUNT(*) AS COUNT
FROM EMPVIEW
WHERE EMP_ID=1001;
--WHERE EMP_ID=1001;
--WHERE EMP_NAME='정미화';
--WHERE BUSEO_NAME='개발부';
--WHERE JIKWI_NAME='대리';
--> 한 줄 구성
SELECT COUNT(*) AS COUNT FROM EMPVIEW WHERE EMP_ID=1001
;
--==>> 1

--8. 직원 전체 출력 쿼리문(사번/이름/부서/직위/급여 내림차순)
SELECT EMP_ID, EMP_NAME, SSN, TO_CHAR(IBSADATE, 'YYYY-MM-DD') AS IBSADATE
     , CITY_LOC, TEL, BUSEO_NAME, JIKWI_NAME, BASICPAY, SUDANG, PAY
FROM EMPVIEW
--ORDER BY EMP_ID ASC;
--ORDER BY EMP_NAME ASC;
--ORDER BY BUSEO_NAME ASC;
--ORDER BY JIKWI_NAME ASC;
--ORDER BY PAY DESC;
--> 한 줄 구성
SELECT EMP_ID, EMP_NAME, SSN, TO_CHAR(IBSADATE, 'YYYY-MM-DD') AS IBSADATE, CITY_LOC, TEL, BUSEO_NAME, JIKWI_NAME, BASICPAY, SUDANG, PAY, FROM EMPVIEW ORDER BY EMP_ID
;


---------------------------
--1. 직원 전체 출력 VIEW

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


-- 사번 이름 주민번호 입사일 지역 전화번호 부서 직위 최소기본급 기본급 수당 급여
SELECT E.EMP_ID, E.EMP_NAME, E.SSN, E.IBSADATE
     , C.CITY_LOC, E.TEL, B.BUSEO_NAME, J.JIKWI_NAME
     , J.MIN_BASICPAY, E.BASICPAY, E.SUDANG
     , (E.BASICPAY + E.SUDANG) AS PAY
FROM TBL_EMP E, TBL_CITY C, TBL_BUSEO B, TBL_JIKWI J
WHERE E.CITY_ID = C.CITY_ID
  AND E.BUSEO_ID = B.BUSEO_ID
  AND E.JIKWI_ID = J.JIKWI_ID;
--ORDER BY E.EMP_ID ASC;        -- 사번 정렬
--ORDER BY E.EMP_NAME ASC;      -- 이름 정렬
--ORDER BY B.BUSEO_NAME ASC;    -- 부서 정렬
--ORDER BY J.JIKWI_NAME ASC;    -- 직위 정렬
--ORDER BY PAY DESC;            -- 급여 내림차순 정렬


--○ 뷰 생성(EMPVIEW)

CREATE OR REPLACE VIEW EMPVIEW
AS
SELECT E.EMP_ID , E.EMP_NAME, E.SSN, TO_CHAR(E.IBSADATE,'YYYY-MM-DD') AS IBSADATE, C.CITY_NAME, E.TEL, B.BUSEO_NAME
     , J.JIKWI_NAME, E.BASICPAY, E.SUDANG, (E.BASICPAY+E.SUDANG) AS PAY
FROM TBL_EMP E, TBL_CITY C, TBL_BUSEO B,TBL_JIKWI J
WHERE E.CITY_ID = C.CITY_ID  AND B.BUSEO_ID = E.BUSEO_ID AND E.JIKWI_ID = J.JIKWI_ID;
--==>> View EMPVIEW이(가) 생성되었습니다.

--○ 확인
SELECT *
FROM EMPVIEW;
--==>>
/*
1001	홍길동	771212-1022432	1998-10-11	서울	011-2356-4528	기획부	부장	2450000	2610000	200000	2810000
1002	이순신	801007-1544236	2000-11-29	경기	010-4758-6532	총무부	사원	1650000	1320000	200000	1520000
1003	이순애	770922-2312547	1999-02-25	인천	010-4231-1236	개발부	부장	2450000	2550000	160000	2710000
1004	김정훈	790304-1788896	2000-10-01	전북	019-5236-4221	영업부	대리	1800000	1954200	170000	2124200
1005	한석봉	811112-1566789	2004-08-13	서울	018-5211-3542	총무부	사원	1650000	1420000	160000	1580000
1006	이기자	780505-2978541	2002-02-11	인천	010-3214-5357	개발부	과장	2260000	2265000	150000	2415000
1007	장인철	780506-1625148	1998-03-16	제주	011-2345-2525	개발부	대리	1800000	1250000	150000	1400000
1008	김영년	821011-2362514	2002-04-30	서울	016-2222-4444	홍보부	사원	1650000	950000	145000	1095000
1009	나윤균	810810-1552147	2003-10-10	경기	019-1111-2222	인사부	사원	1650000	840000	220400	1060400
1010	김종서	751010-1122233	1997-08-08	부산	011-3214-5555	영업부	부장	2450000	2540000	130000	2670000
1011	유관순	801010-2987897	2000-07-07	서울	010-8888-4422	영업부	사원	1650000	1020000	140000	1160000
1012	정한국	760909-1333333	1999-10-16	강원	018-2222-4242	홍보부	사원	1650000	880000	114000	994000
1013	조미숙	790102-2777777	1998-06-07	경기	019-6666-4444	홍보부	대리	1800000	1601000	103000	1704000
1014	황진이	810707-2574812	2002-02-15	인천	010-3214-5467	개발부	사원	1650000	1100000	130000	1230000
1015	이현숙	800606-2954687	1999-07-26	경기	016-2548-3365	총무부	사원	1650000	1050000	104000	1154000
1016	이상헌	781010-1666678	2001-11-29	경기	010-4526-1234	개발부	과장	2260000	2350000	150000	2500000
1017	엄용수	820507-1452365	2000-08-28	인천	010-3254-2542	개발부	사원	1650000	950000	210000	1160000
1018	이성길	801028-1849534	2004-08-08	전북	018-1333-3333	개발부	사원	1650000	880000	123000	1003000
1019	박문수	780710-1985632	1999-12-10	서울	017-4747-4848	인사부	과장	2260000	2300000	165000	2465000
1020	유영희	800304-2741258	2003-10-10	전남	011-9595-8585	자재부	사원	1650000	880000	140000	1020000
1021	홍길남	801010-1111111	2001-09-07	경기	011-9999-7575	개발부	사원	1650000	875000	120000	995000
1022	이영숙	800501-2312456	2003-02-25	전남	017-5214-5282	기획부	대리	1800000	1960000	180000	2140000
1023	김인수	731211-1214576	1995-02-23	서울		영업부	부장	2450000	2500000	170000	2670000
1024	김말자	830225-2633334	1999-08-28	서울	011-5248-7789	기획부	대리	1800000	1900000	170000	2070000
1025	우재옥	801103-1654442	2000-10-01	서울	010-4563-2587	영업부	사원	1650000	1100000	160000	1260000
1026	김숙남	810907-2015457	2002-08-28	경기	010-2112-5225	영업부	사원	1650000	1050000	150000	1200000
1027	김영길	801216-1898752	2000-10-18	서울	019-8523-1478	총무부	과장	2260000	2340000	170000	2510000
1028	이남신	810101-1010101	2001-09-07	제주	016-1818-4848	인사부	사원	1650000	892000	110000	1002000
1029	김말숙	800301-2020202	2000-09-08	서울	016-3535-3636	총무부	사원	1650000	920000	124000	1044000
1030	정정해	790210-2101010	1999-10-17	부산	019-6564-6752	총무부	과장	2260000	2304000	124000	2428000
1031	지재환	771115-1687988	2001-01-21	서울	019-5552-7511	기획부	부장	2450000	2450000	160000	2610000
1032	심심해	810206-2222222	2000-05-05	전북	016-8888-7474	자재부	사원	1650000	880000	108000	988000
1033	김미나	780505-2999999	1998-06-07	서울	011-2444-4444	영업부	사원	1650000	1020000	104000	1124000
1034	이정석	820505-1325468	2005-09-26	경기	011-3697-7412	기획부	사원	1650000	1100000	160000	1260000
1035	정영희	831010-2153252	2002-05-16	인천		개발부	사원	1650000	1050000	140000	1190000
1036	이재영	701126-2852147	2003-08-10	서울	011-9999-9999	자재부	사원	1650000	960400	190000	1150400
1037	최석규	770129-1456987	1998-10-15	인천	011-7777-7777	홍보부	과장	2260000	2350000	187000	2537000
1038	손인수	791009-2321456	1999-11-15	부산	010-6542-7412	영업부	대리	1800000	2000000	150000	2150000
1039	고순정	800504-2000032	2003-12-28	경기	010-2587-7895	영업부	대리	1800000	2010000	160000	2170000
1040	박세열	790509-1635214	2000-09-10	경북	016-4444-7777	인사부	대리	1800000	2100000	130000	2230000
1041	문길수	721217-1951357	2001-12-10	충남	016-4444-5555	자재부	과장	2260000	2300000	150000	2450000
1042	채정희	810709-2000054	2003-10-17	경기	011-5125-5511	개발부	사원	1650000	1020000	200000	1220000
1043	양미옥	830504-2471523	2003-09-24	서울	016-8548-6547	영업부	사원	1650000	1100000	210000	1310000
1044	지수환	820305-1475286	2004-01-21	서울	011-5555-7548	영업부	사원	1650000	1060000	220000	1280000
1045	홍원신	690906-1985214	2003-03-16	전북	011-7777-7777	영업부	사원	1650000	960000	152000	1112000
1046	허경운	760105-1458752	1999-05-04	경남	017-3333-3333	총무부	부장	2450000	2650000	150000	2800000
1047	산마루	780505-1234567	2001-07-15	서울	018-0505-0505	영업부	대리	1800000	2100000	112000	2212000
1048	이기상	790604-1415141	2001-06-07	전남		개발부	대리	1800000	2050000	106000	2156000
1049	이미성	830908-2456548	2000-04-07	인천	010-6654-8854	개발부	사원	1650000	1300000	130000	1430000
1050	이미인	810403-2828287	2003-06-07	경기	011-8585-5252	홍보부	대리	1800000	1950000	103000	2053000
1051	권영미	790303-2155554	2000-06-04	서울	011-5555-7548	영업부	과장	2260000	2260000	104000	2364000
1052	권옥경	820406-2000456	2000-10-10	경기	010-3644-5577	기획부	사원	1650000	1020000	105000	1125000
1053	김싱식	800715-1313131	1999-12-12	전북	011-7585-7474	자재부	사원	1650000	960000	108000	1068000
1054	정상호	810705-1212141	1999-10-16	강원	016-1919-4242	홍보부	사원	1650000	980000	114000	1094000
1055	정한나	820506-2425153	2004-06-07	서울	016-2424-4242	영업부	사원	1650000	1000000	104000	1104000
1056	전용재	800605-1456987	2004-08-13	인천	010-7549-8654	영업부	대리	1800000	1950000	200000	2150000
1057	이미경	780406-2003214	1998-02-11	경기	016-6542-7546	자재부	부장	2450000	2520000	160000	2680000
1058	김신제	800709-1321456	2003-08-08	인천	010-2415-5444	기획부	대리	1800000	1950000	180000	2130000
1059	임수봉	810809-2121244	2001-10-10	서울	011-4151-4154	개발부	사원	1650000	890000	102000	992000
1060	김신애	810809-2111111	2001-10-10	서울	011-4151-4444	개발부	사원	1650000	900000	102000	1002000
1061	정미화	940403-2234567	2010-11-11	서울	010-8743-1000	개발부	대리	1800000	2200000	2000000	4200000
*/




--7. 검색 직원 수 조회 쿼리문 (사번/이름/부서/직위)
SELECT COUNT(*) AS COUNT
FROM EMPVIEW;
--WHERE EMP_ID=1001;
--WHERE EMP_NAME='이원영';
--WHERE BUSEO_NAME='개발부';
--WHERE JIKWI_NAME='대리';
--> 한 줄 구성
SELECT COUNT(*) AS COUNT FROM EMPVIEW
;

@@
--8. 직원 데이터 전체 조회 쿼리문(사번/이름/부서/직위/급여 내림차순)
--                             ------- WHY? TO_CHAR(IBSADATE, 'YYYY-MM-DD') AS IBSADATE 라고안쓰냐? 위에 저렇게써서 지금여기는 이미 설정되어잇는것.!
SELECT EMP_ID, EMP_NAME, SSN, TO_CHAR(IBSADATE, 'YYYY-MM-DD') AS IBSADATE
     , CITY_NAME, TEL, BUSEO_NAME, JIKWI_NAME
     , BASICPAY, SUDANG, (BASICPAY+SUDANG)PAY
FROM EMPVIEW
ORDER BY EMP_ID;
--ORDER BY EMP_NAME;
--ORDER BY BUSEO_NAME;
--ORDER BY JIKWI_NAME;
--ORDER BY PAY DESC;
--> 한 줄 구성
SELECT EMP_ID, EMP_NAME, SSN, TO_CHAR(IBSADATE, 'YYYY-MM-DD') AS IBSADATE, CITY_NAME, TEL, BUSEO_NAME, JIKWI_NAME, BASICPAY, SUDANG, PAY FROM EMPVIEW ORDER BY EMP_ID
;

--전화번호 없는 인원들을 위한 쿼리문 수정
SELECT EMP_ID, EMP_NAME, SSN, TO_CHAR(IBSADATE, 'YYYY-MM-DD') AS IBSADATE, CITY_NAME, NVL(TEL,'번호 없음') AS TEL, BUSEO_NAME, JIKWI_NAME, BASICPAY, SUDANG, PAY FROM EMPVIEW ORDER BY EMP_ID
;


--@@한줄말고 에러남 다시보기
--9. 직원 검색 쿼리문 구성 (사번/이름/부서/직위)

SELECT EMP_ID, EMP_NAME, SSN, TO_CHAR(IBSADATE, 'YYYY-MM-DD') AS IBSADATE
     , CITY_NAME, TEL, BUSEO_NAME, JIKWI_NAME, BASICPAY, SUDANG, PAY
FROM EMPVIEW;
WHERE EMP_ID = 1001;
--WHERE EMP_NAME = '정미화';
--WHERE BUSEO_NAME = '개발부';
--WHERE JIKWI_NAME = '대리';

/*SELECT EMP_ID, EMP_NAME, SSN, TO_CHAR(IBSADATE,'YYYY-MM-DD') AS IBSADATE, CITY_NAME, TEL, BUSEO_NAME, JIKWI_NAME, BASICPAY, SUDANG, PAY FROM EMPVIEW WHERE EMP_ID=1001
;*/

SELECT EMP_ID, EMP_NAME, SSN, IBSADATE, CITY_NAME, TEL, BUSEO_NAME, JIKWI_NAME, BASICPAY, SUDANG, PAY FROM EMPVIEW WHERE EMP_ID = 1001
;
--==>>1001	홍길동	771212-1022432	1998-10-11	서울	011-2356-4528	기획부	부장	2610000	200000	2810000

---------------------------------여기서부터 다시
--10. 직원 데이터 수정 쿼리문 
UPDATE TBL_EMP
SET EMP_NAME='이찬호', SSN='941108-1234567'
  , IBSADATE=TO_DATE('2012-11-11', 'YYYY-MM-DD')
  , CITY_ID=(SELECT CITY_ID FROM TBL_CITY WHERE CITY_NAME ='제주') --> 서브 쿼리 활용\
--           --------------------------------------------------블럭잡아서 제대로 나오는지 확인 -> 제주 CITY_ID는 10!!!!!!!!!!!
  , TEL='010-3370-5057'
  , BUSEO_ID=(SELECT BUSEO_ID FROM TBL_BUSEO WHERE BUSEO_NAME = '개발부')
  , JIKWI_ID=(SELECT JIKWI_ID FROM TLB_JIKWI WHERE JIKWI_NAME = '과장')
  , BASICPAY=3000000
  , SUDANG=2000000
WHERE EMP_ID = 1061;
--> 한 줄 구성


--==>>1 행 이(가) 업데이트되었습니다.

COMMIT;
--==>> 커밋 완료.


--11. 직원 데이터 삭제 쿼리문 구성
SELECT *
FROM TBL_EMP
WHERE EMP_ID=1061;
--==>> 한 줄 구성
SELECT * FROM TBL_EMP WHERE EMP_ID=1061
;

ROLLBACK;

