SELECT USER
FROM DUAL;
--==>> SCOTT

--■■■ 암호화 복호화 확인 실습 ■■■--

--○ 테이블 생성
CREATE TABLE TBL_EXAM
( ID	NUMBER
, PW	VARCHAR2(20)
);
--==>> Table TBL_EXAM이(가) 생성되었습니다.


--○ 데이터 입력(암호화)
--INSERT INTO TBL_EXAM(ID, PW) VALUES(1, 'java006$');
INSERT INTO TBL_EXAM(ID, PW) VALUES(1, CRYPTPACK.ENCRYPT('java006$', '1234'));
--==>> 1 행 이(가) 삽입되었습니다.


--○ 데이터 조회
SELECT ID, PW
FROM TBL_EXAM;
--==>> 1	j??s
--@ 데이터베이스 관리자도 내용을 알 수 없음! (핵심 POINT~!!!)
--@ 오라클에서 표현할 수 없는 문자열의 형태임


--> 키값을 모를 경우
SELECT ID, CRYPTPACK.DECRYPT(PW, '1111')
FROM TBL_EXAM;
--==>> 1	???

SELECT ID, CRYPTPACK.DECRYPT(PW, '2222')
FROM TBL_EXAM;
--==>> 1	??D?


--> 올바른 키값을 입력했을 시
SELECT ID, CRYPTPACK.DECRYPT(PW, '1234')
FROM TBL_EXAM;
--==>> 1	java006$
