SELECT USER
FROM DUAL;
--==>> HR

--�� ����
CREATE TABLE ADMINISTRATOR
( ADMIN_ID  VARCHAR2(30)
, ADMIN_PW  VARCHAR2(30) 
, CONSTRAINT ADMINISTRATOR_ADMIN_ID_PK PRIMARY KEY(ADMIN_ID)
);

ALTER TABLE ADMINISTRATOR
MODIFY
( ADMIN_PW CONSTRAINT ADMINISTRATOR_ADMIN_PW_NN NOT NULL );



CREATE TABLE ESTABLISHED_SUB
( EST_SUB_ID        VARCHAR2(30)
, PRO_ID            VARCHAR2(30)
, COURSE_ID         VARCHAR2(30)
, SUB_ID            VARCHAR2(30)
, ATTEND_PER        NUMBER(3)
, PRACTICAL_PER     NUMBER(3)
, WRITING_PER       NUMBER(3)
, CONSTRAINT EST_SUB_EST_SUB_ID_PK PRIMARY KEY(EST_SUB_ID)
, CONSTRAINT EST_SUB_PRO_ID_FK FOREIGN KEY(PRO_ID) 
                                       REFERENCES PROFESSORS(PRO_ID)
, CONSTRAINT SUBJECTS_COURSE_ID_FK FOREIGN KEY(COURSE_ID) 
                                       REFERENCES COURSE(COURSE_ID)
, CONSTRAINT EST_SUB_SUB_ID_FK FOREIGN KEY(SUB_ID) 
                                       REFERENCES SUBJECTS(SUB_ID)
, CONSTRAINT EST_SUB_ATTEND_PER_CK CHECK(ATTEND_PER BETWEEN 0 AND 100)
, CONSTRAINT EST_SUB_PRACTICAL_PER_CK CHECK(PRACTICAL_PER BETWEEN 0 AND 100)
, CONSTRAINT EST_SUB_WRITING_PER_CK CHECK(WRITING_PER BETWEEN 0 AND 100)
, CONSTRAINT EST_SUB_TOTAL_PER_CK CHECK( (ATTEND_PER + PRACTICAL_PER + WRITING_PER) = 100 )
);

DROP TABLE ESTABLISHED_SUB;

--�� �±�
CREATE TABLE COURSE
( COURSE_ID     VARCHAR2(30)  
, COURSE_NAME   VARCHAR2(30)
, PRO_ID        VARCHAR2(30)
, C_START       DATE
, C_END         DATE
, CLASSROOM     VARCHAR2(30)
, CONSTRAINT COURSE_COURSE_ID_PK PRIMARY KEY(COURSE_ID)
, CONSTRAINT COURSE_COURSE_NAME_FK FOREIGN KEY(PRO_ID)
                                            REFERENCES PROFESSORS(PRO_ID)
, CONSTRAINT COURSE_C_START_CK CHECK(C_START < C_END)
);

DROP TABLE COURSE;

CREATE TABLE TEST
(
 TEST_ID          VARCHAR2(30)
,EST_SUB_ID       VARCHAR2(30)
,TEST_DATE        DATE
,CONSTRAINT TEST_TEST_ID_PK PRIMARY KEY(TEST_ID)
,CONSTRAINT TEST_EST_SUB_ID_FK FOREIGN KEY(EST_SUB_ID) REFERENCES ESTABLISHED_SUB(EST_SUB_ID)
);

DROP TABLE TEST;


--�� ��ȭ
CREATE TABLE MID_DROP
( DROP_ID       VARCHAR2(30)
, ENROLL_ID     VARCHAR2(30)
, DROP_DATE     DATE           NOT NULL
, CONSTRAINT MID_DPOP_ID_PK PRIMARY KEY(DROP_ID)
, CONSTRAINT MID_DPOP_ENROLL_ID_FK FOREIGN KEY(ENROLL_ID)
             REFERENCES ENROLL(E_ID)
-- ����Ϻ��� �ߵ����� ��¥�� �ڿ��� �Ѵٴ� ��������
);

