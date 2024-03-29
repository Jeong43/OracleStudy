--==============================================================================
--■■■ 함수
--==============================================================================

--○강의 진행 상황을 반환하는 함수
CREATE OR REPLACE FUNCTION FN_COURSE
( V_COUR_CODE TBL_COURSE.COUR_CODE%TYPE
)
RETURN VARCHAR2
IS
    V_STARTDATE TBL_COURSE.STARTDATE%TYPE;
    V_ENDDATE   TBL_COURSE.ENDDATE%TYPE;
    
    V_RESULT VARCHAR2(40);          
BEGIN
    SELECT STARTDATE, ENDDATE INTO V_STARTDATE, V_ENDDATE
    FROM TBL_COURSE
    WHERE COUR_CODE = V_COUR_CODE;
    
    IF (SYSDATE < V_STARTDATE)
        THEN V_RESULT := '개설 예정';
    ELSIF ((V_STARTDATE < SYSDATE) AND (V_ENDDATE > SYSDATE )) 
        THEN V_RESULT := '진행 중';
    ELSIF (V_ENDDATE < SYSDATE)
        THEN V_RESULT := '과정 종료';
    ELSE
        V_RESULT := '과정확인불가';
    END IF;
    
    RETURN V_RESULT;  
END;

--==============================================================================

--○개설과목 진행 상황을 반환하는 함수
CREATE OR REPLACE FUNCTION FN_OPSUBJECT
( V_OPSUB_CODE    TBL_OPSUBJECT.SUB_CODE%TYPE
)
RETURN VARCHAR2
IS
    V_STARTDATE TBL_OPSUBJECT.STARTDATE%TYPE;
    V_ENDDATE   TBL_OPSUBJECT.ENDDATE%TYPE;
    
    V_RESULT VARCHAR2(40);
BEGIN
    SELECT STARTDATE, ENDDATE INTO V_STARTDATE, V_ENDDATE
    FROM TBL_OPSUBJECT
    WHERE OPSUB_CODE = V_OPSUB_CODE;
    
    IF (SYSDATE < V_STARTDATE)
        THEN V_RESULT := '개설 예정';
    ELSIF ((V_STARTDATE < SYSDATE) AND (V_ENDDATE > SYSDATE )) 
        THEN V_RESULT := '진행 중';
    ELSIF (V_ENDDATE < SYSDATE)
        THEN V_RESULT := '과정 종료';
    ELSE
        V_RESULT := '개설과목 확인불가';
    END IF;
    
    RETURN V_RESULT;
    
END;

--==============================================================================
--○개설과목의 배점, 교수 입력점수(원점수)를 계산해서 출결 점수 구하는 함수
CREATE OR REPLACE FUNCTION FN_SCORE_ATTEND
( V_GRADE_CODE TBL_GRADE.GRADE_CODE%TYPE
)
RETURN NUMBER
IS
    V_OPSUB_CODE TBL_GRADE.OPSUB_CODE%TYPE;
    V_ATTEND     TBL_GRADE.ATTEND%TYPE;     --출결점수
    V_ALLOT_CODE TBL_ALLOT.ALLOT_CODE%TYPE;
    
    V_ATTEND2     TBL_GRADE.ATTEND%TYPE;     --출결배점
    V_RESULT NUMBER;
  
BEGIN
    -- 점수
    SELECT OPSUB_CODE, ATTEND INTO V_OPSUB_CODE, V_ATTEND
    FROM TBL_GRADE
    WHERE GRADE_CODE = V_GRADE_CODE;
    
    -- 배점코드
    SELECT ALLOT_CODE INTO V_ALLOT_CODE
    FROM TBL_OPSUBJECT
    WHERE OPSUB_CODE = V_OPSUB_CODE;
    
    -- 배점
    SELECT ATTEND INTO V_ATTEND2
    FROM TBL_ALLOT
    WHERE ALLOT_CODE = V_ALLOT_CODE;

    V_RESULT := (V_ATTEND * (V_ATTEND2/100));

    RETURN V_RESULT;
    
