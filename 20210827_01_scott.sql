--○ 접속된 사용자 조회
SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 20;

--※ 테이블을 조회하는 과정에서 각 컬럼에서 별칭(ALIAS)을 부여할 수 있다.

SELECT EMPNO AS "사원번호", ENAME "사원명", JOB 직종, SAL "급   여", DEPTNO"부서번호"
FROM EMP
WHERE DEPTNO = 20;

--※ 테이블을 조회 시 사용하는 별칭의 기본 구문은 『AS "별칭명"』의 형태로 작성되며
--   이 때, 『AS』는 생략 가능하다.
--   또한, 『""』도 생략 가능하다.
--   하지만, 『""』를 생략할 경우 별칭명에 공백을 사용할 수 없다.
--   공백은 해당 컬럼의 종결을 의미하므로 별칭의 이름 내부에 공백을 사용할 경우
--   『""』를 사용하여 별칭을 부여할 수 있도록 처리해야 한다.

--○ EMP 테이블에서 부서번호가 20번과 30번 직원들의 정보 중
--   사원번호, 사원명, 직종명, 급여, 부서번호 항목을 조회한다.
--   단, 별칭(ALIAS)를 사용한다.

SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종", SAL "급여", DEPTNO "부서번호"
FROM EMP
WHERE DEPTNO = 20 || DEPTNO = 30;
--==>> 에러 발생


SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종", SAL "급여", DEPTNO "부서번호"
FROM EMP
WHERE DEPTNO = 20 OR DEPTNO = 30;
--==>>
/*
7369	SMITH	CLERK	        800	        20
7499	ALLEN	SALESMAN	        1600	    30
7521	    WARD    SALESMAN	        1250	        30
7566    	JONES	MANAGER	        2975	        20
7654    	MARTIN	SALESMAN	        1250	        30
7698	BLAKE	MANAGER	        2850	        30
7788	SCOTT	ANALYST	        3000	    20
7844	TURNER	SALESMAN    	    1500        	30
7876	ADAMS	CLERK	        1100	    20
7900	JAMES	CLERK	        950	        30
7902    	FORD    ANALYST	        3000	    20
*/


SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종", SAL "급여", DEPTNO "부서번호"
FROM EMP
WHERE DEPTNO IN (20, 30);
--> IN 연산자를 활용하여 이와 같이 처리할 수도 있으며
--  위의 구문과 같은 결과를 반환하게 된다.


--○ EMP 테이블에서 직종이 CLERK 인 사원들이 정보를 모두 조회한다.
SELECT *
FroM emP
WHerE Job = 'CLERK';

SELECT *
FROM EMP
WHERE JOB = 'CLerK';

--※ 오라클에서... 입력된 데이터(값) 만큼은
--   반.드.시. 대소문자 구분을 한다.


--○ EMP 테이블에서 직종이 CLECK 인 사원들 중
--   20번 부서에 근무하는 사원들의
--   사원번호, 사원명, 직종명, 급여, 부서번호 항목을 조회한다.
SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종", SAL "급여", DEPTNO "부서번호"
FROM EMP
WHERE JOB = 'CLERK' AND DEPTNO = 20;
/*
7369	SMITH	CLERK	800	    20
7876	ADAMS	CLERK	1100	20
*/


--○ EMP 테이블에서 10번 부서에 근무하는 직원들 중
--   급여가 2500 이상인 직원들의
--   사원명, 직종명, 급여, 부서번호 항목을 조회한다.
SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종", SAL "급여", DEPTNO "부서번호"
FROM EMP
WHERE DEPTNO = 10 AND SAL >= 2500;
--==>> 7839	KING    	PRESIDENT	5000	    10


-- ○ 테이블 복사
--> 내부적으로 대상 테이블 안에 있는 데이터 내용만 복사하는 과정

--※ EMP 테이블의 데이터를 확인하여
--   이와 똑같은 데이터가 들어있는 EMPCOPY 테이블을 생성한다. (팀별로...)
DESCRIBE EMP;
DESCRIBE EMPCOPY;

