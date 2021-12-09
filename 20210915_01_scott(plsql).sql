SELECT USER
FROM DUAL;
--==>> SCOTT



--■■■ FUNCTION (함수) ■■■ --

-- 1. 함수란 하나 이상의 PL/SQL 문으로 구성된 서브루틴으로
--    코드를 다시 사용할 수 있도록 캡슐화 하는데 사용된다.
--    오라클에서는 오라클에 정의된 기본 제공 함수를 사용하거나
--    직접 스토어드 함수를 만들 수 있다. (→ 사용자 정의 함수)
--    이 사용자 정의 함수는 시세틈 함수처럼 쿼리에서 호출하거나
--    저장 프로시저처럼 EXEXCUTE 문을 통해 실행할 수 있다.

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] FUNCTION 함수명
[(
    매개변수1 자료형
  , 매개변수2 자료형
)]
RETURN 데이터타입
IS
    -- 주요 변수 선언(지역변수)
BEGIN
    -- 실행문
    ...
    RETURN (값);
    
    [EXCEPTION]
        -- 예외 처리 구문;
END;
*/

--※ 사용자 정의 함수(스토어드 함수)는
--   IN 파라미터(입력 매개변수)만 사용할 수 있으며
--   반드시 반환될 값의 데이터타입을 RETRUN 문에 선언해야 하고,
--   FUNCTION 은 반드시 단일 값만 반환한다.


--○ TBL_INSA 테이블에서
--   주민등록번호를 가지고 성별을 조회한다.

SELECT *
FROM TBL_INSA;

SELECT NAME, SSN, DECODE( SUBSTR(SSN, 8 , 1), '1', '남자', '2', '여자', '확인불가' ) "성별"
FROM TBL_INSA;

/*
         ↓ 주민등록번호
        \  /
    ----    ---------
    |               |
    ------------    -
                /  \
                 ↓ 성별
*/

--○ FUNCTION 생성
-- 함수명: FN_GENDER()
--                  ↑ SSN(주민등록번호) → 'YYMMDD-NNNNNNN'

CREATE OR REPLACE FUNCTION FN_GENDER
( VSSN  VARCHAR2     -- 매개변수: 자릿수(길이) 지정 안함
)
RETURN VARCHAR2      -- 반환 자료형: 자릿수(길이) 지정 안함
IS
    -- 주요 변수 선언
    VRESULT VARCHAR2(20);
BEGIN
    -- 연산 및 처리
    IF ( SUBSTR(VSSN, 8, 1) IN ('1', '3') )
        THEN VRESULT := '남자';
    ELSIF ( SUBSTR(VSSN, 8, 1) IN ('2', '4') )
        THEN VRESULT := '여자';
    ELSE 
        VRESULT := '성별확인불가';
    END IF;
    
    -- 최종 결과값 반환
    RETURN VRESULT;
END;
--==>> Function FN_GENDER이(가) 컴파일되었습니다.


--○ 임의의 정수 두 개를 매개변수(입력 파라미터)로 넘겨받아
--   A의 B 승의 값을 반환하는 사용자 정의 함수를 작성한다.
--   함수명: FN_POW()
/*
사용 예)
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000
*/

-- [나의 풀이]
CREATE OR REPLACE FUNCTION FN_POW
( NUM1      NUMBER
, NUM2      NUMBER
)
RETURN NUMBER
IS
    -- 주요 변수 선언
    RESULT  NUMBER  := 1;
    CNT     NUMBER  := 0;
BEGIN    
    -- 실행문
    FOR CNT IN 1 .. NUM2 LOOP
        RESULT := RESULT * NUM1;
    END LOOP;
    
    -- 최종 결과값 반환
    RETURN RESULT;
END;


-- [함께 풀이]
CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER)
RETURN NUMBER
IS
    V_RESULT  NUMBER  := 1;   -- 누적곱
    V_NUM     NUMBER;
BEGIN    
    FOR V_NUM IN 1 .. B LOOP
        V_RESULT := V_RESULT * A;
    END LOOP;
    
    -- CHECK~!!!
    RETURN V_RESULT;
END;
--==>> Function FN_POW이(가) 컴파일되었습니다.



--○ 과제
-- TBL_INSA 테이블의 급여 계산 전용 함수를 정의한다.
-- 급여는 『(기본급*12)+수당』을 기반으로 연산을 수행한다.
-- 함수명: FN_PAY(기본급, 수당)
CREATE OR REPLACE FUNCTION FN_PAY(BASIC NUMBER, SUDANG NUMBER)
RETURN NUMBER
IS
    V_RESULT NUMBER;
