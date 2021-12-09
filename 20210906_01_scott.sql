SELECT USER
FROM DUAL;
--==>> SCOTT


SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750
20	    10875
30	    9400
(null)	29025
*/

SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750        -- 부서번호가 10번인 직원들의 급여합
20	    10875       -- 부서번호가 20번인 직원들의 급여합
30	    9400        -- 부서번호가 30번인 직원들의 급여합
(null)	8000        -- 부서번호가 존재하지 않는 직원들(null)의 급여합
(null)	37025       -- 모든 부서의 직원들의 급여합
*/


-- 위에서 조회한 내용을
/*
10	        8750        -- 부서번호가 10번인 직원들의 급여합
20	        10875       -- 부서번호가 20번인 직원들의 급여합
30	        9400        -- 부서번호가 30번인 직원들의 급여합
인턴	    8000        -- 부서번호가 존재하지 않는 직원들(null)의 급여합
모든부서    	37025       -- 모든 부서의 직원들의 급여합
*/
-- 이와 같이 조회하고자 한다.

SELECT CASE DEPTNO WHEN NULL
                   THEN '인턴'
                   ELSE DEPTNO
       END "부서번호"
FROM TBL_EMP;
--==>> 에러 발생
/*
ORA-00932: inconsistent datatypes: expected CHAR got NUMBER
00932. 00000 -  "inconsistent datatypes: expected %s got %s"
*Cause:    
*Action:
46행, 29열에서 오류 발생
*/

SELECT CASE DEPTNO WHEN NULL
                   THEN '인턴'
                   ELSE TO_CHAR(DEPTNO)
       END "부서번호"
FROM TBL_EMP;
--==>>
/*
20
30
30
20
30
30
10
20
10
30
20
30
20
10
*/

SELECT CASE WHEN DEPTNO IS NULL
            THEN '인턴'
            ELSE TO_CHAR(DEPTNO)
       END "부서번호"
FROM TBL_EMP;
/*
20
30
30
20
30
30
10
20
10
30
20
30
20
10
인턴
인턴
인턴
인턴
인턴
*/

SELECT CASE WHEN DEPTNO IS NULL
            THEN '인턴'
            ELSE TO_CHAR(DEPTNO)
       END "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750
20	    10875
30	    9400
인턴	8000
인턴	37025
*/


--※ GROPING()
SELECT DEPTNO "부서번호", SUM(SAL) "급여합", GROUPING(DEPTNO)
FROM TBL_EMP
GROUP BY DEPTNO;
--==>>
/*
30	    9400	0
(null)	8000	0
20	    10875	0
10	    8750    	0
*/


SELECT DEPTNO "부서번호", SUM(SAL) "급여합", GROUPING(DEPTNO)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750	    0
20	    10875	0
30	    9400	0
(null)	8000	0
(null)	37025	1
*/



--○ 아래와 같이 조회하고자 한다.
/*
10	        8750        -- 부서번호가 10번인 직원들의 급여합
20	        10875       -- 부서번호가 20번인 직원들의 급여합
30	        9400        -- 부서번호가 30번인 직원들의 급여합
인턴	    8000        -- 부서번호가 존재하지 않는 직원들(null)의 급여합
모든부서    	37025       -- 모든 부서의 직원들의 급여합
*/

SELECT CASE WHEN T.그룹단계 = 1     THEN '모든부서'
            WHEN T.부서번호 IS NULL THEN '인턴'
            ELSE TO_CHAR(T.부서번호)
       END "부서번호"
     , T.급여합
FROM 
(
    SELECT DEPTNO "부서번호", SUM(SAL) "급여합", GROUPING(DEPTNO) "그룹단계"
    FROM TBL_EMP
    GROUP BY ROLLUP(DEPTNO)
) T;



SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '모든부서' 
       END "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	        8750
20	        10875
30	        9400
인턴	    8000
모든부서	    37025
*/


--○ TBL_SAWON 테이블을 다음과 같이 조회될 수 있도록
--   쿼리문을 작성한다.
/*
----------------------
    성별      급여합
----------------------
    남        XXXX
    여        XXXX
    모든사원  XXXX
----------------------
*/