SELECT *
FROM EMP;

SELECT *
FROM EMPCOPY;

CREATE TABLE EMPCOPY
AS
SELECT * 
FROM EMP;

CREATE TABLE EMPCOPY
( EMPNO         NUMBER(4)    
, ENAME         VARCHAR2(10) 
, JOB           VARCHAR2(9)  
, MGR           NUMBER(4)    
, HIREDATE      DATE         
, SAL           NUMBER(7,2)  
, COMM          NUMBER(7,2)  
, DEPTNO        NUMBER(2)   
);

INSERT INTO EMPCOPY (SELECT * FROM EMP);

INSERT INTO EMPCOPY VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMPCOPY VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMPCOPY VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMPCOPY VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMPCOPY VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMPCOPY VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMPCOPY VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMPCOPY VALUES
(7788,'SCOTT','ANALYST',7566,to_date('13-7-1987','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMPCOPY VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMPCOPY VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMPCOPY VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-7-1987','dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMPCOPY VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMPCOPY VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMPCOPY VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);

--------------------------------------------------------------------------------

CREATE TABLE EMP2
AS                   -- ~에 따라서
SELECT *
FROM EMP;
--==>> Table EMP2이(가) 생성되었습니다.
-- 데이터 위주의 복사(cf. 자바의 얕은 복사)

--○ 복사한 테이블 확인
SELECT *
FROM EMP2;

DESC EMP2;


--※ 날짜 관련 형식 세션 정보 설정
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


DROP TABLE EMPCOPY;
--==>> Table EMPCOPY이(가) 삭제되었습니다.


DELETE
FROM EMP2;
--==>> 14개 행 이(가) 삭제되었습니다.

SELECT *
FROM EMP2;

SELECT *
FROM EMPCOPY;

DROP TABLE EMP2;
--==>> Table EMP2이(가) 삭제되었습니다.

CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP이(가) 생성되었습니다.

CREATE TABLE TBL_DEPT
AS
SELECT *
FROM DEPT;
--==>> Table TBL_DEPT이(가) 생성되었습니다.


--○ 복사한 테이블 확인
SELECT *
FROM TBL_EMP;

SELECT *
FROM TBL_DEPT;


-- ○ 테이블의 커멘트 정보 확인
SELECT *
FROM USER_TAB_COMMENTS;


-- ○ 테이블의 커멘트 정보 입력
COMMENT ON TABLE TBL_EMP IS '사원정보';
--==>> Comment이(가) 생성되었습니다.


-- ○ 테이블의 커멘트 정보 다시 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_EMP	          TABLE	사원정보
SALGRADE	      TABLE	
BONUS	          TABLE	
DEPT	          TABLE	
TBL_DEPT	      TABLE	
TBL_EXAMPLE1	  TABLE	
TBL_EXAMPLE2	  TABLE	
EMP	              TABLE	
*/


-- ○ 테이블 레벨의 커멘트 정보 입력(TBL_DEPT → 부서정보)
COMMENT ON TABLE TBL_DEPT IS '부서정보';
--==>> Comment이(가) 생성되었습니다.


-- ○ 테이블의 커멘트 정보 다시 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_EMP	            TABLE	사원정보
SALGRADE	        TABLE	
BONUS	            TABLE	
DEPT	            TABLE	
TBL_DEPT	        TABLE	부서정보
TBL_EXAMPLE1        TABLE	
TBL_EXAMPLE2	    TABLE	
EMP	                TABLE	
*/


--○ 컬럼 레벨의 커멘트 정보 확인
SELECT *
FROM USER_COL_COMMENTS;
--==>>
/*
SALGRADE	GRADE	
EMP	        JOB	
EMP	        MGR	
TBL_EXAMPLE1	NAME	
TBL_EMP	COMM	
EMP	EMPNO	
DEPT	DEPTNO	
SALGRADE	LOSAL	
EMP	HIREDATE	
DEPT	DNAME	
TBL_EMP	MGR	
TBL_EMP	EMPNO	
EMP	SAL	
TBL_EXAMPLE1	NO	
EMP	DEPTNO	
TBL_EMP	DEPTNO	
TBL_DEPT	DEPTNO	
TBL_EMP	JOB	
TBL_EMP	ENAME	
BONUS	COMM	
TBL_EXAMPLE1	ADDR	
EMP	ENAME	
TBL_EXAMPLE2	ADDR	
BONUS	SAL	
SALGRADE	HISAL	
EMP	COMM	
TBL_EXAMPLE2	NO	
TBL_EMP	SAL	
TBL_EMP	HIREDATE	
TBL_DEPT	LOC	
DEPT	LOC	
BONUS	JOB	
TBL_EXAMPLE2	NAME	
BONUS	ENAME	
TBL_DEPT	DNAME	
*/


--※ 휴지통 비우기
PURGE RECYCLEBIN;
--==>> RECYCLEBIN이(가) 비워졌습니다.


SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_DEPT';
--==>>
/*
TBL_DEPT	DEPTNO	
TBL_DEPT	DNAME	
TBL_DEPT	LOC	
*/


--○ 테이블에 소속된(포함된) 컬럼 레벨의 커멘트 정보 입력(설정)
COMMENT ON COLUMN TBL_DEPT.DEPTNO IS '부서번호';
--==>> Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_DEPT.DNAME IS '부서명';
--==>> Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_DEPT.LOC IS '부서명';
--==>> Comment이(가) 생성되었습니다.


--○ 컬럼 레벨의 커멘트 정보 확인
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_DEPT';
--==>>
/*
TBL_DEPT	DEPTNO	부서번호
TBL_DEPT	DNAME	부서명
TBL_DEPT	LOC	    부서명
*/

DESC TBL_EMP;

/*
이름       널? 유형           
-------- -- ------------ 
EMPNO       NUMBER(4)       -- 사원번호
ENAME       VARCHAR2(10)    -- 사원명
JOB         VARCHAR2(9)     -- 직종명
MGR         NUMBER(4)       -- 관리자사원번호
HIREDATE    DATE            -- 입사일
SAL         NUMBER(7,2)     -- 급여
COMM        NUMBER(7,2)     -- 수당
DEPTNO      NUMBER(2)       -- 부서번호
*/

COMMENT ON COLUMN TBL_EMP.EMPNO IS '사원번호';
COMMENT ON COLUMN TBL_EMP.ENAME IS '사원명';
COMMENT ON COLUMN TBL_EMP.JOB IS '직종명';
COMMENT ON COLUMN TBL_EMP.MGR IS '관리자사원번호';
COMMENT ON COLUMN TBL_EMP.HIREDATE IS '입사일';
COMMENT ON COLUMN TBL_EMP.SAL IS '급여';
COMMENT ON COLUMN TBL_EMP.COMM IS '수당';
COMMENT ON COLUMN TBL_EMP.DEPTNO IS '부서번호';
--==>> Comment이(가) 생성되었습니다. * 8


--○ 커멘트 정보가 입력된 테이블의 컬럼 레벨의 정보 확인
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_EMP';
--==>>
/*
TBL_EMP	EMPNO	    사원번호
TBL_EMP	ENAME	    사원명
TBL_EMP	JOB	        직종명
TBL_EMP	MGR	        관리자사원번호
TBL_EMP	HIREDATE	    입사일
TBL_EMP	SAL	        급여
TBL_EMP	COMM	        수당
TBL_EMP	DEPTNO	    부서번호
*/


--■■■ 컬럼 구조의 추가 및 제거 ■■■--
SELECT *
FROM TBL_EMP;

--○ TBL_EMP 테이블에 주민등록번호 정보를 담을 수 있는 컬럼 추가
ALTER TABLE TBL_EMP 
ADD SSN CHAR(13);
--==>> Table TBL_EMP이(가) 변경되었습니다.


----------------------------------

SELECT 9501052234567
FROM DUAL;
--==>> 9501052234567

SELECT 0501052234567
FROM DUAL;
--==>> 501052234567

SELECT '0501052234567'
FROM DUAL;
--==>> 0501052234567

SELECT 01044342587
FROM DUAL;
--==>> 1044342587

SELECT '01044342587'
FROM DUAL;
--==>> 01044342587

----------------------------------

SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902    	1980-12-17	800		        20	
7499	ALLEN	SALESMAN	    7698	1981-02-20	1600	300	    30	
7521    WARD	    SALESMAN	    7698	1981-02-22	1250    500	    30	
7566	    JONES	MANAGER	    7839	1981-04-02	2975		        20	
7654    MARTIN	SALESMAN    7698	    1981-09-28	1250    	1400	30	
7698	BLAKE	MANAGER	    7839	1981-05-01	2850		        30	
7782    	CLARK	MANAGER	    7839	1981-06-09	2450		        10	
7788	SCOTT	ANALYST     7566    1987-07-13	3000		    20	
7839	KING    	PRESIDENT		    1981-11-17	5000		        10	
7844	TURNER	SALESMAN   	7698	1981-09-08	1500	    0	    30	
7876	ADAMS	CLERK	    7788	1987-07-13	1100		    20	
7900	JAMES	CLERK	    7698	1981-12-03	950		        30	
7902    FORD    ANALYST	    7566    1981-12-03	3000		    20	
7934	MILLER	CLERK	    7782    1982-01-23	1300		    10	
*/
--> SSN 컬럼이 정상적으로 추가된 상황임을 확인

SELECT EMPNO, ENAME, SSN, HIREDATE, SAL, COMM
FROM TBL_EMP;
--> 테이블 내에서 컬럼의 순서는 구조적으로 의미 없음.


--○ TBL_EMP 테이블에서 추가한 SSN(주민등록번호) 컬럼 제거
ALTER TABLE TBL_EMP
DROP COLUMN SSN;
--==>> Table TBL_EMP이(가) 변경되었습니다.
-- 다양한 것을 드랍시킬 수 있으므로, 드랍 시킬 것이 '컬럼'임을 명시해주어야 함.


--○ 확인
SELECT *
FROM TBL_EMP;

DESC TBL_EMP;
--> SSN(주민등록번호) 컬럼이 정상적으로 제거되었음을 확인


--○ 데이터 삭제
SELECT *
FROM TBL_EMP
WHERE ENAME = 'SMITH';

DELETE
FROM TBL_EMP
WHERE ENAME = 'SMITH';


DELETE TBL_EMP;     -- 권장하지 않음

DELETE              -- SELECT 로 지울 내용 확인 → DELETE로 변경하여 삭제
FROM TBL_EMP;       -- 권장


--○ 테이블을 구조적으로 삭제(데이터의 내용 뿐 아니라... 테이블 자체를 제거)
DROP TABLE TBL_EMP;
--==>> Table TBL_EMP이(가) 삭제되었습니다.

--○ 확인
SELECT *
FROM TBL_EMP;
--==>> 에러 발생
/*
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:
478행, 6열에서 오류 발생
*/


--○ 테이블 다시 생성(복사)
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP이(가) 생성되었습니다.

--------------------------------------------------------------------------------

--○ NULL 의 처리
SELECT 2, 10+2, 10-2, 10*2, 10/2
FROM DUAL;
--==>> 2	    12	8	20	5


SELECT NULL, NULL+2, NULL-2, NULL*2, NULL/2, 10+NULL, 10-NULL, 10*NULL, 10/NULL
FROM DUAL;
--==>> (null) (null) (null) (null) (null) (null) (null) (null) (null)

--※ 관찰 결과
--   NULL 은 상태의 값을 의미하며, 실제 존재하지 않는 값이기 때문에
--   이 NULL 이 연산에 포함된 경우... 그 결과는 무조건 NULL 이다.


-- ○ TBL_EMP 테이블에서 커미션(COMM, 수당)이 NULL 인 직원의
--    사원명, 직종명, 급여, 커미션 항목을 조회한다.
SELECT ENAME "사원명", JOB "직종", SAL "급여", COMM "커미션"
FROM TBL_EMP
WHERE COMM = NULL;
--==>> 조회 결과 없음

SELECT ENAME "사원명", JOB "직종", SAL "급여", COMM "커미션"
FROM TBL_EMP
WHERE COMM = (null);
--==>> 조회 결과 없음

SELECT ENAME "사원명", JOB "직종", SAL "급여", COMM "커미션"
FROM TBL_EMP
WHERE COMM = 'NULL';
--==>> 에러 발생
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

DESC TBL_EMP;
--> COMM 컬럼은 숫자형 데이터 타입을 취하고 있음을 확인
--※ NULL 은 실제 존재하지 않는 값이기 때문에 일반적인 연산자를 활용하여 비교할 수 없다.
--   즉, 산술적인 비교 연산을 수행할 수 없다는 의미이다.
--   NULL 을 대상으로 사용할 수 없는 연산자들...
--   >=, <=, >, <, !=, ^=, <>

SELECT ENAME "사원명", JOB "직종", SAL "급여", COMM "커미션"
FROM TBL_EMP
WHERE COMM IS NULL;
/*
SMITH	CLERK	    800	
JONES	MANAGER	    2975	
BLAKE	MANAGER	    2850	
CLARK	MANAGER	    2450	
SCOTT	ANALYST	    3000	
KING    	PRESIDENT	5000	
ADAMS	CLERK	    1100	
JAMES	CLERK	    950	
FORD	    ANALYST	    3000	
MILLER	CLERK	    1300	
*/


--○ TBL_EMP 테이블에서 20번 부서에서 근무하지 않는 직원들의
--   사원명, 직종명, 부서번호 항목을 조회한다.

SELECT ENAME "사원명", JOB "직종", DEPTNO "부서번호"
FROM TBL_EMP
WHERE DEPTNO != 20;
-- WHERE DEPTNO ^= 20;
-- WHERE DEPTNO <> 20;
--==>>
/*
ALLEN	SALESMAN	        30
WARD	    SALESMAN        	30
MARTIN	SALESMAN	        30
BLAKE	MANAGER	        30
CLARK	MANAGER	        10
KING	PRESIDENT	        10
TURNER	SALESMAN        	30
JAMES	CLERK	        30
MILLER	CLERK	        10
*/


--○ TBL_EMP 테이블에서 커미션이 NULL 이 아닌 직원들의
--   사원명, 직종명, 급여, 커미션 항목을 조회한다.
SELECT ENAME "사원명", JOB "직종", SAL "급여", COMM "커미션"
FROM TBL_EMP
WHERE COMM IS NOT NULL;
-- WHERE NOT COMM IS NULL;
--==>>
/*
ALLEN	SALESMAN	    1600	300
WARD	    SALESMAN	    1250	    500
MARTIN	SALESMAN	    1250	    1400
TURNER	SALESMAN	    1500    	0
*/


--○ TBL_EMP 테이블에서 모든 사원들의
--   사원번호, 사원명, 급여, 커미션, 연봉 항목을 조회한다.
--   단, 급여(SAL)는 매월 지급한다. (→ 1회/월)  
--   또한, 수당(COMM)은 매년 지급한다. (→ 1회/연)
SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", COMM "커미션", SAL*12+COMM "연봉"
FROM TBL_EMP;
--==>>
/*
7369	SMITH	800		
7499	ALLEN	1600	300	    19500
7521    	WARD	    1250	    500	    15500
7566	    JONES	2975		
7654	    MARTIN	1250    	1400	16400
7698	BLAKE	2850		
7782	    CLARK	2450		
7788	SCOTT	3000		
7839	KING    	5000		
7844	TURNER	1500    	0	    18000
7876	ADAMS	1100		
7900	JAMES	950		
7902    	FORD	3   000		
7934	MILLER	1300		
*/

-- NVL()


SELECT NULL "1", NVL(NULL, 10) "2", NVL(10, 20) "3"
FROM DUAL;
--==>> (null)   10  10
--> 첫 번째 파라미터 값이 NULL 이면, 두 번째 파라미터 값을 반환한다.
--  첫 번째 파라미터 값이 NULL 이 아니면, 그 값(첫 번째 파라미터)을 그대로 반환한다.


-- 관찰
SELECT *
FROM EMP
WHERE EMPNO = 7369;
--==>> 7369	SMITH	CLERK	7902	1980-12-17	800	    (null)	20

SELECT ENAME, COMM
FROM EMP
WHERE EMPNO = 7369;
--==>> 7369	SMITH	(null)

SELECT ENAME, NVL(COMM, 0)
FROM EMP
WHERE EMPNO = 7369;
--==>> 7369	SMITH	0

SELECT ENAME "사원명", COMM "수당", NVL(COMM, -1) "함수호출결과"
FROM TBL_EMP;
--==>>
/*
SMITH	(null)  -1
ALLEN	300	    300
WARD	    500	    500
JONES	(null)  -1
MARTIN	1400	1400
BLAKE	(null)  -1
CLARK	(null)  -1
SCOTT	(null)  -1
KING	    (null)  -1
TURNER	0	    0
ADAMS	(null)  -1
JAMES	(null)  -1
FORD		(null)  -1
MILLER	(null)  -1
*/


SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", NVL(COMM, 0) "커미션"
       , SAL*12 + NVL(COMM, 0) "연봉"
FROM TBL_EMP;
--==>>
/*
7369	SMITH	800	    0	    9600
7499	ALLEN	1600	300	    19500
7521	    WARD	    1250    	500	    15500
7566	    JONES	2975    	0	    35700
7654	    MARTIN	1250	    1400	16400
7698	BLAKE	2850    	0	    34200
7782	    CLARK	2450    	0	    29400
7788	SCOTT	3000	0	    36000
7839	KING	    5000    	0	    60000
7844	TURNER	1500	    0	    18000
7876	ADAMS	1100	0	    13200
7900	JAMES	950	    0	    11400
7902	    FORD	    3000	0   	36000
7934	MILLER	1300	0	    15600
*/


--○ NVL2()
--> 첫 번째 파라미터 값이 NULL 이 아닌 경우, 두 번째 파라미터 값을 반환하고
--  첫 번째 파라미터 값이 NULL 인 경우, 세 번째 파라미터 값을 반환한다.

SELECT ENAME, COMM, NVL2(COMM, '청기올려', '백기올려') "확인여부"
FROM TBL_EMP;
--==>>
/*
SMITH	(null)  백기올려
ALLEN	300	    청기올려
WARD    	500     	청기올려
JONES	(null)  백기올려
MARTIN	1400	청기올려
BLAKE	(null)  백기올려
CLARK	(null)  백기올려
SCOTT	(null)  백기올려
KING		(null)  백기올려
TURNER	0	    청기올려
ADAMS	(null)  백기올려
JAMES	(null)  백기올려
FORD		(null)  백기올려
MILLER	(null)  백기올려
*/


--○ NVL2() 활용~ 연봉조회
-- COMM 이 NULL 이 아니면... SAL*12+COMM
-- COMM 이 NULL 이면........ SAL*12
SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", COMM "커미션"
     ,NVL2(COMM, SAL*12+COMM, SAL*12) "연봉"
FROM TBL_EMP;

--==>>
/*
7369	SMITH	800		        9600
7499	ALLEN	1600	300	    19500
7521	    WARD	    1250	    500	    15500
7566	    JONES	2975		        35700
7654    	MARTIN	1250	    1400	16400
7698	BLAKE	2850		        34200
7782    	CLARK	2450		        29400
7788	SCOTT	3000		    36000
7839	KING	    5000		        60000
7844	TURNER	1500    	0	    18000
7876	ADAMS	1100		    13200
7900	JAMES	950		        11400
7902	    FORD    	3000		    36000
7934	MILLER	1300		    15600
*/


--○ COALESCE()
--> 매개변수 제한이 없는 형태로 인지하고 활용한다.
-- 맨 앞에 있는 매개변수부터 차례대로 NULL 인지 아닌지 확인하여
-- NULL 이 아닐 경우 적용(반환, 처리)하고,
-- NULL 인 경우에는 그 다음 매개변수의 값으로 적용(반환, 처리)한다.
-- NVL() 나 NVL2() 에 비해... 모~~~ 든 경우의 수를 고려하여 처리할 수 있는 특징을 갖고 있다.

SELECT NULL "기본 확인"
     , COALESCE(NULL, NULL, NULL, NULL, 30) "함수확인1"
     , COALESCE(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100) "함수확인2"
     , COALESCE(10, NULL, NULL, NULL, NULL) "함수확인3"
     , COALESCE(NULL, NULL, 200, NULL, NULL) "함수확인4"
FROM DUAL;
--==>> 	30	100	10	200


--○ 실습을 위한 데이터 추가 입력
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO)
VALUES(8000, '송해덕', 'SALESMAN', 7839, SYSDATE, 10);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, COMM, DEPTNO)
VALUES(8001, '이다영', 'SALESMAN', 7839, SYSDATE, 100, 10);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_EMP;

