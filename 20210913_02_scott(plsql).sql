SELECT USER
FROM DUAL;
--==>> SCOTT

--■■■ PL/SQL ■■■--
/*
1. PL/SQL(Procedural Language extension to SQL) 은
   프로그래밍 언어의 특성을 가지는 SQL 의 확장이며,
   데이터 조작과 질의 문장은 PL/SQL 의 절차적 코드 안에 포함된다.
   또한 PL/SQL을 사용하면 SQL로 할 수 없는 절차적 작업이 가능하다.
   여기에서 『절차적』이라는 단어가 가지는 의미는
   어떤 것이 어떤 과정을 거져 어떻게 완료되는지
   그 방법을 정확하게 코드에 기술한다는 것을 의미한다.

2. PL/SQL 은 절차적으로 표현하기 위해
   범수를 선언할 수 있는 기능
   참과 거짓을 구별할 수 있는 기능.
   실행 흐름을 컨트롤할 수 있는 기능 등을 제공한다.

3. PL/SQL 은 블럭 구조로 되어 있으며
   블럭은 선언 부분, 실행 부분, 예외 처리 부분의 
   세 부분으로 구성되어 있다.
   또한, 반드시 실행 부분은 존재해야 하며, 구조는 다음과 같다.
   
4. 형식 및 구조
[DECLARE]
    -- 선언문(declarations)
BEGIN
    -- 실행문(statements)
        
    [EXCEPTION]
        -- 예외 처리문(execption handlers)
END;

5. 변수 선언
DECLAER
                        (cf. 자바: 자료형 변수명; → int num;)       int num = 10;
    변수명 자료형;        (테이블 생성 시와 유사: COL1 NUMBER(3);)   COL1 NUMBER(3) := 10;
    변수명 자료형 := 초기값;
BEGIN
    PL/SQL 구문;
END;    
*/

SET SERVEROUTPUT ON;
--==>> 작업이 완료되었습니다.
-- 『DBMS_OUTPUT.PUT_LINE()』 을 통해
--  화면에 결과를 출력하기 위한 환경변수 설정


--○ 변수에 임의의 값을 대입하고 출력하는 구문 구성

DECLARE 
    -- 선언부
    V1 NUMBER := 10;
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(20) := 'Oracle';    
BEGIN
    -- 실행부
    -- cf. 자바 →SYSTEM.OUT.PRINTLN(V1);
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
--==>> 
/*
10
HELLO
Oracle

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 변수에 임의의 값을 대입하고 출력하는 구문 구성

DECLARE 
    -- 선언부
    V1 NUMBER := 10;
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(20) := 'Oracle';    
BEGIN
    -- 실행부              -- cf. 자바
    V1 := V1 * 10;         -- V1 *= 10;
    V2 := V2 || ' 수지';   -- V2 += " 수지";
    V3 := V3 || ' World';
    
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
    
END;
--==>>
/*
100
HELLO 수지
Oracle World


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


/*
○ IF문(조건문)
IF ~ TEHN ~ ELSE ~ END IF;

1. PL/SQL 의 IF 문장은 다른 언어의 IF 조건문과 거의 유사하다.
   일치하는 조건에 따라 선택적으로 작업을 수행할 수 있도록 한다.
   TRUE 이면 THEN 과 ELSE 사이의 문장을 수행하고
   FALSE 나 NULL 이면 ELSE 와 END IF 사이의 문장을 수행하게 된다.
   
2. 형식 및 구조
IF 조건
    THEN 처리구문;
ELSIF 조건
    THEN 처리구문;
ELSIF 조건
    THEN 처리구문;
ELSE 
    처리구문;
END IF;
*/


--○ 변수에 들어있는 값에 따라...
--   Excellent, Good, Fail 로 구분하여
--   결과를 출력하는 PL/SQL 구문을 작성한다.
DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'C';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('Excellent');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('Good');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Fail');    
    END IF;
END;    
--==>> Fail


DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'B';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('Excellent');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('Good');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Fail');    
    END IF;
END;    
--==>> Good


/*
○ CASE문 (조건문)
CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

1. 형식 및 구조
CASE
    WHEN 값1
        THEN 실행문;
    WHEN 값2
        THEN 실행문;
    ELSE
        실행문;
END CASE;
*/