END;

--==============================================================================

--○개설과목의 배점, 교수 입력점수(원점수)를 계산해서 필기 점수 구하는 함수
CREATE OR REPLACE FUNCTION FN_SCORE_WRITTEN
( V_GRADE_CODE TBL_GRADE.GRADE_CODE%TYPE
)
RETURN NUMBER
IS
    V_OPSUB_CODE TBL_GRADE.OPSUB_CODE%TYPE;
    V_WRITTEN    TBL_GRADE.WRITTEN%TYPE;     --필기점수
    V_ALLOT_CODE TBL_ALLOT.ALLOT_CODE%TYPE;
    
    V_WRITTEN2   TBL_GRADE.WRITTEN%TYPE;     --필기배점
    
    V_RESULT NUMBER;
  
BEGIN
    
    -- 점수테이블 (점수, 개설과목코드)
    SELECT OPSUB_CODE, WRITTEN INTO V_OPSUB_CODE, V_WRITTEN
    FROM TBL_GRADE 
    WHERE GRADE_CODE = V_GRADE_CODE;
    
    -- 개설과목테이블 (배점코드)
    SELECT ALLOT_CODE INTO V_ALLOT_CODE
    FROM TBL_OPSUBJECT
    WHERE OPSUB_CODE = V_OPSUB_CODE;
    
    -- 배점테이블 (필기배점)
    SELECT WRITTEN INTO V_WRITTEN2
    FROM TBL_ALLOT
    WHERE ALLOT_CODE = V_ALLOT_CODE;

    V_RESULT := (V_WRITTEN * (V_WRITTEN2/100));   

    RETURN V_RESULT;
    
END;

--==============================================================================

--○개설과목의 배점, 교수 입력점수(원점수)를 계산해서 실기 점수 구하는 함수
CREATE OR REPLACE FUNCTION FN_SCORE_PRACTICE
( V_GRADE_CODE TBL_GRADE.GRADE_CODE%TYPE
)
RETURN NUMBER
IS
    V_OPSUB_CODE TBL_GRADE.OPSUB_CODE%TYPE;
    V_PRACTICE   TBL_GRADE.PRACTICE%TYPE;   --실기점수
    V_ALLOT_CODE TBL_ALLOT.ALLOT_CODE%TYPE;
    V_PRACTICE2   TBL_GRADE.PRACTICE%TYPE;   --실기배점
    V_RESULT NUMBER;
BEGIN
    
    -- 점수
    SELECT OPSUB_CODE, PRACTICE INTO V_OPSUB_CODE, V_PRACTICE
    FROM TBL_GRADE
    WHERE GRADE_CODE = V_GRADE_CODE;
    
    -- 배점코드
    SELECT ALLOT_CODE INTO V_ALLOT_CODE
    FROM TBL_OPSUBJECT
    WHERE OPSUB_CODE = V_OPSUB_CODE;
    
    -- 배점
    SELECT PRACTICE INTO V_PRACTICE2
    FROM TBL_ALLOT
    WHERE ALLOT_CODE = V_ALLOT_CODE;

    V_RESULT := (V_PRACTICE * (V_PRACTICE2/100));
    
    RETURN V_RESULT;
    
END;

--==============================================================================

--○중도하차 여부 확인 함수
CREATE OR REPLACE FUNCTION FN_QUIT
( V_REG_CODE TBL_REGIST.REG_CODE%TYPE )
RETURN VARCHAR2
IS
    V_RESULT    VARCHAR2(30);
    V_COUNT     NUMBER;
    
BEGIN        
    SELECT COUNT(*) INTO V_COUNT
    FROM TBL_QUIT
    WHERE REG_CODE = V_REG_CODE;
     
       
    IF (V_COUNT >= 1)
        THEN V_RESULT := '중도하차';
    ELSIF (V_COUNT = 0)
        THEN V_RESULT := '중도하차 아님';
    END IF;

    RETURN V_RESULT;       
END;

      