COMMIT;
--==>> 커밋 완료.


--○ TBL_EMP 테이블에서 모든 사원들의
--   사원번호, 사원명, 급여, 커미션, 연봉 항목을 조회한다.
--   단, 급여(SAL)는 매월 지급한다. (→ 1회/월)  
--   또한, 수당(COMM)은 매년 지급한다. (→ 1회/연)
--   ※ COALESCE() 함수를 활용한다.

SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", COMM "커미션"
     , COALESCE(SAL*12+COMM, SAL*12, COMM, 0) "연봉"
FROM TBL_EMP;
--==>>
/*
7369	SMITH	800		        9600
7499	ALLEN	1600	300     19500
7521    	WARD	    1250    	500	    15500
7566	    JONES	2975		        35700
7654    	MARTIN	1250	    1400	16400
7698	BLAKE	2850		        34200
7782	    CLARK	2450		        29400
7788	SCOTT	3000		    36000
7839	KING	    5000		        60000
7844	TURNER	1500	    0	    18000
7876	ADAMS	1100		    13200
7900	JAMES	950		        11400
7902    	FORD	    3000		    36000
7934	MILLER	1300		    15600
8000	송해덕			        0
8001	이다영		    100	    100
*/


--------------------------------------------------------------------------------

--※ 날짜에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

