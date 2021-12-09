SELECT USER
FROM DUAL;
--==>> SCOTT

--○ 생성한 함수(FN_GENDER())가 제대로 작동하는지의 여부 확인
SELECT NAME, SSN, FN_GENDER(SSN) "함수호출결과"
FROM TBL_INSA;

--○ 생성한 함수(FN_POW())가 제대로 작동하는지의 여부 확인
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000



-- 프로시저 관련 실습

-- 실습 테이블 생성(TBL_STUDENTS)
CREATE TABLE TBL_STUDENTS
( ID    VARCHAR2(10)
, NAME  VARCHAR2(40)
, TEL   VARCHAR2(20)
, ADDR  VARCHAR2(100)
);
--==>> Table TBL_STUDENTS이(가) 생성되었습니다.

-- 실습 테이블 생성(TBL_IDPW)
CREATE TABLE TBL_IDPW
( ID    VARCHAR2(10)
, PW    VARCHAR2(20)
, CONSTRAINT IDPW_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_IDPW이(가) 생성되었습니다.


-- 두 테이블에 데이터 입력
INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
VALUES('superman', '손범석', '010-1111-1111', '서울 강남구...');
INSERT INTO TBL_IDPW(ID, PW)
VALUES('superman', 'java006$');
--==>> 1 행 이(가) 삽입되었습니다. * 2

SELECT *
FROM TBL_STUDENTS;
--==>> superman	손범석	010-1111-1111	서울 강남구...

SELECT *
FROM TBL_IDPW;
--==>> superman	java006$


-- 위의 업무를 프로시저(INSERT 프로시저, 입력 프로시저)를 생성하게 되면
EXEC PRO_STUDENTS_INSERT('batman', 'java006$', '송해덕', '010-2222-2222', '경기도 고양시');
-- 이와 같은 구문 한 줄로 양쪽 테이블에 데이터를 모두 제대로 입력할 수 있다.

DESC TBL_STUDENTS;
DESC TBL_IDPW;


--○ 생성한 프로시저(PRC_STUDENTS_INSERT())가 제대로 작동하는지의 여부 확인
--   → 프로시저 호출
EXEC PRC_STUDENTS_INSERT('batman', 'java006$', '송해덕', '010-2222-2222', '경기도 고양시');

SELECT *
FROM TBL_STUDENTS;

SELECT *
FROM TBL_IDPW;


--○ 학번, 이름, 국어점수, 영어점수, 수학점수 데이터를 
--   입력 받을 수 있는 실습 테이블 생성(TBL_SUNGJUK)
CREATE TABLE TBL_SUNGJUK
( HAKBUN    NUMBER
, NAME      VARCHAR(40)
, KOR       NUMBER(3)
, ENG       NUMBER(3)
, MAT       NUMBER(3)
, CONSTRAINT SUNGJUK_HAKBUN_PK PRIMARY KEY(HAKBUN)
);
--==>> Table TBL_SUNGJUK이(가) 생성되었습니다.

--○ 생성된 테이블에 컬럼 구조 추가
--   (총점→TOT, 평균→AVG, 등급→GRADE)
ALTER TABLE TBL_SUNGJUK
ADD ( TOT NUMBER(3), AVG NUMBER(4, 1), GRADE CHAR );
--==>> Table TBL_SUNGJUK이(가) 변경되었습니다.

--※ 여기서 추가한 컬럼에 대한 항목들은
--   프로시저 실습을 위해 추가한 것일 뿐
--   실제 테이블 구조에 적합하지도, 바람직하지도 않은 내용이다.

--○ 변경된 테이블의 구조 확인
DESC TBL_SUNGJUK;
--==>>
/*
이름     널?       유형           
------ -------- ------------ 
HAKBUN NOT NULL NUMBER       
NAME            VARCHAR2(40) 
KOR             NUMBER(3)    
ENG             NUMBER(3)    
MAT             NUMBER(3)    
TOT             NUMBER(3)    
AVG             NUMBER(4,1)  
GRADE           CHAR(1)   
*/


--○ 생성한 프로시저(PRC_SUNGJUK_INSERT())가 제대로 작동하는지의 여부 확인
--   → 프로시저 호출
EXEC PRC_SUNGJUK_INSERT(1, '김진희', 90, 80, 70);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT *
FROM TBL_SUNGJUK;
--==>> 1	김진희	90	80	70	240	80	B

EXEC PRC_SUNGJUK_INSERT(2, '김소연', 98, 88, 77);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT *
FROM TBL_SUNGJUK;
--==>>
/*
1	김진희	90	80	70	240	80	B
2	김소연	98	88	77	263	87.7	B
*/


--○ 생성한 프로시저(PRC_SUNGJUK_UPDATE())가 제대로 작동하는지의 여부 확인
--   → 프로시저 호출
EXEC PRC_SUNGJUK_UPDATE(2, 100, 100, 100);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT *
FROM TBL_SUNGJUK;
--==>>
/*
1	김진희	90	80	70	240	80	B
2	김소연	100	100	100	300	100	A
*/


--○ 생성한 프로시저(PRC_STUDENTS_UPDATE())가 제대로 작동하는지의 여부 확인
-- 기존 데이터 확인
SELECT *
FROM TBL_STUDENTS;
--==>>
/*
superman	    손범석	010-1111-1111	서울시 강남구...
batman	    송해덕	010-2222-2222	경기도 고양시
*/


-- 프로시저 호출(틀린 패스워드)
EXEC PRC_STUDENTS_UPDATE('superman', 'java001', '010-9999-9999', '인천');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 데이터 확인
SELECT *
FROM TBL_STUDENTS;
--==>>
/*
superman	    손범석	010-1111-1111	서울시 강남구...
batman	    송해덕	010-2222-2222	경기도 고양시
*/


-- 프로시저 호출(유효한 패스워드)
EXEC PRC_STUDENTS_UPDATE('superman', 'java006$', '010-9999-9999', '인천');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 데이터 확인
SELECT *
FROM TBL_STUDENTS;
--==>>
/*
superman	    손범석	010-9999-9999	인천
batman	    송해덕	010-2222-2222	경기도 고양시
*/
SELECT MAX(NUM)+1
FROM TBL_INSA;



