SELECT USER
FROM DUAL;
--==>> HR

--------------------------------------------------------------------------------

--■■■ 정규화(Normalization) ■■■--                                            <<<< ★★★★★

--○ 정규화란?
--   한 마디로... 데이터베이스 서버의 메모리 낭비를 막기 위해
--   어떤 하나의 테이블을... 식별자를 가지는 여러 개의 테이블로
--   나누는(분리하는, 쪼개는) 과정을 말한다.

-- ex) 범석이가... 옥장판을 판매한다.
--     고객리스트 → 거래처 직원 명단이 적혀있는 수첩의 정보를 데이터베이스화 하려고 한다.

-- 테이블명 : 거래처 직원
/*
  10Byte      10Byte     10Byte       10Byte     10Byte 10Byte  10Byte
-----------------------------------------------------------------------------
거래처회사명  회사주소   회사전화    거래처직원명 직급  이메일   휴대폰
-----------------------------------------------------------------------------
    LG        서울여의도 02-345-6789     정미화   부장 jmi@na..   010-...
    LG        서울여의도 02-345-6789     장진하   대리 cjh@da..   010-...
    LG        서울여의도 02-345-6789     김소연   과장 ksy@ga..   010-...
    SK        서울소공동 02-123-5678     최수지   대리 csj@na..   010-...
    LG        부산동래구 051-7777-8888   김진령   대리 kjr@na..   010-...
                                    :
                                    :
-----------------------------------------------------------------------------    
*/

/*
가정) 서울 여의도 LG 라는 회사에 근무하는 거래처 직원 명단이 
      총 100만 명이라고 가정한다.
      (한 행(레코드)은 70Byte 이다.)
      
      어느 날... 『서울여의도』에 위치한 『LG』 본사가
      『경기분당』으로 사옥을 이전하게 되었다.
      이로 인해...
      회사 주소는 『경기분당』으로 바뀌고,
      회사 전화는 『031-1111-2222』로 바뀌게 되었다.
      
      그러면... 100만 명의 회사주소와 회사전화를 변경해야 한다.
      
      - 이때 수행되어야 할 쿼리문 → UPDATE 구문
      
      UPDATE 거래처직원
      SET 회사주소='경기분당', 회사전화='031-1111-2222'
      WHERE 거래처회사명 = 'LG'
        AND 회사주소 = '서울여의도';
        
      --> 100만 개 행을 하드디스크 상에서 읽어다가
          메모리에 로드시켜 주어야 한다.
          즉, 100만 * 70Byte 를 모두 
          하드디스크 상에서 읽어다가 메모리를 로드시켜 주어야 한다는 말이다.
          
          --> 이는 테이블의 설계가 잘못되었으므로
              DB 서버는 조만간 메모리 고갈로 인해 DOWN 될 것이다.
              
              --> 그러므로 정규화를 수행해야 한다.      
*/      


--○ 제 1 정규화
--> 어떤 하나의 테이블에 반복되어 컬럼 값들이 존재한다면
--  값들이 반복되어 나오는 컬럼을 분리하여
--  새로운 테이블을 만들어준다.

--> 제 1 정규화를 수행하는 과정에서 분리되는 테이블은
--  반드시 부모 테이블과 자식 테이블의 관계를 갖게 된다.

--> 부모 테이블 → 참조 받는 컬럼 → PRIMARY KEY
--  자식 테이블 → 참조 하는 컬럼 → FOREIGN KEY

-- ※ 참조 받는 컬럼이 갖는 특징(부모 테이블)
--    - 반드시 고유한 값(데이터)이 들어와야 한다.
--      즉, 중복된 값(데이터)이 없어야 한다.
--    - NULL 이 있어서는 안 된다. (NOT NULL 이어야 한다.)

--> 제 1 정규화를 수행하는 과정에서 부모 테이블의 PRIMARY KEY 는
--  항상 자식 테이블의 FOREIGN KEY 로 전이된다.

/*
테이블명: 회사 → 부모 테이블
10Byte     10Byte       10Byte     10Byte       
----------------------------------------------
회사ID    거래처회사명  회사주소   회사전화 
------
(참조받는 컬럼 → P.K)
----------------------------------------------
10          LG        서울여의도 02-345-6789 
20          SK        서울소공동 02-123-5678 
30          LG        부산동래구 051-7777-8888
----------------------------------------------


테이블명: 직원 → 자식 테이블
  10Byte     10Byte  10Byte     10Byte      10Byte
-----------------------------------------------------
거래처직원명 직급   이메일      휴대폰      회사ID
                                            ------
                                            (참조하는 컬럼 → F.K)
-----------------------------------------------------
    정미화   부장    jmi@na..   010-...       10
    장진하   대리    cjh@da..   010-...       10
    김소연   과장    ksy@ga..   010-...       10
    최수지   대리    csj@na..   010-...       20
    김진령   대리    kjr@na..   010-...       30
                        :
                        :
-----------------------------------------------------
*/

