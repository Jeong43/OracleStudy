SELECT USER
FROM DUAL;
--==>> SCOTT

--■■■ UNION / UNION ALL ■■■--
-- ○ 실습 테이블 생성(TBL_JUMUN)
CREATE TABLE TBL_JUMUN              -- 주문 테이블 생성
( JUNO      NUMBER                  -- 주문 번호
, JECODE    VARCHAR2(30)            -- 제품 코드
, JUSU      NUMBER                  -- 주문 수량
, JUDAY     DATE DEFAULT SYSDATE    -- 주문 일자
);
--==>> Table TBL_JUMUN이(가) 생성되었습니다.
-- 고객의 주문이 발생했을 경우 주문에 대한 데이터가 입력될 수 있는 테이블


--○ 데이터 입력 → 고객의 주문 발생/접수
INSERT INTO TBL_JUMUN VALUES
(1, '홈런볼', 20, TO_DATE('2001-11-01 09:00:10', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(2, '구운양파', 10, TO_DATE('2001-11-01 09:23:15', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(3, '빼빼로', 30, TO_DATE('2001-11-02 12:00:11', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(4, '콘칩', 10, TO_DATE('2001-11-02 15:16:17', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(5, '다이제', 50, TO_DATE('2001-11-03 10:22:33', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(6, '홈런볼', 50, TO_DATE('2001-11-04 11:11:11', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(7, '콘칩', 20, TO_DATE('2001-11-06 19:10:10', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(8, '포카칩', 40, TO_DATE('2001-11-13 09:07:09', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(9, '칙촉', 30, TO_DATE('2001-11-15 10:23:09', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(10, '새우깡', 20, TO_DATE('2001-11-16 14:20:00', 'YYYY-MM-DD HH24:MI:SS'));
--==>> 1 행 이(가) 삽입되었습니다. * 10

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session이(가) 변경되었습니다.

UPDATE TBL_JUMUN
SET JECODE = '구운파'
WHERE JUNO = 2;
--==>> 1 행 이(가) 업데이트되었습니다.

SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	홈런볼	20	2001-11-01 09:00:10
2	구운파	10	2001-11-01 09:23:15
3	빼빼로	30	2001-11-02 12:00:11
4	콘칩  	10	2001-11-02 15:16:17
5	다이제	50	2001-11-03 10:22:33
6	홈런볼	50	2001-11-04 11:11:11
7	콘칩  	20	2001-11-06 19:10:10
8	포카칩	40	2001-11-13 09:07:09
9	칙촉  	30	2001-11-15 10:23:09
10	새우깡	20	2001-11-16 14:20:00
*/


--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 데이터 추가 입력 → 2001년 부터 시작된 주문이... 현재(2021년)까지 계속 발생~!!!
INSERT INTO TBL_JUMUN VALUES(98785, '홈런볼', 10, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98786, '빼빼로', 20, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98787, '홈런볼', 20, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98788, '새우깡', 20, SYSDATE); 
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98789, '콘칩', 10, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다. 

INSERT INTO TBL_JUMUN VALUES(98790, '콘칩', 20, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98791, '꼬북칩', 20, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98792, '뽀빠이', 10, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98793, '홈런볼', 30, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98794, '홈런볼', 10, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.


--○ 확인
SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	    홈런볼	20	2001-11-01 09:00:10
2	    구운파	10	2001-11-01 09:23:15
3	    빼빼로	30	2001-11-02 12:00:11
4	    콘칩  	10	2001-11-02 15:16:17
5	    다이제	50	2001-11-03 10:22:33
6	    홈런볼	50	2001-11-04 11:11:11
7	    콘칩	    20	2001-11-06 19:10:10
8	    포카칩	40	2001-11-13 09:07:09
9	    칙촉	    30	2001-11-15 10:23:09
10	    새우깡	20	2001-11-16 14:20:00
98785	홈런볼	10	2021-09-07 14:27:11
98786	빼빼로	20	2021-09-07 14:27:20
98787	홈런볼	20	2021-09-07 14:27:27
98788	새우깡	20	2021-09-07 14:27:32
98789	콘칩	    10	2021-09-07 14:28:25
98790	콘칩	    20	2021-09-07 14:28:30
98791	꼬북칩	20	2021-09-07 14:29:09
98792	뽀빠이	10	2021-09-07 14:29:13
98793	홈런볼	30	2021-09-07 14:30:01
98794	홈런볼	10	2021-09-07 14:30:11
*/


--○ 커밋
COMMIT;
--==>> 커밋 완료.


--※ 진하가 과자 쇼핑몰 운영 중...
--   TBL_JUMUN 테이블이 너무 무거워진 상황
--   어플리케이션과의 연동으로 인해 주문 내역을 다른 테이블에 저장될 수 있도록
--   다시 구성하는 것은 불가능한 상황
--   → 결과적으로... 현재까지 누적된 주문 데이터들 중
--      금일 발생한 주문 내역을 제외하고 나머지를 다른 테이블(TBL_JUMUNBACKUP)로
--      데이터 이관을 수행할 계획

--○ 금일 주문이 아닌 것 확인
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');


--○ 위의 조회 결과로 TBL_JUMUNBACKUP 테이블 생성
CREATE TABLE TBL_JUMUNBACKUP
AS
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
--==>> Table TBL_JUMUNBACKUP이(가) 생성되었습니다.


--○ 확인
SELECT *
FROM TBL_JUMUNBACKUP;
--==>>
/*
1	홈런볼	20	2001-11-01 09:00:10
2	구운파	10	2001-11-01 09:23:15
3	빼빼로	30	2001-11-02 12:00:11
4	콘칩	    10	2001-11-02 15:16:17
5	다이제	50	2001-11-03 10:22:33
6	홈런볼	50	2001-11-04 11:11:11
7	콘칩  	20	2001-11-06 19:10:10
8	포카칩	40	2001-11-13 09:07:09
9	칙촉	    30	2001-11-15 10:23:09
10	새우깡	20	2001-11-16 14:20:00
*/
--> TBL_JUMUN 테이블의 데이터 중
--  금일 주문내역 이외의 데이터는 모두 TBL_JUMUNBACKUP 테이블에 백업을 마친 상태


--○ TBL_JUMUN 테이블의 데이터 중
--   백업을 마친 데이터들 삭제 → 금일 주문이 아닌 데이터 제거
DELETE
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
--==>> 10개 행 이(가) 삭제되었습니다. (→ 98784 개의 데이터가 삭제됐다고 가정)

-- 아직 제품 발송이 완료되지 않은 금일 주문 데이터를 제외하고
-- 이전의 모든 주문 데이터들이 삭제된 상황이므로
-- 테이블은 행(레코드)의 갯수가 줄어들어 매우 가벼워진 상황


--○ 확인
SELECT *
FROM TBL_JUMUN;
--==>>
/*
98785	홈런볼	10	2021-09-07 14:27:11
98786	빼빼로	20	2021-09-07 14:27:20
98787	홈런볼	20	2021-09-07 14:27:27
98788	새우깡	20	2021-09-07 14:27:32
98789	콘칩  	10	2021-09-07 14:28:25
98790	콘칩	    20	2021-09-07 14:28:30
98791	꼬북칩	20	2021-09-07 14:29:09
98792	뽀빠이	10	2021-09-07 14:29:13
98793	홈런볼	30	2021-09-07 14:30:01
98794	홈런볼	10	2021-09-07 14:30:11
*/


--○ 커밋
COMMIT;

-- 그런데, 지금까지 주문 받은 내역에 대한 정보를
-- 제품별 총 주문량으로 나타내야 할 상황이 발생하게 되었다.
-- 그렇다면... TBL_JUMUNBACKUP 테이블의 레코드(행)와
-- TBL_JUMUN 테이블의 레코드(행)를 합쳐서 하나의 테이블을
-- 조회하는 것과 같은 결과를 확인할 수 있도록 해야 한다.

-- 컬럼과 컬럼의 관계를 고려하여 테이블을 결합하고자 하는 경우
-- JOIN 을 사용하지만
-- 레코드(행)와 레코드(행)를 결합하고자 하는 경우
-- UNION / UNION ALL 을 사용할 수 있다.


SELECT *
FROM TBL_JUMUNBACKUP
UNION
SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;


--○ 테이블 순서 바꾸기

SELECT *
FROM TBL_JUMUN
UNION
SELECT *
FROM TBL_JUMUNBACKUP;

SELECT *
FROM TBL_JUMUN
UNION ALL
SELECT *
FROM TBL_JUMUNBACKUP;

--※ UNION 은 항상 결과물의 첫 번째 컬럼을 기준으로
--   오름차순 정렬을 수행한다.
--   UNION ALL 은 결합된 순서대로 조회한 결과를 반환한다. (정렬 없음)
--   이로 인해 정렬 기능을 포함하고 있는 UNION 이 부하가 더 크다.
--   또한, UNION 은 결과물에서 중복된 행이 존재할 경우
--   중복을 제거하고 1개 행만 조회된 결과를 반환한다.

-->  따라서, UNION은 부하가 크고,
--   실무에서는 성능이 더 좋은 UNION ALL을 더 많이 쓴다!


--○ 지금까지 주문받은 모든 데이터를 통해
--   제품별 총 주문량을 조회하는 쿼리문을 구성한다.
/*
------------------------------------
    제품코드        총 주문량
------------------------------------
    ...             XX
    ...             XXXX

-------------------------------------
*/

SELECT JECODE "제품코드", SUM(JUSU) "총 주문량"
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
    UNION ALL
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
)
GROUP BY JECODE;
--==>>
/*
콘칩  	60
꼬북칩	20
새우깡	40
구운파	10
뽀빠이	10
포카칩	40
칙촉	    30
홈런볼	140
빼빼로	50
다이제	50
*/


SELECT JECODE "제품코드", SUM(JUSU) "총 주문량"
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
    UNION 
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
)
GROUP BY JECODE;
--==>>
/*
콘칩  	30
꼬북칩	20
구운파	10
새우깡	20
뽀빠이	10
칙촉    30
포카칩	40
다이제	50
빼빼로	50
홈런볼	110
*/
--> 이 문제를 해결하는 과정에서 UNION 을 사용해서는 안 된다.
--  → JECODE 와 JUSU 를 조회하는 과정에서 중복된 행을 제거하는 상황 발생~!!!


--○ INTERSECT / MINUS (→ 교집합 / 차집합)
-- TBL_JUMUNBACKUP 테이블과 TBL_JUMUN 테이블에서
-- 제품코드와 주문량의 값이 똑같은 해만 추출하고자 한다.
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP;
SELECT JECODE, JUSU
FROM TBL_JUMUN;

SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
새우깡	20
콘칩  	10
콘칩	    20
홈런볼	20
*/


--○ TBL_JUMUNBACKUP 테이블과 TBL_JUMUN 테이블에서
--   제품코드와 주문량의 값이 똑같은 행의 정보를
--   주문번호, 제품코드, 주문량, 주문일자 항목으로 조회한다.

-- 나의 풀이
SELECT T1.*
FROM
(
    SELECT *
    FROM TBL_JUMUN
    UNION
    SELECT *
    FROM TBL_JUMUNBACKUP
) T1
, (
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
) T2
WHERE T1.JECODE = T2. JECODE
  AND T1.JUSU = T2.JUSU;
--==>>
/*
1	    홈런볼	20	2001-11-01 09:00:10
4	    콘칩	    10	2001-11-02 15:16:17
7	    콘칩	    20	2001-11-06 19:10:10
10	    새우깡	20	2001-11-16 14:20:00
98787	홈런볼	20	2021-09-07 14:27:27
98788	새우깡	20	2021-09-07 14:27:32
98789	콘칩	    10	2021-09-07 14:28:25
98790	콘칩	    20	2021-09-07 14:28:30
*/


-- 방법 1.
SELECT T2.JUNO "주문번호", T1.JECODE "제품코드", T1.JUSU "주문수량", T2.JUDAY "주문일자"
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN    
) T1
JOIN
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) T2
ON T1.JECODE = T2.JECODE
   AND T1.JUSU = T2.JUSU;
--==>>
/*
1	    홈런볼	20	2001-11-01 09:00:10
4	    콘칩  	10	2001-11-02 15:16:17
7	    콘칩  	20	2001-11-06 19:10:10
10	    새우깡	20	2001-11-16 14:20:00
98787	홈런볼	20	2021-09-07 14:27:27
98788	새우깡	20	2021-09-07 14:27:32
98789	콘칩  	10	2021-09-07 14:28:25
98790	콘칩  	20	2021-09-07 14:28:30
*/
    
    
-- 방법 2.
SELECT T.*
FROM
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN    
) T
--WHERE JECODE IN ('홈런볼', '콘칩', '새우깡')
--  AND JUSU IN (10, 20)
--WHERE JECODE || JUSU IN ('홈런볼20', '콘칩10', '콘칩20', '새우깡20');
--WHERE CONCAT(JECODE, JUSU) IN ('홈런볼20', '콘칩10', '콘칩20', '새우깡20');
WHERE CONCAT(JECODE, JUSU) =ANY ('홈런볼20', '콘칩10', '콘칩20', '새우깡20');
    

SELECT CONCAT(JECODE, JUSU)
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT CONCAT(JECODE, JUSU)
FROM TBL_JUMUN;
--==>>
/*
새우깡20
콘칩10
콘칩20
홈런볼20
*/
  
    
SELECT T.*
FROM
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN    
) T
WHERE CONCAT(JECODE, JUSU) =ANY (SELECT CONCAT(JECODE, JUSU)
                                FROM TBL_JUMUNBACKUP
                                INTERSECT
                                SELECT CONCAT(JECODE, JUSU)
                                FROM TBL_JUMUN);    
--==>>
/*
1	    홈런볼	20	2001-11-01 09:00:10
4	    콘칩	    10	2001-11-02 15:16:17
7	    콘칩  	20	2001-11-06 19:10:10
10	    새우깡	20	2001-11-16 14:20:00
98787	홈런볼	20	2021-09-07 14:27:27
98788	새우깡	20	2021-09-07 14:27:32
98789	콘칩  	10	2021-09-07 14:28:25
98790	콘칩  	20	2021-09-07 14:28:30
*/
    
    
-- MINUS : 차집합
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
새우깡	20
콘칩  	10
콘칩	    20
홈런볼	20
*/
    
    
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
MINUS
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
구운파	10
다이제	50
빼빼로	30
칙촉	    30
포카칩	40
홈런볼	50
*/
    
/*
A = {10, 20, 30, 40, 50}
B = {10, 20, 30}

A - B = {40, 50}
*/
    
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
    
-- CHECK~!!!
SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP NATURAL JOIN DEPT;
--> 연결고리를 찾고, 조회하는 컬럼을 어디서 가져와야 하는지 생각해야 한다.
--> 오라클의 업무 부하가 많으므로 권장하지 않는 방식.

SELECT DEPT.DEPTNO, DNAME, ENAME, SAL
FROM EMP JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP JOIN DEPT
USING(DEPTNO);
--> 결합하는데 사용하는 컬럼이 무엇인지 명시
    
    
    
    
    
    
    
    
    