DROP TABLE MID_DROP;

CREATE TABLE SCORE
( SCORE_ID              VARCHAR2(30) 
, ENROLL_ID             VARCHAR2(30)
, EST_SUB_ID            VARCHAR2(30)
, ATTEND_SCORE          NUMBER(3)
, PRACTICAL_SCORE       NUMBER(3)
, WRITING_SCORE         NUMBER(3)
, CONSTRAINT SOCRE_ID_PK PRIMARY KEY(SCORE_ID)
, CONSTRAINT SCORE_ENROLL_ID_FK FOREIGN KEY(ENROLL_ID)
             REFERENCES ENROLL(E_ID)
, CONSTRAINT SCORE_ESTABLISHED_SUB_ID_FK FOREIGN KEY(EST_SUB_ID)
             REFERENCES ESTABLISHED_SUB(EST_SUB_ID)
, CONSTRAINT SCORE_ATTEND_SCORE_CK CHECK(ATTEND_SCORE BETWEEN 0 AND 100)            
, CONSTRAINT SCORE_PRACTICAL_SCORE_CK CHECK(PRACTICAL_SCORE BETWEEN 0 AND 100)            
, CONSTRAINT SCOREWRITING_SCORE_CK CHECK(WRITING_SCORE BETWEEN 0 AND 100)

);

DROP TABLE SCORE;


--�� ȿ��
-- �������� ���̺�
CREATE TABLE PROFESSORS
( PRO_ID     VARCHAR2(30)                               -- �����ڹ�ȣ
, PRO_NAME   VARCHAR2(10)                               -- �����ڸ�
, PRO_PW     VARCHAR2(30)                               -- ������ ��й�ȣ(�ʱⰪ�� �ֹι�ȣ ���ڸ�)
, PRO_SSN    CHAR(14)                                   -- ������ �ֹι�ȣ
, CONSTRAINT PROFESSORS_PRO_ID_PK PRIMARY KEY(PRO_ID)
);

-- NOT NULL �������� ����
ALTER TABLE PROFESSORS
MODIFY
( PRO_NAME CONSTRAINT PROFESSORS_PRO_NAME_NN NOT NULL
, PRO_PW CONSTRAINT PROFESSORS_PRO_PW_NN NOT NULL
, PRO_SSN CONSTRAINT PROFESSORS_PRO_SSN_NN NOT NULL
);

ALTER TABLE PROFESSORS
ADD CONSTRAINT PROFESSORS_PRO_SSN_UK UNIQUE(PRO_SSN);

-- ���� ���̺�
CREATE TABLE SUBJECTS
( SUB_ID            VARCHAR2(30)        -- �����ڵ�
, SUB_NAME            VARCHAR2(30)
, S_START           DATE                -- ������
, S_END             DATE                -- ������
, CLASSROOM         VARCHAR2(30)        -- ���ǽ�
, BOOK_NAME         VARCHAR2(30)        -- å�̸�
, CONSTRAINT SUBJECTS_SUB_ID_PK PRIMARY KEY(SUB_ID)
, CONSTRAINT SUBJECTS_S_START_CK CHECK(S_START < S_END)
);

DROP TABLE SUBJECTS;

-- �̺�Ʈ�α�(PRO_EVENTLOG) ���̺� ����
CREATE TABLE PRO_EVENTLOG
( PRO_ID    VARCHAR2(30)
, MEMO      VARCHAR2(200)
, ILJA      DATE DEFAULT SYSDATE
, CONSTRAINT PRO_EVENTLOG_PRO_ID_FK FOREIGN KEY(PRO_ID)
                REFERENCES PROFESSORS(PRO_ID)
);

