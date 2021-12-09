--○ TBL_FILES 테이블을 대상으로 위와 같이 조회될 수 있도록 
--   쿼리문을 구성한다.

-- 방법①
SELECT FILENO "파일번호"
     , SUBSTR(FILENAME, LENGTH(FILENAME)-INSTR(REVERSE(FILENAME), '\', 1) + 2) "파일명"
FROM TBL_FILES;

--INSTR(REVERSE(FILENAME), '\', 1) 
--> 뒤에서부터 '\' 가 있는 위치
--LENGTH(FILENAME)-INSTR(REVERSE(FILENAME), '\', 1)+2   
--> 앞에서부터 첫 글자가 시작하는 위치('\'와 첫 글자 때문에 2 더함)


-- 방법② / 선생님 해설
SELECT FILENO "파일번호"
     , REVERSE(SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1)-1)) "파일명"
FROM TBL_FILES;

--INSTR(REVERSE(FILENAME), '\', 1)  
--> 뒤에서부터 '\' 가 있는 위치
--SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1)-1)
--> 거꾸로 된 파일명


--○ LPAD()
--> Byte 공간을 확보하여 왼쪽부터 문자로 채우는 기능을 가진 함수
SELECT 'ORACLE' "1"
     , LPAD('ORACLE', 10, '*') "2"
FROM DUAL;
--==>> ORACLE	****ORACLE
--> ① 10Byte 공간을 확보한다.                      → 두 번째 파라미터 값에 의해...
--  ② 확보한 공간에 'ORACLE' 문자열을 담는다.      → 첫 번째 파라미터 값에 의해...
--  ③ 남아 있는 Byte 공간을 왼쪽부터 세 번째 파라미터 값으로 채운다
--  ④ 이렇게 구성된 최종 결과값을 반환한다.


--○ BPAD()
--> Byte 공간을 확보하여 오른쪽부터 문자로 채우는 기능을 가진 함수
SELECT 'ORACLE' "1"
     , RPAD('ORACLE', 10, '*') "2"
FROM DUAL;
--==>> ORACLE	ORACLE****
--> ① 10Byte 공간을 확보한다.                      → 두 번째 파라미터 값에 의해...
--  ② 확보한 공간에 'ORACLE' 문자열을 담는다.      → 첫 번째 파라미터 값에 의해...
--  ③ 남아 있는 Byte 공간을 오른쪽부터 세 번째 파라미터 값으로 채운다
--  ④ 이렇게 구성된 최종 결과값을 반환한다.


--○ LTRIM()
SELECT 'ORAORAORACLEORACLE' "1"      -- 오라 오라 오라클 오라클
     , LTRIM('ORAORAORACLEORACLE', 'ORA') "2"
     , LTRIM('AAAORAORAORACLEORACLE', 'ORA') "3"        -- 한 글자씩 처리
     , LTRIM('oRAoRAoRACLEoRACLE', 'ORA') "4"           -- 대소문자 구분
     , LTRIM('ORA ORAORACLEORACLE', 'ORA') "5"          -- 공백도 처리 가능
     , LTRIM('          ORA ORA ORACLEORACLE', ' ') "6"
     , LTRIM('                       ORACLE') "7"       -- 왼쪽 공백 제거 함수로 활용(두 번째 파라미터 생략)
FROM DUAL;
--==>> 
/*
ORAORAORACLEORACLE	CLEORACLE	CLEORACLE	oRAoRAoRACLEoRACLE	 ORAORACLEORACLE	ORA ORA ORACLEORACLE	ORACLE
*/
--> 첫 번째 파라미터 값에 해당하는 문자열을 대상으로
--  왼쪽부터 연속적으로 두 번째 파라미터 값에서 지정한 글자와 같은 글자가 등장할 경우
--  이를 제거한 결과값을 반환한다.
--  단, 완성형으로 처리되지 않는다.

SELECT LTRIM('이김신이김신이이김신이김신이이김신이박이김신', '이김신') "TEST"
FROM DUAL;
--==>>박이김신

--○ RTRIM()
SELECT 'ORAORAORACLEORACLE' "1"      -- 오라 오라 오라클 오라클
     , RTRIM('ORAORAORACLEORACLE', 'ORA') "2"
     , RTRIM('AAAORAORAORACLEORACLE', 'ORA') "3"        -- 한 글자씩 처리
     , RTRIM('oRAoRAoRACLEoRACLE', 'ORA') "4"           -- 대소문자 구분
     , RTRIM('ORA ORAORACLEORACLE', 'ORA') "5"          -- 공백도 처리 가능
     , RTRIM('          ORA ORA ORACLEORACLE', ' ') "6"
     , RTRIM('ORACLE                       ') "7"       -- 오른쪽 공백 제거 함수로 활용(두 번째 파라미터 생략)
FROM DUAL;
--==>>
/*
ORAORAORACLEORACLE	ORAORAORACLEORACLE	AAAORAORAORACLEORACLE	oRAoRAoRACLEoRACLE	
ORA ORAORACLEORACLE	          ORA ORA ORACLEORACLE	ORACLE                     
*/
--> 첫 번째 파라미터 값에 해당하는 문자열을 대상으로
--  오른쪽부터 연속적으로 두 번째 파라미터 값에서 지정한 글자와 같은 글자가 등장할 경우
--  이를 제거한 결과값을 반환한다.
--  단, 완성형으로 처리되지 않는다.


--○ TRANSLATE()
--> 1:1 로 바꾸어준다.
SELECT TRANSLATE('MY ORACLE SERVER'
                , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                , 'abcdefghijklmnopqrstuvwxyz') "RESULT"
FROM DUAL;
--==>> my oracle server

SELECT TRANSLATE('010-8743-7042'
                , '0123456789'
                , '영일이삼사오륙칠팔구') "RESULT"
FROM DUAL;
--==>> 영일영-팔칠사삼-칠영사이


--○ REPLACE()
SELECT REPLACE('MY ORACLE ORAHOME', 'ORA', '오라')
FROM DUAL;
--==>> MY 오라CLE 오라HOME


--------------------------------------------------------------------------------

-- 숫자 관련된 함수들

--○ ROUND() 반올림을 처리해주는 함수
SELECT 48.678 "1"
     , ROUND(48.678, 2) "2"     -- 소수점 이하 둘째자리까지 표현(→ 셋째 자리에서 반올림)
     , ROUND(48.674, 2) "3"
     , ROUND(48.674, 1) "4"
     , ROUND(48.674, 0) "5"     -- 정수로 표현
     , ROUND(48.674) "6"        -- 두 번째 파라미터 값이 0일 경우 생략 가능
     , ROUND(48.674, -1) "7"  
     , ROUND(48.674, -2) "8"  
     , ROUND(48.674, -3) "9"  
FROM DUAL;
--==>> 48.678	48.68	48.67	48.7	49	49	50	0	0


--○ TRUNC() 절삭을 처리해주는 함수
SELECT 48.678 "1"
     , TRUNC(48.678, 2) "2"     -- 소수점 이하 둘째자리까지 표현
     , TRUNC(48.674, 2) "3"
     , TRUNC(48.674, 1) "4"
     , TRUNC(48.674, 0) "5" 
     , TRUNC(48.674) "6"        -- 두 번째 파라미터 값이 0일 경우 생략 가능
     , TRUNC(48.674, -1) "7"  
     , TRUNC(48.674, -2) "8"  
     , TRUNC(48.674, -3) "9"  
FROM DUAL;
--==>> 48.678	48.67	48.67	48.6	48	48	40	0	0


--○ MOD() 나머지를 반환하는 함수
SELECT MOD(5, 2) "RESULT"
FROM DUAL;
--==>> 1
--> 5로 2를 나눈 나머지 결과값 반환


--○ POWER() 제곱의 결과를 반환하는 함수
SELECT POWER(5, 3) "RESULT"
FROM DUAL;
--==>> 125
--> 5의 3승을 결과값 반환


--○ SQRT() 루트 결과값을 반환하는 함수
SELECT SQRT(2)
FROM DUAL;
--==>> 1.41421356237309504880168872420969807857
--> 루트 2에 대한 결과값 반환


--○ LOG() 로그 함수
--   (※ 오라클은 상용로그만 지원하는 반면, MSSQL 은 상용로그, 자연로그 모두 지원한다.)
SELECT LOG(10, 100), LOG(10, 20)
FROM DUAL;
--==>> 2	1.30102999566398119521373889472449302677


--○ 삼각함수
-- 싸인, 코싸인, 탄젠트 값을 반환한다.
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
--==>>
/*
0.8414709848078965066525023216302989996233	
0.5403023058681397174009366074429766037354	
1.55740772465490223050697480745836017308
*/


--○ 삼각함수의 역함수 (범위: -1 ~ 1)
--   어싸인, 어코싸인, 어탄젠트 결과값을 반환한다.
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
--==>>
/*
0.52359877559829887307710723054658381405	
1.04719755119659774615421446109316762805	
0.4636476090008061162142562314612144020295
*/


--○ SIGN()      서명, 부호, 특징
--> 연산 결과값이 양수이면 1, 0이면 0, 음수이면 -1 을 반환한다.
SELECT SIGN(5-2), SIGN(5-5), SIGN(5-8)
FROM DUAL;
--==>> 1	0	-1


--○ ASCII(), CHR() → 서로 상응하는 개념의 함수
SELECT ASCII('A') "RESULT1", CHR(65) "RESULT2"
FROM DUAL;
--==>> 65	A
-- ASCII() : 매개변수로 넘겨받은 문자의 아스키코드 값을 반환한다.
-- CHR()   : 매개변수로 넘겨받은 숫자를 아스키코드 값으로 취하는 문자를 반환한다.


--------------------------------------------------------------------------------


--※ 날짜 관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


--※ 날짜 연산의 기본 단위는 DAY(일수)이다~!!! CHECK~!!!               ★★★

SELECT SYSDATE "1", SYSDATE+1 "2", SYSDATE-2 "3", SYSDATE+3 "4"
FROM DUAL;
--==>>
/*
2021-09-02 10:35:37	    -- 현재
2021-09-03 10:35:37	    -- 1일 후
2021-08-31 10:35:37	    -- 2일 전
2021-09-05 10:35:37     -- 3일 후
*/


--○ 시간 단위 연산
SELECT SYSDATE "1", SYSDATE + 1/24 "2", SYSDATE - 2/24 "3"
FROM DUAL;
--==>>
/*
2021-09-02 10:38:40	    -- 현재
2021-09-02 11:38:40	    -- 1시간 후
2021-09-02 08:38:40     -- 2시간 전
*/


--○ 현재 시간과... 현지 시간 기준 1일 2시간 3분 4초 후를 조회한다.
/*
---------------------------------------------------
        현재시간                연산 후 시간
---------------------------------------------------
    2021-09-02 10:41:38	    2021-09-03 12:44:42
---------------------------------------------------
*/
-- 방법 ①
SELECT SYSDATE "현재 시간"
     , SYSDATE + 1 + 2/24 + 3/(24*60) + 4/(24*60*60) "연산 후 시간"
FROM DUAL;

-- 방법 ②
SELECT SYSDATE "현재 시간"
     , SYSDATE + ((24*60*60) + (2*60*60) + (3*60) + 4) / (24*60*60) "연산 후 시간"
     --             1일          2시간      3분     4초
FROM DUAL;
--==>>
/*
2021-09-02 11:06:08	
2021-09-03 13:09:12
*/


--○ 날짜 - 날짜 = 일수
-- ex) (2021-12-28) - (2021-09-02)
--        수료일        현재일
SELECT TO_DATE('2021-12-28', 'YYYY-MM-DD') - TO_DATE('2021-09-02', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 117


--○ 데이터 타입의 변환
SELECT TO_DATE('2021-09-02', 'YYYY-MM-DD') "결과"     -- 날짜 형식으로 변환
FROM DUAL;
--==>> 2021-09-02 00:00:00

SELECT TO_DATE('2021-13-02', 'YYYY-MM-DD') "결과"
FROM DUAL;
--==>> 에러 발생
/*
ORA-01843: not a valid month
01843. 00000 -  "not a valid month"
*Cause:    
*Action:
*/

SELECT TO_DATE('2021-09-31', 'YYYY-MM-DD') "결과"
FROM DUAL;
--==>> 에러 발생
/*
ORA-01839: date not valid for month specified
01839. 00000 -  "date not valid for month specified"
*Cause:    
*Action:
*/

SELECT TO_DATE('2021-02-29', 'YYYY-MM-DD') "결과"
FROM DUAL;
--==>> 에러 발생
/*
ORA-01839: date not valid for month specified
01839. 00000 -  "date not valid for month specified"
*Cause:    
*Action:
*/

SELECT TO_DATE('2020-02-29', 'YYYY-MM-DD') "결과"
FROM DUAL;
--==>> 2020-02-29 00:00:00


--※ TO_DATE() 함수를 통해 문자 타입을 날짜 타입으로 변환을 진행할 때
--   내부적으로 해당 날짜에 대한 유효성 검사가 이루어진다~!!!


--○ ADD_MONTHS()    개월 수를 더해주는 함수
SELECT SYSDATE "1"
     , ADD_MONTHS(SYSDATE, 2) "2"
     , ADD_MONTHS(SYSDATE, 3) "3"
     , ADD_MONTHS(SYSDATE, -2) "4"
     , ADD_MONTHS(SYSDATE, -3) "5"
FROM DUAL;
--==>>
/*
2021-09-02 11:18:29	    → 현재
2021-11-02 11:18:29	    → 2개월 후
2021-12-02 11:18:29	    → 3개월 후
2021-07-02 11:18:29	    → 2개월 전
2021-06-02 11:18:29	    → 3개월 전
*/
--> 월 더하고 빼기


--※ 날짜에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


--○ MONTHS_BETWEEN()
-- 첫 번째 인자값에서 두 번째 인자값을 뺀 개월 수를 반환
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-31', 'YYYY-MM-DD')) "결과확인"
FROM DUAL;
--==>> 231.079832362604540023894862604540023895

--> 개월 수의 차이를 반환하는 함수
-- ※ 결과값의 부호가 『-』로 반환되었을 경우에는
--    첫 번째 인자값에 해당하는 날짜보다
--    두 번째 인자값에 해당하는 날짜가 『미래』라는 의미로 확인할 수 있다.


SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2021-12-28', 'YYYY-MM-DD')) "결과확인"
FROM DUAL;
--==>> -3.82335125448028673835125448028673835125
--> 수료일이 현재일보다 미래


--○ NEXT_DAY()
-- 첫 번째 인자값을 기준 날짜로 돌아오는 가장 빠른 요일 반환
SELECT NEXT_DAY(SYSDATE, '토') "결과1", NEXT_DAY(SYSDATE, '월') "결과2"
FROM DUAL;
--==>> 2021-09-04	2021-09-06


--○ 추가 세션 설정 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>> Session이(가) 변경되었습니다.


--○ 세션 설정을 변경 후 위의 쿼리문을 다시 한 번 조회
SELECT NEXT_DAY(SYSDATE, '토') "결과1", NEXT_DAY(SYSDATE, '월') "결과2"
FROM DUAL;
--==>> 에러 발생
/*
ORA-01846: not a valid day of the week
01846. 00000 -  "not a valid day of the week"
*Cause:    
*Action:
*/


SELECT NEXT_DAY(SYSDATE, 'SAT') "결과1", NEXT_DAY(SYSDATE, 'MON') "결과2"
FROM DUAL;
--==>> 2021-09-04	2021-09-06


--○ 추가 세션 설정 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session이(가) 변경되었습니다.


--○ LAST_DAY()
-- 해당 날짜가 포함되어 있는 그 달의 마지막 날을 반환한다.
SELECT LAST_DAY(SYSDATE) "결과 확인"
FROM DUAL;
--==>> 2021-09-30

SELECT LAST_DAY(TO_DATE('2020-02-05', 'YYYY-MM-DD')) "결과 확인"
FROM DUAL;
--==>> 2020-02-29

SELECT LAST_DAY(TO_DATE('2021-02-05', 'YYYY-MM-DD')) "결과 확인"
FROM DUAL;
--==>> 2021-02-28



--○ 오늘부로... 이중호 님이... 군대에 또 끌려(?)간다.
--   복무 기간은 22개월로 한다.

-- 1. 전역 일자를 구한다.

-- 2. 하루 꼬박꼬박 3끼 식사를 해야 한다고 가정하면
--    중호가 몇 끼를 먹어야 집에 보내줄까.

SELECT ADD_MONTHS(SYSDATE, 22) "전역 일자",
       (ADD_MONTHS(SYSDATE, 22) - SYSDATE) *3 "끼니"
FROM DUAL;



--○ 현재 날짜 및 시각으로부터... 수료일(2021-12-28 18:00:00) 까지
--   남은 기간을... 다음과 같은 형태로 조회할 수 있도록 한다.
/*
--------------------------------------------------------------------------------
현재시각            | 수료일자             | 일 | 시간 | 분 | 초
--------------------------------------------------------------------------------
2021-09-02 12:08:23 | 2021-12-28 18:00:00 |116 |  4  | 42  | 37
--------------------------------------------------------------------------------
*/
ALTER SESSION SET NLS_DATE_FORMAT = "YYYY-MM-DD HH24:MI:SS";
--==>> Session이(가) 변경되었습니다.

-- ① 나의 풀이
SELECT SYSDATE "현재시각"
     , TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일자"
     , TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) "일"
     , TRUNC(MOD((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE)*24, 24)) "시"
     , TRUNC(MOD((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE)*24*60, 60)) "분"
     , TRUNC(MOD((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE)*24*60*60, 60)) "초"
FROM DUAL;
--==>> 2021-09-02 15:30:23	2021-12-28 18:00:00	    117	    2	    29	    37


-- ○ 함께 풀이
--『1일 2시간 3분 4초』를... 『초』로 환산하면...
SELECT (1일) + (2시간) + (3분) + (4초)
FROM DUAL;

SELECT (1*24*60*60) + (2*60*60) + (3*60) + (4)
FROM DUAL;
--==>> 93784


-- 61초 → 1분 1초
SELECT MOD(61, 60)
FROM DUAL;


-- 『93784』초를 다시 일, 시간, 분, 초로 환산하면...
SELECT TRUNC(TRUNC(TRUNC(93784/60)/60)/24) "일"
     , MOD(TRUNC(TRUNC(93784/60)/60), 24) "시간"
     , MOD(TRUNC(93784/60), 60) "분"
     , MOD(93784, 60) "초"
FROM DUAL;


-- ○ 함께 풀이
-- 수료일까지 남은 기간 확인(날짜 기준) → 단위: 일수
SELECT 수료일자 - 현재일자
FROM DUAL;

-- 수료일자
SELECT TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
FROM DUAL;
--==>> 2021-12-28 18:00:00 → 날짜 형식

-- 현재일자
SELECT SYSDATE
FROM DUAL;
--==>> 2021-09-02 15:21:19 → 날짜 형식

-- 수료일까지 남은 기간 확인(날짜 기준) → 단위: 일수
SELECT TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE
FROM DUAL;
--==>> 117.109537037037037037037037037037037037 → 단위: 일수 → 숫자 형식
--==>> 수료일까지 남은 일수

-- 수료일까지 남은 기간 확인(날짜 기준) → 단위: 초
SELECT (수료일까지 남은 일수) * 하루를 구성하는 전체 초
FROM DUAL;

SELECT (TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)
FROM DUAL;
--==>> 10118171.99999999999999999999999999999998 → 단위: 일수 → 숫자 형식
--==>> 수료일까지 남은 초


--○ 위 식에 넣기
SELECT SYSDATE "현재시각"
     , TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
     , TRUNC(TRUNC(TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60)/60)/24) "일"
     , MOD(TRUNC(TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60)/60), 24) "시간"
     , MOD(TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60), 60) "분"
     , TRUNC(MOD(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)), 60)) "초"
