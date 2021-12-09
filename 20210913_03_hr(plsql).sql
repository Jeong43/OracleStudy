SELECT USER
FROM DUAL;
--==>> HR

SET SERVEROUTPUT ON;

--○ %TYPE

-- 1. 특정 테이블에 포함되어 있는 컬럼의 자료형을 참조하는 데이터 타입

-- 2. 형식 및 구조
-- 변수명 테이블명.컬럼명%TYPE [:= 초기값];
SELECT FIRST_NAME
FROM EMPLOYEES;

DESC EMPLOYEES;


--○ HR.EMPLYEES 테이블의 특정 데이터를 변수에 저장

DECLARE 
    --VNAME VARCHAR2(20);
    VNAME EMPLOYEES.FIRST_NAME%TYPE;        --VARCHAR(20)
BEGIN
    SELECT FIRST_NAME INTO VNAME
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID=103;
    
    DBMS_OUTPUT.PUT_LINE(VNAME);
END;
--==>> Alexander



--○ %ROWTYPE

-- 1. 테이블의 레코드와 같은 구조의 구조체 변수를 선언(여러 개의 컬럼)

-- 2. 형식 및 구조
-- 변수명 테이블명%ROWTYPE;

DESC EMPLOYEES;

--○ HR.EMPLOYEES 테이블의 값 여러개를 변수에 저장
DECLARE
    --VNAME   VARCHAR2(20);
    --VPHONE  VARCHAR2(20);
    --VEMAIL  VARCHAR2(25);
    
    --VNAME EMPLOYEES.FIRST_NAME%TYPE;
    --VPHONE EMPLOYEES.PHONE_NUMBER%TYPE;
    --VEMAIL EMPLOYEES.EMAIL%TYPE;
    
    VEMP EMPLOYEES%ROWTYPE;
    
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL
      INTO VEMP.FIRST_NAME, VEMP.PHONE_NUMBER, VEMP.EMAIL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.FIRST_NAME || ' - ' || VEMP.PHONE_NUMBER || ' - ' || VEMP.EMAIL);
END;
--==>> Alexander - 590.423.4567 - AHUNOLD


--○ HR.EMPLOYEES 테이블의 여러명의 여러 데이터를 변수에 저장
--   103번 사원만 골라서 담아내는 것이 아니라
--   전체 사원의 이름, 전화번호, 이메일을 변수에 담아 출력

DECLARE
    VEMP EMPLOYEES%ROWTYPE;
    
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL
      INTO VEMP.FIRST_NAME, VEMP.PHONE_NUMBER, VEMP.EMAIL
    FROM EMPLOYEES;
       
    DBMS_OUTPUT.PUT_LINE(VEMP.FIRST_NAME || ' - ' || VEMP.PHONE_NUMBER || ' - ' || VEMP.EMAIL);
END;
--==>> 에러 발생
/*
01422. 00000 -  "exact fetch returns more than requested number of rows"/
*/
--> 여러 개의 행(ROWS) 정보를 얻어와 담으려고 하면
--  변수에 저장하는 것 자체가 불가능한 상황...

--  불가~!!!








