SELECT USER
FROM DUAL;
--==>> SCOTT


--○ 실습 테이블 생성(TBL_TEST2) → 부모 테이블
CREATE TABLE TBL_TEST2
( CODE  NUMBER
, NAME  VARCHAR2(40)
, CONSTRAINT TEST2_CODE_PK PRIMARY KEY(CODE)
);
--==>> Table TBL_TEST2이(가) 생성되었습니다.

--○ 실습 테이블 생성(TBL_TEST3) → 자식 테이블
CREATE TABLE TBL_TEST3
( SID   NUMBER
, CODE  NUMBER
, SU    NUMBER
, CONSTRAINT TEST3_SID_PK PRIMARY KEY(SID)
, CONSTRAINT TEST3_CODE_FK FOREIGN KEY(CODE)
             REFERENCES TBL_TEST2 (CODE)
);
--==>> Table TBL_TEST3이(가) 생성되었습니다.

--○ 데이터 입력
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(1, '냉장고');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(2, '세탁기');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(3, '건조기');
--==>> 1 행 이(가) 삽입되었습니다. * 2

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	냉장고
2	세탁기
3	건조기
*/

COMMIT;
--==>> 커밋 완료.


--○ 데이터 입력
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(1, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(2, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(3, 2, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(4, 3, 40);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(5, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(6, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(7, 3, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(8, 3, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(9, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(10, 3, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(11, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(12, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(13, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(14, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(15, 3, 20);
--==>> 1 행 이(가) 삽입되었습니다. * 15

SELECT *
FROM TBL_TEST3;
--==>>
/*
1	1	20
2	1	20
3	2	30
4	3	40
5	2	20
6	2	20
7	3	20
8	3	20
9	2	20
10	3	20
11	2	20
12	2	20
13	1	20
14	2	20
15	3	20
*/

SELECT T2.SID, T1.CODE, T2.SU, T1.NAME
FROM TBL_TEST2 T1 JOIN TBL_TEST3 T2
    ON T1.CODE = T2.CODE;
--==>>
/*
1	1	20	냉장고
2	1	20	냉장고
3	2	30	세탁기
4	3	40	건조기
5	2	20	세탁기
6	2	20	세탁기
7	3	20	건조기
8	3	20	건조기
9	2	20	세탁기
10	3	20	건조기
11	2	20	세탁기
12	2	20	세탁기
13	1	20	냉장고
14	2	20	세탁기
15	3	20	건조기
*/

COMMIT;
--==>> 커밋 완료.


-- 부모 테이블(TBL_TEST2)에서 냉장고 삭제
DELETE
FROM TBL_TEST2
WHERE CODE=1;
--==>> 에러 발생
/*
ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found
*/

DELETE 
FROM TBL_TEST3
WHERE CODE=1;
--==>> 3개 행 이(가) 삭제되었습니다.


SELECT T2.SID, T1.CODE, T2.SU, T1.NAME
FROM TBL_TEST2 T1 JOIN TBL_TEST3 T2
    ON T1.CODE = T2.CODE;
--==>>
/*
3	2	30	세탁기
4	3	40	건조기
5	2	20	세탁기
6	2	20	세탁기
7	3	20	건조기
8	3	20	건조기
9	2	20	세탁기
10	3	20	건조기
11	2	20	세탁기
12	2	20	세탁기
14	2	20	세탁기
15	3	20	건조기
*/


COMMIT;
--==>> 커밋 완료.


DELETE
FROM TBL_TEST2
WHERE CODE=1;
--==>> 1 행 이(가) 삭제되었습니다.


SELECT *
FROM TBL_TEST2;
--==>>
/*
2	세탁기
3	건조기
*/


COMMIT;
--==>> 커밋 완료.


SELECT *
FROM TBL_TEST2
WHERE CODE = 2;
--==>> 2	    세탁기


DELETE
FROM TBL_TEST2
WHERE CODE = 2;
--==>> 에러 발생
/*
ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found
*/


SELECT *
FROM TBL_TEST2
WHERE CODE = 3;
--==>> 3	건조기


DELETE
FROM TBL_TEST2
WHERE CODE = 3;
--==>> 에러 발생
/*
ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found
*/


--○ 트리거 작성 이후 다시 테스트

DELETE
FROM TBL_TEST2
WHERE CODE = 3;
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_TEST2;
--==>> 2    	세탁기

SELECT *
FROM TBL_TEST3;
--==>>
/*
3	2	30
5	2	20
6	2	20
9	2	20
11	2	20
12	2	20
14	2	20
*/


DELETE
FROM TBL_TEST2
WHERE CODE = 2;
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_TEST2;

SELECT *
FROM TBL_TEST3;


TRUNCATE TABLE TBL_입고;
--==>> Table TBL_입고이(가) 잘렸습니다.

TRUNCATE TABLE TBL_출고;
--==>> Table TBL_출고이(가) 잘렸습니다.

UPDATE TBL_상품
SET 재고수량 = 0;
--==>> 21개 행 이(가) 업데이트되었습니다.

COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_입고;
SELECT *
FROM TBL_출고;
SELECT *
FROM TBL_상품;


INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(1, 'C001', SYSDATE, 100, 1800);
--==>> 1 행 이(가) 삽입되었습니다.

UPDATE TBL_상품
SET 재고수량 = 35
WHERE 상품코드 = 'C001';

INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(2, 'C002', SYSDATE, 100, 1600);

DELETE
FROM TBL_입고
WHERE 입고번호 = 1;

INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(4, 'C001', SYSDATE, 1, 1100);

INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(5, 'C001', SYSDATE, 1, 1100);

INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(6, 'C001', SYSDATE, 1, 1100);

UPDATE TBL_입고
SET 입고수량 = 2
WHERE 입고번호 = 1;

DELETE 
FROM TBL_입고
WHERE 입고번호 = 1; 

INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(7, 'C001', SYSDATE, 1, 1100);

UPDATE TBL_입고
SET 입고수량 = 2
WHERE 입고번호 = 1;

INSERT INTO TBL_출고(출고번호, 상품코드, 출고일자, 출고수량, 출고단가)
VALUES(1, 'C001', SYSDATE, 10, 2100);

INSERT INTO TBL_출고(출고번호, 상품코드, 출고일자, 출고수량, 출고단가)
VALUES(2, 'C001', SYSDATE, 1, 2100);

INSERT INTO TBL_출고(출고번호, 상품코드, 출고일자, 출고수량, 출고단가)
VALUES(3, 'C001', SYSDATE, 1, 2100);

INSERT INTO TBL_출고(출고번호, 상품코드, 출고일자, 출고수량, 출고단가)
VALUES(4, 'C001', SYSDATE, 1, 2100);

UPDATE TBL_출고
SET 출고수량 = 200000
WHERE 출고번호 = 6;

INSERT INTO TBL_출고(출고번호, 상품코드, 출고일자, 출고수량, 출고단가)
VALUES(7, 'C001', SYSDATE, 1000, 2100);


DELETE 
FROM TBL_출고
WHERE 출고번호 = 6; 


--------------------------------------------------------------------------------
SELECT INSA_PACK.FN_GENDER('751212-1234567') RESULT
FROM DUAL;
--==>> 남자

SELECT NAME, SSN, INSA_PACK.FN_GENDER(SSN) "성별"
FROM TBL_INSA;



