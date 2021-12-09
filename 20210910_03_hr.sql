SELECT USER
FROM DUAL;
--==>> HR

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

--○ EMPLOYEES 테이블의 직워들 SALARY 를 10% 인상한다.
--   단, 부서명이 'IT'인 경우로 한정한다.
--   (직접 눈으로 찾아 부서번호를 입력하는 것이 아님.
--    또한, 결과 확인 후 ROLLBACK)

UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> 5개 행 이(가) 업데이트되었습니다.

SELECT EMPLOYEE_ID, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> 변경 전
/*
103	9000
104	6000
105	4800
106	4800
107	4200
*/

--==>> 변경 후
/*
103	9900
104	6600
105	5280
106	5280
107	4620
*/

ROLLBACK;


--○ EMPLOYEES 테이블에서 JOB_TITLE이 『Sales Manager』인 사원들의
--   SALARY 를 해당 직무(직종)의 최고 급여(MAX_SALALY)로 수정한다.
--   단, 입사일이 2006년 이전(해당년도 제외) 입사자에 한하여
--   적용할 수 있도록 처리한다.
--   (결과 확인 후 ROLLBACK)

-- 수정 구문
UPDATE EMPLOYEES
SET SALARY = (Salese Manager 의 MAX_SALARY)
WHERE JOB_ID =(Salese Manager 의 JOB_ID)
  AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;
  
-- Salese Manager 의 MAX_SALARY
SELECT MAX_SALARY
FROM JOBS
WHERE JOB_TITLE = 'Sales Manager';  
--==>> 20080

-- Salese Manager 의 JOB_ID
SELECT JOB_ID
FROM JOBS
WHERE JOB_TITLE = 'Sales Manager';
--==>> SA_MAN  


UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
             FROM JOBS
             WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;
--  AND EXTRACT(YEAR FROM HIRE_DATE) < 2006;
--==>> 3개 행 이(가) 업데이트되었습니다.  


SELECT SALARY
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND EXTRACT(YEAR FROM HIRE_DATE) < 2006;
--==>> 변경 전
/*
14000
13500
12000
*/

--==>> 변경 후
/*
20080
20080
20080
*/

ROLLBACK;