BEGIN
    V_RESULT := BASIC*12 + NVL(SUDANG, 0);
    
    RETURN V_RESULT;
END;
--==>> Function FN_PAY이(가) 컴파일되었습니다.

-- 확인
SELECT NAME, BASICPAY, SUDANG, FN_PAY(BASICPAY, SUDANG) "급여"
FROM TBL_INSA;
--==>> 
/*
홍길동	2610000	200000	31520000
이순신	1320000	200000	16040000
이순애	2550000	160000	30760000
김정훈	1954200	170000	23620400
한석봉	1420000	160000	17200000
이기자	2265000	150000	27330000
장인철	1250000	150000	15150000
김영년	950000	145000	11545000
나윤균	840000	220400	10300400
김종서	2540000	130000	30610000
유관순	1020000	140000	12380000
정한국	880000	114000	10674000
조미숙	1601000	103000	19315000
황진이	1100000	130000	13330000
이현숙	1050000	104000	12704000
이상헌	2350000	150000	28350000
엄용수	950000	210000	11610000
이성길	880000	123000	10683000
박문수	2300000	165000	27765000
유영희	880000	140000	10700000
홍길남	875000	120000	10620000
이영숙	1960000	180000	23700000
김인수	2500000	170000	30170000
김말자	1900000	170000	22970000
우재옥	1100000	160000	13360000
김숙남	1050000	150000	12750000
김영길	2340000	170000	28250000
이남신	892000	110000	10814000
김말숙	920000	124000	11164000
정정해	2304000	124000	27772000
지재환	2450000	160000	29560000
심심해	880000	108000	10668000
김미나	1020000	104000	12344000
이정석	1100000	160000	13360000
정영희	1050000	140000	12740000
이재영	960400	190000	11714800
최석규	2350000	187000	28387000
손인수	2000000	150000	24150000
고순정	2010000	160000	24280000
박세열	2100000	130000	25330000
문길수	2300000	150000	27750000
채정희	1020000	200000	12440000
양미옥	1100000	210000	13410000
지수환	1060000	220000	12940000
홍원신	960000	152000	11672000
허경운	2650000	150000	31950000
산마루	2100000	112000	25312000
이기상	2050000	106000	24706000
이미성	1300000	130000	15730000
이미인	1950000	103000	23503000
권영미	2260000	104000	27224000
권옥경	1020000	105000	12345000
김싱식	960000	108000	11628000
정상호	980000	114000	11874000
정한나	1000000	104000	12104000
전용재	1950000	200000	23600000
이미경	2520000	160000	30400000
김신제	1950000	180000	23580000
임수봉	890000	102000	10782000
김신애	900000	102000	10902000
*/


--○ 과제
-- TBL_INSA 테이블의 입사일을 기준으로
-- 현재까지의 근무년수를 반환하는 함수를 정의한다.
-- 단, 근무년수는 소수점 이하 한자리까지 계산한다.
-- 함수명: FN_WORKYEAR(입사일)
-- 예: 12.5년, 13.6년
CREATE OR REPLACE FUNCTION FN_WORKYEAR(I DATE)
RETURN NUMBER
IS
    V_RESULT NUMBER;
BEGIN
    V_RESULT := ROUND(MONTHS_BETWEEN(SYSDATE, I)/12, 1);
    
    RETURN V_RESULT;
END;
--==>> Function FN_WORKYEAR이(가) 컴파일되었습니다.

