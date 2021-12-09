--○ 문제
-- TBL_SAWON 테이블을 활용하여 다음과 같은 항목들을 조회한다.

-- 사원번호, 사원명, 주민번호, 성별, 현재 나이, 입사일
-- , 정년퇴직일, 근무일수, 남은일수, 급여, 보너스

-- 단, 현재나이는 한국나이 계산법에 따라 연산을 수행한다.
-- 또한, 정년퇴직일은 해당 직원의 나이가 한국나이로 60세가 되는 해(연도)의
-- 그 직원의 입사 월, 일로 연산을 수행한다.
-- 그리고, 보너스는 1000일 이상 2000일 미만 근무한 사원은
-- 그 직원의 원래 급여 기준 30% 지급,
-- 2000일 이상 근무한 직원은
-- 그 직원의 원래 급여 기준 50% 지급을 할 수 있도록 처리한다.


SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호" 
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '3') THEN '남'
            WHEN SUBSTR(JUBUN, 7, 1) IN('2', '4') THEN '여'
       END "성별"
     , EXTRACT(YEAR FROM SYSDATE) - (CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '2')
                                              THEN 1900 + TO_NUMBER(SUBSTR(JUBUN, 1, 2))
                                         WHEN SUBSTR(JUBUN, 7, 1) IN('3', '4')
                                              THEN 2000 + TO_NUMBER(SUBSTR(JUBUN, 1, 2))
                                    END) + 1 "나이"           -- 현재 년도 - 탄생년 + 1
     , HIREDATE "입사일"
     , TO_DATE(CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '2') THEN '19'
                    WHEN SUBSTR(JUBUN, 7, 1) IN('3', '4') THEN '20'
               END
               || SUBSTR(JUBUN, 1, 2) || '-' || SUBSTR(JUBUN, 3, 2) || '-' || SUBSTR(JUBUN, 5, 2))
        + TO_YMINTERVAL('59-00') "정년퇴직일"            -- 출생일 + 59년
     , TRUNC(SYSDATE - HIREDATE) "근무일수"
     , TRUNC(TO_DATE(CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '2') THEN '19'
                          WHEN SUBSTR(JUBUN, 7, 1) IN('3', '4') THEN '20'
                    END
                    || SUBSTR(JUBUN, 1, 2) || '-' || SUBSTR(JUBUN, 3, 2) || '-' || SUBSTR(JUBUN, 5, 2))
            + TO_YMINTERVAL('59-00') - SYSDATE) "남은일수"      --정년퇴직일 - 현재일
     , SAL "급여" 
     , CASE WHEN TRUNC(SYSDATE - HIREDATE)>=1000 AND TRUNC(SYSDATE - HIREDATE)<2000
                    THEN SAL*0.3
            WHEN TRUNC(SYSDATE - HIREDATE)>=2000 
                    THEN SAL*0.5
            ELSE 0
       END "보너스"
FROM TBL_SAWON;


------함께 푼 풀이--------------------------------------------------------------

-- TBL_SAWON 테이블에 존재하는 사원들의 
-- 입사일(HIREDATE) 컬럼에서 월, 일만 조회하기
SELECT SANAME, HIREDATE, TO_CHAR(HIREDATE,'MM-DD') "월일"
FROM TBL_SAWON;
--==>>
/*
김소연       2001-01-03   01-03
이다영       2010-11-05   11-05
이지영       2012-08-16   08-16
손다정       1999-02-02   02-02
이하이       2013-07-15   07-15
이이경       2011-08-17   08-17
김이나       1999-11-11   11-11
아이유       1999-11-11   11-11
선동열       1995-11-11   11-11
선우용녀     1995-10-10   10-10
선우선       2001-10-10   10-10
남진         1998-02-13   02-13
남궁현       2002-02-13   02-13
남도일       2002-02-13   02-13
김남길       2015-01-10   01-10
*/