--○ 변수에 들어있는 값에 따라...
--   Excellent, Good, Fail 로 구분하여
--   결과를 출력하는 PL/SQL 구문을 작성한다.

DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'A';
    
    CASE GRADE
        WHEN 'A'
            THEN DBMS_OUTPUT.PUT_LINE('Excellent');
        WHEN 'B'
            THEN DBMS_OUTPUT.PUT_LINE('Good');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Fail');
    END CASE;
END;
/*
Excellent

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 외부 입력 처리
--ACEEP 문
--  ACCEP 변수명 PROMPT '메시지';
--  외부 변수로부터 입력받은 데이터를 내부 변수에 전달할 때
--  『&외부변수명』 형태로 접근하게 된다.


--○ 정수 2개를 외부로부터(사용자로부터) 입력 받아
--   이들의 덧셈 결과를 출력하는 PL/SQL 구문을 작성한다.

ACCEPT N1 PROMPT '첫 번째 정수를 입력하세요.';
ACCEPT N2 PROMPT '두 번째 정수를 입력하세요.';

DECLARE
    -- 주요 변수 선언
    NUM1    NUMBER := &N1;
    NUM2    NUMBER := &N2;
    TOTAL   NUMBER := 0;    
BEGIN
    -- 연산 및 처리
    TOTAL := NUM1 + NUM2;
    
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' + ' || NUM2 || ' = ' || TOTAL);
END;
--==>
/*
10 + 20 = 30


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 사용자로부터 입력받은 금액을 화폐 단위로 출력하는 프로그램을 작성한다.
--   단, 반환 금액은 편의상 1천원 미만, 10원 이상만 가능하다고 가정한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 금액 입력 : [    890 ]
입력받은 금액 총액 : 890원
화폐 단위 : 오백원 1, 백원 3, 오십원 1, 십원 4
*/

-- [나의 풀이]
ACCEPT MM PROMPT '금액 입력을 입력하세요.';

DECLARE
    -- 주요 변수 선언   
    MM      NUMBER := &MM;  -- 입력받은 금액
    M       NUMBER;         -- 연산 시 사용할 금액

    M500    NUMBER := 0;
    M100    NUMBER := 0;
    M50     NUMBER := 0;
    M10     NUMBER := 0;
    
BEGIN
    -- 연산 및 처리
    M := MM;
    
    M500 := TRUNC(M/500);
    M := MOD(M, 500);
    
    M100 := TRUNC(M/100);
    M := MOD(M, 100);
    
    M50 := TRUNC(M/50);
    M := MOD(M, 50);
    
    M10 := TRUNC(M/10);
    M := MOD(M, 10);
    
    -- 결과 출력   
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : ' || MM || '원');
    DBMS_OUTPUT.PUT_LINE('화폐 단위 : 오백원 ' || M500 || ', 백원 ' || M100 || ', 오십원 ' || M50 || ', 십원 ' || M10); 
END;



-- [함께 풀이]
ACCEPT INPUT PROMPT '금액 입력';

DECLARE
    --○ 주요 변수 선언 및 초기화
    MONEY   NUMBER := &INPUT;        -- 연산을 위해 담아둔 변수
    MONEY2  NUMBER := &INPUT;        -- 출력을 위해 담아둔 변수(연산 과정에서 값이 변하기 때문에...)
    M500    NUMBER;                  -- 500원 짜리 갯수를 담아둘 변수
    M100    NUMBER;                  -- 100원 짜리 갯수를 담아둘 변수
    M50     NUMBER;                  --  50원 짜리 갯수를 담아둘 변수
    M10     NUMBER;                  --  10원 짜리 갯수를 담아둘 변수