-- 확인
SELECT NAME, IBSADATE, FN_WORKYEAR(IBSADATE) "근무년수"
FROM TBL_INSA;
--==>>
/*
홍길동	1998-10-11	22.9
이순신	2000-11-29	20.8
이순애	1999-02-25	22.6
김정훈	2000-10-01	21
한석봉	2004-08-13	17.1
이기자	2002-02-11	19.6
장인철	1998-03-16	23.5
김영년	2002-04-30	19.4
나윤균	2003-10-10	17.9
김종서	1997-08-08	24.1
유관순	2000-07-07	21.2
정한국	1999-10-16	21.9
조미숙	1998-06-07	23.3
황진이	2002-02-15	19.6
이현숙	1999-07-26	22.1
이상헌	2001-11-29	19.8
엄용수	2000-08-28	21.1
이성길	2004-08-08	17.1
박문수	1999-12-10	21.8
유영희	2003-10-10	17.9
홍길남	2001-09-07	20
이영숙	2003-02-25	18.6
김인수	1995-02-23	26.6
김말자	1999-08-28	22.1
우재옥	2000-10-01	21
김숙남	2002-08-28	19.1
김영길	2000-10-18	20.9
이남신	2001-09-07	20
김말숙	2000-09-08	21
정정해	1999-10-17	21.9
지재환	2001-01-21	20.7
심심해	2000-05-05	21.4
김미나	1998-06-07	23.3
이정석	2005-09-26	16
정영희	2002-05-16	19.3
이재영	2003-08-10	18.1
최석규	1998-10-15	22.9
손인수	1999-11-15	21.8
고순정	2003-12-28	17.7
박세열	2000-09-10	21
문길수	2001-12-10	19.8
채정희	2003-10-17	17.9
양미옥	2003-09-24	18
지수환	2004-01-21	17.7
홍원신	2003-03-16	18.5
허경운	1999-05-04	22.4
산마루	2001-07-15	20.2
이기상	2001-06-07	20.3
이미성	2000-04-07	21.4
이미인	2003-06-07	18.3
권영미	2000-06-04	21.3
권옥경	2000-10-10	20.9
김싱식	1999-12-12	21.8
정상호	1999-10-16	21.9
정한나	2004-06-07	17.3
전용재	2004-08-13	17.1
이미경	1998-02-11	23.6
김신제	2003-08-08	18.1
임수봉	2001-10-10	19.9
김신애	2001-10-10	19.9
*/

--------------------------------------------------------------------------------

--※ 참고
-- 1. INSERT, UPDATE, DELETE, (MERGE)   → 추가, 수정, 삭제, (병합)
--==>> DML(Data Manipulation Language)
-- COMMIT / ROLLBACK 이 필요하다.

-- 2. CREATE, DROP, ALTER, (TRUNCATE)   → 생성, 삭제, 수정, (잘라내기)
--==>> DDL(Data Definition Language)     → 데이터 정의어
-- 실행하면 자동으로 COMMIT 된다.

-- 3. GRANT, REVOKE
--==>> DCL(Data Control Language)
-- 실행하면 자동으로 COMMIT 된다.

--4. COMMIT, ROLLBACK
--==>> TCL(Transaction Control Language)

-- 정적 PL/SQL문 → DML문, TCL문만 사용 가능하다.
-- 동적 PL/SQL문 → DML문, DDL문, DCL문, TCL문 사용 가능하다.

--------------------------------------------------------------------------------

--■■■ PROCEDURE(프로시저) ■■■--

-- 1. PL/SQL 에서 가장 대표적인 구조인 스토어드 프로시저는
--    개발자가 자주 작성해야 하는 업무의 흐름을 
--    미리 작성하여 데이터베이스 내에 저장해 두었다가
--    필요할 때마다 호출하여 실행할 수 있도록 처리해 주는 구문이다.

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] PROCEDURE 프로시저명
[( 
    매개변수 IN 데이터타입           → 입력 (사용빈도 많음)
  , 매개변수 OUT 데이터타입          → 출력
  , 매개변수 INOUT 데이터타입        → 입출력
)]
IS
    -- 주요 변수 선언
BEGIN
    -- 실행 구문
    ...
    [EXCEPTION]
        -- 예외 처리 구문    
END;
*/

-- ※ FUNCTION 과 비교했을 때...
--    『RETURN 반환자료형』 부분이 존재하지 않으며,
--    『RETRUN』문 자체도 존재하지 않으며,
--    프로시저 실행 시 넘겨주게 되는 매개변수의 종류는
--    IN, OUT, INOUT 으로 구분된다.

-- 3. 실행(호출)
/*
EXEC[UTE] 프로시저명[(인수1, 인수2, ...)];
*/

--○ INSERT 쿼리 실행을 프로시저로 작성 ( → INSERT 프로시저 )

-- 프로시저 생성
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_INSERT
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
    -- 주요 변수 선언
BEGIN
    -- TBL_IDPW 테이블에 데이터 입력
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS 테이블에 데이터 입력
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    -- 커밋
    COMMIT;
    
END;
--==>> Procedure PRC_STUDENTS_INSERT이(가) 컴파일되었습니다.