SELECT SANAME, HIREDATE, TO_CHAR(HIREDATE,'MM') "월", TO_CHAR(HIREDATE,'DD') "일"
FROM TBL_SAWON;
--==>>
/*
김소연       2001-01-03   01   03
이다영       2010-11-05   11   05
이지영       2012-08-16   08   16
손다정       1999-02-02   02   02
이하이       2013-07-15   07   15
이이경       2011-08-17   08   17
김이나       1999-11-11   11   11
아이유       1999-11-11   11   11
선동열       1995-11-11   11   11
선우용녀     1995-10-10   10   10
선우선       2001-10-10   10   10
남진         1998-02-13   02   13
남궁현       2002-02-13   02   13
남도일       2002-02-13   02   13
김남길       2015-01-10   01   10
*/

SELECT SANAME, HIREDATE, TO_CHAR(HIREDATE,'MM') ||'-'|| TO_CHAR(HIREDATE,'DD') "월일"
FROM TBL_SAWON;
--==>>
/*
김소연       2001-01-03   01-03
이다영       2010-11-05   11-05
이지영       2012-08-16   08-16
손다정       1999-02-02   02-02
이하이       2013-07-15   07-15
이이경       2011-08-17   08-17
김이나       1999-11-11   11-11
아이유       1999-11-11   11-11
선동열       1995-11-11   11-11
선우용녀     1995-10-10   10-10
선우선       2001-10-10   10-10
남진         1998-02-13   02-13
남궁현       2002-02-13   02-13
남도일       2002-02-13   02-13
김남길       2015-01-10   01-10
*/

--○ 문제 변경
--   TBL_SAWON 테이블을 활용하여 다음과 같은 항목들을 조회한다.
--   사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
--  , 정년퇴직일, 근무일수, 남은일수, 급여, 보너스

--  단, 현재나이는 한국나이 계산법에 따라 연산을 수행한다.
--  또한, 정년퇴직일은 해당 직원의 나이가 한국나이로 60세가 되는 해(연도)의
--  그 직원의 입사 월, 일로 연산을 수행한다.
--  그리고, 보너스는 4000일 이상 8000일 미만 근무한 사원은 원래 급여 기준 30% 지급,
--  8000일 이상 근무한 사원은 원래 급여 기준 50% 지급을 할 수 있도록 처리한다.

-- 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일, 급여
SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN 주민번호 7번째 자리 1개가 '1' 또는 '3' THEN '남자'
            WHEN 주민번호 7번째 자리 1개가 '2' 또는 '4' THEN '여자'
            ELSE '성별확인불가' 
       END "성별"
FROM TBL_SAWON;
------------------------------------------------------------------------
SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남자'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여자'
            ELSE '성별확인불가' 
       END "성별"
FROM TBL_SAWON;
--==>>
/*
1001   김소연       9307302234567   여자
1002   이다영       9510272234567   여자
1003   이지영       0909014234567   여자
1004   손다정       9406032234567   여자
1005   이하이       0406034234567   여자
1006   이이경       0202023234567   남자
1007   김이나       8012122234567   여자
1008   아이유       8105042234567   여자
1009   선동열       7209301234567   남자
1010   선우용녀     7001022234567   여자
1011   선우선       9001022234567   여자
1012   남진         8009011234567   남자
1013   남궁현       8203051234567   남자
1014   남도일       9208091234567   남자
1015   김남길       0202023234567   남자
*/


SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남자'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여자'
            ELSE '성별확인불가' 
       END"성별"
    -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대 생 / 2000년대 생)
    , CASE WHEN 1900년대 생이라면.. 
           THEN 현재년도 - (주민번호 앞 두자리 + 1899) 
           WHEN 2000년대 생이라면...
           THEN 현재년도 - (주민번호 앞 두자리 + 1999)
           ELSE -1
      END "현재나이" 
FROM TBL_SAWON;
-----------------------------------------------------------------------------
SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남자'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여자'
            ELSE '성별확인불가' 
       END"성별"
    -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대 생 / 2000년대 생)
    , CASE WHEN 주민번호 7번째자리 1개가 '1' 또는 '2'
           THEN 현재년도 - (주민번호 앞 두자리 + 1899) 
           WHEN 주민번호 7번째자리 1개가 '3' 또는 '4'
           THEN 현재년도 - (주민번호 앞 두자리 + 1999)
           ELSE -1
      END "현재나이" 