--○ 현재 날짜 및 시간을 반환하는 함수
SELECT SYSDATE, CURRENT_DATE, LOCALTIMESTAMP
FROM DUAL;
--==>> 
/*
2021-08-27 16:33:18	    
2021-08-27 16:33:18     	
21/08/27 16:33:18.000000000
*/

--※ 날짜에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


--○ 컬럼과 컬럼의 연결(결합)
--   문자타입과 문자타입의 연결
--   『+』 연산자를 통한 결합 수행은 불가능 → 『||』

SELECT 1+1
FROM DUAL;

SELECT '송해덕' + '이다영' 
FROM DUAL;
--==>> 에러 발생
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

SELECT '송해덕', '이다영'
FROM DUAL;
--==>> 송해덕	이다영

SELECT '송해덕' || '이다영'
FROM DUAL;
--==>> 송해덕이다영

SELECT EMPNO, ENAME
FROM TBL_EMP;

SELECT EMPNO || ENAME
FROM TBL_EMP;
--==>>
/*
7369SMITH
7499ALLEN
7521WARD
7566JONES
7654MARTIN
7698BLAKE
7782CLARK
7788SCOTT
7839KING
7844TURNER
7876ADAMS
7900JAMES
7902FORD
7934MILLER
8000송해덕
8001이다영
*/