FROM DUAL;
--==>> 2021-09-02 15:29:04	2021-12-28 18:00:00	    117	    2	    30	    56



--○ 문제
-- 본인이 태어나서 현재까지...
-- 얼마만큼의 일, 시간, 분, 초를 살았는지... (살고 있는지...)
-- 조회하는 쿼리문을 구성한다.
/*
------------------------------------------------------------------------
현재 시각           | 태어난 시각        | 일    | 시 | 분 | 초
------------------------------------------------------------------------
2021-09-02 15:36:44 |1994-05-13 12:00:00 |	9974 |	3 |	36 | 44
------------------------------------------------------------------------
*/
-- ①
SELECT SYSDATE "현재 시각"
     , TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS') "태어난 시각"
     , TRUNC(SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) "일"
     , TRUNC(MOD((SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24, 24)) "시"
     , TRUNC(MOD((SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60, 60)) "분"
     , TRUNC(MOD((SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60, 60)) "초"
FROM DUAL;


-- ②
-- 기간 확인(날짜 기준) → 단위: 일수
SELECT SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS') "일"
FROM DUAL;

-- 기간 확인(날짜 기준) → 단위: 초
SELECT (SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60) "초"
FROM DUAL;

-- 대입
SELECT SYSDATE "현재시각"
     , TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS') "태어난 시각"
     , TRUNC(TRUNC(TRUNC(((SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60)/60)/24) "일"
     , MOD(TRUNC(TRUNC(((SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60)/60), 24) "시간"
     , MOD(TRUNC(((SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60), 60) "분"
     , TRUNC(MOD(((SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60)), 60)) "초"
FROM DUAL;



---○ 날짜 형식 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

-- ※ 날짜 데이터를 대상으로 반올림, 절삭을 수행할 수 있다.

--○ 날짜 반올림
SELECT SYSDATE "1"                      -- 2021-09-02 → 기본 현재 날짜
     , ROUND(SYSDATE, 'YEAR') "2"       -- 2022-01-01 → 년도까지 유효한 데이터(상반기, 하반기 기준)
     , ROUND(SYSDATE, 'MONTH') "3"      -- 2021-09-01 → 월까지 유효한 데이터(15일 기준)
     , ROUND(SYSDATE, 'DD') "4"         -- 2021-09-03 → 날짜까지 유효한 데이터(정오 기준)
     , ROUND(SYSDATE, 'DAY') "5"        -- 2021-09-05 → 날짜까지 유효한 데이터(수요일 기준)
FROM DUAL;

--○ 날짜 절삭
SELECT SYSDATE "1"                      -- 2021-09-02 → 기본 현재 날짜
     , TRUNC(SYSDATE, 'YEAR') "2"       -- 2021-01-01 → 년도까지 유효한 데이터
     , TRUNC(SYSDATE, 'MONTH') "3"      -- 2021-09-01 → 월까지 유효한 데이터
     , TRUNC(SYSDATE, 'DD') "4"         -- 2021-09-02 → 날짜까지 유효한 데이터(하루 기준)
     , TRUNC(SYSDATE, 'DAY') "5"        -- 2021-08-29 → 날짜까지 유효한 데이터(주 기준)
FROM DUAL;


--------------------------------------------------------------------------------

--■■■ 변환 함수 ■■■--

--TO_CHAR()   : 숫자나 날짜 데이터를 문자 타입으로 변환시켜주는 함수
--TO_DATE()   : 문자 데이터(날짜 형식)를 날짜 타입으로 변환시켜주는 함수
--TO_NUMBER() : 문자 데이터(숫자 형식)를 숫자 타입으로 변환시켜주는 함수

--※ 날짜나 통화 형식이 맞지 않는 경우
--   세션 설정값을 통해 설정을 변경할 수 있다.

ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session이(가) 변경되었습니다.

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
--==>> Session이(가) 변경되었습니다.

ALTER SESSION SET NLS_CURRENCY = '\';   -- 화폐 원(￦)
--==>> Session이(가) 변경되었습니다.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')   -- 2021-09-02
     , TO_CHAR(SYSDATE, 'YYYY')         -- 2021
     , TO_CHAR(SYSDATE, 'YEAR')         -- TWENTY TWENTY-ONE → 언어설정이 'KOREAN' 이여도 영문이 나오는 경우 있음
     , TO_CHAR(SYSDATE, 'MM')           -- 09
     , TO_CHAR(SYSDATE, 'MONTH')        -- 9월 
     , TO_CHAR(SYSDATE, 'MON')          -- 9월 -->동일
     , TO_CHAR(SYSDATE, 'DD')           -- 02
     , TO_CHAR(SYSDATE, 'DAY')          -- 목요일
     , TO_CHAR(SYSDATE, 'DY')           -- 목
     , TO_CHAR(SYSDATE, 'HH24')         -- 16
     , TO_CHAR(SYSDATE, 'HH')           -- 04
     , TO_CHAR(SYSDATE, 'HH AM')        -- 04 오후
     , TO_CHAR(SYSDATE, 'HH PM')        -- 04 오후
     , TO_CHAR(SYSDATE, 'MI')           -- 30               → 분
     , TO_CHAR(SYSDATE, 'SS')           -- 05               → 초
     , TO_CHAR(SYSDATE, 'SSSSS')        -- 59405            → 금일 흘러온 전체 초
     , TO_CHAR(SYSDATE, 'Q')            -- 3                → 분기
FROM DUAL;


SELECT 2021 "1", '2021' "2"
     , TO_NUMBER('23') "2", '23' "1"
FROM DUAL;
-- 같아 보이지만 각각 숫자, 문자



-- ○ EXTRACT()
SELECT TO_CHAR(SYSDATE, 'YYYY') "1"     -- 2021     → 연도를 추출하여 문자 타입으로...
     , TO_CHAR(SYSDATE, 'MM') "2"       -- 09       → 월을 추출하여 문자 타입으로...
     , TO_CHAR(SYSDATE, 'DD') "3"       -- 02       → 일을 추출하여 문자 타입으로...
     , EXTRACT(YEAR FROM SYSDATE) "4"   -- 2021     → 연도를 추출하여 숫자 타입으로...
     , EXTRACT(MONTH FROM SYSDATE) "5"  -- 9        → 월을 추출하여 숫자 타입으로...
     , EXTRACT(DAY FROM SYSDATE) "6"    -- 2        → 일을 추출하여 숫자 타입으로...
FROM DUAL;
--> 연, 월, 일 이하 다른 것은 불가


-- ○ TO_CHAR() 활용 → 형식 맞춤 표기 결과값 반환
SELECT 60000 "1"
     , TO_CHAR(60000) "2"
     , TO_CHAR(60000, '99,999') "3"
     , TO_CHAR(60000, '$99,999') "4"
     , TO_CHAR(60000, 'L99,999') "5"            --> '언어'와 맞닿아있는 통화 설정(다양한 화폐를 표현하기 위해 공간을 확보해둠)
     , LTRIM(TO_CHAR(60000, 'L99,999')) "6"     --> 때문에 LTRIM() 함수와 함께 쓰는 경우가 많다.
FROM DUAL;


--○ 날짜 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


--○ 현재 시간을 기준으로 1일 2시간 3분 4초 후를 조회한다.
SELECT SYSDATE "현재 시간"
     , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "1일2시간3분4초 후"
FROM DUAL;


--○ 현재 시간을 기준으로 1년 2개월 3일 4시간 5분 6초
--   TO_YMINTERVAL(), TO_DSINTERVAL() : 연월, 일초
SELECT SYSDATE "현재 시간"
     , SYSDATE + TO_YMINTERVAL('01-02') + TO_DSINTERVAL('003 04:05:06') "연산 결과"
FROM DUAL;
--==>> 
/*
2021-09-02 17:06:42	
2022-11-05 21:11:48
*/


--------------------------------------------------------------------------------

--○ CASE 구문 (조건문, 분기문)
/*
CASE
WHEN
TEHN
ELSE
END
*/

SELECT CASE 5+2 WHEN 7 THEN '5+2=7' ELSE '5+2는 몰라요' END "결과 확인"
FROM DUAL;
--==>> 5+2=7

SELECT CASE 5+2 WHEN 9 THEN '5+2=7' ELSE '5+2는 몰라요' END "결과 확인"
FROM DUAL;
--==>> 5+2는 몰라요

SELECT CASE 1+1 WHEN 2 THEN '1+1=2'
                WHEN 3 THEN '1+1=3'
                WHEN 4 THEN '1+1=4'
                ELSE '몰라요'
       END "결과 확인"
FROM DUAL;
--==> 1+1=2


--○ DECODE()
SELECT DECODE(5-2, 1, '5-2=1', 2, '5-2=2', 3, '5-3=3', '5-2는 몰라요') "결과 확인"
FROM DUAL;
--==>> 5-3=3


SELECT CASE WHEN 5<2 THEN '5<2'
            WHEN 5>2 THEN '5>2'
            ELSE '비교 불가'
       END "결과 확인"
FROM DUAL;
--==>> 5>2


SELECT CASE WHEN 5<2 OR 3>1 THEN '범석만세'
            WHEN 5>2 OR 2=3 THEN '지윤만세'
            ELSE '현정 만세'
        END "결과 확인"
FROM DUAL;
--==>> 범석만세
-- JAVA 의 SCE 와 비슷함.


SELECT CASE WHEN 3<1 AND 5<2 OR 3>1 AND 2=2 THEN '해덕만세'
            WHEN 5<2 AND 2=3 THEN '지영만세'
            ELSE '진하만세'
       END "결과 확인"        
FROM DUAL;
--==>> 해덕만세

SELECT CASE WHEN 3<1 AND (5<2 OR 3>1) AND 2=2 THEN '해덕만세'
            WHEN 5<2 AND 2=3 THEN '지영만세'
            ELSE '진하만세'
       END "결과 확인"        
FROM DUAL;
--==>> 진하만세


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