--○ TBL_SUNGJUK 테이블에 데이터 입력 시
--   특정 항목의 데이터(학번, 이름, 국어점수, 영어점수, 수학점수)만 입력하면
--   내부적으로 총점, 평균, 등급 항목이 함께 입력 처리될 수 있도록 하는
--   프로시저를 생성한다.
--   프로시저명 : PRC_SUNGJUK_INSERT()
/*
실행 예)
EXEC PRC_SUNGJUK_INSERT(1, '김진희', 90, 80, 70);

프로시저 호출로 처리된 결과)
학번  이름  국어점수    영어점수    수학점수    총점  평균  등급
 1   김진희    90          80          70        240   80    B
*/
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN      IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME        IN TBL_SUNGJUK.NAME%TYPE
, V_KOR         IN TBL_SUNGJUK.KOR%TYPE
, V_ENG         IN TBL_SUNGJUK.ENG%TYPE
, V_MAT         IN TBL_SUNGJUK.MAT%TYPE
)

IS
    -- 주요변수 선언(지역변수)
    V_TOT       TBL_SUNGJUK.TOT%TYPE;
    V_AVG       TBL_SUNGJUK.AVG%TYPE;
    V_GRADE     TBL_SUNGJUK.GRADE%TYPE;
    
BEGIN
    -- 연산 및 처리
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    
    IF (V_AVG >= 90) 
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80) 
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70) 
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60) 
        THEN V_GRADE := 'D';
    ELSIF (V_AVG >= 50) 
        THEN V_GRADE := 'E';
    ELSE V_GRADE := 'F';
    END IF;

    -- INSERT 쿼리문 실행
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_INSERT이(가) 컴파일되었습니다.



--○ TBL_SUNGJUK 테이블에서
--   특정 학생의 점수(학번, 국어, 영어, 수학)
--   데이터 수정 시 총점, 평균, 등급까지 수정하는 프로시저를 작성한다.
--   프로시저 명: PRC_SUNGJUK_UPDATE()
/*
실행 예)
EXEC PRC_SUNGJUK_UPDATE(2, 100, 100, 100);

프로시저 호출로 처리된 결과)
학번  이름  국어점수    영어점수    수학점수    총점  평균  등급
 2   김소연    100        100         100        300  100    A
 */
 
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR    IN TBL_SUNGJUK.KOR%TYPE
, V_ENG    IN TBL_SUNGJUK.ENG%TYPE
, V_MAT    IN TBL_SUNGJUK.MAT%TYPE
)

IS
    -- 주요 변수 선언
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
    
BEGIN
    -- 연산 및 처리
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    
    IF (V_AVG >= 90) 
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80) 
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70) 
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60) 
        THEN V_GRADE := 'D';
    ELSIF (V_AVG >= 50) 
        THEN V_GRADE := 'E';
    ELSE V_GRADE := 'F';
    END IF;

    -- UPDATE 쿼리문 실행
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG, MAT = V_MAT
      , TOT = V_TOT, AVG = V_AVG, GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_UPDATE이(가) 컴파일되었습니다.


--○ TBL_STUDENTS 테이블에서
--   전화번호와 주소 데이터를 수정하는(변경하는) 프로시저를 작성한다.
--   단, ID와 PW가 일치하는 경우에만 수정을 진행할 수 있도록 한다.
--   프로시저 명 : PRC_STUDENTS_UPDATE()
/*
실행 예)
EXEC PRC_STUDENTS_UPDATE('superman', 'java006$', '010-9999-9999', '인천');

프로시저 호출로 처리된 결과
superman    손범석     010-9999-9999       인천
*/

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)

IS    
BEGIN
    -- UPDATE 쿼리문 구성
    UPDATE (SELECT I.ID, I.PW, S.TEL, S.ADDR
             FROM TBL_IDPW I JOIN TBL_STUDENTS S
             ON I.ID = S.ID) T
    SET T.TEL = V_TEL, T.ADDR = V_ADDR
    WHERE T.ID = V_ID AND T.PW = V_PW;
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.



--○ TBL_INSA 테이블을 대상으로 신규 데이터 입력 프로시저를 작성한다.
--   NUM NAME SSN IBSADATE CITY TEL BUSEO JIKWI BASICPAY SUDANG
--   구조를 갖고 있는 대상 테이블에 데이터 입력 시
--   NUM 컬럼(사원번호)의 값은
--   기존 부여된 사원번호 마지막 번호의 그 다음 번호를 자동으로
--   입력 처리할 수 있는 프로시저로 구성한다.
--   프로시저 명 : PRC_INSA_INSERT(NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG);
/*
실행 예)
EXEC PRC_INSA_INSERT('이다영', '951027-2234567', SYSDATE, '서울', '010-4113-2353', '영업부', '대리', 10000000, 2000000);  -- 천만, 이백만

프로시저 호출로 처리된 결과)
1061 이다영 2234567 SYSDATE 서울 010-4113-2353 영업부 대리 10000000 2000000
*/