--       문자타입   날짜타입  문자타입   숫자타입   문자타입
--      ---------   -------  ---------   ---  -------------
SELECT '해덕이는 ', SYSDATE, '에 연봉 ', 500, '억을 원한다.'
FROM DUAL;

--       문자타입     날짜타입    문자타입   숫자타입     문자타입
--      ---------     -------    ---------     ---    -------------
SELECT '해덕이는 ' || SYSDATE || '에 연봉 ' || 500 || '억을 원한다.'
FROM DUAL;
--==>> 해덕이는 2021-08-27에 연봉 500억을 원한다.

--※ 오라클에서는 문자 타입의 형태로 형 변환하는 별도의 과정 없이
--   위에서 처리한 내용처럼 『||』만 삽입해주면 간단히 컬럼과 컬럼을
--   (즉, 서로 다른 종류의 데이터들을) 결합하는 것이 가능하다.
--   MSSQL 서버에서는 모든 데이터를 문자 타입으로 CONVERT 해야 한다.     ★★★

DELETE
FROM TBL_EMP
WHERE EMPNO IN (8000, 8001);
--==>> 2개 행 이(가) 삭제되었습니다.

COMMIT;
--==>> 커밋 완료.


--○ TBL_EMP 테이블의 정보를 활용하여
--   모든 직원들의 데이터에 대해서
--   다음과 같은 결과를 얻을 수 있도록 쿼리문을 작성한다.