FROM TBL_SAWON;
-----------------------------------------------------------------------------
SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남자'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여자'
            ELSE '성별확인불가' 
       END"성별"
    -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대 생 / 2000년대 생)
    , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
           --                                           -----------------
           --                                   문자열이기 때문에 +못함
           WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
           ELSE -1
      END "현재나이"
    , HIREDATE "입사일"
    , SAL "급여"
FROM TBL_SAWON;
--==>>
/*
1001   김소연       9307302234567   여자   29   2001-01-03   3000
1002   이다영       9510272234567   여자   27   2010-11-05   2000
1003   이지영       0909014234567   여자   13   2012-08-16   1000
1004   손다정       9406032234567   여자   28   1999-02-02   4000
1005   이하이       0406034234567   여자   18   2013-07-15   1000
1006   이이경       0202023234567   남자   20   2011-08-17   2000
1007   김이나       8012122234567   여자   42   1999-11-11   3000
1008   아이유       8105042234567   여자   41   1999-11-11   3000
1009   선동열       7209301234567   남자   50   1995-11-11   3000
1010   선우용녀     7001022234567   여자   52   1995-10-10   3000
1011   선우선       9001022234567   여자   32   2001-10-10   2000
1012   남진         8009011234567   남자   42   1998-02-13   4000
1013   남궁현       8203051234567   남자   40   2002-02-13   3000
1014   남도일       9208091234567   남자   30   2002-02-13   3000
1015   김남길       0202023234567   남자   20   2015-01-10   2000
*/
-----------------------------------------------------------------
--서브쿼리
--; 위치 주의
SELECT T.사원번호, T.연봉
FROM
(
SELECT SANO "사원번호", SANAME "사원명", SAL "급여", SAL*12 "연봉"
FROM TBL_SAWON
)T;


--원래 이렇게 조회된는것
SELECT TBL_SAWON.SANO
FROM TBL_SAWON;

SELECT T.SANO
FROM TBL_SAWON T;


SELECT A.SANO
FROM
(
SELECT SANO "사원번호", SANAME "사원명", SAL "급여"
FROM TBL_SAWON
) A;
--==>> 에러 발생
-- 사원번호라는 컬럼은 존재하지만 SANO라는 컬럼은 없음!

SELECT A.사원번호, A.사원명
FROM
(
SELECT SANO "사원번호", SANAME "사원명", SAL "급여"
FROM TBL_SAWON
) A;


SELECT A.사원번호, A.사원명,A.연봉, A.연봉*2 "두배연봉"
FROM
(                                                                       --            
SELECT SANO "사원번호", SANAME "사원명", SAL "급여", SAL*12 "연봉"  --      |    → 이만큼 인라인뷰라고 함!
FROM TBL_SAWON                                                      --     |
) A;                                                                     --    


-- 인라인뷰안에서는 연봉*2 "두배연봉" 이걸 할수없는데 (파싱 순서 때문에)
-- 서브쿼리에서는 가넝한~!!

--숫자는 우측정렬 문자는 좌측정렬
DESC TBL_SAWON;
-------------------------------------------------------------------------------
-- 다시 이걸이용해서 하자
-- 아까만든거 서브쿼리로


--   사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
--  , 정년퇴직일, 근무일수, 남은일수, 급여, 보너스

SELECT T.사원번호,T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
    -- 정년퇴직일
    -- 정년퇴직년도 → 해당 직원의 나이가 한국나이로 60세가 되는 해
    -- 현재 나이가... 58세...2년 후     2021 → 2023
    -- 현재 나이가... 35세...25년 후     2021 → 2046
    -- ADD_MONTHS(SYSDATE, 남은년수 * 12)
    --                      -------
    --                      (60 - 현재나이)
    -- ADD_MONTHS(SYSDATE, (60 - 현재나이) *12) → 이 결과에서 정년퇴직 년도만 필요
    -- TO_CHAR(ADD_MONTHS(SYSDATE, (60 - 현재나이) *12),'YYYY') → 정년퇴직 년도만 추출
    -- TO_CHAR(ADD_MONTHS(SYSDATE, (60 - 현재나이) *12),'YYYY') || '-' || TO_CHAR(HIREDATE,''MM-DD')
    
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) *12),'YYYY') || '-' || TO_CHAR(T.입사일,'MM-DD') "정년퇴직일"
     
    -- 근무일수 = 현재날짜 - 입사일  → 하루를 다 채우지 못한건 버려야함!   --> 서브쿼리에 넣는게 더 편함!
     , TRUNC(SYSDATE - T.입사일) "근무일수"
     
    -- 남은일수 = 현재일 - 입사일
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) *12),'YYYY') 
       || '-' || TO_CHAR(T.입사일,'MM-DD'),'YYYY-MM-DD') - SYSDATE) "남은일수"
       
    -- 급여
     , T.급여
     
    -- 보너스
    -- 근무일수가 4000일 이상 8000일 미만 → 원래 급여의 30%
    -- 근무일수가 8000일 이상 → 원래 급여의 50%
    -- 나머지는 0
     , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 8000 THEN T.급여 * 0.5
            WHEN TRUNC(SYSDATE - T.입사일) >= 4000 THEN T.급여 * 0.3
            ELSE 0
       END "보너스"