--※ 테이블이 분할(분리)되기 이전 상태로 조회
/*
SELECT A.거래처회사명, A.회사주소, A.회사전화
     , B.거래처직원명, B.직급, B.이메일, B.휴대폰
FROM 회사 A, 직원 B
WHERE A.회사ID = B.회사ID;
*/


/*
가정) 서울 여의도 LG 라는 회사에 근무하는 거래처 직원 명단이 
      총 100만 명이라고 가정한다.
      
      어느 날... 『서울여의도』에 위치한 『LG』 본사가
      『경기분당』으로 사옥을 이전하게 되었다.
      이로 인해...
      회사 주소는 『경기분당』으로 바뀌고,
      회사 전화는 『031-1111-2222』로 바뀌게 되었다.
      
      그러면... 회사 테이블에서 1건의 회사주소와 회사전화를 변경해야 한다.      -- CHECK~!!
      
      - 이때 수행되어야 할 쿼리문 → UPDATE 구문
      
      UPDATE 회사
      SET 회사주소='경기분당', 회사전화='031-1111-2222'
      WHERE 회사ID=10;
        
      --> 1 개 행을 하드디스크 상에서 읽어다가
          메모리에 로드시켜 주어야 한다.
          즉, 1 * 40Byte 를 
          하드디스크 상에서 읽어다가 메모리를 로드시켜 주면 된다는 말이다.
          
          --> 이는 테이블의 설계가 잘 된 상황이다.
              
              --> 정규화를 수행하기 이전에는 100만 건을 처리해야 할 업무에서
                  1 건만 처리하면 되는 업무로 바뀐 상황이기 때문에
                  DB 서버는 메모리 고갈 없이 아주 빠르게 처리될 것이다.      
*/   

-- A. 거래처회사명, 회사전화
/*
SELECT 거래처회사명, 회사전화         | SELECT 거래처회사명, 회사전화
FORM 회사                             | FROM 거래처직원
→ 3 Record * 40 Byte = 120 Byte      | → 200만 Record * 70Byte
*/

-- B. 거래처직원명, 직급  
/*              
SELECT 거래처직원명, 직급             | SELECT 거래처직원명, 직급
FROM 직원                             | FROM 거래처직원
→ 200만 * 50Byte                     | → 200만 * 70 Byte
*/

-- C. 거래처회사명, 거래처직원명
/*
SELECT 회사.거래처회사명, 직원.거래처직원명     | SELECT 거래처회사명, 거래처직원명
FROM 회사 JOIN 직원                             | FROM 거래처직원
ON 회사.회사ID = 직원.회사ID;                   |
→ (3*40Byte) + (200만*50Byte)                  | → 200만*70Byte
*/

/*
-- 테이블명: 주문
------------------------------------------------------------------------
고객ID               제품코드            주문일자            주문수량
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                        P.K
------------------------------------------------------------------------
SSK1127(서승균)    SWK9984(새우깡)    2021-08-02 11:27:31     50
SHD7766(송해덕)    YPR8866(양파링)    2021-08-02 11:31:43     30
PHB7755(박효빈)    CPI1100(초파이)    2021-08-02 11:45:54     20
PHB7755(박효빈)    SWK9984(새우깡)    2021-08-02 15:00:03     20
SHD7766(송해덕)    CPI1100(초파이)    2021-08-05 05:12:12     50
                                :
                                :
------------------------------------------------------------------------
*/

-- ※ 하나의 테이블에 존재하는 PRIMARY KEY 의 최대 갯수는 1개이다.
--    하지만, PRIMARY KEY 를 이루는(구성하는) 컬럼의 갯수는
--    복수(다수, 여러개)인 것이 가능하다.
--    컬럼 1개로만 (단일 컬럼) 구성된 PRIMARY KEY 를 Single Primary Key 라고 부른다. (단일 프라이머리 키)
--    두 개 이상의 컬럼으로 구성된 PRIMARY KEY 를 Composite Primary Key 라고 부른다. (복합 프라이머리 키)


--○ 제 2 정규화
--> 제 1 정규화를 마친 결과물에서 PRIMARY KEY 가 SINGLE COLUMN 이면
--  제 2 정규화를 수행하지 않는다.
--  하지만, PRIMARY KEY 가 COMPOSITE COLUMN 이라면
--  반.드.시. 제 2 정규화를 수행해야 한다.