BEGIN
    --○ 연산 및 처리
    -- MONEY 를 500으로 나눠서 몫을 취하고 나머지는 버린다. → 500원의 갯수
    M500 := TRUNC(MONEY/500);
    
    -- MONEY 를 500으로 나눠서 몫을 버리고 나머지는 취한 다음
    -- 이 결과를 다시 MONEY에 담아낸다.
    MONEY := MOD(MONEY, 500);
    
    -- MONEY 를 100으로 나눠서 몫을 취하고 나머지는 버린다. → 100원의 갯수
    M100 := TRUNC(MONEY/100);
    
    -- MONEY 를 100으로 나눠서 몫을 버리고 나머지는 취한 다음
    -- 이 결과를 다시 MONEY 에 담아낸다.
    MONEY := MOD(MONEY, 100);
    
    -- MONEY 를 50으로 나눠서 몫을 취하고 나머지는 버린다. → 50원의 갯수
    M50 := TRUNC(MONEY/50);
    
    -- MONEY 를 50으로 나눠서 몫을 버리고 나머지는 취한 다음
    -- 이 결과를 다시 MONEY 에 담아낸다.
    MONEY := MOD(MONEY, 50);
    
    -- MONEY 를 10으로 나눠서 몫을 취하고 나머지는 버린다. → 10원의 갯수
    M10 := TRUNC(MONEY/10);
    
    --○ 결과 출력 
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : ' || MONEY2 || '원');
    DBMS_OUTPUT.PUT_LINE('화폐 단위 : 오백원 ' || M500 || ', 백원 ' || M100 || ', 오십원 ' || M50 || ', 십원 ' || M10);
END;
--> 바인딩 변수 입력 대화창에 870 입력

--==>>
/*
입력받은 금액 총액 : 870원
화폐 단위 : 오백원 1, 백원 3, 오십원 1, 십원 2

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/



--○ 기본 반복문
-- LOOP ~ END LOOP;

-- 1. 별도의 조건과 상관 없이 무조건 반복하는 구문.

-- 2. 형식 및 구조
/*
LOOP
    -- 실행문;
    
    [EXIT WHEN 조건]  -- 조건이 참인 경우 반복문을 빠져나간다.
    
END LOOP;    
*/

--○ 1 부터 10 까지의 수 출력(LOOP 활용)
DECLARE
    N NUMBER;
BEGIN
    N := 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        
        EXIT WHEN N >= 10;
        
        N := N + 1;                 -- N++;     N+=1;
    END LOOP;
END;  
--==>>
/*
1
2
3
4
5
6
7
8
9
10

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ WHILE 반복문
-- WHILE LOOP ~ END LOOP;

-- 1. 제어 조건이 TRUE 인 동안 일련의 문장을 반복하기 위해
--    WHILE LOOP 문장을 사용하게 된다.
--    조건은 반복이 시작될 때 체크하게 되어
--    LOOP 내의 문장이 한 번도 수행되지 않을 수도 있다.

-- 2. 형식 및 구조
/*
WHILE 조건 LOOP           -- 조건이 참인 경우 반복 수행
    -- 실행문;
END LOOP;    
*/


--○ 1부터 10까지의 수 출력(WHILE LOOP 활용) 
DECLARE
    N   NUMBER;
BEGIN
    N := 0;
    
    WHILE N<10 LOOP
        N := N + 1;  
        DBMS_OUTPUT.PUT_LINE(N);  
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ FOR 반복문
-- FOR LOOP ~ END LOOP;

-- 1. 『시작 수』에서 1씩 증가하여
--    『끝냄 수』가 될 때까지 반복 수행한다.

-- 2. 형식 및 구조
/*
FOR 카운터 in [REVERSE] 시작수 .. 끝냄 수 LOOP
    -- 실행문;
END LOOP;
*/

--○ 1 부터 10 까지의 수 출력(FOR LOOP 활용)
DECLARE
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;    
/*
1
2
3
4
5
6
7
8
9
10

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 사용자로부터 임의의 단(구구단)을 입력 받아
--   해당 단수의 구구단을 출력하는 PL/SQL 구문을 작성한다.

/*
실행 예)
바인딩 변수 입력 대화창 → 단을 입력하세요 : [    2 ]

2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- 1. LOOP 문의 경우
ACCEPT INPUT PROMPT '단을 입력하세요';

DECLARE
    DAN NUMBER := &INPUT;
    N  NUMBER;
BEGIN  
    N := 0;  
    LOOP
        N := N + 1;
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || (DAN * N));
        EXIT WHEN N >= 9;
    END LOOP;
END;

-- 2. WHILE LOOP 문의 경우
ACCEPT INPUT PROMPT '단을 입력하세요';

DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER := 0;
    
BEGIN
    WHILE N < 9 LOOP
        N := N + 1;
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || (DAN * N));
    END LOOP;
END;

-- 3. FOR LOOP 문의 경우
ACCEPT INPUT PROMPT '단을 입력하세요';

DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER;

BEGIN
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || (DAN * N));
    END LOOP;
END;







