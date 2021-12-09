SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT *
FROM TBL_출고;


--○ 실습 테이블 생성(TBL_TEST1)
CREATE TABLE TBL_TEST1
( ID    NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
);
--==>> Table TBL_TEST1이(가) 생성되었습니다.

--○ 생성된 테이블에 제약조건 추가
--   ID 컬럼에 PK 제약조건 지정
ALTER TABLE TBL_TEST1
ADD CONSTRAINT TEST1_ID_PK PRIMARY KEY(ID);
--==>> Table TBL_TEST1이(가) 변경되었습니다.


--○ 실습 테이블 생성(TBL_EVENTLOG)
CREATE TABLE TBL_EVENTLOG
( MEMO  VARCHAR2(200)
, ILJA  DATE DEFAULT SYSDATE
);
--==>> Table TBL_EVENTLOG이(가) 생성되었습니다.

SELECT *
FROM TBL_TEST1;
--==>> 조회 결과 없음

SELECT *
FROM TBL_EVENTLOG;
--==>> 조회 결과 없음


--○ 날짜 세션 정보 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


--○ TBL_TEST1 테이블에 데이터 입력
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1, '이찬호', '010-1111-1111');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(2, '장민지', '010-2222-2222');
--==>> 1 행 이(가) 삽입되었습니다.

--○ TBL_TEST1 테이블에 데이터 수정
UPDATE TBL_TEST1
SET NAME = '차노'
WHERE ID = 1;
--==>> 1 행 이(가) 업데이트되었습니다.

--○ TBL_TEST1 테이블에 데이터 삭제
DELETE
FROM TBL_TEST1
WHERE ID = 1;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 2;
--==>> 1 행 이(가) 삭제되었습니다.


--○ 확인
SELECT *
FROM TBL_TEST1;
--==>> 조회 결과 없음

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ TBL_EVENTLOG 테이블 조회
SELECT *
FROM TBL_EVENTLOG;
--==>>
/*
INSERT 쿼리문이 수행되었습니다.	2021-09-17 17:19:40
INSERT 쿼리문이 수행되었습니다.	2021-09-17 17:20:03
UPDATE 쿼리문이 수행되었습니다.	2021-09-17 17:20:39
DELETE 쿼리문이 수행되었습니다.	2021-09-17 17:21:30
DELETE 쿼리문이 수행되었습니다.	2021-09-17 17:21:45
*/

SELECT TO_CHAR(SYSDATE, 'HH24')
FROM DUAL;
--==>> 17   → 문자 타입

SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'))
FROM DUAL;
--==>> 17   → 숫자 타입


--○ 테스트
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(3, '윤유동', '010-3333-3333');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(4, '김진령', '010-4444-4444');
--==>> 1 행 이(가) 삽입되었습니다.

UPDATE TBL_TEST1
SET NAME = '정효진'
WHERE ID = 4;
--==>> 1 행 이(가) 업데이트되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 4;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 확인
SELECT *
FROM TBL_TEST1;
--==>> 3	윤유동	010-3333-3333

COMMIT;


-- 오라클 서버의 시간을 오전 7시 대로 변경
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(5, '서승균', '010-5555-5555');
--==>> 에러 발생
/*
ORA-20003: 작업은 8:00 ~ 18:00 까지만 가능합니다.
*/

UPDATE TBL_TEST1
SET NAME = '서승균'
WHERE ID = 3;
--==>> 에러 발생
/*
ORA-20003: 작업은 8:00 ~ 18:00 까지만 가능합니다.
*/

DELETE
FROM TBL_TEST1
WHERE ID=3;
--==>> 에러 발생
/*
ORA-20003: 작업은 8:00 ~ 18:00 까지만 가능합니다.
*/


--○ 확인
SELECT *
FROM TBL_TEST1;
--==>> 3	윤유동	010-3333-3333