--> 식별자가 아닌 컬럼은 식별자 전체 컬럼에 대해 의존적이어야 하는데
--  식별자 전체 컬럼이 아닌 일부 식별자 컬럼에 대해서만 의존적이라면
--  이를 분리하여 새로운 테이블을 생성해 준다.

/*
테이블명: 과목 → 부모 테이블
------------------------------------------------------------------------------------
과목번호    과목명     교수자번호   교수자명    강의실코드   강의실설명
++++++++               ++++++++++
   (P            .         K)
------------------------------------------------------------------------------------
JV0101      자바기초       21      슈바이처       A301       전산실습관 3층 40석 규모
JV0102      자바중급       22      테슬라         T502       전자공학관 5층 20석 규모
DB0102      오라클중급     22      테슬라         A201       전산실습관 2층 50석 규모
DB0102      오라클중급     10      장영실         T502       전자공학과 5층 20석 규모
DB0103      오라클고급     22      테슬라         A203       전산실습관 2층 90석 규모
JS0105      JSP심화        10      장영실         K101       인문사회관 1층 80석 규모
------------------------------------------------------------------------------------

테이블명: 점수 → 자식 테이블
-------------------------------------------------
과목번호 교수자번호  학번       학생명     점수
===================
      (F.K)
++++++++             ++++
    (P      .          K)
-------------------------------------------------
DB0102        22      210210      채지윤		76
DB0102        22      212111      손범석     56


------> 제 2 정규화를 마치면... PRIMARY KEY 를 하나로 만든다.
*/



--○ 제 3 정규화
-->  식별자가 아닌 컬럼이 식별자가 아닌 컬럼에 대해 의존적인 상황이라면
--   이를 분리하여 새로운 테이블을 생성해 주어야 한다.
--   (예시: 강의실코드 ← 강의실 설명)


------> 제 3 정규화까지 마치면... 식별자가 아닌 컬럼은 식별자에 대해서만 의존적!



--※ 관계(Ralation)의 종류

-- 1:1
-- (예시: 로그인)

-- 1:다
--> 제 1 정규화를 마친 결과물에서 나타나는 바람직한 관계
--  관계형 데이터베이스를 활용하는 과정에서 추구해야 하는 관계

-- 다:다
--> 논리적인 모델링에서는 존재할 수 있지만
--  실제 물리적인 모델링에서는 존재할 수 없는 관계

/*
테이블명: 고객           (다)                테이블명: 제품              (다)
-----------------------------           --------------------------------------
고객번호 고객명 이메일 ...                제품코드 제품명   제품단가   ...
(P.K)                                       (P.K)
-----------------------------           --------------------------------------
1100     장민지    ...                     swk     새우깡     1500    ...
1101     최현정    ...                     ggk     감자깡      700    ...
1102     윤유동    ...                     ggc     자갈치      500    ...
            :                                         :
-----------------------------           --------------------------------------



            테이블명: 주문등록
   -------------------------------------------------------
   주문번호 고객번호    제품코드    주문일자    주문수량
     (p.k)   (f.k)       (f.k)
   -------------------------------------------------------
             1100        swk         ...         20
             1100        ggk         ...         50
             1101        ggc         ...         11
             1101        swk         ...         20
             1102        ggk         ...         10
             1102        ggc         ...         20
   -------------------------------------------------------
   
EX2. 수강신청   
*/

--○ 제 4 정규화
--   위에서 확인한 내용과 같이 『다:다』 관계를 『1:다』 관계로 깨뜨리는 과정이
--   제 4 정규화의 수행과정이다.
--   → 일반적으로 파생 테이블 생성
--      → 『다:다』 관계를 『1:다』 관계로 깨뜨리는 역할 수행