FROM
(
-- 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일, 급여
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남자'
                WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여자'
                ELSE '성별확인불가' 
           END"성별"
        -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대 생 / 2000년대 생)
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
               --                                           -----------------
               --                                   문자열이기 때문에 +못함
               WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
               ELSE -1
          END "현재나이"
        , HIREDATE "입사일"
        , SAL "급여"
    FROM TBL_SAWON
) T;

--------------------------------------------------------------------------------
-- 주석처리뺀 쿼리문

--   사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
--  , 정년퇴직일, 근무일수, 남은일수, 급여, 보너스
SELECT T.사원번호,T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) *12),'YYYY') || '-' || TO_CHAR(T.입사일,'MM-DD') "정년퇴직일"
     , TRUNC(SYSDATE - T.입사일) "근무일수"
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) *12),'YYYY') 
       || '-' || TO_CHAR(T.입사일,'MM-DD'),'YYYY-MM-DD') - SYSDATE) "남은일수"
     , T.급여
     , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 8000 THEN T.급여 * 0.5
            WHEN TRUNC(SYSDATE - T.입사일) >= 4000 THEN T.급여 * 0.3
            ELSE 0
       END "보너스"
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남자'
                WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여자'
                ELSE '성별확인불가' 
           END"성별"
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
               WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
               ELSE -1
          END "현재나이"
        , HIREDATE "입사일"
        , SAL "급여"
    FROM TBL_SAWON
) T;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- 1. 번거로움 줄이기위해
-- 2. 보안성을 위해

--※ 상기 내용에서... 특정 근무일수의 사원을 확인해야 한다거나...
--   특정 보너스 금액을 받는 사원을 확인해야 할 경우가 생길 수 있다.
--   이와 같은 경우... 해당 쿼리문을 다시 구성하는 번거로움을 줄일 수 있도록
--   뷰(VIEW)를 만들어 저장해 둘 수 있다.

CREATE OR REPLACE VIEW VIEW_SAWON
AS
SELECT T.사원번호,T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) *12),'YYYY') || '-' || TO_CHAR(T.입사일,'MM-DD') "정년퇴직일"
     , TRUNC(SYSDATE - T.입사일) "근무일수"
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) *12),'YYYY') 
       || '-' || TO_CHAR(T.입사일,'MM-DD'),'YYYY-MM-DD') - SYSDATE) "남은일수"
     , T.급여
     , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 8000 THEN T.급여 * 0.5
            WHEN TRUNC(SYSDATE - T.입사일) >= 4000 THEN T.급여 * 0.3
            ELSE 0
       END "보너스"
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남자'
                WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여자'
                ELSE '성별확인불가' 
           END"성별"
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
               WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
               ELSE -1
          END "현재나이"
        , HIREDATE "입사일"
        , SAL "급여"
    FROM TBL_SAWON
) T;
--==>> 에러 발생
/*
ORA-01031: insufficient privileges
01031. 00000 -  "insufficient privileges"
*Cause:    An attempt was made to perform a database operation without
           the necessary privileges.
*Action:   Ask your database administrator or designated security
           administrator to grant you the necessary privileges
*/
--> 권한이 불충분하여 발생하는 에러
-- SYS한테서 권한받아오자(20210903_02_sys.sql)