--   SMITH 의 현재 연봉은 9600인데 희망 연봉은 19200이다.
--   ALLEN 의 현재 연봉은 19500인데 희망 연봉은 39000이다.
--                          :

-- 방식1
SELECT ENAME || '의 현재 연봉은 ' || NVL(SAL*12, SAL*12+COMM) || '인데 희망 연봉은 '
        || NVL(SAL*12, SAL*12+COMM) * 2 || '이다.'
FROM TBL_EMP;

-- 방식2
SELECT ENAME || '의 현재 연봉은 ' || NVL2(COMM, SAL*12+COMM, SAL*12) || '인데 희망 연봉은 '
        || NVL2(COMM, SAL*12+COMM, SAL*12) * 2 || '이다.'
FROM TBL_EMP;

-- 방식3
SELECT ENAME || '의 현재 연봉은 ' || COALESCE(SAL*12+COMM, SAL*12, COMM, 0) || '인데 희망 연봉은 '
        || COALESCE(SAL*12+COMM, SAL*12, COMM, 0) * 2 || '이다.'
FROM TBL_EMP;

SELECT *
FROM TBL_EMP;

-- SMITH's 입사일은 1980-12-17이다. 그리고 급여는 800이다.
-- ALLEN's 입사일은 1981-02-20이다. 그리고 급여는 1600이다.