--�� ����
--�л�����
CREATE TABLE STUDENTS
( ST_ID     VARCHAR2(30) 
, ST_PW     VARCHAR2(30)         -- ���ʱⰪ �ֹι�ȣ ���ڸ�
, ST_NAME   VARCHAR2(10)  
, ST_SSN    CHAR(14)     UNIQUE
, ST_DATE   DATE         DEFAULT SYSDATE
, CONSTRAINT STUDENTS_ST_ID_PK PRIMARY KEY(ST_ID)
);

-- �������� ����
ALTER TABLE STUDENTS
MODIFY
( ST_ID CONSTRAINT STUDENTS_STUDENT_ID_NN NOT NULL
, ST_NAME CONSTRAINT STUDENTS_STUDENT_NAME_NN NOT NULL
, ST_PW CONSTRAINT STUDENTS_STUDENT_PASSWORD_NN NOT NULL
, ST_SSN CONSTRAINT STUDENTS_STUDENT_SSN_NN NOT NULL
, ST_DATE CONSTRAINT STUDENTS_STUDENT_DATE_NN NOT NULL
);

--������û
CREATE TABLE ENROLL
( E_ID          VARCHAR2(30)
, ST_ID         VARCHAR2(30)
, COURSE_ID     VARCHAR2(30)
, E_DATE        DATE    DEFAULT SYSDATE
, CONSTRAINT ENROLL_E_ID_PK PRIMARY KEY(E_ID)
, CONSTRAINT ENROLL_ST_ID_FK FOREIGN KEY(ST_ID) 
                                       REFERENCES STUDENTS(ST_ID)
, CONSTRAINT ENROLL_COURSE_ID_FK FOREIGN KEY(COURSE_ID) 
                                       REFERENCES COURSE(COURSE_ID)
);

-- �������� ����
ALTER TABLE ENROLL
MODIFY
(E_DATE   CONSTRAINT ENROLL_E_DATE_NN NOT NULL
);



DROP TABLE ENROLL;

DROP TABLE MID_DROP;
DROP TABLE SCORE;
DROP TABLE ENROLL;
DROP TABLE TEST;

--�� �л� INSERT, UPDATE �α� ���̺�
CREATE TABLE STD_EVENTLOG
( ST_ID         VARCHAR2(30)
, ILJA          DATE DEFAULT SYSDATE
, MEMO          VARCHAR2(200)
, CONSTRAINT TBL_EVENTLOG_ST_ID_FK FOREIGN KEY(ST_ID) 
                                       REFERENCES STUDENTS(ST_ID)
);
--==>> Table STD_EVENTLOG��(��) �����Ǿ����ϴ�.




--�� ��ȭ
-- �ߵ����� INSERT ���ν���
--> �ߵ����� ���ڵ带 �Է� ��, "���� ������ < �ߵ������� < ����������"�� �´��� Ȯ���ϴ� ���ν���
CREATE OR REPLACE PROCEDURE PRC_MID_DROP_INSERT
( V_DROP_ID     IN MID_DROP.DROP_ID%TYPE
, V_ENROLL_ID   IN MID_DROP.ENROLL_ID%TYPE
, V_DROP_DATE   IN MID_DROP.DROP_DATE%TYPE
)
IS
    V_COURSE_ID         COURSE.COURSE_ID%TYPE;
    V_C_START           COURSE.C_START%TYPE;
    V_C_END             COURSE.C_END%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;

BEGIN
    -- ������ �� ���
    SELECT COURSE_ID INTO V_COURSE_ID
    FROM ENROLL
    WHERE ENROLL_ID = V_ENROLL_ID;    
    
    SELECT C_START, C_END INTO V_C_START, V_C_END
    FROM COURSE
    WHERE COURSE_ID = V_COURSE_ID;
    
    -- ���� ó�� : "���� ������ < �ߵ������� < ����������"�� �ƴ� ���
    IF (V_DROP_DATE < V_C_START OR V_DROP_DATE > V_C_END)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- INSERT
    INSERT INTO MID_DROP(DROP_ID, ENROLL_ID, DROP_DATE)
    VALUES (V_DROP_ID, V_ENROLL_ID, V_DROP_DATE);
    
    -- Ŀ��
    COMMIT;
    
    -- ���� �߻�
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '�ߵ����� ��¥�� �߸� �ԷµǾ����ϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;