--※ SYS 로부터 VIEW를 생성할 수 있는 권한을 부여받은 후
--   다시 뷰(VIEW) 생성
CREATE OR REPLACE VIEW VIEW_SAWON
AS
SELECT T.사원번호,T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) *12),'YYYY') || '-' || TO_CHAR(T.입사일,'MM-DD') "정년퇴직일"
     , TRUNC(SYSDATE - T.입사일) "근무일수"
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) *12),'YYYY') 
       || '-' || TO_CHAR(T.입사일,'MM-DD'),'YYYY-MM-DD') - SYSDATE) "남은일수"
     , T.급여
     , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 8000 THEN T.급여 * 0.5
            WHEN TRUNC(SYSDATE - T.입사일) >= 4000 THEN T.급여 * 0.3
            ELSE 0
       END "보너스"
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남자'
                WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여자'
                ELSE '성별확인불가' 
           END"성별"
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
               WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
               ELSE -1
          END "현재나이"
        , HIREDATE "입사일"
        , SAL "급여"
    FROM TBL_SAWON
) T;
--==>> View VIEW_SAWON이(가) 생성되었습니다.

SELECT *
FROM VIEW_SAWON;


--------------------------------------------------------------------------------

--○ TBL_SAWON 테이블의 김소연 사원의 입사일 및 급여 데이터 변경
-- 현재 TABLE 상태 : 1001	김소연	9307302234567	01/01/03	3000
-- 현재 VIEW 상태  : 1001	김소연	9307302234567	여자	29	01/01/03	2052-01-03	7548	11078	3000	900

UPDATE TBL_SAWON
SET HIREDATE = SYSDATE, SAL=5000
WHERE SANO=1001;
--==>> 1 행 이(가) 업데이트되었습니다.

SELECT *
FROM TBL_SAWON
WHERE SANO=1001;
--==>> 1001	김소연	9307302234567	21/09/03	5000

COMMIT;
--==> 커밋 완료.

SELECT *
FROM VIEW_SAWON;


--○ TBL_SAWON 테이블의 김소연 사원의 입사일 및 급여 데이터 변경 이후 다시 확인
-- 현재 TABLE   : 1001    김소연	9307302234567	01/01/03	3000
-- 현재 VIEW    : 1001    김소연	9307302234567	여자	    29	01/01/03	2052-01-03	7548    	11078	3000	900
-- 변경 후 VIEW : 1001    김소연	9307302234567	여자	    29	21/09/03	    2052-09-03	0	    11322	5000	    0


--○ 문제
-- 서브쿼리를 활용하여 TBL_SAWON 테이블을 다음과 같이 조회할 수 있도록 한다.
-- 단, 나이보너스는 현재 나이가 40세 이상이면 급여의 70%,
--     30세 이상 40세 미만이면 급여의 50%,
--     20세 이상 30세 미만이면 급여의 30% 로 한다.
-- 또한, 완성된 조회 구문을 기반으로
-- VIEW_SAWON2 라는 이름의 뷰(VIEW)를 생성한다.
/*
-----------------------------------------------------------------------
사원명 성별 현재나이 급여 나이보너스
-----------------------------------------------------------------------

*/
-- TBL_SAWON 조회
SELECT *
FROM TBL_SAWON;


-- 서브쿼리 활용
SELECT T.*
     , CASE WHEN T.현재나이 >= 40 THEN T.급여 * 0.7
            WHEN T.현재나이 >= 30 THEN T.급여 * 0.5
            WHEN T.현재나이 >= 20 THEN T.급여 * 0.3
            ELSE 0
       END "나이보너스"
FROM 
(
    SELECT SANAME "사원명"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '3') THEN '남'
                WHEN SUBSTR(JUBUN, 7, 1) IN('2', '4') THEN '여'
                ELSE '확인불가'
           END "성별"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '2')
                THEN EXTRACT(YEAR FROM SYSDATE) - ((TO_NUMBER(SUBSTR(JUBUN, 1, 2))) + 1900) -1
                WHEN SUBSTR(JUBUN, 7, 1) IN('3', '4')
                THEN EXTRACT(YEAR FROM SYSDATE) - ((TO_NUMBER(SUBSTR(JUBUN, 1, 2))) + 2000) - 1
                ELSE -1
           END "현재나이"
         , SAL "급여"
    FROM TBL_SAWON
) T;