SELECT ENAME || '''s 입사일은 ' || HIREDATE || '이다. 그리고 급여는 ' || SAL || '이다.'
FROM TBL_EMP;

--※ 문자열을 나타내는 홑따옴표 사이에서(시작과 끝)
--   홑따옴표 두 개가 홑따옴표 하나(어퍼스트로피)를 의미한다.
--   결과적으로...
--   홑따옴표 하나 『'』는 문자열의 시작을 나타내고
--   홑따옴표 두 개 『''』는 문자열의 영역 안에서 어퍼스트로피를 나타내며
--   다시 등장하는 홑따옴표 하나 『'』가 문자열 영역의 종료를 의미하게 된다.

SELECT *
FROM TBL_EMP
WHERE JOB = 'salesman';
--==>> 검색 결과 없음.

--○ UPPER(), LOWER(), INITCAP()
SELECT 'oRAcLe' "1", UPPER('oRAcLe') "2", LOWER('oRAcLe') "3", INITCAP('oRAcLe') "4"
FROM DUAL;
--==>> oRAcLe	ORACLE	oracle	Oracle
--> UPPER() 는 모두 대문자로 변환하여 반환
--  LOWER() 는 모두 소문자로 변환하여 반환
--  INITCAP() 는 첫 글자만 대문자로 하고 나머지는 모두 소문자로 변환하여 반환

SELECT *
FROM TBL_EMP
WHERE JOB = 'sALesman';

SELECT *
FROM TBL_EMP
WHERE JOB = UPPER('sALesman');

SELECT *
FROM TBL_EMP
WHERE UPPER(JOB) = UPPER('sALesman');

COMMIT;
