
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

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME      IN TBL_INSA.NAME%TYPE
, V_SSN       IN TBL_INSA.SSN%TYPE
, V_IBSADATE  IN TBL_INSA.IBSADATE%TYPE
, V_CITY      IN TBL_INSA.CITY%TYPE
, V_TEL       IN TBL_INSA.TEL%TYPE
, V_BUSEO     IN TBL_INSA.BUSEO%TYPE
, V_JIKWI     IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY  IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG    IN TBL_INSA.SUDANG%TYPE
)

IS
    V_NUM   TBL_INSA.NUM%TYPE;
    
BEGIN
    -- 연산 및 처리
    SELECT MAX(NUM)+1 INTO V_NUM
    FROM TBL_INSA;

    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_INSA_INSERT이(가) 컴파일되었습니다.


--------------------------------------------------------------------------------

--○ TBL_상품, TBL_입고 테이블을 대상으로
--   TBL_입고 테이블에 데이터 입력 시(즉, 입고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량이 함께 변동될 수 있는 기능을 가진
--   프로시저를 작성한다.
--   단, 이 과정에서 입고번호는 자동 증가 처리한다. (시퀀스 사용 안함)
--   TBL_입고 테이블 구성 컬럼
--   → 입고번호, 상품코드, 입고일자, 입고수량, 입고단가
--   프로시저 명: PRC_입고_INSERT(상품코드, 입고수량, 입고단가)

-- ※ TBL_입고 테이블에서 입고 이벤트 발생 시... 
--    관련 테이블에서 수행되어야 하는 내용
--    0. SELECT → TBL_입고
--       SELECT NVL(MAX(입고번호), 0)
--       FROM TBL_입고
--    1. INSERT → TBL_입고
--       INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
--       VLALUES(1, 'C001', SYSDATE, 30, 1000);
--    2. UPDATE → TBL_상품
--       UPDATE TBL_상품
--       SET 재고수량 = 기존재고수량 + 30(←입고수량)
--       WHERE 상품코드 = 'C001';

CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( V_상품코드 IN TBL_입고.상품코드%TYPE
, V_입고수량 IN TBL_입고.입고수량%TYPE
, V_입고단가 IN TBL_입고.입고단가%TYPE
)

IS
    V_입고번호 TBL_입고.입고번호%TYPE;
    
BEGIN
    -- 연산 및 처리
    SELECT NVL(MAX(입고번호), 0) INTO V_입고번호
    FROM TBL_입고;
    
    -- INSERT
    INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
    VALUES((V_입고번호+1), V_상품코드, SYSDATE, V_입고수량, V_입고단가); 
    
    -- UPDATE
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;   

    -- 커밋
    COMMIT;
    
    -- 예외처리
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;    
END;
--==>> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.



--■■■ 프로시저 내에서의 예외 처리 ■■■---

--○ TBL_MEMBER 테이블에서 데이터를 입력하는 프로시저 작성
--   단, 이 프로시저를 통해 데이터를 입력할 경우
--   CITY(지역) 항목에 '서울', '인천', '경기'만 입력이 가능하도록 구성한다.
--   허용된 지역 외의 지역을 프로시저 호출을 통해 입력하려고 하는 경우
--   예외 처리를 하려고 한다.
--   프로시저 명 : PRC_MEMBER_INSERT(이름, 전화번호, 지역)

-- 프로시저 생성
CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME    IN TBL_MEMBER.NAME%TYPE
, V_TEL     IN TBL_MEMBER.TEL%TYPE
, V_CITY    IN TBL_MEMBER.CITY%TYPE
)

IS
    -- 실행 영역의 쿼리문 수행을 위해 필요한 변수 선언
    V_NUM   TBL_MEMBER.NUM%TYPE;
    
    -- 사용자 정의 예외에 대한 변수 선언 CHECK~!!!
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    -- 프로시저를 통해 입력 처리를 정상적으로 진행해야 할 데이터인지 아닌지의 여부를
    -- 가장 먼저 확인할 수 있도록 코드 구성
    IF (V_CITY NOT IN ('서울', '인천', '경기'))
        -- 예외 발생
        -- THEN USER_DIFINE_ERROR 를 발생시키겠다.
        THEN RAISE USER_DEFINE_ERROR; --cf. JAVA → throw
    END IF;

    -- 선언한 변수에 값 담아내기
    SELECT NVL(MAX(NUM), 0) INTO V_NUM
    FROM TBL_MEMBER;

    -- 쿼리문 구성
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES((V_NUM+1), V_NAME, V_TEL, V_CITY);
    
    -- 커밋
    COMMIT;
    
    -- 예외 처리 구문
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '서울, 인천, 경기만 입력이 가능합니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_MEMBER_INSERT이(가) 컴파일되었습니다.



--------------------------------------------------------------------------------

