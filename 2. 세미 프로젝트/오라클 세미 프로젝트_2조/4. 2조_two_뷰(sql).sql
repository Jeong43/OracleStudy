--==============================================================================
--�� ����л����� ��� �������� ���� ���� ��ȸ�ϴ� ��

-- ��� : �л���, ������, ��������, �������, �Ǳ�����, �ʱ�����, ����, �ߵ���������
--==============================================================================
CREATE OR REPLACE VIEW VIEW_STUDENT_INFO
AS
SELECT T1.�л���, T1.������, T1.��������, T1.�������, T1.�Ǳ�����, T1.�ʱ�����
     , (T1.������� + T1.�Ǳ����� + T1.�ʱ�����) "����", T1.�ߵ���������
FROM
(
    SELECT ST.NAME"�л���",CO.COUR_CODE"������" 
        , SU.NAME "��������"
        , FN_SCORE_ATTEND(GR.GRADE_CODE) "�������"
        , FN_SCORE_PRACTICE(GR.GRADE_CODE) "�Ǳ�����"
        , FN_SCORE_WRITTEN(GR.GRADE_CODE) "�ʱ�����"
        , FN_QUIT(RE.REG_CODE) "�ߵ���������"
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

--��ȸ
SELECT *   
FROM VIEW_STUDENT_INFO;


--==============================================================================
--�� ��� ������ ���� ��ȸ �� ����

-- ��� : ������, ���ǽ�, �����, ����SDATE, ����EDATE, ����, ������
--==============================================================================
CREATE OR REPLACE VIEW VIEW_OPSUBJECT
AS
SELECT O.COUR_CODE "������", CR.NAME "���ǽ�", S.NAME "�����"
    , O.STARTDATE "���������", O.ENDDATE "����������", S.BOOK "�����", P.NAME "������"
FROM TBL_OPSUBJECT O LEFT JOIN TBL_SUBJECTS S
ON O.SUB_CODE = S.SUB_CODE
    LEFT JOIN TBL_PROFESSOR P
    ON O.PRO_ID = P. PRO_ID
    LEFT JOIN TBL_COURSE C
    ON O.COUR_CODE = C.COUR_CODE
    LEFT JOIN TBL_CLASSROOM CR
    ON C.CLASS_CODE = CR.CLASS_CODE;
    

--��ȸ
SELECT * FROM VIEW_OPSUBJECT;


--==============================================================================
--�� ������ ���� ��ȸ ��

-- (��� �����ڿ� ���� ���� ���)
-- ������, ��������, ����SDATE, ����EDATE, �����, ���ǽ�, ���� ���� ����
-- ����, ����, ��������, ����, ���ǽ�
-- ���� ���� ��Ȳ ��ȯ�ϴ� �Լ� (FN_COURSE) ���
--==============================================================================

CREATE OR REPLACE VIEW VIEW_PROFESSOR_COUR
AS
SELECT P.NAME "������", C.COUR_CODE "������",  S.NAME "��������", O.STARTDATE "���������", O.ENDDATE "����������"
     , S.BOOK "�����", R.NAME "���ǽ�", FN_COURSE(C.COUR_CODE) "�������࿩��"
FROM TBL_PROFESSOR P LEFT JOIN TBL_OPSUBJECT O
ON P.PRO_ID = O.PRO_ID
    LEFT JOIN TBL_SUBJECTS S
    ON O.SUB_CODE = S.SUB_CODE
    LEFT JOIN TBL_COURSE C
    ON O.COUR_CODE = C.COUR_CODE
    LEFT JOIN TBL_CLASSROOM R
    ON C.CLASS_CODE = R.CLASS_CODE;


-- ��ȸ    
SELECT *
FROM VIEW_PROFESSOR_COUR;



--==============================================================================
--�� ������ ���� ��ȸ �ϴ� VIEW ���� (VIEW_PROFESSOR_COUR) 

--��� : ������, ���ǽ�, �����, ����������, ����������, ����, ������, �������࿩��
--���� ���� ��Ȳ ��ȯ�ϴ� �Լ� (FN_COURSE) ���
--==============================================================================

CREATE OR REPLACE VIEW VIEW_COURSE
AS
SELECT CO.COUR_CODE"������", CL.CAPACITY "���ǽ�" , SU.NAME"�����"
     , CO.STARTDATE"������",CO.ENDDATE"������", SU.BOOK"�����̸�", PRO.NAME"�����ڸ�"     
     , FN_COURSE(CO.COUR_CODE)"�������࿩��"
FROM TBL_PROFESSOR PRO RIGHT JOIN TBL_OPSUBJECT OP
ON PRO.PRO_ID = OP.PRO_ID
    LEFT JOIN TBL_SUBJECTS SU ON OP.SUB_CODE = SU.SUB_CODE
    RIGHT JOIN TBL_COURSE CO ON CO.COUR_CODE = OP.COUR_CODE
    LEFT JOIN TBL_CLASSROOM CL ON CL.CLASS_CODE = CO.CLASS_CODE;

 
--��ȸ
SELECT *
FROM VIEW_COURSE;


--==============================================================================
--�� ���� ���� ���� ��ȸ ��

--��� : ������, ������, ���������, ����������, ����, �л��̸�, �������, �Ǳ�����
--     , �ʱ�����, ����, ���, �ߵ���������      
--���� ��� �Լ� (FN_SCORE_PRACTICE, FN_SCORE_WRITTEN, FN_SCORE_ATTEND) ���
--==============================================================================

-- ������ ���� ���� ��ȸ
CREATE OR REPLACE VIEW VIEW_PROFESSOR
AS
SELECT T.������, T.������, T.�����, T.���������, T.����������, T.�����̸�, T.�л��̸�, T.���, T.�Ǳ�
     , T.�ʱ�,(T.������� + T.�ʱ����� + T.�Ǳ�����)"����"
     , RANK() OVER(PARTITION BY T.������, T.����� ORDER BY (T.������� + T.�ʱ����� + T.�Ǳ�����)DESC)"���"
     , T.�ߵ�����     
FROM ( 
       SELECT PRO.NAME"������", SU.NAME"�����", OP.STARTDATE"���������", OP.ENDDATE"����������", SU.BOOK"�����̸�"
             , ST.NAME"�л��̸�", GR.ATTEND"���", GR.PRACTICE"�Ǳ�", GR.WRITTEN"�ʱ�"
             , FN_SCORE_PRACTICE(GR.GRADE_CODE)"�Ǳ�����"
             , FN_SCORE_WRITTEN(GR.GRADE_CODE)"�ʱ�����"
             , FN_SCORE_ATTEND(GR.GRADE_CODE)"�������"
             , OP.COUR_CODE"������"
             , FN_QUIT(RE.REG_CODE)"�ߵ�����"
  
        FROM TBL_OPSUBJECT OP LEFT JOIN TBL_PROFESSOR PRO
        ON PRO.PRO_ID = OP.PRO_ID
            LEFT JOIN TBL_SUBJECTS SU ON SU.SUB_CODE = OP.SUB_CODE
            LEFT JOIN TBL_GRADE GR ON GR.OPSUB_CODE = OP.OPSUB_CODE
            LEFT JOIN TBL_REGIST RE ON RE.REG_CODE = GR.REG_CODE
            LEFT JOIN TBL_STUDENT ST ON ST.STU_ID = RE.STU_ID    
)T;


-- ��ȸ
SELECT * 
FROM VIEW_PROFESSOR;

-- �ߵ������� �л� ���� ���� ��ȸ
SELECT * 
FROM VIEW_PROFESSOR
WHERE �ߵ����� <> '�ߵ�����';


--==============================================================================
--�� �л� ���� ��ȸ ��
-- ������� : �л���, ������, �����, ����������, ����������, ����� 
--           , ������� , �ʱ�����, �Ǳ�����, ����, ���
--���� ��� �Լ� (FN_SCORE_PRACTICE, FN_SCORE_WRITTEN, FN_SCORE_ATTEND) ���
--==============================================================================
CREATE OR REPLACE VIEW VIEW_STUDENT_GRADE
AS
SELECT T2.�л���, T2.������, T2.�����, T2.����������, T2.����������, T2.�����
    , T2.�������, T2.�ʱ�����, T2.�Ǳ�����, T2.����
    , RANK() OVER(PARTITION BY T2.������, T2.����� ORDER BY T2.���� DESC) "���"
FROM
(
    SELECT T1.�л���, T1.������, T1.�����, T1.����������, T1.����������, T1.�����
        , T1.�������, T1.�ʱ�����, T1.�Ǳ�����, (T1.������� + T1.�ʱ����� + T1.�Ǳ�����) "����"
    FROM
    (
    SELECT S.NAME "�л���", R.COUR_CODE "������", SJ.NAME "�����"
         , C.STARTDATE "����������", C.ENDDATE "����������", SJ.BOOK "�����"
    
         , FN_SCORE_PRACTICE(G.GRADE_CODE) "�Ǳ�����"
         , FN_SCORE_WRITTEN(G.GRADE_CODE) "�ʱ�����"
         , FN_SCORE_ATTEND(G.GRADE_CODE) "�������"   
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

    
-- ��ȸ
SELECT *
FROM VIEW_STUDENT_GRADE;