-- ���õ�����
-- 1. ������
INSERT INTO ADMINISTRATOR(ADMIN_ID, ADMIN_PW) VALUES('AD1', 'QWER1234');
INSERT INTO ADMINISTRATOR(ADMIN_ID, ADMIN_PW) VALUES('AD2', 'ASDF1234');

-- 2. ����
INSERT INTO PROFESSORS(PRO_ID, PRO_NAME, PRO_PW, PRO_SSN)
VALUES('PRO1', '���� ��', 'QWER1234', '840218-2813239');

INSERT INTO PROFESSORS(PRO_ID, PRO_NAME, PRO_PW, PRO_SSN)
VALUES('PRO2', '������', 'ASDF1234', '111111-1111111');

-- 3. �л�
INSERT INTO STUDENTS(ST_ID, ST_PW, ST_NAME, ST_SSN, ST_DATE)
VALUES('STU1', 'QWER1234', '��ȸ��', '111111-3111111', TO_DATE('2020-09-24', 'YYYY-MM-DD'));

INSERT INTO STUDENTS(ST_ID, ST_PW, ST_NAME, ST_SSN, ST_DATE)
VALUES('STU2', 'ASDF1234', '���ʿ�', '111111-4111111', TO_DATE('2020-09-24', 'YYYY-MM-DD'));

-- 4. ����
INSERT INTO SUBJECTS(SUB_ID, SUB_NAME, S_START, S_END, CLASSROOM, BOOK_NAME)
VALUES('SUB1', '����Ŭ�߱�',  TO_DATE('2020-12-24', 'YYYY-MM-DD'),  TO_DATE('2021-1-19', 'YYYY-MM-DD'), '����Ŭ���ǽ�A1', '����Ŭ������');

INSERT INTO SUBJECTS(SUB_ID, SUB_NAME, S_START, S_END, CLASSROOM, BOOK_NAME)
VALUES('SUB2', '�ڹٰ��',  TO_DATE('2020-7-2', 'YYYY-MM-DD'),  TO_DATE('2020-9-19', 'YYYY-MM-DD'), '�ڹٰ��ǽ�B1', '����ڹٸ�����');

-- 5. ����
INSERT INTO COURSE(COURSE_ID, COURSE_NAME, PRO_ID, C_START, C_END, CLASSROOM)
VALUES('CO1', '�����ھ缺����', 'PRO1', TO_DATE('2020-11-24', 'YYYY-MM-DD'), TO_DATE('2021-4-18', 'YYYY-MM-DD'), '����Ŭ���ǽ�A1');

INSERT INTO COURSE(COURSE_ID, COURSE_NAME, PRO_ID, C_START, C_END, CLASSROOM)
VALUES('CO2', '����������������', 'PRO2', TO_DATE('2020-6-14', 'YYYY-MM-DD'), TO_DATE('2020-12-30', 'YYYY-MM-DD'), '�ڹٰ��ǽ�B1');


-- 6. ��������
INSERT INTO ESTABLISHED_SUB(EST_SUB_ID, PRO_ID, COURSE_ID, SUB_ID, ATTEND_PER, PRACTICAL_PER, WRITING_PER)
VALUES('ESI1', 'PRO1', 'CO1', 'SUB1', 20, 40, 40);

INSERT INTO ESTABLISHED_SUB(EST_SUB_ID, PRO_ID, COURSE_ID, SUB_ID, ATTEND_PER, PRACTICAL_PER, WRITING_PER)
VALUES('ESI2', 'PRO2', 'CO2', 'SUB2', 20, 20, 60);