SELECT CASE GROUPING(T.성별) WHEN 0 THEN T.성별
            ELSE '모든사원'
       END "성별"
     , SUM(T.급여) "급여합"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '3') THEN '남'
                WHEN SUBSTR(JUBUN, 7, 1) IN('2', '4') THEN '여'
                ELSE '확인불가'
           END "성별"
         , SAL "급여"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남	        20000
여	        21000
모든사원	    41000
*/



--○ TBL_SAWON 테이블을 다음과 같이 연령대별 인원수 형태로
--   조회할 수 있도록 쿼리문을 작성한다.
/*
------------------------------------------
연령대             인원수
------------------------------------------
10                  X
20                  X
30                  X
40                  X
50                  X
전체                XX
------------------------------------------
*/

SELECT *
FROM TBL_SAWON;

--○ 나의 풀이
SELECT CASE GROUPING(T.연령대) WHEN 0 THEN TO_CHAR(T.연령대)
                              ELSE '전체'
       END "연령대"
     , COUNT(T.연령대) "인원수"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN TRUNC((EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900) + 1), -1)  
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                THEN TRUNC((EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000) + 1), -1)
                ELSE -1
           END "연령대"  -- 나이를 절삭
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.연령대);


--○ 함께 풀이
-- 방법1. (INLINE VIEW 를 두 번 중첩)
SELECT CASE GROUPING(Q.연령대) WHEN 0 THEN TO_CHAR(Q.연령대)
                              ELSE '전체'
       END "연령대"
     , COUNT(Q.연령대) "인원수"
FROM 
(
    SELECT CASE WHEN T.나이 >= 50 THEN 50
                WHEN T.나이 >= 40 THEN 40
                WHEN T.나이 >= 30 THEN 30
                WHEN T.나이 >= 20 THEN 20
                WHEN T.나이 >= 10 THEN 10            
                ELSE 0
           END "연령대"
    FROM
    (
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '2')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                    WHEN SUBSTR(JUBUN, 7, 1) IN('3', '4')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                    ELSE 0
               END "나이"
        FROM TBL_SAWON
    ) T
) Q
GROUP BY ROLLUP(Q.연령대);


-- 방법2. (INLINE VIEW 를 한 번 사용)
SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '2')
                  THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                  WHEN SUBSTR(JUBUN, 7, 1) IN('3', '4')
                  THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                  ELSE 0
            END, -1) "연령대" 
FROM TBL_SAWON;


SELECT TRUNC(23, -1) "확인"
FROM DUAL;
--==>> 20 → 23세의 연령대


--○ ROLLUP 활용 및 CUBE
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10		(null)      8750    -- 10번 부서 모든 직종의 급여합
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20		(null)      10875   -- 20번 부서 모든 직종의 급여합
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	    5600
30      (null)		9400    -- 30번 부서 모든 직종의 급여합
(null)  (null)		29025   -- 모든 부서 모든 직종의 급여합
*/


SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10		(null)      8750        -- 10번 부서 모든 직종의 급여합
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20		(null)      10875       -- 20번 부서 모든 직종의 급여합
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	    5600
30		(null)      9400        -- 30번 부서 모든 직종의 급여합
(null)	ANALYST	    6000        -- 모든 부서 ANALYST 직종의 급여합
(null)	CLERK	    4150        -- 모든 부서 CLERK 직종의 급여합
(null)	MANAGER	    8275        -- 모든 부서 MANAGER 직종의 급여합
(null)	PRESIDENT	5000        -- 모든 부서 PRESIDENT 직종의 급여합
(null)	SALESMAN	    5600        -- 모든 부서 SALESMAN 직종의 급여합
(null)  (null)		29025       -- 모든 부서 모든 직종의 급여합
*/


--※ ROLLUP() 과 CUBE() 는
--   그룹을 묶어주는 방식이 다르다. --차이

-- ROLLUP(A, B, C)
-- → (A, B, C) / (A, B) / (A) / ()

