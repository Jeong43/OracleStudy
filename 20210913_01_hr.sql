SELECT USER
FROM DUAL;
--=>> HR

-- ○ EMPLOYEES 테이블에서  SALARY 를
--    각 부서의 이름별로 다른 인상률을 적용하여 수정할 수 있도록 한다.
--    Finance → 10%
--    Executive → 15%
--    Accounting → 20%
--    (쿼리문 구성 및 결과 확인 후 ROLLBACK)

-- 쿼리문 [나의 풀이]
UPDATE EMPLOYEES
SET SALARY = DECODE(DEPARTMENT_ID, (SELECT DEPARTMENT_ID
                                   FROM DEPARTMENTS
                                   WHERE DEPARTMENT_NAME = ('Finance')), SALARY * 1.1
                                , (SELECT DEPARTMENT_ID
                                   FROM DEPARTMENTS
                                   WHERE DEPARTMENT_NAME = ('Executive')), SALARY * 1.15
                                , (SELECT DEPARTMENT_ID
                                   FROM DEPARTMENTS
                                   WHERE DEPARTMENT_NAME = ('Accounting')), SALARY * 1.2 )
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting')); 
--==>> 11개 행 이(가) 업데이트되었습니다.


-- 쿼리문 [함께 풀이]
UPDATE EMPLOYEES
SET SALARY =  CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                       FROM DEPARTMENTS
                                       WHERE DEPARTMENT_NAME = ('Finance'))
                                THEN SALARY * 1.1
                                WHEN (SELECT DEPARTMENT_ID
                                       FROM DEPARTMENTS
                                       WHERE DEPARTMENT_NAME = ('Executive'))
                                THEN SALARY * 1.15
                                WHEN (SELECT DEPARTMENT_ID
                                       FROM DEPARTMENTS
                                       WHERE DEPARTMENT_NAME = ('Accounting'))
                                THEN SALARY * 1.2
                                ELSE SALARY
              END
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting')); 


-- 확인
SELECT FIRST_NAME, DEPARTMENT_ID, SALARY      
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting'));
--==>> 수정 전
/*
Steven	    90	24000
Neena	    90	17000
Lex     	90	17000
Nancy	    100	12008
Daniel	    100	9000
John	        100	8200
Ismael	    100	7700
Jose Manuel	100	7800
Luis	        100	6900
Shelley	    110	12008
William	    110	8300
*/
--==>> 수정 후
/*
Steven	    90	27600
Neena	    90	19550
Lex     	90	19550
Nancy	    100	13208.8
Daniel	    100	9900
John        	100	9020
Ismael	    100	8470
Jose Manuel	100	8580
Luis	        100	7590
Shelley	    110	14409.6
William	    110	9960
*/

ROLLBACK;
--==>> 롤백 완료.



--■■■ DELETE ■■■--
/*
1. 테이블에서 지정된 행(레코드)을 삭제하는데 사용하는 구문.

2. 형식 및 구조
DELETE [FROM] 테이블명
[WHERE 조건절];
*/

SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 198	Donald	OConnell	DOCONNEL	650.507.9833	07/06/21	SH_CLERK	2600		124	50

DELETE
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 1 행 이(가) 삭제되었습니다.

ROLLBACK;
--==>> 롤백 완료.



--○ EMPLOYEES 테이블에서 직원들의 정보를 삭제한다.
--   단, 부서명이 'IT'인 경우로 한정한다.

--※ 실제로는 EMPLOYEES 테이블의 데이터가(삭제하고자 하는 대상)
--   다른 테이블(혹은 자기 자신 테이블)에 의해 참조당하는 경우
--   삭제되지 않을 수 있다는 사실을 염두해야 하며...
--   그에 대한 이유도 알아야 한다.

DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> 에러 발생
/*
ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found
*/


SELECT FIRST_NAME, DEPARTMENT_ID 
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> 삭제 전
/*
Alexander	60
Bruce	    60
David	    60
Valli	    60
Diana	    60
*/


--■■■ 뷰(VIEW) ■■■--
/*
1. 뷰(VIEW)란 이미 특정한 데이터베이스 내에 존재하는
   하나 이상의 테이블에서 사용자가 얻기 원하는 데이터들만을
   정확하고 편하게 가져오기 위하여 사전에 원하는 컬럼들만 모아서
   만들어놓은 가상의 테이블로 편의성 및 보안에 목적이 있다.

   가상의 테이블이란 뷰가 실제로 존재하는 테이블(객체)이 아니라
   하나 이상의 테이블에서 파생된 또 다른 정보를 볼 수 있는 방법이며
   그 정보를 추출해내는 SQL 문장이라고 볼 수 있다는 것이다.
   
2. 형식 및 구조
CREATE [OR REPLACE] VIEW 뷰이름
[(ALISA[, ALIAS, ...])]
AS
서브쿼리(SUBQUERY)
[WITH CHECK OPTION]
[WITH READ ONLY];
*/


--○ 뷰(VIEW) 생성
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+);
--==>> View VIEW_EMPLOYEES이(가) 생성되었습니다.


SELECT *
FROM VIEW_EMPLOYEES;

DESC VIEW_EMPLOYEES;


--○ 뷰(VIEW) 소스 확인                 -- CHECK~!!!
SELECT VIEW_NAME, TEXT                  -- TEXT
FROM USER_VIEWS                         -- USER_VIEWS              
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';

--==>> 
/*
"SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
      , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+)"
*/