-- VIEW_SAWON2 생성
--> VIEW 는 오로지 테이블을 투영해서 만들 뿐이다.
--> 'OR REPLACE'를 사용하면, 기본에 생성되어 있다고 해도 덮어쓰고 수정한다.
CREATE OR REPLACE VIEW VIEW_SAWON2
AS 
SELECT T.*
     , CASE WHEN T.현재나이 >= 40 THEN T.급여 * 0.7
            WHEN T.현재나이 >= 30 THEN T.급여 * 0.5
            WHEN T.현재나이 >= 20 THEN T.급여 * 0.3
            ELSE 0
       END "나이보너스"
FROM 
(
    SELECT SANAME "사원명"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '3') THEN '남'
                WHEN SUBSTR(JUBUN, 7, 1) IN('2', '4') THEN '여'
                ELSE '확인불가'
           END "성별"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '2')
                THEN EXTRACT(YEAR FROM SYSDATE) - ((TO_NUMBER(SUBSTR(JUBUN, 1, 2))) + 1900) -1
                WHEN SUBSTR(JUBUN, 7, 1) IN('3', '4')
                THEN EXTRACT(YEAR FROM SYSDATE) - ((TO_NUMBER(SUBSTR(JUBUN, 1, 2))) + 2000) - 1
                ELSE -1
           END "현재나이"
         , SAL "급여"
    FROM TBL_SAWON
) T;


-- VIEW 생성 확인
SELECT *
FROM VIEW_SAWON2;
--==>>
/*
김소연 	    여	27	5000
이다영 	    여	25	2000
이지영	    여	11	1000
손다정	    여	26	4000
이하이	    여	16	1000
이이경	    남	18	2000
김이나	    여	40	3000
아이유	    여	39	3000
선동열	    남	48	3000
선우용녀	남	50	3000
선우선	    여	30	2000
남진	        남	40	4000
남궁현	    남	38	3000
남도일	    남	28	3000
김남길	    남	18	2000
*/


--------------------------------------------------------------------------------

--○ RANK() 등수(순위)를 반환하는 함수
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
     , RANK() OVER(ORDER BY SAL DESC) "전체 급여순위"
FROM EMP;

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서 내 급여순위"
     , RANK() OVER(ORDER BY SAL DESC) "전체 급여순위"
FROM EMP;

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서 내 급여순위"
     , RANK() OVER(ORDER BY SAL DESC) "전체 급여순위"
FROM EMP
ORDER BY 3, 4 DESC;



--○ DENSE_RANK()    → 서열을 반환하는 함수
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
     , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서 내 급여서열"
     , DENSE_RANK() OVER(ORDER BY SAL DESC) "전체 급여서열"
FROM EMP
ORDER BY 3, 4 DESC;
/*
7839	KING    	10	5000    	1	1
7782	    CLARK	10	2450	    2	5
7934	MILLER	10	1300	3	8
7902	    FORD    	20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	    JONES	20	2975    	2	3
7876	ADAMS	20	1100	3	10
7369	SMITH	20	800	    4	12
7698	BLAKE	30	2850    	1	4
7499	ALLEN	30	1600	2	6
7844	TURNER	30	1500    	3	7
7654    	MARTIN	30	1250    	4	9
7521    	WARD    	30	1250	    4	9
7900	JAMES	30	950	    5	11
*/


--○ EMP 테이블의 사원 정보를
--   사원명, 부서번호, 연봉, 부서내 연봉순위, 전체 연봉순위 항목으로 조회한다.
SELECT *
FROM EMP;


SELECT T.*
     , RANK() OVER(PARTITION BY 부서번호 ORDER BY 연봉 DESC) "부서내 연봉순위"
     , RANK() OVER(ORDER BY 연봉 DESC) "전체 연봉순위"
FROM
(
    SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12 + NVL(COMM, 0) "연봉"
    FROM EMP
) T
ORDER BY 2, 3 DESC;



--○ EMP 테이블에서 전체 연봉 순위가 1등부터 5등 까지만...
--   사원명, 부서번호, 연봉, 전체연봉순위 항목으로 조회한다.
SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
     , RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0) DESC) "전체연봉순위"