-- CUBE(A, B, C)
-- → (A, B, C) / (A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()


--==>> 위의 처리 내용은 너무 많은 결과물이 출력되기 때문에
--     다음의 쿼리 형태를 더 많이 사용한다.
--     다음 작성하는 쿼리는 조회하고자 하는 그룹만 『GROUPING SETS』를
--     이용하여 묶어주는 방법이다.

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
                            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
                         ELSE '전체직종'
       END "직종" 
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>> 
/*
10	        CLERK	    1300    -> 1. 부서번호와 직종이 모두 같은 것들끼리 묶음
10	        MANAGER	    2450
10	        PRESIDENT	5000
10	        전체직종	    8750    -> 2. 부서 번호가 같은 것들끼리
20	        ANALYST	    6000
20	        CLERK	    1900
20	        MANAGER	    2975
20	        전체직종    	10875
30	        CLERK	    950
30	        MANAGER	    2850
30	        SALESMAN    	5600
30	        전체직종    	9400
인턴  	    CLERK	    2500
인턴  	    SALESMAN    	5500
인턴	    전체직종    	8000
전체부서	    전체직종    	37025   -> 3.전체 다
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
                            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
                         ELSE '전체직종'
       END "직종" 
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;

--> 부서번호 / 직종 / 전체 다
/*
10	        CLERK	    1300
10	        MANAGER	    2450
10	        PRESIDENT	5000
10	        전체직종	    8750
20	        ANALYST	    6000
20	        CLERK	    1900
20	        MANAGER	    2975
20	        전체직종	    10875
30	        CLERK	    950
30	        MANAGER	    2850
30	        SALESMAN    	5600
30	        전체직종    	9400
인턴	    CLERK	    2500
인턴	    SALESMAN    	5500
인턴	    전체직종    	8000
전체부서    	ANALYST	    6000
전체부서    	CLERK	    6650
전체부서    	MANAGER	    8275
전체부서    	PRESIDENT	5000
전체부서    	SALESMAN    	11100
전체부서    	전체직종    	37025
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
                            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
                         ELSE '전체직종'
       END "직종" 
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), DEPTNO, ())    --ROLLUP() 과 같은 결과
ORDER BY 1, 2;


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
                            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
                         ELSE '전체직종'
       END "직종" 
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB), ())    --CUBE() 와 같은 결과
ORDER BY 1, 2;


--○ TBL_EMP 테이블에서 입사년도별 인원수를 조회한다.
SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;


SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE))
            WHEN 0 THEN TO_CHAR(EXTRACT(YEAR FROM HIREDATE))
            ELSE '전체'
       END "입사년도"
     , COUNT(EXTRACT(YEAR FROM HIREDATE)) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE));


SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY GROUPING SETS(EXTRACT(YEAR FROM HIREDATE), ())
ORDER BY 1;


-- 주의!
SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))      --'1980', '1981', '1982'...
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
499행, 26열에서 오류 발생
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(TO_CHAR(HIREDATE, 'YYYY'))      --'1980', '1981', '1982'...
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
513행, 26열에서 오류 발생
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY GROUPING SETS(TO_CHAR(HIREDATE, 'YYYY'), ())      --'1980', '1981', '1982'...
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
527행, 26열에서 오류 발생
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')      --'1980', '1981', '1982'...
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
541행, 26열에서 오류 발생
*/

--> GROUP BY 에서 묶어준 내용과 SELECT에서 출력하는 내용이 달라서 발생하는 에러일까?

SELECT TO_CHAR(HIREDATE, 'YYYY') "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')      --'1980', '1981', '1982'...
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982    	1
1987	2
2021    	5
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_NUMBER(TO_CHAR(HIREDATE, 'YYYY'))      --'1980', '1981', '1982'...
ORDER BY 1;
--> 숫자 타입으로 바꿨는데도 에러 발생
--> 파싱 순서 때문에 발생하는 에러 (그룹바이 한 내용 -> 셀렉트한 내용이 다름.)
--> 그룹바이 된 걸 셀렉트 해야 한다!!

SELECT TO_NUMBER(TO_CHAR(HIREDATE, 'YYYY')) "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_NUMBER(TO_CHAR(HIREDATE, 'YYYY'))      --'1980', '1981', '1982'...
ORDER BY 1;


--------------------------------------------------------------------------------
--■■■ HAVING ■■■--
-- 조건절

--○ EMP 테이블에서 부서번호가 20, 30인 부서를 대상으로
--   부서의 총 급여가 10000 보다 적을 경우만 부서별 총 급여를 조회한다.

SELECT *
FROM EMP;

SELECT DEPTNO "부서번호"
     , SUM(SAL) "총 급여"
FROM EMP
GROUP BY DEPTNO
ORDER BY 1;

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN(20, 30)
      AND SUM(SAL) < 10000
GROUP BY DEPTNO;
--==>> 에러 발생

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN(20, 30)
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000;
--==>> 30	9400
--> 더 권장하는 형태
-- WHERE 절에 해당하는 것만 메모리에 올려둔 후 처리하므로
-- 모두 HAVING 절에서 처리하는 것보다 더 효율적이다.

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING DEPTNO IN(20, 30)
   AND SUM(SAL) < 10000;
--==>> 30	9400


--------------------------------------------------------------------------------

--■■■ 중첩 그룹함수 / 분석함수 ■■■---

-- 그룹 함수 2 LEVEL 까지 중첩해서 사용할 수 있다.
-- 이마저도... MSSQL은 불가능하다.

SELECT SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
--==>>
/*
9400
10875
8750
*/

SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>> 10875


-- RANK()
-- DENSE_RANK()
--> ORCLE 9i 부터 적용... MSSQL 2005부터 적용...

--※ 하위 버전에서는 RANK() 나 DENSE_RANK() 를 적용할 수 없기 때문에
--   이를 대체하여 연산을 수행할 수 있는 방법을 강구해야 한다.

-- 예를 들어, 급여의 순위를 구하고자 한다면...
-- 해당 사원의 급여보다 더 큰 값이 몇 개인지 확인한 후
-- 확인한 숫자에 +1 을 추가 연산해주면 그것이 곧 등수가 된다.

-- 80 90 10 50 → 50 많은 것은 2개(80, 90) → 2 + 1 → 3등
--          -- 

SELECT ENAME, SAL, 1
FROM EMP;

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;
--==>> 14 → SMITH의 급여 등수

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600;
--==>> 7 → ALLEN의 급여 등수

SELECT ENAME, SAL, RANK() OVER(ORDER BY SAL DESC)
FROM EMP;


--※ 서브 상관 쿼리 (상관 서브 쿼리)
--   메인 쿼리에 있는 테이블 컬럼이
--   서브 쿼리의 조건절(WHERE절, HAVING절)에 사용되는 경우
--   우리는 이 쿼리문을 서브 상관 쿼리라고 부른다.

SELECT ENAME "사원명", SAL "급여", 1 "급여등수"
FROM EMP;

SELECT E1.ENAME "사원명", E1.SAL "급여", (SELECT COUNT(*) + 1
                                          FROM EMP E2
                                          WHERE E2.SAL > E1.SAL) "급여등수"
FROM EMP E1;
--==>>
/*
SMITH	800	    14
ALLEN	1600	7
WARD	    1250	    10
JONES	2975    	4
MARTIN	1250	    10
BLAKE	2850	    5
CLARK	2450    	6
SCOTT	3000	2
KING    	5000    	1
TURNER	1500    	8
ADAMS	1100	12
JAMES	950	    13
FORD	    3000	2
MILLER	1300	9
*/


--○ EMP 테이블을 대상으로
--   사원명, 급여, 부서번호, 부서내급여등수, 전체급여등수 항목을 조회한다.
--   단, RANK() 함수를 사용하지 않고, 상관 서브 쿼리를 활용할 수 있도록 한다.

SELECT E1.ENAME "사원명", E1.SAL "급여", E1.DEPTNO "부서번호"
     , (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO
              AND E2.SAL > E1.SAL) "부서내급여등수"
     , (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.SAL > E1.SAL) "전체급여등수"
FROM EMP E1
ORDER BY 3, 2 DESC;


--○ EMP 테이블을 대상으로 다음과 같이 조회할 수 있도록 쿼리문을 구성한다.
/*
--------------------------------------------------------------------------------
    사원명  부서번호 입사일     급여    부서내입사별급여누적
--------------------------------------------------------------------------------
    CLARK	10	    1981-06-09  2450    2450
    KING    10      1981-11-17  5000    7450
    MILLER	10	    1982-01-23	1300	8750
    SMITH	20	    1980-12-17	800	    800
    JONES	20	    1981-04-02	2975    	3775
    FORD    	20  	    1981-12-03	3000	6775
    SCOTT	20	    1987-07-13	3000	10875
    ADAMS	20	    1987-07-13	1100	10875
    ALLEN	30	    1981-02-20	1600	1600
    WARD    	30	    1981-02-22	1250	    2850
    BLAKE	30	    1981-05-01	2850	    5700
    TURNER	30	    1981-09-08	1500	    7200
    MARTIN	30	    1981-09-28	1250    	8450
    JAMES	30	    1981-12-03	950	    9400
*/

SELECT ENAME "사원명", DEPTNO "부서번호", HIREDATE "입사일", SAL "급여"
     , (SELECT SUM(SAL)
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO
              AND E2.HIREDATE <= E1.HIREDATE) "부서급여누적"
FROM EMP E1
ORDER BY DEPTNO, HIREDATE;



--○ TBL_EMP 테이블에서 입사한 사원의 수가 제일 많았을 때의
--   입사년월과 인원수를 조회할 수 있는 쿼리문을 구성한다.
/*
--------------------------------
    입사년월        인원수
--------------------------------
    2021-09         11
--------------------------------
*/
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (5);
--==>> 2021-09	5

SELECT MAX(COUNT(*))
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>> 5

SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM TBL_EMP
                   GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM'));
--==>> 2021-09	5


--------------------------------------------------------------------------------

--■■■ ROW_NUMBER() ■■■--
SELECT ENAME "사원명", SAL "급여", HIREDATE "입사일"
FROM EMP;

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "테스트"
     , ENAME "사원명", SAL "급여", HIREDATE "입사일"
FROM EMP;

--※ 게시판의 게시물 번호를 SEQUENCE 나 IDENTITY 를 사용하게 되면
--   게시물을 삭제했을 경우, 삭제한 게시물의 자리에 다음 번호를 가진
--   게시물이 등록되는 상황이 발생하게 된다.
--   이는 보안 측면에서나... 미관적인 측면에서나... 바람직하지 않은 상황일 수 있기 때문에
--   ROW_NUMBER() 의 사용을 고려해 볼 수 있다.
--   관리의 목적으로 사용할 때에는 SQUENCE 나 IDENTITY 를 사용하지만
--   단순히 게시물을 목록화하여 사용자에게 리스트 형식으로 보여줄 때에는
--   사용하지 않는 것이 좋다.


--※ 관찰
CREATE TABLE TBL_AAA
( NO        NUMBER
, NAME      VARCHAR2(30)
, GRADE     CHAR(10)
);
--==>> Table TBL_AAA이(가) 생성되었습니다.

INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(1, '손범석', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(2, '송해덕', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(3, '김진령', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(4, '최수지', 'D');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(5, '서승균', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(6, '정미화', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(7, '손범석', 'A');
--==>> 1 행 이(가) 삽입되었습니다. * 7

SELECT *
FROM TBL_AAA;
--==>>
/*
1	손범석	A         
2	송해덕	B         
3	김진령	A         
4	최수지	D         
5	서승균	A         
6	정미화	A         
7	손범석	A         
*/

COMMIT;
--==>> 커밋 완료.

UPDATE TBL_AAA
SET GRADE = 'A'
WHERE NAME = '최수지';
--==>> 1 행 이(가) 업데이트되었습니다.

SELECT *
FROM TBL_AAA;

UPDATE TBL_AAA
SET GRADE = 'A'
WHERE NAME = '최수지';
--==>> 1 행 이(가) 업데이트되었습니다.


--○ SEQUENCE (시퀀스: 주문번호) 생성
--   → 사전적인 의미: 1.(일련의) 연속적인 사건들  2(사건,행동 등의) 순서

CREATE SEQUENCE SEQ_BOARD       -- 시퀀스 생성 기본구문(MSSQL 의 IDENTITY 와 동일한 개념)
START WITH 1                    -- 시작값
INCREMENT BY 1                  -- 증가값
NOMAXVALUE                      -- 최대값 제한 없음
NOCACHE;                        -- 캐시 사용 안함(없음)
--==>> Sequence SEQ_BOARD이(가) 생성되었습니다.


--○ 테이블 생성(TBL_BOARD)
CREATE TABLE TBL_BOARD              -- TBL_BOARD 이름의 테이블 생성 → 게시판
( NO        NUMBER                  -- 게시물 번호           -- X
, TITLE     VARCHAR(50)             -- 게시물 제목           -- O
, CONTENTS  VARCHAR(2000)           -- 게시물 내용           -- O
, NAME      VARCHAR(20)             -- 게시물 작성자         -- △
, PW        VARCHAR(20)             -- 게시물 패스워드       -- △
, CREATED   DATE DEFAULT SYSDATE    -- 게시물 작성일         -- X
);
--==>> Table TBL_BOARD이(가) 생성되었습니다.


--○ 데이터 입력 → 게시판에 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '앗싸~1 1등', '내가 1등이지롱', '이찬호', 'JAVA006$', SYSDATE);
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '건강관리', '다들 건강 챙깁시당', '이윤서', 'JAVA006$', SYSDATE);
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '오늘은', '저녁 뭘 먹지', '손다정', 'JAVA006$', SYSDATE);
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '오늘은', '갑자기 비가 오네', '윤유동', 'JAVA006$', SYSDATE);
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '공부하고 싶은데', '자꾸 졸려요', '정효진', 'JAVA006$', SYSDATE);
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '질문', '배고프면 어떻게 하나요', '박혜진', 'JAVA006$', SYSDATE);
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '질문', '어려우면 어떡하죠', '박효빈', 'JAVA006$', SYSDATE);