-- 7. ����
INSERT INTO TEST(TEST_ID, SUB_ID, TEST_DATE)
VALUES('TEST1', 'SUB1', TO_DATE('2020-12-31', 'YYYY-MM-DD'));

INSERT INTO TEST(TEST_ID, SUB_ID, TEST_DATE)
VALUES('TEST2', 'SUB1', TO_DATE('2021-01-10', 'YYYY-MM-DD'));


-- 8. ������û
INSERT INTO ENROLL(ENROLL_ID, ST_ID, COURSE_ID, ENROLL_DATE)
VALUES('ENROLL1', 'STU1', 'CO1', TO_DATE('2020-10-24', 'YYYY-MM-DD'));

INSERT INTO ENROLL(ENROLL_ID, ST_ID, COURSE_ID, ENROLL_DATE)
VALUES('ENROLL2', 'STU2', 'CO1', TO_DATE('2020-10-25', 'YYYY-MM-DD'));

-- 9. ����
INSERT INTO SCORE(SCORE_ID, ENROLL_ID, EST_SUB_ID, ATTEND_SCORE, PRACTICAL_SCORE, WRITING_SCORE)
VALUES('SCORE1', 'ENROLL1', 'ESI1', 90, 30, 100);

-- 10. �ߵ�����
INSERT INTO MID_DROP(DROP_ID, ENROLL_ID, DROP_DATE)
VALUES('DROP1', 'ENROLL2', TO_DATE('2020-10-29', 'YYYY-MM-DD'));

-- Ŀ��
COMMIT;



--�� ������ �䱸 �м�
-- 3-5~6. ��� �������� ������ ���
-- �����ڸ�, �����, ����Ⱓ(����), ����Ⱓ(��), �����, ���ǽ�, �������࿩��(���� ����, ���� ��, ��������)
SELECT P.PRO_NAME "�����ڸ�", S.SUB_NAME "�����", S.S_START "���� ������", S.S_END "���� ������"
     , S.BOOK_NAME "�����", S.CLASSROOM "���ǽ�"
     , CASE WHEN SYSDATE < S.S_START THEN '���� ����'
            WHEN S.S_END < SYSDATE THEN '���� ����'
            ELSE '���� ��'
       END "�������࿩��"
FROM PROFESSORS P JOIN ESTABLISHED_SUB E
     ON P.PRO_ID = E.PRO_ID
                 JOIN SUBJECTS S
                 ON E.SUB_ID = S.SUB_ID;


-- 4-4~5. ��� ������ ������ ���
-- ������, ���ǽ�, ����Ⱓ(����), ����Ⱓ(��), �����, �����ڸ�

-- �� ������, ���� ���ǽ�, �����, ���� ���ǽ�, ���� ������, ���� ������, �����, �����ڸ�
-- �Ʒ� ���� ���� ��°� �ߺ��Ǵ� ������ ����.
SELECT C.COURSE_NAME "������", C.CLASSROOM "���� ���ǽ�"
     , S.SUB_NAME "�����", S.CLASSROOM "���� ���ǽ�", S.S_START "���� ������", S.S_END "���� ������"
     , S.BOOK_NAME "�����", P.PRO_NAME "�����ڸ�"
FROM COURSE C JOIN PROFESSORS P
     ON C.PRO_ID = P.PRO_ID
             JOIN ESTABLISHED_SUB E
             ON C.COURSE_ID = E.COURSE_ID
                    JOIN SUBJECTS S
                    ON E.SUB_ID = S.SUB_ID;
                    
-- �� ������, ���� ���ǽ�, ���� ������, ���� ������, �����, �����ڸ�
-- �� ���� Ư�̻��� ������ ����(�䱸�м����� '���� �Ⱓ'���� ���������� '���� �Ⱓ'���� �ؼ��� ���)
SELECT C.COURSE_NAME "������", C.CLASSROOM "���� ���ǽ�", C.C_START "���� ������", C.C_END "���� ������"
     , S.SUB_NAME "�����", S.CLASSROOM "���� ���ǽ�"
     , S.BOOK_NAME "�����", P.PRO_NAME "�����ڸ�"