FROM EMP
WHERE RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0) DESC) <= 5;
--==>> 에러 발생
/*
ORA-30483: window  functions are not allowed here
30483. 00000 -  "window  functions are not allowed here"
*Cause:    Window functions are allowed only in the SELECT list of a query.
           And, window function cannot be an argument to another window or group
           function.
*Action:
645행, 37열에서 오류 발생
*/

--※ 위의 내용은 RANK() OVER() 를 WHERE 조건절에서 사용한 경우이며...
--   이 함수는 WHERE 조건절에서 사용할 수 없는 함수이며
--   이 규칙을 어겼기 때문에 발생하는 에러이다.
--   이 경우... 우리는 INLINE VIEW 를 활용하여 풀이해야 한다.

-- 방법①
SELECT T.*
FROM
(
    SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
         , RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0) DESC) "전체연봉순위"
    FROM EMP
) T
WHERE T.전체연봉순위 <= 5;


-- 방법②
SELECT T2.*
FROM
(
    SELECT T1.*
         , RANK() OVER(ORDER BY T1.연봉 DESC) "전체연봉순위"
    FROM
    (
        SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
        FROM EMP
    ) T1
) T2    
WHERE T2.전체연봉순위 <= 5;
--==>>
/*
KING    	10	60000	1
SCOTT	20	36000	2
FORD    	20	36000	2
JONES	20	35700	4
BLAKE	30	34200	5
*/


--○ EMP 테이블에서 각 부서별로 연봉 등수가 1등부터 2등까지만...
--   사원명, 부서번호, 연봉, 부서내연봉등수, 전체연봉등수 항목을 조회할 수 있도록 한다.

SELECT T.*
FROM
(
    SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
         , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM, 0) DESC) "부서내연봉등수"
         , RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0) DESC) "전체연봉순위"
    FROM EMP
) T
WHERE 부서내연봉등수 <= 2
ORDER BY 부서번호, 연봉 DESC;


--------------------------------------------------------------------------------

--■■■ 그룹 함수 ■■■--

-- SUM() 합, AVG() 평균, COUNT() 카운트, MAX() 최대값, MIN() 최소값,
-- VARIANCE() 분산, STDDEV() 표준편차

-- ※ 그룹함수의 가장 큰 특징은
--    처리해야 할 데이터들 중에 NULL 이 존재하면
--    이 NULL 은 제외하고 연산을 수행한다는 것이다.

-- SUM()
-- EMP 테이블을 대상으로 전체 사원들의 급여 총합을 조회한다.
SELECT SUM(SAL)         -- 800+1600+1250+2975+ ... +1300
FROM EMP;
--==>> 29025

SELECT SUM(COMM)        -- NULL+300+500+NULL+ ... +NULL (X)
FROM EMP;               -- 300+500+1400+0               (O)
--==>> 2200


--○ COUNT()
-- 행의 갯수 조회하여 결과값 반환
SELECT COUNT(ENAME)
FROM EMP;
--==>> 14

SELECT COUNT(SAL)
FROM EMP;

SELECT COUNT(COMM) -- COMM 컬럼의 행의 갯수 조회 → NULL 은 제외~!!!
FROM EMP;

SELECT COUNT(*)
FROM EMP;


--○ AVG()
-- 평균 반환
SELECT SUM(SAL) / COUNT(SAL) "1", AVG(SAL) "2"
FROM EMP;
--==>>
/*
2073.214285714285714285714285714285714286
2073.214285714285714285714285714285714286
*/

SELECT AVG(COMM)
FROM EMP;
--==>> 550

SELECT SUM(COMM) / COUNT(COMM)
FROM EMP;
--==>> 550

SELECT SUM(COMM) /14
FROM EMP;
--==>> 157.142857142857142857142857142857142857

SELECT SUM(COMM) / COUNT(*)
FROM EMP;
--==>> 157.142857142857142857142857142857142857


--※ 표준편차의 제곱이 분산
--   분산의 제곱근이 표준편차
SELECT AVG(SAL), VARIANCE(SAL), STDDEV(SAL)
FROM EMP;
--==>> 
/*
2073.214285714285714285714285714285714286	
1398313.87362637362637362637362637362637	
1182.503223516271699458653359613061928508
*/

