-- 3�� : ����, �ߵ�����

CREATE TABLE MID_DROP
( DROP_ID       VARCHAR2(30)
, ENROLL_ID     VARCHAR2(30)
, DROP_DATE     DATE           NOT NULL
, CONSTRAINT MID_DPOP_ID_PK PRIMARY KEY(DROP_ID)
, CONSTRAINT MID_DPOP_ENROLL_ID_FK FOREIGN KEY(ENROLL_ID)
             REFERENCES ENROLL(ENROLL_ID)
, CONSTRAINT DROP_DATE_INTERVAL CHECK(DROP_DATE > ENROLL.ENROLL_DATE)   ------ < �ٸ� ���̺� ���� �ϴ� �� �̷��� �ϴ� �� ������...
);

CREATE TABLE SCORE
( SCORE_ID              VARCHAR2(30) 
, ENROLL_ID             VARCHAR2(30)
, ESTABLISHED_SUB_ID    VARCHAR2(30)
, ATTEND_SCORE          NUMBER(3)
, PRACTICAL_SCORE       NUMBER(3)
, WRITING_SCORE         NUMBER(3)
, CONSTRAINT SOCRE_ID_PK PRIMARY KEY(SCORE_ID)
, CONSTRAINT SCORE_ENROLL_ID_FK FOREIGN KEY(ENROLL_ID)
             REFERENCES ENROLL(ENROLL_ID)
, CONSTRAINT SCORE_ESTABLISHED_SUB_ID_FK FOREIGN KEY(ESTABLISHED_SUB_ID)
             REFERENCES ESTABLISHED_SUB(ESTABLISHED_SUB_ID)
, CONSTRAINT SCORE_ATTEND_SCORE_CK CHECK(ATTEND_SCORE BETWEEN 0 AND ESTABLISHED_SUB.ATTEND_PERCENT)
, CONSTRAINT SCORE_PRACTICA_SCORE_CK CHECK(PRACTICA_SCORE BETWEEN 0 AND ESTABLISHED_SUB.PRACTICA_PERCENT)
, CONSTRAINT SCORE_WRITING_SCORE_CK CHECK(WRITING_SCORE BETWEEN 0 AND ESTABLISHED_SUB.WRITING_PERCENT)
);


--�� �����Է� ���ν���
--1. ���� �Է� ���� ȭ�� ���
-- �ڽ��� ������ ������, �ߵ�Ż���ڸ� �����ϰ� ���� �Է�
-- �л� �̸��� �ڵ����� �ԷµǾ� �ְ�, ����(���, �Ǳ�, �ʱ�)�� �Է��ϸ� �ȴ�.
-- �� ������ ��(����)�� �ڵ����� ��µȴ�.
SELECT C.COURSE_NAME "�����", S.ST_NAME "�л���"
     , NVL(SCO.ATTEND_SCORE, 0) "�������", NVL(SCO.PRACTICAL_SCORE, 0) "�Ǳ�����", NVL(SCO.WRITING_SCORE, 0) "�ʱ�����"
     , (NVL(SCO.ATTEND_SCORE, 0) + NVL(SCO.PRACTICAL_SCORE, 0) + NVL(SCO.WRITING_SCORE, 0)) "����"
FROM PROFESSORS P JOIN COURSE C
    ON P.PRO_ID = C.PRO_ID
                JOIN ENROLL E
                ON C.COURSE_ID = E.COURSE_ID
                    JOIN STUDENTS S
                    ON E.ST_ID = S.ST_ID
                        LEFT JOIN SCORE SCO
                        ON E.E_ID = SCO.E_ID                            
                            LEFT JOIN MID_DROP M
                            ON E.E_ID = M.E_ID
WHERE P.PRO_ID = 'PRO1'     -- ���� ���� ������ ID �Է�
  AND M.DROP_ID IS NULL;    -- �ߵ�Ż���ڰ� �ƴ� ���


--2. ���� �Է� ���ν���
CREATE OR REPLACE PROCEDURE PRC_SCORE_INSERT 
( V_E_ID                IN SCORE.E_ID%TYPE 
, V_EST_SUB_ID          IN SCORE.EST_SUB_ID%TYPE
, V_ATTEND_SCORE        IN SCORE.ATTEND_SCORE%TYPE
, V_PRACTICAL_SCORE     IN SCORE.PRACTICAL_SCORE%TYPE
, V_WRITING_SCORE       IN SCORE.WRITING_SCORE%TYPE
)
IS
    V_COURSE_ID         COURSE.COURSE_ID%TYPE;
    V_PRO_ID            COURSE.PRO_ID%TYPE;
    V_CNT               NUMBER;

    NOT_YOUR_EST_ERROR   EXCEPTION;
    MID_DROP_STU_ERROR   EXCEPTION;

BEGIN
    -- ����ó��1. �ڽ��� ������ ������ �ƴ� ���
    SELECT COURSE_ID INTO V_COURSE_ID
    FROM ENROLL
    WHERE E_ID = V_E_ID;
    
    SELECT PRO_ID INTO V_PRO_ID
    FROM COURSE
    WHERE COURSE_ID = V_COURSE_ID;
    
    IF (V_PRO_ID != 'PRO1') -- �ش� ������ �ڵ带 �Է��ؾ� ��
        THEN RAISE NOT_YOUR_EST_ERROR;
    END IF;
    
    
    -- ����ó��2. �ߵ�Ż���� ������û ������ ���
    SELECT COUNT(*) INTO V_CNT
    FROM MID_DROP
    WHERE E_ID = V_E_ID;
    
    IF (V_CNT > 0)
        THEN RAISE MID_DROP_STU_ERROR;
    END IF;
    

    -- SCORE(�������̺�) INSERT 
    INSERT INTO SCORE(SCORE_ID, E_ID, EST_SUB_ID, ATTEND_SCORE, PRACTICAL_SCORE, WRITING_SCORE)
    VALUES('SCORE' || SEQ_SCORE_ID.NEXTVAL, V_E_ID, V_EST_SUB_ID, V_ATTEND_SCORE, V_PRACTICAL_SCORE, V_WRITING_SCORE);


    -- Ŀ��
    COMMIT;
    
    
    -- ����ó��
    EXCEPTION
        WHEN NOT_YOUR_EST_ERROR 
            THEN RAISE_APPLICATION_ERROR(-20001, '����ó���� �� ���� ������û �����Դϴ�.');
                 ROLLBACK;
        WHEN MID_DROP_STU_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '�ߵ������� ������û �����Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS 
            THEN ROLLBACK;
END;
--==>> Procedure PRC_SCORE_INSERT��(��) �����ϵǾ����ϴ�.


-- �׽�Ʈ
    SELECT COURSE_ID -- INTO V_COURSE_ID
    FROM ENROLL
    WHERE E_ID = 'ENROLL1';
    
    SELECT PRO_ID --INTO V_PRO_ID
    FROM COURSE
    WHERE COURSE_ID = 'CO1';

    SELECT COUNT(*) --INTO V_CNT
    FROM MID_DROP
    WHERE E_ID = 'ENROLL2';
    
    
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
FROM STUDENTS STU RIGHT JOIN ENROLL E
     ON STU.ST_ID = E.ST_ID
        LEFT JOIN SCORE SC
        ON E.E_ID = SC.E_ID
            RIGHT JOIN ESTABLISHED_SUB EST
            ON SC.EST_SUB_ID = EST.EST_SUB_ID
                LEFT JOIN SUBJECTS SUB
                ON EST.SUB_ID = SUB.SUB_ID
                    LEFT JOIN MID_DROP MID
                    ON E.E_ID = MID.E_ID                    
WHERE EST.PRO_ID IN ('PRO1', 'PRO2'); -- WHERE���� �ش�Ǵ� ���� �ڵ� �Է�    