--○ 역정규화(비정규화)
/*
-- A 경우 → 역정규화를 수행하지 않는 것이 바람직한 경우
테이블명 : 부서                     테이블명 : 사원
  10        10      10                10       10    10   10     10        10         10
--------------------------          --------------------------------------------    ------
부서번호  부서명   주소             사원번호 사원명 직급  급여  입사일  부서번호  +  부서명
++++++++                            ++++++++                            =======
 (P.K)                                (P.K)                              (F.K)
--------------------------          --------------------------------------------    ------   
        10개 행                                      1,000,000개 행
--------------------------          --------------------------------------------    ------

>> 업무 분석 상 조회 결과물 (빈번하게 조회하는 내용)
-------------------------
 부서명 사원명 직급 급여
-------------------------
  부서   사원  사원 사원

→ 『부서』 테이블과 『사원』 테이블을 JOIN 했을 때의 크기
    : (10개 * 30 Byte) + (1,000,000개 * 60 Byte) = 60,000,300 Byte

→ 『사원』 테이블을 역정규화 수행 후 이 테이블만 읽어올 때의 크기
    (즉, 부서 테이블의 부서명 컬럼을 사원 테이블에 추가한 경우)
    : 1,000,000개 * 70 Byte = 70,000,000 Byte


-- B 경우

테이블명 : 부서                     테이블명 : 사원
  10        10      10                10       10    10   10     10        10         10
--------------------------          --------------------------------------------    ------
부서번호  부서명   주소             사원번호 사원명 직급  급여  입사일  부서번호  +  부서명
++++++++                            ++++++++                            =======
 (P.K)                                (P.K)                              (F.K)
--------------------------          --------------------------------------------    ------   
      500,000개 행                                   1,000,000개 행
--------------------------          --------------------------------------------    ------

>> 업무 분석 상 조회 결과물 (빈번하게 조회하는 내용)
-------------------------
 부서명 사원명 직급 급여
-------------------------
  부서   사원  사원 사원
  
→ 『부서』 테이블과 『사원』 테이블을 JOIN 했을 때의 크기
    : (500,000개 * 30 Byte) + (1,000,000개 * 60 Byte) = 75,000,000 Byte

→ 『사원』 테이블을 역정규화 수행 후 이 테이블만 읽어올 때의 크기
    (즉, 부서 테이블의 부서명 컬럼을 사원 테이블에 추가한 경우)
    : 1,000,000개 * 70 Byte = 70,000,000 Byte
   
   
    
--> TIP!!!!    
--> 테이블 간의 데이터의 건수가 많이 차이날 경우, 안 하는 게 나은 경우가 많다!
*/


--------------------------------------------------------------------------------


/*
테이블명: 사원 → 부모 테이블
---------------------------------------------------------------------               
 사원번호   사원명     주민번호       입사일      급여      직급 ...                 직급
 ++++++++                                                                           -----------------
   (P.K)                                                                             직급코드   직급
---------------------------------------------------------------------               -----------------
 7369       장진하     9XXXXX...   2010-XX-XX     XXXX     부장 ...                      2       부장
 7370       김진희     9XXXXX...   2010-XX-XX     XXXX     차장 ...                      3       차장
 7971       장민지     9XXXXX...   2011-XX-XX     XXXX     과장 ...                      4       과장  
 7372       손범석     9XXXXX...   2010-XX-XX     XXXX     대리 ...                           :
 7373       이찬호     9XXXXX...   2011-XX-XX     XXXX     사원 ...
                                :
                                :
---------------------------------------------------------------------

테이블명: 사원가족 → 자식 테이블
-----------------------------------------------
 주민번호      사원번호    관계      성명
 ++++++++      ========
   (P.K)         (F.K)
-----------------------------------------------
 9XXXXX...      7369        남편      송강
 0XXXXX...      7369        아들      송강호
 9XXXXX...      7372        아내      송지효
 9XXXXX...      7371        남편      남주혁 
                       :
                       :
-----------------------------------------------
*/


/*
테이블명: 사원 → 부모 테이블
---------------------------------------------------------------------               
 사원번호   사원명     주민번호       입사일      급여     직급코드 ...              직급
 ++++++++                                                  =======                 -----------------
   (P.K)                                                    (F.K)                   직급코드   직급
---------------------------------------------------------------------              -----------------
 7369       장진하     9XXXXX...   2010-XX-XX     XXXX       2 ...                     2       부장
 7370       김진희     9XXXXX...   2010-XX-XX     XXXX       3 ...                     3       차장
 7971       장민지     9XXXXX...   2011-XX-XX     XXXX       4 ...                     4       과장  
 7372       손범석     9XXXXX...   2010-XX-XX     XXXX       5 ...                           :
 7373       이찬호     9XXXXX...   2011-XX-XX     XXXX       6 ...
                                :
                                :
---------------------------------------------------------------------

테이블명: 사원가족 → 자식 테이블                                                가족관계
-----------------------------------------------                                 -------------------------
 주민번호      사원번호    관계      성명                                        관계코드 관계명  관계설명
 ++++++++      ========                                                         -------------------------
   (P.K)         (F.K)                                                             1    배우자  남편이나 아내  
-----------------------------------------------                                    2    부모    본인이나 배우자의 부모
 9XXXXX...      7369        남편      송강
 0XXXXX...      7369        아들      송강호
 9XXXXX...      7372        아내      송지효
 9XXXXX...      7371        남편      남주혁 
                       :
                       :
-----------------------------------------------


※ 데이터를 범례를 통해 코드화 시키자!
*/