SELECT POWER(STDDEV(SAL), 2) "급여표준편차제곱"
     , VARIANCE(SAL) "급여분산"
FROM EMP;
--==>>
/*
1398313.87362637362637362637362637362637	
1398313.87362637362637362637362637362637
*/

SELECT SQRT(VARIANCE(SAL)) "급여분산제곱근"
     , STDDEV(SAL) "급여표준편차"
FROM EMP;
--==>>
/*
1182.503223516271699458653359613061928508	
1182.503223516271699458653359613061928508
*/


--○ MAX() / MIN()
--  최대값 / 최소값 반환
SELECT MAX(SAL), MIN(SAL)
FROM EMP;
--==>> 5000 800

--※ 주의
SELECT ENAME, SUM(SAL)
FROM EMP;
--==>>
/*
ORA-00937: not a single-group group function
00937. 00000 -  "not a single-group group function"
*Cause:    
*Action:
813행, 8열에서 오류 발생
*/

SELECT ENAME, SAL
FROM EMP;

SELECT SUM(SAL)
FROM EMP;

SELECT DEPTNO, SUM(SAL)
FROM EMP;
/*
ORA-00937: not a single-group group function
00937. 00000 -  "not a single-group group function"
*Cause:    
*Action:
830행, 8열에서 오류 발생
*/

--○ 부서별 급여합 조회
SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
--==>>
/*
10	8750
20	10875
30	9400
*/

--○ 직종별 급여합 조회
SELECT JOB "직종명", SUM(SAL) "급여합"
FROM EMP
GROUP BY JOB;
--==>>
/*
CLERK	    4150
SALESMAN	    5600
PRESIDENT	5000
MANAGER	    8275
ANALYST	    6000
*/

SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	8750
20	10875
30	9400
	29025   -- 총합
*/


--------------------------------------------------------------------------------

--○ 데이터 입력
INSERT INTO TBL_EMP VALUES
(8001, '차은우', 'CLERK', 7566, SYSDATE, 1500, 10, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8002, '서강준', 'CLERK', 7566, SYSDATE, 1000, 0, NULL);
--==>> 1 행 이(가) 삽입되었습니다.


--○ 커밋
COMMIT;
--==>> 커밋 완료.

INSERT INTO TBL_EMP VALUES
(8003, '공유', 'SALESMAN', 7698, SYSDATE, 2000, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8004, '이동욱', 'SALESMAN', 7698, SYSDATE, 2500, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8005, '조인성', 'SALESMAN', 7698, SYSDATE, 1000, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.


SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	    80/12/17    	800		        20
7499	ALLEN	SALESMAN	    7698	81/02/20	    1600	300	    30
7521    	WARD	    SALESMAN	    7698	81/02/22	    1250	    500	    30
7566    	JONES	MANAGER	    7839	81/04/02	    2975		20
7654	    MARTIN	SALESMAN	    7698	81/09/28	    1250	    1400	30
7698	BLAKE	MANAGER	    7839	81/05/01	    2850		30
7782	    CLARK	MANAGER	    7839	81/06/09	2450		10
7788	SCOTT	ANALYST	    7566	    87/07/13	3000		    20
7839	KING	    PRESIDENT		    81/11/17	5000		10
7844	TURNER	SALESMAN	    7698	81/09/08	1500	    0	    30
7876	ADAMS	CLERK	    7788	87/07/13	1100		    20
7900	JAMES	CLERK	    7698	81/12/03    	950		30
7902	    FORD    	ANALYST	    7566    	81/12/03    	3000		    20
7934	MILLER	CLERK	    7782    	82/01/23    	1300		    10
8001	차은우	CLERK	    7566    	21/09/03    	1500	    10	
8002    	서강준	CLERK	    7566	    21/09/03    	1000	0	
8003	공유  	SALESMAN	    7698	21/09/06    	2000		
8004	이동욱	SALESMAN	    7698	21/09/06	    2500		
8005    	조인성	SALESMAN	    7698	21/09/06	    1000		
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';


--○ 커밋
COMMIT;
--==>> 커밋 완료.





