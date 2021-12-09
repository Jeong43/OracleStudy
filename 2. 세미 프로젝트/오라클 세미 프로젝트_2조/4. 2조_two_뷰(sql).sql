--==============================================================================
--○ 모든학생들의 모든 수강과목에 대한 정보 조회하는 뷰

-- 출력 : 학생명, 과정명, 수강과목, 출결점수, 실기점수, 필기점수, 총점, 중도하차여부
--==============================================================================
CREATE OR REPLACE VIEW VIEW_STUDENT_INFO
AS
SELECT T1.학생명, T1.과정명, T1.수강과목, T1.출결점수, T1.실기점수, T1.필기점수
     , (T1.출결점수 + T1.실기점수 + T1.필기점수) "총점", T1.중도하차여부
FROM
(
    SELECT ST.NAME"학생명",CO.COUR_CODE"과정명" 
        , SU.NAME "수강과목"
        , FN_SCORE_ATTEND(GR.GRADE_CODE) "출결점수"
        , FN_SCORE_PRACTICE(GR.GRADE_CODE) "실기점수"
        , FN_SCORE_WRITTEN(GR.GRADE_CODE) "필기점수"
        , FN_QUIT(RE.REG_CODE) "중도하차여부"
    FROM TBL_STUDENT ST LEFT JOIN TBL_REGIST RE
            ON ST.STU_ID = RE.STU_ID
           LEFT JOIN TBL_COURSE CO
            ON RE.COUR_CODE = CO.COUR_CODE
           LEFT JOIN TBL_OPSUBJECT OP
            ON CO.COUR_CODE = OP.COUR_CODE
           LEFT JOIN TBL_SUBJECTS SU 
            ON OP.SUB_CODE = SU.SUB_CODE 
           LEFT JOIN TBL_GRADE GR
            ON OP.OPSUB_CODE = GR.OPSUB_CODE
            AND RE.REG_CODE = GR.REG_CODE
)T1;

--조회
SELECT *   
FROM VIEW_STUDENT_INFO;


--==============================================================================
--○ 모든 과목의 정보 조회 뷰 생성

-- 출력 : 과정명, 강의실, 과목명, 과목SDATE, 과목EDATE, 교재, 교수명
--==============================================================================
CREATE OR REPLACE VIEW VIEW_OPSUBJECT
AS
SELECT O.COUR_CODE "과정명", CR.NAME "강의실", S.NAME "과목명"
    , O.STARTDATE "과목시작일", O.ENDDATE "과목종료일", S.BOOK "교재명", P.NAME "교수명"
FROM TBL_OPSUBJECT O LEFT JOIN TBL_SUBJECTS S
ON O.SUB_CODE = S.SUB_CODE
    LEFT JOIN TBL_PROFESSOR P
    ON O.PRO_ID = P. PRO_ID
    LEFT JOIN TBL_COURSE C
    ON O.COUR_CODE = C.COUR_CODE
    LEFT JOIN TBL_CLASSROOM CR
    ON C.CLASS_CODE = CR.CLASS_CODE;
    

--조회
SELECT * FROM VIEW_OPSUBJECT;


--==============================================================================
--○ 교수자 과목 조회 뷰

-- (모든 교수자에 대한 정보 출력)
-- 교수명, 배정과목, 과목SDATE, 과목EDATE, 교재명, 강의실, 강의 진행 여부
-- 교수, 과목, 개설과목, 과정, 강의실
-- 과정 진행 상황 반환하는 함수 (FN_COURSE) 사용
--==============================================================================

CREATE OR REPLACE VIEW VIEW_PROFESSOR_COUR
AS
SELECT P.NAME "교수명", C.COUR_CODE "과정명",  S.NAME "배정과목", O.STARTDATE "과목시작일", O.ENDDATE "과목종료일"
     , S.BOOK "교재명", R.NAME "강의실", FN_COURSE(C.COUR_CODE) "강의진행여부"
FROM TBL_PROFESSOR P LEFT JOIN TBL_OPSUBJECT O
ON P.PRO_ID = O.PRO_ID
    LEFT JOIN TBL_SUBJECTS S
    ON O.SUB_CODE = S.SUB_CODE
    LEFT JOIN TBL_COURSE C
    ON O.COUR_CODE = C.COUR_CODE
    LEFT JOIN TBL_CLASSROOM R
    ON C.CLASS_CODE = R.CLASS_CODE;


-- 조회    
SELECT *
FROM VIEW_PROFESSOR_COUR;



--==============================================================================
--○ 개설된 과정 조회 하는 VIEW 생성 (VIEW_PROFESSOR_COUR) 

--출력 : 과정명, 강의실, 과목명, 과정시작일, 과목종료일, 교재, 교수명, 강의진행여부
--과정 진행 상황 반환하는 함수 (FN_COURSE) 사용
--==============================================================================

CREATE OR REPLACE VIEW VIEW_COURSE
AS
SELECT CO.COUR_CODE"과정명", CL.CAPACITY "강의실" , SU.NAME"과목명"
     , CO.STARTDATE"시작일",CO.ENDDATE"종료일", SU.BOOK"교재이름", PRO.NAME"교수자명"     
     , FN_COURSE(CO.COUR_CODE)"강의진행여부"