FROM COURSE C JOIN PROFESSORS P
     ON C.PRO_ID = P.PRO_ID
             JOIN ESTABLISHED_SUB E
             ON C.COURSE_ID = E.COURSE_ID
                    JOIN SUBJECTS S
                    ON E.SUB_ID = S.SUB_ID;                    
                    

-- 5-8~9. ��� ������ ���� ���
-- ������, ���ǽ�, �����, ����Ⱓ(����), ����Ⱓ(��), �����, �����ڸ�
SELECT C.COURSE_NAME "������", S.CLASSROOM "���� ���ǽ�"
     , S.SUB_NAME "�����", S.S_START "���� ������", S.S_END "���� ������"
     , S.BOOK_NAME "�����", P.PRO_NAME "�����ڸ�"
FROM COURSE C JOIN PROFESSORS P
     ON C.PRO_ID = P.PRO_ID
             JOIN ESTABLISHED_SUB E
             ON C.COURSE_ID = E.COURSE_ID
                    JOIN SUBJECTS S
                    ON E.SUB_ID = S.SUB_ID;


--�� ������ �䱸 �м�
-- 3. ���� ��� ���
-- �ڽ��� ������ ����, "�����, ���� �Ⱓ(����), ����Ⱓ(��), �����, �л���, ���, �Ǳ�, �ʱ�, ����, ���
-- ���� �ߵ�Ż�� ��: ������ ���� ���� ���, �ߵ�Ż�� ���� ���
SELECT SUB.SUB_NAME "�����", SUB.S_START "���� ������", SUB.S_END "���� ������", SUB.BOOK_NAME "�����"
     , STU.ST_NAME "�л���", SC.ATTEND_SCORE "�������", SC.PRACTICAL_SCORE "�Ǳ�����", SC.WRITING_SCORE "�ʱ�����"
     , (NVL(SC.ATTEND_SCORE, 0) + NVL(SC.PRACTICAL_SCORE, 0) + NVL(SC.WRITING_SCORE, 0)) "����"
     , RANK() OVER(ORDER BY (NVL(SC.ATTEND_SCORE, 0) + NVL(SC.PRACTICAL_SCORE, 0) + NVL(SC.WRITING_SCORE, 0)) DESC) "���"
     , CASE WHEN MID.E_ID IS NOT NULL THEN 'Y'
            ELSE 'N'
       END "�ߵ�����"
FROM STUDENTS STU LEFT JOIN ENROLL E
    ON STU.ST_ID = E.ST_ID
        LEFT JOIN SCORE SC
        ON E.E_ID = SC.E_ID
            LEFT JOIN ESTABLISHED_SUB EST
            ON SC.EST_SUB_ID = EST.EST_SUB_ID
                LEFT JOIN SUBJECTS SUB
                ON EST.SUB_ID = SUB.SUB_ID
                    LEFT JOIN MID_DROP MID
                    ON E.E_ID = MID.E_ID                    
WHERE PRO_ID IN ('PRO1', 'PRO2'); -- WHERE���� �ش�Ǵ� ���� �ڵ� �Է�


--�� ������û �Ұ� ���ν���
-- �Ʒ��� ������ Ȯ�� �� �����͸� �Է��Ѵ�.
-- 1) ��������ϰ� ������
-- 2) ������ ���� ��û ����
-- 3) ���� ��¥ �ߺ�
CREATE OR REPLACE PROCEDURE PRC_ENROLL_INSERT
( V_E_ID       IN ENROLL.E_ID%TYPE
, V_ST_ID      IN ENROLL.ST_ID%TYPE
, V_COURSE_ID  IN ENROLL.COURSE_ID%TYPE
, V_E_DATE     IN ENROLL.E_DATE%TYPE
)