SELECT *
FROM TBL_BOARD;
--==>>
/*
1	앗싸~1 1등	        내가 1등이지롱	            이찬호	JAVA006$	2021-09-06
2	건강관리            	다들 건강 챙깁시당	        이윤서	JAVA006$	2021-09-06
3	오늘은	            저녁 뭘 먹지	            손다정	JAVA006$	2021-09-06
4	오늘은	            갑자기 비가 오네	            윤유동	JAVA006$	2021-09-06
5	공부하고 싶은데	    자꾸 졸려요	                정효진	JAVA006$	2021-09-06
6	질문	                배고프면 어떻게 하나요	    박혜진	JAVA006$	2021-09-06
7	질문	                어려우면 어떡하죠	        박효빈	JAVA006$	2021-09-06
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO=5;
--==>> 1 행 이(가) 삭제되었습니다.


--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '졸려요', '전 그냥 잘래요', '김진희', 'JAVA006$', SYSDATE);


--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO=2;

DELETE
FROM TBL_BOARD
WHERE NO=7;

DELETE
FROM TBL_BOARD
WHERE NO=8;


--○ 확인
SELECT *
FROM TBL_BOARD;


--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '저는요', '잘 지내고 있어요', '정가연', 'JAVA006$', SYSDATE);


--○ 확인
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	앗싸~1 1등	내가 1등이지롱	        이찬호	JAVA006$	2021-09-06
3	오늘은	    저녁 뭘 먹지	        손다정	JAVA006$	2021-09-06
4	오늘은	    갑자기 비가 오네	        윤유동	JAVA006$	2021-09-06
6	질문	        배고프면 어떻게 하나요	박혜진	JAVA006$	2021-09-06
9	저는요	    잘 지내고 있어요	        정가연	JAVA006$	2021-09-06
*/

--○ 커밋
COMMIT;



SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;


--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '멋지죠', '멋져 멋져', '이중호', 'JAVA006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.


SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;

DELETE
FROM TBL_BOARD
WHERE NO=3;
--==>> 1 행 이(가) 삭제되었습니다.


--○ 커밋
COMMIT;
--==>> 커밋 완료.


SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
5	멋지죠	    이중호	2021-09-06
4	저는요	    정가연	2021-09-06
3	질문	        박혜진	2021-09-06
2	오늘은	    윤유동	2021-09-06
1	앗싸~1 1등	이찬호	2021-09-06
*/