FROM TBL_PROFESSOR PRO RIGHT JOIN TBL_OPSUBJECT OP
ON PRO.PRO_ID = OP.PRO_ID
    LEFT JOIN TBL_SUBJECTS SU ON OP.SUB_CODE = SU.SUB_CODE
    RIGHT JOIN TBL_COURSE CO ON CO.COUR_CODE = OP.COUR_CODE
    LEFT JOIN TBL_CLASSROOM CL ON CL.CLASS_CODE = CO.CLASS_CODE;

 
--조회
SELECT *
FROM VIEW_COURSE;


--==============================================================================
--○ 교수 과목 성적 조회 뷰

--출력 : 교수명, 과정명, 과목시작일, 과목종료일, 교재, 학생이름, 출결점수, 실기점수
--     , 필기점수, 총점, 등수, 중도하차여부      
--점수 계산 함수 (FN_SCORE_PRACTICE, FN_SCORE_WRITTEN, FN_SCORE_ATTEND) 사용
--==============================================================================

-- 교수자 과목 성적 조회
CREATE OR REPLACE VIEW VIEW_PROFESSOR
AS
SELECT T.교수명, T.과정명, T.과목명, T.과목시작일, T.과목종료일, T.교재이름, T.학생이름, T.출결, T.실기
     , T.필기,(T.출결점수 + T.필기점수 + T.실기점수)"총점"
     , RANK() OVER(PARTITION BY T.과정명, T.과목명 ORDER BY (T.출결점수 + T.필기점수 + T.실기점수)DESC)"등수"
     , T.중도하차     
FROM ( 
       SELECT PRO.NAME"교수명", SU.NAME"과목명", OP.STARTDATE"과목시작일", OP.ENDDATE"과목종료일", SU.BOOK"교재이름"
             , ST.NAME"학생이름", GR.ATTEND"출결", GR.PRACTICE"실기", GR.WRITTEN"필기"
             , FN_SCORE_PRACTICE(GR.GRADE_CODE)"실기점수"
             , FN_SCORE_WRITTEN(GR.GRADE_CODE)"필기점수"
             , FN_SCORE_ATTEND(GR.GRADE_CODE)"출결점수"
             , OP.COUR_CODE"과정명"
             , FN_QUIT(RE.REG_CODE)"중도하차"
  
        FROM TBL_OPSUBJECT OP LEFT JOIN TBL_PROFESSOR PRO
        ON PRO.PRO_ID = OP.PRO_ID
            LEFT JOIN TBL_SUBJECTS SU ON SU.SUB_CODE = OP.SUB_CODE
            LEFT JOIN TBL_GRADE GR ON GR.OPSUB_CODE = OP.OPSUB_CODE
            LEFT JOIN TBL_REGIST RE ON RE.REG_CODE = GR.REG_CODE
            LEFT JOIN TBL_STUDENT ST ON ST.STU_ID = RE.STU_ID    
)T;


-- 조회
SELECT * 
FROM VIEW_PROFESSOR;

-- 중도하차한 학생 빼고 성적 조회
SELECT * 
FROM VIEW_PROFESSOR
WHERE 중도하차 <> '중도하차';


--==============================================================================
--○ 학생 성적 조회 뷰
-- 출력정보 : 학생명, 과정명, 과목명, 과정시작일, 과정종료일, 교재명 
--           , 출결점수 , 필기점수, 실기점수, 총점, 등수
--점수 계산 함수 (FN_SCORE_PRACTICE, FN_SCORE_WRITTEN, FN_SCORE_ATTEND) 사용
--==============================================================================
CREATE OR REPLACE VIEW VIEW_STUDENT_GRADE
AS
SELECT T2.학생명, T2.과정명, T2.과목명, T2.과정시작일, T2.과정종료일, T2.교재명
    , T2.출결점수, T2.필기점수, T2.실기점수, T2.총점
    , RANK() OVER(PARTITION BY T2.과정명, T2.과목명 ORDER BY T2.총점 DESC) "등수"
FROM
(
    SELECT T1.학생명, T1.과정명, T1.과목명, T1.과정시작일, T1.과정종료일, T1.교재명
        , T1.출결점수, T1.필기점수, T1.실기점수, (T1.출결점수 + T1.필기점수 + T1.실기점수) "총점"
    FROM
    (
    SELECT S.NAME "학생명", R.COUR_CODE "과정명", SJ.NAME "과목명"
         , C.STARTDATE "과정시작일", C.ENDDATE "과정종료일", SJ.BOOK "교재명"
    
         , FN_SCORE_PRACTICE(G.GRADE_CODE) "실기점수"
         , FN_SCORE_WRITTEN(G.GRADE_CODE) "필기점수"
         , FN_SCORE_ATTEND(G.GRADE_CODE) "출결점수"   
    FROM TBL_STUDENT S LEFT JOIN TBL_REGIST R
    ON S.STU_ID = R.STU_ID
        LEFT JOIN TBL_COURSE C
        ON R.COUR_CODE = C.COUR_CODE
        LEFT JOIN TBL_OPSUBJECT O
        ON C.COUR_CODE = O.COUR_CODE
        LEFT JOIN TBL_SUBJECTS SJ
        ON O.SUB_CODE = SJ.SUB_CODE
        JOIN TBL_GRADE G
        ON O.OPSUB_CODE = G.OPSUB_CODE  AND R.REG_CODE = G.REG_CODE
    ) T1
) T2;

    
-- 조회
SELECT *
FROM VIEW_STUDENT_GRADE;