IS
   V_ST_DATE           STUDENTS.ST_DATE%TYPE;
   V_C_START           COURSE.C_START%TYPE;     -- ����Ϸ��� ������ ������
   V_C_END             COURSE.C_END%TYPE;       -- ����Ϸ��� ������ ������
   nCNT                NUMBER;
   USER_DEFINE_ERROR   EXCEPTION;
   SAME_COURSE         EXCEPTION;
   SAME_DATE           EXCEPTION;

BEGIN
    -- ���� ó�� 1. ��������ϰ� ������
    -- ������û���� ��������Ϻ��� �����ų�, �����Ϻ��� �����ų� ���� �� ����.
    SELECT ST_DATE INTO V_ST_DATE
    FROM STUDENTS
    WHERE ST_ID = V_ST_ID;
    
    SELECT C_START, C_END INTO V_C_START, V_C_END
    FROM COURSE
    WHERE COURSE_ID = V_COURSE_ID;    

    IF (V_E_DATE < V_ST_DATE OR V_E_DATE >= V_C_START)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    -- ���� ó�� 2. ������ ���� ��û ����
    -- �� �л��� ���� ������ ��û�� �� ����.
    SELECT COUNT(*) INTO nCNT
    FROM ENROLL
    WHERE ST_ID = V_ST_ID AND COURSE_ID = V_COURSE_ID;    
    
    IF (nCNT > 0)
        THEN RAISE SAME_COURSE;
    END IF;

    
    -- ���� ó�� 3. ���� ��¥ �ߺ�
    -- �� �л��� ������ ������ ������ ��¥��, ���� �����Ϸ��� ������ ��¥�� ��ĥ �� ����.
    SELECT COUNT(*) INTO nCNT
    FROM ENROLL E JOIN COURSE C
      ON E.COURSE_ID = C.COURSE_ID      
    WHERE E.ST_ID = V_ST_ID
      AND ( V_C_START > C.C_START AND V_C_START < C.C_END     -- ����Ϸ��� ������ ���� ��¥ ���� Ȯ��
       OR   V_C_END > C.C_START AND V_C_END < C.C_END );      -- ����Ϸ��� ������ ���� ��¥ ���� Ȯ��

    IF (nCNT > 0)
        THEN RAISE SAME_DATE;
    END IF; 


    -- INSERT
    INSERT INTO ENROLL(E_ID, ST_ID, COURSE_ID, E_DATE)
    VALUES (V_E_ID, V_ST_ID, V_COURSE_ID, V_E_DATE);

    -- Ŀ��
    COMMIT;
        
    -- ���� �߻�
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '���� ��û�� �Ұ����մϴ�.');
                 ROLLBACK;
        WHEN SAME_COURSE
            THEN RAISE_APPLICATION_ERROR(-20003, '�̹� ��û�� �����Դϴ�.');
                 ROLLBACK;
        WHEN SAME_DATE
            THEN RAISE_APPLICATION_ERROR(-20004, '��¥�� �ߺ��Ǵ� �����Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;            
END;


/*
-- ����ó��3 Ȯ�ο�
SELECT COUNT(*) --INTO nCNT
FROM ENROLL E JOIN COURSE C
  ON E.COURSE_ID = C.COURSE_ID      
WHERE E.ST_ID = 'STU1'
  AND ( TO_DATE('2020-11-29', 'YYYY-MM-DD') > C.C_START AND TO_DATE('2020-11-29', 'YYYY-MM-DD') < C.C_END     -- ����Ϸ��� ������ ���� ��¥ ���� Ȯ��
   OR   TO_DATE('2020-12-29', 'YYYY-MM-DD') > C.C_START AND TO_DATE('2020-12-29', 'YYYY-MM-DD') < C.C_END );  
*/   