--○ TBL_출고 테이블에 데이터 입력 시(즉, 출고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량이 변동되는 프로시저를 작성한다.
--   단, 출고번호는 입고 번호와 마찬가지로 자동 증가.
--   또한, 출고수량이 재고수량보다 많은 경우...
--   출고 액션을 취소할 수 있도록 처리한다. (출고가 이루어지지 않도록...)
--   프로시저 명: PRC_출고_INSERT(상품코드, 출고수량, 출고단가)

CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
( V_상품코드    IN TBL_출고.상품코드%TYPE
, V_출고수량    IN TBL_출고.출고수량%TYPE
, V_출고단가    IN TBL_출고.출고단가%TYPE
)

IS
    -- 주요 변수 선언
    V_출고번호  TBL_출고.출고번호%TYPE;
    V_재고수량  TBL_상품.재고수량%TYPE;
    
    -- 사용자 정의 예외 변수 
    USER_DIFINE_ERROR   EXCEPTION;

BEGIN
    -- 프로시저 진행여부 판단
    -- 쿼리문 수행 이전에 수행 가능 여부 확인 → 기존 재고 확인 → 출고수량과 비교    
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;

    -- 출고를 정상적으로 진행해 줄 것인지 아닌지에 대한 여부 확인
    -- (즉, 출고하려는 수량이 파악한 재고수량보다 많으면... 예외 발생)    
    IF (V_출고수량 > V_재고수량)
        -- 예외 발생
        THEN RAISE USER_DIFINE_ERROR;
    END IF;
    

    -- 선언한 변수에 값 담아내기
    SELECT NVL(MAX(출고번호), 0) INTO V_출고번호
    FROM TBL_출고;    
    
    -- INSERT
    INSERT INTO TBL_출고(출고번호, 상품코드, 출고일자, 출고수량, 출고단가)
    VALUES((V_출고번호+1), V_상품코드, SYSDATE, V_출고수량, V_출고단가);
    
    -- UPDATE
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 커밋
    COMMIT;
    
    
    -- 예외처리
    EXCEPTION
        WHEN USER_DIFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고 수량이 부족합니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;


--------------------------------------------------------------------------------

--○ TBL_출고 테이블에서 출고 수량을 수정(변경)하는 프로시저를 작성한다.
--   프로시저 명 : PRC_출고_UPDATE(출고번호, 변경할출고수량);

-- [나의 풀이]
CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
( V_출고번호          IN TBL_출고.출고번호%TYPE
, V_변경할출고수량    IN TBL_출고.출고수량%TYPE
)

IS
    -- 주요 변수 선언
    V_상품코드      TBL_출고.상품코드%TYPE;
    V_기존출고수량  TBL_출고.출고수량%TYPE;
    V_현재재고수량  TBL_상품.재고수량%TYPE;
    
    -- 사용자 정의 예외 변수
    USER_DIFINE_ERROR   EXCEPTION;

BEGIN
    --○ 선언한 변수에 값 담기
    SELECT 상품코드, 출고수량 INTO V_상품코드, V_기존출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;    
    
    SELECT 재고수량 INTO V_현재재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;


    --○ 프로시저 진행여부 판단
    IF (V_현재재고수량 + V_기존출고수량 < V_변경할출고수량)
        THEN RAISE USER_DIFINE_ERROR;
    END IF;
    
    
    --○ 프로시저 진행
    -- UPDATE : TBL_상품
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_기존출고수량 - V_변경할출고수량
    WHERE 상품코드 = V_상품코드;

    -- UPDATE : TBL_출고
    UPDATE TBL_출고
    SET 출고수량 = V_변경할출고수량
    WHERE 출고번호 = V_출고번호;

    -- 커밋
    COMMIT;
    
    
    --○ 예외처리
    EXCEPTION 
        WHEN USER_DIFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003, '재고가 부족합니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;


-- [함께 풀이]
CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
( --① 매개변수 구성
  V_출고번호          IN TBL_출고.출고번호%TYPE
, V_출고수량    IN TBL_출고.출고수량%TYPE
)

IS
    --③ 주요 변수 추가 선언
    V_상품코드      TBL_상품.상품코드%TYPE;
    
    --⑤ 주요 변수 추가 선언
    V_이전출고수량  TBL_출고.출고수량%TYPE;
    
    --⑦ 주요 변수 추가 선언
    V_재고수량  TBL_상품.재고수량%TYPE;
    
    --⑨ 주요 변수(사용자 정의 예외) 추가 선언
    USER_DIFINE_ERROR   EXCEPTION;

BEGIN    
    --④ 상품코드와 이전출고수량 파악을 위해 변경 이전의 출고 내역 확인
    SELECT 상품코드, 출고수량 INTO V_상품코드,V_이전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호; 
    
    --⑥ 출고를 정상적으로 수행해야 할지 말지의 여부 판단 필요
    --   변경 이전의 출고수량 및 현재의 재고수량 확인
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    --⑧ 파악한 재고수량에 따라 데이터 변경 실시 여부 판단
    --   (『재고수량+이전출고수량 < 현재출고수량』인 상황이라면... 사용자 정의 예외 발생)
    IF (V_재고수량 + V_이전출고수량 < V_출고수량)
        THEN RAISE USER_DIFINE_ERROR;
    END IF;
    
    --② 수행해야 할 쿼리문 구성(UPDATE → TBL_출고 / UPDATE → TBL_상품)
    UPDATE TBL_출고
    SET 출고수량 = V_출고수량
    WHERE 출고번호 = V_출고번호;

    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_이전출고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    --⑩ 커밋
    COMMIT;
    
    --⑪ 예외처리
    EXCEPTION 
        WHEN USER_DIFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고가 부족합니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.