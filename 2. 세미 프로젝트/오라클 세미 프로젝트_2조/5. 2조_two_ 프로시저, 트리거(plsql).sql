--==============================================================================

--���� ���������̺� ����

--�� ������ �Է� ���ν���
CREATE OR REPLACE PROCEDURE PRC_ADMIN_INSERT
( V_ADMIN_ID    IN TBL_ADMIN.ADMIN_ID%TYPE
, V_PW          IN TBL_ADMIN.PW%TYPE
, V_NAME        IN TBL_ADMIN.NAME%TYPE
)
IS 
BEGIN
    INSERT INTO TBL_ADMIN(ADMIN_ID, PW, NAME) VALUES (V_ADMIN_ID, V_PW, V_NAME);
    
    COMMIT;
    
END;

--���ν��� ȣ��
--EXEC PRC_ADMIN_INSERT(ID, ��й�ȣ, �̸�)
EXEC PRC_ADMIN_INSERT('ad_songjh', '1227', '����ȿ');

--------------------------------------------------------------------------------

--�� ���������̺� �α��� ���ν���
CREATE OR REPLACE PROCEDURE PRC_ADMIN_LOGIN
( V_ADMIN_ID    IN TBL_ADMIN.ADMIN_ID%TYPE
, V_PW          IN TBL_ADMIN.PW%TYPE
)
IS
    V_ADMIN_ID2 TBL_ADMIN.ADMIN_ID%TYPE;
    V_PW2       TBL_ADMIN.PW%TYPE;
    V_IDCOUNT   NUMBER;
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2   EXCEPTION;
BEGIN
    
    SELECT COUNT(*) INTO V_IDCOUNT 
    FROM TBL_ADMIN
    WHERE ADMIN_ID = V_ADMIN_ID;
    
    IF (V_IDCOUNT =0 )
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    SELECT PW INTO V_PW2
    FROM TBL_ADMIN
    WHERE ADMIN_ID = V_ADMIN_ID;  

    IF (V_PW = V_PW2)
        THEN DBMS_OUTPUT.PUT_LINE('������ �α���');
    ELSE
        RAISE USER_DEFINE_ERROR2; 
    END IF;
   
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20004,'���̵� �������� �ʽ��ϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20005,'���̵�� �н����尡 ��ġ���� �ʽ��ϴ�.');
            ROLLBACK;
END;


--���ν��� ȣ��
--EXEC PRC_ADMIN_LOGIN(ID, ��й�ȣ)
EXEC PRC_ADMIN_LOGIN('ad_songjh','1227'); -- ID, PW ��ġ�� �� 
EXEC PRC_ADMIN_LOGIN('ad_songjh','1234'); -- ID, PW ����ġ�� �� 
EXEC PRC_ADMIN_LOGIN('ad_song','1227'); -- �������� �ʴ� ID �Է��� ��

--==============================================================================

--���� �������̺� ����

--�� ���� ���̺� �Է� ���ν���
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_INSERT
( V_PRO_ID  IN TBL_PROFESSOR.PRO_ID%TYPE
, V_NAME    IN TBL_PROFESSOR.NAME%TYPE
, V_FSSN    IN TBL_PROFESSOR.FSSN%TYPE
, V_BSSN    IN TBL_PROFESSOR.BSSN%TYPE
)
IS
    USER_DEFINE_ERROR   EXCEPTION;
    V_SSN       CHAR(13);       -- �Է¹��� �ֹι�ȣ �յ� ���� ����
    V2_SSN      CHAR(13);       -- ���̺��� �ֹι�ȣ �յ� ���� ����
    
    V2_FSSN     TBL_PROFESSOR.FSSN%TYPE;
    V2_BSSN     TBL_PROFESSOR.BSSN%TYPE;
    
    CURSOR CUR_PROFESSOR_SELECT
    IS
    SELECT FSSN, BSSN
    FROM TBL_PROFESSOR;
BEGIN
    
    V_SSN := V_FSSN || V_BSSN;
    
    OPEN CUR_PROFESSOR_SELECT;
    LOOP
        FETCH CUR_PROFESSOR_SELECT INTO V2_FSSN, V2_BSSN;
        V2_SSN := V2_FSSN || V2_BSSN;
        EXIT WHEN CUR_PROFESSOR_SELECT%NOTFOUND;
        
        IF(V_SSN = V2_SSN)
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
    
    END LOOP;
    CLOSE CUR_PROFESSOR_SELECT;
       
    --�ʱ� ��й�ȣ�� �ֹε�Ϲ�ȣ ���ڸ�
    INSERT INTO TBL_PROFESSOR (PRO_ID, PW, NAME, FSSN, BSSN, SIGNDATE)
        VALUES (V_PRO_ID, V_BSSN, V_NAME, V_FSSN, V_BSSN, SYSDATE);
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003,'�ֹι�ȣ�� �ߺ��˴ϴ�. �ٽ� �Է��ϼ���.');
            ROLLBACK;     
        WHEN OTHERS
             THEN ROLLBACK;
END;

--���ν��� ȣ��
--EXEC PRC_PROFESSOR_INSERT(����ID, �̸�, �ֹι�ȣ���ڸ�, �ֹι�ȣ���ڸ�)
EXEC PRC_PROFESSOR_INSERT('hjyoon', '������', '880111', '1111234'); -- ���� �Է� �����Ϳ� �ֹι�ȣ �ߺ��� ��
EXEC PRC_PROFESSOR_INSERT('hjyoon', '������', '810801', '2222345'); -- ���� ó��

--------------------------------------------------------------------------------

--�� ���� �α��� ���ν���
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_LOGIN
( V_PRO_ID    IN TBL_PROFESSOR.PRO_ID%TYPE
, V_PW        IN TBL_PROFESSOR.PW%TYPE
)
IS
    V_PW2     TBL_PROFESSOR.PW%TYPE;
    V_IDCOUNT   NUMBER;
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2   EXCEPTION; 
BEGIN
    
    SELECT COUNT(*) INTO V_IDCOUNT 
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;
    
    IF (V_IDCOUNT =0 )
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    SELECT PW INTO V_PW2
     FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;

    IF (V_PW = V_PW2)
        THEN DBMS_OUTPUT.PUT_LINE('������ �α���');
    ELSE
        RAISE USER_DEFINE_ERROR2; 
    END IF;
   
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20004,'���̵� �������� �ʽ��ϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20005,'���̵�� �н����尡 ��ġ���� �ʽ��ϴ�.');
            ROLLBACK;
END;

--���ν��� ȣ��
--EXEC PRC_PROFESSOR_LOGIN(����ID, PW);
EXEC PRC_PROFESSOR_LOGIN('hjyoon','newpassword'); --���� �Է�
EXEC PRC_PROFESSOR_LOGIN('hjyoon','password');    --ID, PW ����ġ
EXEC PRC_PROFESSOR_LOGIN('hjy','newpassword');    --ID�� �������� ���� ��

--------------------------------------------------------------------------------

--�� ���� ��й�ȣ ���� ���ν���
CREATE OR REPLACE PROCEDURE PRC_PRO_PW_UPDATE
( V_ID            IN TBL_PROFESSOR.PRO_ID%TYPE
, V_PW            IN TBL_PROFESSOR.PW%TYPE    --���� �н�����
, V_NEWPW         IN TBL_PROFESSOR.PW%TYPE    --�ٲٰ� �;��ϴ� �н�����
)
IS
    V_PW2    TBL_PROFESSOR.PW%TYPE;
    
BEGIN 
 
    SELECT PW INTO V_PW2 
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_ID AND PW = V_PW;
         
    IF(V_PW = V_PW2)
        THEN
            UPDATE TBL_PROFESSOR
            SET PW =V_NEWPW
            WHERE PRO_ID = V_ID; 
    END IF;
    
    COMMIT;       
                          
    EXCEPTION      �ƴ϶�� ���� 
        WHEN OTHERS 
            THEN RAISE_APPLICATION_ERROR(-20005,'���̵�� �н����尡 ��ġ���� �ʽ��ϴ�.');
        ROLLBACK;
END;

--���ν��� ȣ��
--EXEC PRC_PRO_PW_UPDATE(ID, ����PW, �ٲٷ���PW);
EXEC PRC_PRO_PW_UPDATE('hjyoon', '2222345', 'newpassword');

--------------------------------------------------------------------------------

--�� ���� ���� (�̸�, �ֹι�ȣ, ���Գ�¥) ���� ���ν���
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_UPDATE
( V_PRO_ID   IN TBL_PROFESSOR.PRO_ID%TYPE
, V_NAME     IN TBL_PROFESSOR.NAME%TYPE
, V_FSSN     IN TBL_PROFESSOR.FSSN%TYPE
, V_BSSN     IN TBL_PROFESSOR.BSSN%TYPE
, V_SIGNDATE IN TBL_PROFESSOR.SIGNDATE%TYPE
)
IS
    V_IDCOUNT   NUMBER;
    USER_DEFINE_ERROR EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO V_IDCOUNT
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;
    
    IF (V_IDCOUNT = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    SELECT COUNT(*) INTO V_IDCOUNT   --�ߺ��� ���� ã�� ���� 
    FROM TBL_PROFESSOR
    WHERE NAME = V_NAME AND FSSN = V_FSSN AND BSSN = V_BSSN AND SIGNDATE = V_SIGNDATE;
    
    IF(V_IDCOUNT != 0)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    --UPDATE
    UPDATE TBL_PROFESSOR
    SET NAME = V_NAME, FSSN = V_FSSN, BSSN = V_BSSN, SIGNDATE = V_SIGNDATE
    WHERE PRO_ID = V_PRO_ID;
    
    COMMIT;

    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20004,'���̵� �������� �ʽ��ϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20002,'�̹� �Էµ� ���� �Դϴ�!');
            ROLLBACK;

END;

--���ν��� ȣ��
--EXEC PRC_PROFESSOR_UPDATE( ID, �̸�, �ֹι�ȣ���ڸ�, �ֹι�ȣ���ڸ�, ���Գ�¥);
EXEC PRC_PROFESSOR_UPDATE('hjkim', '��ȣ��', '850924', '1234567', TO_DATE('2010-05-22', 'YYYY-MM-DD'));
EXEC PRC_PROFESSOR_UPDATE('hjk', '��ȣ��', '850924', '1234567', TO_DATE('2010-05-22', 'YYYY-MM-DD'));  --���̵� �������� ���� ��
EXEC PRC_PROFESSOR_UPDATE('hjkim', '��ȣ��', '850924', '1234567', TO_DATE('2010-05-22', 'YYYY-MM-DD'));--�����ϴ� �� ���� �Է����� ��

--------------------------------------------------------------------------------

--�� ���� ���� ���ν��� 
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_DELETE
( V_PRO_ID  IN TBL_PROFESSOR.PRO_ID%TYPE
)
IS
    V2_PRO_ID           TBL_PROFESSOR.PRO_ID%TYPE;    --ID�� �����ϴ��� Ȯ�� ��
    V_NAME              TBL_PROFESSOR.NAME%TYPE;      --�̸�
    V_RESULT            VARCHAR2(30); 
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;    

    CURSOR CUR_OPSUBJECT_RESULT         --������ �������� ������ �ִ��� ����� Ŀ���� ��´�.
    IS
    SELECT FN_OPSUBJECT(OPSUB_CODE) 
    FROM TBL_OPSUBJECT
    WHERE PRO_ID = V_PRO_ID;

BEGIN

    SELECT ( SELECT PRO_ID
             FROM TBL_PROFESSOR
             WHERE PRO_ID = V_PRO_ID ) INTO V2_PRO_ID
    FROM DUAL;
   
    -- ���̵� ������ ��ġȮ��
    IF(V2_PRO_ID IS NULL)       --�Ű����� ID�� ��ġ�ϴ� ID�� ���ٸ�
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
  
    SELECT NAME INTO V_NAME     
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;
    
    OPEN CUR_OPSUBJECT_RESULT;
        LOOP
            FETCH CUR_OPSUBJECT_RESULT INTO V_RESULT;
             
            -- ���� �������� ������ ��� ���� �Ұ�                         
            IF ( V_RESULT = '���� ��')
                THEN RAISE USER_DEFINE_ERROR;
            END IF;
            
        END LOOP;
        
    CLOSE CUR_OPSUBJECT_RESULT;
    
        -- PROFESSOR ���̺� ���� ������ ����
    DELETE 
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;
    
    COMMIT;
    
    -- �׽�Ʈ ���
    DBMS_OUTPUT.PUT_LINE('������ ����ID/������ : ' || V_PRO_ID || '/' || V_NAME);
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20011,'��ġ�ϴ� �����Ͱ� �����ϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20012,'���� ���� ���� ������ ���� �� �� �����ϴ�.');
            ROLLBACK;
        WHEN OTHERS
             THEN ROLLBACK;
END;

-- ���ν��� ȣ��
-- EXEC PRC_PROFESSOR_DELETE(����ID) 
EXEC PRC_PROFESSOR_DELETE('hjyoon');     --���� �Է�
EXEC PRC_PROFESSOR_DELETE('hj');         --ID�� �������� ���� ��


--==============================================================================

--���� �л����̺� ���� 

--�� �л����̺� �Է� ���ν���
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( V_STU_ID      IN TBL_STUDENT.STU_ID%TYPE
, V_NAME        IN TBL_STUDENT.NAME%TYPE
, V_FSSN        IN TBL_STUDENT.FSSN%TYPE
, V_BSSN        IN TBL_STUDENT.BSSN%TYPE
)
IS
    V_SSN CHAR(13);  --�Ű������� ���� �ֹι�ȣ ����
    V_SSN2 CHAR(13); --������ �ԷµǾ��ִ� �ֹι�ȣ���� ��� ���� 
    
    V_FSSN2 TBL_STUDENT.FSSN%TYPE; --Ŀ����뺯��
    V_BSSN2 TBL_STUDENT.BSSN%TYPE; --Ŀ����뺯��
    
    USER_DEFINE_ERROR EXCEPTION;
    
    CURSOR CUR_STUDENT_SELECT
    IS
    SELECT FSSN, BSSN
    FROM TBL_STUDENT;
    
BEGIN
    V_SSN := V_FSSN || V_BSSN; 

    OPEN CUR_STUDENT_SELECT;   
    LOOP
        FETCH CUR_STUDENT_SELECT INTO V_FSSN2, V_BSSN2; 
	V_SSN2 := V_FSSN2 || V_BSSN2; 
        EXIT WHEN CUR_STUDENT_SELECT%NOTFOUND;

   	 -- �ֹι�ȣ �ߺ��� �����߻�
    	IF(V_SSN = V_SSN2)
        	THEN RAISE USER_DEFINE_ERROR;
    	END IF;

    END LOOP;
    CLOSE CUR_STUDENT_SELECT;
    
    -- INSERT ����
    -- ��й�ȣ �ʱⰪ�� �ֹι�ȣ ���ڸ�.
    INSERT INTO TBL_STUDENT(STU_ID, PW, NAME, FSSN, BSSN, SIGNDATE)
    VALUES (V_STU_ID, V_BSSN, V_NAME, V_FSSN, V_BSSN, SYSDATE);
    
    COMMIT;
    
    EXCEPTION  
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003,'�ֹι�ȣ�� �ߺ��˴ϴ�.');
            ROLLBACK;
        WHEN OTHERS
             THEN ROLLBACK;
END;

--���ν��� ȣ��
--EXEC PRC_STUDENT_INSERT(�л�ID, �̸�, �ֹι�ȣ���ڸ�, �ֹι�ȣ���ڸ�)
EXEC PRC_STUDENT_INSERT('201402013', '���ش�', '950212', '1735914');

--------------------------------------------------------------------------------

--�� �л����̺� �α��� ���ν���
CREATE OR REPLACE PROCEDURE PRC_STUDENT_LOGIN
( V_STU_ID    IN TBL_STUDENT.STU_ID%TYPE
, V_PW        IN TBL_STUDENT.PW%TYPE
)
IS
    V_PW2     TBL_STUDENT.PW%TYPE;
    V_IDCOUNT   NUMBER;
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2   EXCEPTION;  
BEGIN

    SELECT COUNT(*) INTO V_IDCOUNT 
    FROM TBL_STUDENT
    WHERE STU_ID = V_STU_ID;
    
    IF ( V_IDCOUNT = 0 )
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    SELECT PW INTO V_PW2
    FROM TBL_STUDENT
    WHERE STU_ID = V_STU_ID ;
    
    IF (V_PW = V_PW2)
        THEN DBMS_OUTPUT.PUT_LINE('�л� �α���');
    ELSE
        RAISE USER_DEFINE_ERROR2; 
    END IF;
   
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20004,'���̵� �������� �ʽ��ϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20005,'���̵�� �н����尡 ��ġ���� �ʽ��ϴ�.');
            ROLLBACK;
END;

--���ν��� ȣ��
--EXEC PRC_STUDENT_LOGIN(�л�ID, PW)
EXEC PRC_STUDENT_LOGIN('201402013','1735914');

--------------------------------------------------------------------------------

--�� �л� ��й�ȣ ���� ���ν���
CREATE OR REPLACE PROCEDURE PRC_STU_PW_UPDATE
( V_ID            IN TBL_STUDENT.STU_ID%TYPE   --���� ���̵�
, V_PW            IN TBL_STUDENT.PW%TYPE       --���� �н�����
, V_NEWPW         IN TBL_STUDENT.PW%TYPE       --�ٲٰ� �;��ϴ� �н�����
)
IS
    V_PW2    TBL_STUDENT.PW%TYPE;    
BEGIN 

    SELECT PW INTO V_PW2 
    FROM TBL_STUDENT
    WHERE STU_ID = V_ID;
         
    IF(V_PW = V_PW2)      
        THEN
            UPDATE TBL_STUDENT
            SET PW =V_NEWPW
            WHERE STU_ID = V_ID;     
    END IF;
    
    COMMIT;
                          
    EXCEPTION         
        WHEN OTHERS 
            THEN RAISE_APPLICATION_ERROR(-20005,'���̵�� �н����尡 ��ġ���� �ʽ��ϴ�.');
    ROLLBACK;

END;


--���ν��� ȣ��
--EXEC PRC_STU_PW_UPDATE(ID, ����PW, �ٲٷ���PW);
EXEC PRC_STU_PW_UPDATE('201402013', '1735914', 'newpassword');

--------------------------------------------------------------------------------

--�� �л� ������ ���� �� �ߵ��ϴ� Ʈ���� ���� 
-- �л� DELETE �� TBL_REGIST �� �ش��л� ������ ����
CREATE OR REPLACE TRIGGER TRG_STUDENT_DELETE
        BEFORE
        DELETE ON TBL_STUDENT
        FOR EACH ROW
BEGIN
    DELETE
    FROM TBL_GRADE
    WHERE REG_CODE = (SELECT REG_CODE
                        FROM TBL_REGIST
                        WHERE STU_ID = :OLD.STU_ID);
                        
    DELETE
    FROM TBL_REGIST
    WHERE STU_ID = :OLD.STU_ID;
    
END;

--------------------------------------------------------------------------------

--�� �л� ���� ���ν��� 

-- �ߵ����� ���̺� �����Ͱ� �ִ� �л��� ���� �Ұ� 
-- �л� ���� �� ������û ���̺��� ���� Ʈ���� ���� ���ƾ� ��
CREATE OR REPLACE PROCEDURE PRC_STUDENT_DELETE
( V_STU_ID  IN TBL_STUDENT.STU_ID%TYPE
)
IS
    IDCHECK    NUMBER;
    QUCHECK    VARCHAR2(20);
    CUCHECK    VARCHAR2(20);
    USER_DEFINE_ERROR    EXCEPTION;
    USER_DEFINE_ERROR1   EXCEPTION;
    USER_DEFINE_ERROR2   EXCEPTION;
    
BEGIN
        
    -- �л�ID �ִ��� Ȯ��
    SELECT COUNT(*)  INTO IDCHECK
    FROM TBL_STUDENT
    WHERE STU_ID = V_STU_ID;
    
    IF(IDCHECK = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
       
    --�ߵ����� ���̺� �л� ������ �ִ��� Ȯ��
    SELECT FN_QUIT(REG_CODE) INTO QUCHECK
    FROM TBL_REGIST
    WHERE STU_ID = V_STU_ID;
                        
    --�ߵ� ������ �л��� ��� �����߻�
    IF(QUCHECK = '�ߵ�����')
        THEN RAISE USER_DEFINE_ERROR1;
    END IF; 
                        
    -- �л� ������û ���� ��ȸ�� ���� ����, ������ ����
    SELECT FN_COURSE(COUR_CODE) INTO CUCHECK
    FROM TBL_REGIST
    WHERE STU_ID = V_STU_ID;
    
    -- ���� �������̰ų� �����Ϸ��� �л� ���� �Ұ�
    IF(CUCHECK = '���� ��' OR CUCHECK = '���� ����')
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- STUDENT ���̺� �л����� ����
    DELETE 
    FROM TBL_STUDENT
     WHERE STU_ID = V_STU_ID ;
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20004,'���̵� �������� �ʽ��ϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20013,'�ߵ����� �̷� �����Ͽ� �����Ұ�');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20014,'�����̷��� �ִ� �л��� ������ �� �����ϴ�.');
            ROLLBACK;
    
END;


--���ν��� ȣ��
--EXEC PRC_STUDENT_DELETE(�л�ID, �л���)
EXEC PRC_STUDENT_DELETE('201402013', '���ش�');

--------------------------------------------------------------------------------

--�� �л� ���� ���ν���
-- �����ڴ� �л��� ���� NAME, FSSN, BSSN,PW,SIGNDATE �� ������ �� �ִ�. 
CREATE OR REPLACE PROCEDURE PRC_STUDENT_UPDATE
(
  V_STU_ID   IN TBL_STUDENT.STU_ID%TYPE
, V_NAME     IN TBL_STUDENT.NAME%TYPE
, V_FSSN     IN TBL_STUDENT.FSSN%TYPE
, V_BSSN     IN TBL_STUDENT.BSSN%TYPE
, V_SIGNDATE IN TBL_STUDENT.SIGNDATE%TYPE
)
IS
    V_IDCOUNT   NUMBER;
    USER_DEFINE_ERROR EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO V_IDCOUNT
    FROM TBL_STUDENT
    WHERE STU_ID = V_STU_ID;
    
    IF (V_IDCOUNT = 0)              --�Է��� �л� ID�� ������ ���� 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    SELECT COUNT(*) INTO V_IDCOUNT  --�ߺ��� ���� ã�� ���� 
    FROM TBL_STUDENT
    WHERE NAME = V_NAME AND FSSN = V_FSSN AND BSSN = V_BSSN AND SIGNDATE = V_SIGNDATE;
    
    
    IF(V_IDCOUNT != 0)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
        
    
    --UPDATE
    UPDATE TBL_STUDENT
    SET NAME = V_NAME, FSSN = V_FSSN, BSSN = V_BSSN, SIGNDATE = V_SIGNDATE
    WHERE STU_ID = V_STU_ID;
    
    COMMIT;

    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20004,'���̵� �������� �ʽ��ϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20002,'�̹� �Էµ� ���� �Դϴ�!');
            ROLLBACK;

END;

--���ν��� ȣ��
--EXEC PRC_STUDENT_UPDATE(�л�ID, �л���, �ֹι�ȣ���ڸ�, �ֹι�ȣ���ڸ�, ���Գ�¥)
EXEC PRC_STUDENT_UPDATE('201402013','���ش�','950212','1735914',TO_DATE('2020-09-25', 'YYYY-MM-DD'));

--==============================================================================

--���� ���ǽ� ���̺� ����

--�� ���ǽ� �Է� ���ν���
CREATE OR REPLACE PROCEDURE PRC_CLASSROOM_INSERT
( V_CLASS_CODE    IN TBL_CLASSROOM.CLASS_CODE%TYPE
, V_NAME          IN TBL_CLASSROOM.NAME%TYPE
, V_CAPACITY      IN TBL_CLASSROOM.CAPACITY%TYPE
)
IS
BEGIN
    INSERT INTO TBL_CLASSROOM(CLASS_CODE,NAME,CAPACITY) VALUES(V_CLASS_CODE,V_NAME,V_CAPACITY);
    
    COMMIT;
END;

--���ν��� Ȯ��
--EXEC PRC_CLASSROOM_INSERT(���ǽ� �ڵ�, ���ǽ� �̸�, ���ǽ� ����);
EXEC PRC_CLASSROOM_INSERT(7,'���а�R101','���ǽ�1�� �����ο�15��');

--==============================================================================

--���� ���� ���̺� ����

--�� ���� �Է� ���ν���
CREATE OR REPLACE PROCEDURE PRC_ALLOT_INSERT
( V_ATTEND        IN TBL_ALLOT.ATTEND%TYPE
, V_PRACTICE      IN TBL_ALLOT.PRACTICE%TYPE
, V_WRITTEN       IN TBL_ALLOT.WRITTEN%TYPE
)
IS
    V_ALLOT_CODE    TBL_ALLOT.ALLOT_CODE%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    V_ALLOT         VARCHAR2(20);  --���� �˻� ���ڿ� ���� ���� 
    
    CURSOR CUR_ALLOT_SELECT
    IS
    SELECT ATTEND||PRACTICE||WRITTEN
    FROM TBL_ALLOT;
    
BEGIN

    SELECT NVL(MAX(ALLOT_CODE),0) +1 INTO V_ALLOT_CODE
    FROM TBL_ALLOT;
    
    OPEN CUR_ALLOT_SELECT;
    
    LOOP
        
        FETCH CUR_ALLOT_SELECT INTO V_ALLOT; 
        
            -- �̹� �Ȱ��� ���� ������ ������ ���� �߻�
            IF(V_ATTEND||V_PRACTICE||V_WRITTEN = V_ALLOT)
                THEN RAISE USER_DEFINE_ERROR;
            END IF;
        
        EXIT WHEN CUR_ALLOT_SELECT%NOTFOUND;
    END LOOP;
    
    CLOSE CUR_ALLOT_SELECT;
    
    --���� INSERT 
    INSERT INTO TBL_ALLOT(ALLOT_CODE,ATTEND,PRACTICE,WRITTEN) 
    VALUES(V_ALLOT_CODE,V_ATTEND,V_PRACTICE,V_WRITTEN);
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20007,'�̹� ���� ���� �����մϴ�!');
            ROLLBACK;
    
    COMMIT;
END;

--���ν��� ȣ��
--EXEC PRC_ALLOT_INSERT(������, �Ǳ����, �ʱ����)
EXEC PRC_ALLOT_INSERT(20, 50, 30);     -- ���ο� ���� �Է�
EXEC PRC_ALLOT_INSERT(20, 40, 40);     -- ������ �ִ� ���� ���� �Է�. 

--==============================================================================

--���� ���� ���̺� ����  

--�� ���� �Է� ���ν���
CREATE OR REPLACE PROCEDURE PRC_SUBJECTS_INSERT
(
  V_NAME    IN TBL_SUBJECTS.NAME%TYPE
, V_BOOK    IN TBL_SUBJECTS.BOOK%TYPE
)
IS 
    V_SUB_CODE  TBL_SUBJECTS.SUB_CODE%TYPE;
    SCOUNT          NUMBER;
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    SELECT NVL(MAX(SUB_CODE),0) +1 INTO V_SUB_CODE
    FROM TBL_SUBJECTS;
    
    SELECT COUNT(*) INTO SCOUNT  --�ߺ��� ���� ã�� ���� 
    FROM TBL_SUBJECTS
    WHERE NAME = V_NAME AND BOOK = V_BOOK;
    
    
    IF(SCOUNT  != 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --�Է�
    INSERT INTO TBL_SUBJECTS(SUB_CODE, NAME, BOOK) 
    VALUES (V_SUB_CODE, V_NAME, V_BOOK);
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20007, '�̹� ���� ���� �����մϴ�!');
            ROLLBACK;
    
END;

--���ν��� ȣ��
--EXEC PRC_SUBJECTS_INSERT(�����̸�, å�̸�)
EXEC PRC_SUBJECTS_INSERT('���̽�', '���̽��� �ְ��.');

--------------------------------------------------------------------------------

--�� ���� ���� ���ν���
CREATE OR REPLACE PROCEDURE PRC_SUB_UPDATE
(
   V_SUB_CODE  TBL_SUBJECTS.SUB_CODE%TYPE
  ,V_NAME    IN TBL_SUBJECTS.NAME%TYPE
  ,V_BOOK    IN TBL_SUBJECTS.BOOK%TYPE
)
IS
    SCOUNT   NUMBER;
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2   EXCEPTION;
   
BEGIN
    
    --�Է��� SUB_CODE�� ��ȿ���� Ȯ��
    SELECT COUNT(*) INTO SCOUNT
    FROM TBL_SUBJECTS
    WHERE SUB_CODE = V_SUB_CODE;
    
    IF(SCOUNT = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    SELECT COUNT(*) INTO SCOUNT  --�ߺ��� ���� ã�� ���� 
    FROM TBL_SUBJECTS
    WHERE NAME = V_NAME AND BOOK = V_BOOK;
    
    IF(SCOUNT  != 0)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    --�Է�
    
    UPDATE TBL_SUBJECTS
    SET NAME = V_NAME, BOOK = V_BOOK
    WHERE SUB_CODE = V_SUB_CODE;
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20020,'�Է��� �ڵ尡 �������� �ʽ��ϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20007, '�̹� ���� ���� �����մϴ�!');
            ROLLBACK;

END;

--���ν��� ȣ��
--EXEC PRC_SUB_UPDATE(�����ڵ�, �����̸�, �����)
EXEC PRC_SUB_UPDATE(3, 'CSS', 'DO IT! CSS'); 

--==============================================================================

--���� ���� ���̺� ����  

--�� ���� �Է� ���ν���
CREATE OR REPLACE PROCEDURE PRC_COURSE_INSERT
( V_COUR_CODE     IN TBL_COURSE.COUR_CODE%TYPE      
, V_CLASS_CODE    IN TBL_COURSE.CLASS_CODE%TYPE
, V_STARTDATE     IN TBL_COURSE.STARTDATE%TYPE
, V_ENDDATE       IN TBL_COURSE.ENDDATE%TYPE
, V_LIMIT         IN TBL_COURSE.LIMIT%TYPE
) 
IS
    V_SD        TBL_COURSE.STARTDATE%TYPE;
    V_ED        TBL_COURSE.ENDDATE%TYPE;

    USER_DEFINE_ERROR EXCEPTION;
    
    CURSOR CUR_SDED_SELECT
    IS
    SELECT STARTDATE,ENDDATE
    FROM TBL_COURSE
    WHERE CLASS_CODE = V_CLASS_CODE;
    
BEGIN
    
     OPEN CUR_SDED_SELECT;
    
    LOOP
        
        FETCH CUR_SDED_SELECT INTO V_SD,V_ED;   --���ǽ��� �Ȱ��� ������ ��¥�� ��´�.        
        
        --�������� ��ġ�� ���� �߻�
        IF((V_SD <= V_STARTDATE AND V_STARTDATE <= V_ED) OR
           (V_SD <= V_ENDDATE AND V_ENDDATE <= V_ED) OR
            (V_STARTDATE <= V_SD AND V_ENDDATE > V_ED))
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
        
        EXIT WHEN CUR_SDED_SELECT%NOTFOUND;
    END LOOP;
    
    --Ŀ�� Ŭ����
    CLOSE CUR_SDED_SELECT;
    
    INSERT INTO TBL_COURSE(COUR_CODE, CLASS_CODE, STARTDATE, ENDDATE,LIMIT)
    VALUES (V_COUR_CODE, V_CLASS_CODE, V_STARTDATE, V_ENDDATE,V_LIMIT);
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20006,'�Է��Ͻ� ���ǽ��� �ش�Ⱓ�� ��� �Ұ��մϴ�!');
                 ROLLBACK;
    COMMIT;
        
END;


--���ν��� ȣ��
--EXEC PRC_COURSE_INSERT(�����ڵ�, ���ǽǹ�ȣ, ����������, ����������, �������� )
EXEC PRC_COURSE_INSERT('�ۺ���B', 5, TO_DATE('2021-06-01', 'YYYY-MM-DD'), TO_DATE('2021-09-30', 'YYYY-MM-DD'), 25);

--------------------------------------------------------------------------------

--�� ���� ���� ���ν���
-- ���� ������ ������ ���ؼ� ���� ������ �̷������ ���ν���.
-- ������û�� �ڵ� ��ҵǸ�, �������̺� ������ ��ϵ� �����͵� �����ȴ�.
CREATE OR REPLACE PROCEDURE PRC_COURSE_DELETE
(
    V_COUR_CODE    IN TBL_COURSE.COUR_CODE%TYPE
) 
IS 
    CCHECK         VARCHAR2(40);
    USER_DEFINE_ERROR   EXCEPTION;
    
    CURSOR CUR_COUR_REG
    IS
    SELECT REG_CODE 
    FROM TBL_REGIST
    WHERE COUR_CODE = V_COUR_CODE;
    
    V_REG_CODE       TBL_REGIST.REG_CODE%TYPE;
    
BEGIN
    
    SELECT FN_COURSE(COUR_CODE) INTO CCHECK --�ش� ������ ������� Ȯ��
    FROM TBL_COURSE
    WHERE COUR_CODE = V_COUR_CODE; 
    
    IF(CCHECK = '���� ��' OR CCHECK = '���� ����')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --���� ������ ����
    --> �����Ϸ��� ������ ������û�ؼ� �������̺� �ö�� �͵� ����     
    OPEN CUR_COUR_REG;
    
    LOOP
        FETCH CUR_COUR_REG INTO V_REG_CODE;
        
        DELETE
        FROM TBL_GRADE
        WHERE REG_CODE = V_REG_CODE;
    
        EXIT WHEN CUR_COUR_REG%NOTFOUND;
        
    END LOOP;
    
    CLOSE CUR_COUR_REG;

        
    --���� ������ - ������û ���� 
    DELETE
    FROM TBL_REGIST
    WHERE COUR_CODE = V_COUR_CODE;
    
    --���� ������ - �������� ���� 
    DELETE
    FROM TBL_OPSUBJECT
    WHERE COUR_CODE = V_COUR_CODE;
     
    --�������� 
    DELETE
    FROM TBL_COURSE
    WHERE COUR_CODE = V_COUR_CODE;
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20016,'�̹� ������ �����Դϴ�.');
            ROLLBACK;             
END;

--���ν��� ȣ��
--EXEC PRC_COURSE_DELETE(�����ڵ�)

--------------------------------------------------------------------------------

--�� ���� ���� ���ν���
-- ������ ���� ��(��������)�� ���� ���ǽ�,������,������,�������� ��������
-- ������ -> ���ǽ�, ������ ���� 
-- �������� -> ���� �Ұ��� 

-- 1. �����ڵ尡 ��ȿ���� Ȯ��(���̺� �����ϴ��� Ȯ��)
-- 2. ������ ���������� Ȯ��
-- 3. IF ���� ����� ����Ұ� ���� �߻�
--  IF ���������� -> ���氡�� -> IF V_CLASSROOM�� �̿����̸� -> �����߻� 
--  IF ������ -> IF �������� V_�������� �ٸ��� �����߻� -> �����ϸ� ���� �����մϴ�
CREATE OR REPLACE PROCEDURE PRC_COURSE_UPDATE
(    V_COUR_CODE     IN TBL_COURSE.COUR_CODE%TYPE      
,    V_CLASS_CODE    IN TBL_COURSE.CLASS_CODE%TYPE
,    V_STARTDATE     IN TBL_COURSE.STARTDATE%TYPE
,    V_ENDDATE       IN TBL_COURSE.ENDDATE%TYPE
,    V_LIMIT         IN TBL_COURSE.LIMIT%TYPE
) 
IS

    V_SD        TBL_COURSE.STARTDATE%TYPE;
    V_ED        TBL_COURSE.ENDDATE%TYPE;
    CCOUNT      NUMBER; --�Է��� ������ ���̺� ��ȿ������ ���� ���� 
    CCHECK      VARCHAR2(30); --�Է��� ������ �����Ȳ Ȯ���� ���� ���� 
    
    USER_DEFINE_ERROR EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION;
    USER_DEFINE_ERROR3 EXCEPTION;
    USER_DEFINE_ERROR4 EXCEPTION;
    
    CURSOR CUR_SDED_SELECT  -- �����Ϸ��� CLASS_CODE �� ��¥�� ���� 
    IS
    SELECT STARTDATE,ENDDATE
    FROM TBL_COURSE
    WHERE CLASS_CODE = V_CLASS_CODE;
    
    V_CC        TBL_COURSE.COUR_CODE%TYPE;
    
BEGIN
    
    --�Է��� COUR_CODE�� ��ȿ���� Ȯ��
    SELECT COUNT(*) INTO CCOUNT
    FROM TBL_COURSE
    WHERE COUR_CODE = V_COUR_CODE;
    
    IF(CCOUNT = 0) -- ������ ����
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --�Է��� COUR_CODE�� �����Ȳ Ȯ��
    SELECT FN_COURSE(COUR_CODE) INTO CCHECK
    FROM TBL_COURSE
    WHERE COUR_CODE = V_COUR_CODE;
    
    IF(CCHECK = '���� ����') --�̹� ����� �����̸� ���� �Ұ� 
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    SELECT STARTDATE,ENDDATE INTO V_SD,V_ED
    FROM TBL_COURSE
    WHERE COUR_CODE = V_COUR_CODE;
    
    IF(CCHECK = '���� ��')
        THEN
             IF(V_STARTDATE != V_SD) --�������� ������ ���۳�¥�� �ٲ��� ���� 
             THEN RAISE USER_DEFINE_ERROR3;
             END IF;
    END IF;
    
    
     OPEN CUR_SDED_SELECT;
        LOOP
            
            FETCH CUR_SDED_SELECT INTO V_SD,V_ED; --���ǽ��� �Ȱ��� ������ ��¥ �̾Ƴ� 
            
            SELECT COUR_CODE INTO V_CC
            FROM TBL_COURSE
            WHERE STARTDATE= V_SD AND ENDDATE =V_ED;
            
            IF(V_COUR_CODE != V_CC AND 
              ((V_SD <= V_STARTDATE AND V_STARTDATE <= V_ED) OR
               (V_SD <= V_ENDDATE AND V_ENDDATE <= V_ED) OR
                (V_STARTDATE <= V_SD AND V_ENDDATE > V_ED)))
                THEN RAISE USER_DEFINE_ERROR4;
            END IF;
            
            EXIT WHEN CUR_SDED_SELECT%NOTFOUND;
        END LOOP;

    CLOSE CUR_SDED_SELECT;
    
    --����
    UPDATE TBL_COURSE
    SET COUR_CODE = V_COUR_CODE, CLASS_CODE = V_CLASS_CODE
    , STARTDATE = V_STARTDATE, ENDDATE = V_ENDDATE, LIMIT = V_LIMIT
    WHERE COUR_CODE = V_COUR_CODE;
   
    COMMIT;
   
   --����ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20020,'�Է��� �ڵ尡 �������� �ʽ��ϴ�.'); 
                 ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20021,'����� ������ ���� �Ұ��մϴ�!');
                 ROLLBACK;
        WHEN USER_DEFINE_ERROR3
            THEN RAISE_APPLICATION_ERROR(-20022,'�̹� �������� ������ ���۳�¥�� ������ �� �����ϴ�');
                 ROLLBACK;
        WHEN USER_DEFINE_ERROR4
            THEN RAISE_APPLICATION_ERROR(-20006,'�Է��Ͻ� ���ǽ��� �ش�Ⱓ�� ��� �Ұ��մϴ�!');
                 ROLLBACK;

END;

--EXEC PRC_COURSE_UPDATE(�����ڵ�, ���ǽǹ�ȣ, ���۳�¥, ���ᳯ¥, �����ο�)
EXEC PRC_COURSE_UPDATE('������B',2, TO_DATE('2021-09-26','YYYY-MM-DD'), TO_DATE('2021-12-31','YYYY-MM-DD'),15);



--==============================================================================

--���� ������û ���̺� ���� 

--�� ������û �Է� ���ν���
-- ������û�� �̷������, �л��� �����ϴ� ���� ���� ���� ���̺� ���ÿ� ������ �Է�
CREATE OR REPLACE PROCEDURE PRC_REGIST_INSERT
( V_STU_ID      IN TBL_REGIST.STU_ID%TYPE
, V_COUR_CODE   IN TBL_REGIST.COUR_CODE%TYPE
)
IS
    USER_DEFINE_ERROR1   EXCEPTION;
    USER_DEFINE_ERROR2   EXCEPTION;
    USER_DEFINE_ERROR3   EXCEPTION;
    V_REG_CODE          TBL_REGIST.REG_CODE%TYPE;
    
    V2_STU_ID           TBL_REGIST.STU_ID%TYPE;
    V2_COUR_CODE        TBL_REGIST.COUR_CODE%TYPE;
    V_STARTDATE         TBL_COURSE.STARTDATE%TYPE;
    
    --TBL_GRADE �߰��� ���� ��������
    CURSOR CUR_OPSUB_SELECT  --�ش� ������ �ش��ϴ� ����� �̾Ƴ� Ŀ�� 
    IS
    SELECT OPSUB_CODE
    FROM TBL_OPSUBJECT
    WHERE COUR_CODE = V_COUR_CODE;
    
    V_OPSUB_CODE        TBL_OPSUBJECT.OPSUB_CODE%TYPE; --�̾Ƴ� ���� ��Ƴ� ���� 
    V_GRADE_CODE        TBL_GRADE.GRADE_CODE%TYPE; 
    V_LIMIT             TBL_COURSE.LIMIT%TYPE;
    V_LIMIT_NOW         TBL_COURSE.LIMIT%TYPE;
    
BEGIN
    -- ������û �ڵ� �ڵ����� ���� ��ȸ
    SELECT NVL(MAX(REG_CODE),0) INTO V_REG_CODE
    FROM TBL_REGIST;
    
    -- �л� ID ���� ���� ��ȸ
    SELECT (
        SELECT STU_ID
        FROM TBL_STUDENT
        WHERE STU_ID = V_STU_ID) INTO V2_STU_ID
    FROM DUAL;
    
    -- �л� ������ ���ܹ߻�
    IF (V2_STU_ID IS NULL)
        THEN RAISE USER_DEFINE_ERROR1;      
    END IF;
    
    -- ���� ���� ���� ��ȸ
    SELECT (
        SELECT COUR_CODE
        FROM TBL_COURSE
        WHERE COUR_CODE = V_COUR_CODE) INTO V2_COUR_CODE
    FROM DUAL;
       
    -- �ش� ���� ������ ���� �߻�
    IF (V2_COUR_CODE IS NULL)
        THEN RAISE USER_DEFINE_ERROR1;      
    END IF;
    
    -- ��û�Ϸ��� ������ ���� ��¥ ��ȸ
    SELECT STARTDATE INTO V_STARTDATE
    FROM TBL_COURSE
    WHERE COUR_CODE = V2_COUR_CODE;
    
    -- �̹� ���۵� ���� ��û �� ���� �߻�
    IF (V_STARTDATE < SYSDATE)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- �����ο��� �����ο����� ���� ��� ���� �߻�
    SELECT COUNT(*) INTO V_LIMIT_NOW    -- ���� �� ������ �����ϴ� �л� �ο��� 
    FROM TBL_REGIST
    WHERE COUR_CODE = V_COUR_CODE;
    
    SELECT LIMIT INTO V_LIMIT       -- ������ ����
    FROM TBL_COURSE
    WHERE COUR_CODE = V_COUR_CODE;
    
    -- ���� �ο��� ���������� �Ȱ��ٸ�, ���� �� �̻� �ο��߰��� �ȵǴϱ� ���� �߻�
    IF (V_LIMIT_NOW = V_LIMIT )     
        THEN RAISE USER_DEFINE_ERROR3;
    END IF;
    
    -- ������û ���̺� ������ �Է�
    INSERT INTO TBL_REGIST (REG_CODE, STU_ID, COUR_CODE, REG_DATE)
        VALUES (V_REG_CODE+1, V_STU_ID, V_COUR_CODE, SYSDATE);          
               
    -- ������û�� �̷������ �� �Ŀ� ���� ���̺� �������Է��� ���� ������ ���.
    SELECT REG_CODE INTO V_REG_CODE
    FROM TBL_REGIST
    WHERE STU_ID = V_STU_ID 
    AND COUR_CODE = V_COUR_CODE;
    
    --���� ���̺� INSERT 
    OPEN CUR_OPSUB_SELECT;
    
    LOOP
        
        FETCH CUR_OPSUB_SELECT INTO V_OPSUB_CODE; 
            SELECT NVL(MAX(GRADE_CODE),0) INTO V_GRADE_CODE
            FROM TBL_GRADE; 
        EXIT WHEN CUR_OPSUB_SELECT%NOTFOUND;
            INSERT INTO TBL_GRADE(GRADE_CODE,OPSUB_CODE,REG_CODE)
            VALUES (V_GRADE_CODE +1, V_OPSUB_CODE, V_REG_CODE); 
        
    END LOOP;
    
    CLOSE CUR_OPSUB_SELECT;
    
    COMMIT; 
    
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20015,'�л� Ȥ�� ������ �������� �ʽ��ϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20016,'�̹� ������ �����Դϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR3
            THEN RAISE_APPLICATION_ERROR(-20023,'���������� �����ƽ��ϴ�.');
            ROLLBACK;
    
END;

--���ν��� ȣ��
--EXEC PRC_REGIST_INSERT(�л�ID, �����ڵ�)
EXEC PRC_REGIST_INSERT('201402013', '������A');

--==============================================================================

--���� �ߵ��������� ���̺� ����

--�� �ߵ����� �Է� ���ν���
CREATE OR REPLACE PROCEDURE PRC_QUIT_INSERT
( V_REG_CODE    IN TBL_QUIT.REG_CODE%TYPE
, V_REASON      IN TBL_QUIT.REASON%TYPE
, V_QUIT_DATE   IN TBL_QUIT.QUIT_DATE%TYPE
)
IS
    V_QUIT_CODE TBL_QUIT.QUIT_CODE%TYPE;
    V_REG_CODE2 TBL_QUIT.REG_CODE%TYPE;
    V_REG_DATE  TBL_REGIST.REG_DATE%TYPE;
    V_STARTDATE TBL_COURSE.STARTDATE%TYPE;
    V_ENDDATE   TBL_COURSE.ENDDATE%TYPE;
    
    USER_DEFINE_ERROR  EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION;
BEGIN
    -- ������û�ڵ尡 �������� �������
    SELECT REG_CODE, REG_DATE INTO V_REG_CODE2, V_REG_DATE
    FROM TBL_REGIST
    WHERE REG_CODE = V_REG_CODE;
    
    -- ���������� ����������
    SELECT STARTDATE, ENDDATE INTO V_STARTDATE,V_ENDDATE
    FROM TBL_COURSE
    WHERE COUR_CODE = (SELECT COUR_CODE
                       FROM TBL_REGIST
                       WHERE REG_CODE = V_REG_CODE);

    SELECT NVL(MAX(QUIT_CODE),0) INTO V_QUIT_CODE
    FROM TBL_QUIT;
    
    -- �������ڰ� ������û��¥���� ������ ��� ����
    IF (V_QUIT_DATE < V_REG_DATE)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- �������ڰ� ���������Ϻ��� �����̰ų� �������� ������ ��� ����
    IF ((V_QUIT_DATE < V_STARTDATE) OR V_QUIT_DATE > V_ENDDATE)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;    
    
    INSERT INTO TBL_QUIT(QUIT_CODE, REG_CODE, REASON, QUIT_DATE)
    VALUES (V_QUIT_CODE +1, V_REG_CODE, V_REASON, V_QUIT_DATE);
    
    COMMIT; 
    
    EXCEPTION
        
        -- �������ڰ� ������û��¥���� ������ ���
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20009,'�������ڰ� ������û ��¥���� �����Դϴ�.');
            ROLLBACK;
        
        -- �������ڰ� ���������Ϻ��� �����̰ų� �������� ������ ��� ����
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20010,'�������ڰ� ���������� �����̰ų� ���������� �����Դϴ�.');
            ROLLBACK;
        
        -- ������û���̺� ������û�ڵ� ���� X    
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20020, '�Է��� �ڵ尡 �������� �ʽ��ϴ�.');
            ROLLBACK;
            
END;

--���ν��� ȣ��
--EXEC PRC_QUIT_INSERT(������û�ڵ�, ��������, ��������)
EXEC PRC_QUIT_INSERT(2, '����Ŭ�������', SYSDATE);

--------------------------------------------------------------------------------

--�� �ߵ����� ����, ��¥ ���� ���ν���
CREATE OR REPLACE PROCEDURE PRC_QUIT_UPDATE
( V_QUIT_CODE   IN TBL_QUIT.QUIT_CODE%TYPE
, V_REASON      IN TBL_QUIT.REASON%TYPE
, V_QUIT_DATE   IN TBL_QUIT.QUIT_DATE%TYPE
)
IS
    V_REG_CODE  TBL_QUIT.REG_CODE%TYPE;
    V_REG_DATE  TBL_REGIST.REG_DATE%TYPE;
    V_COUR_CODE TBL_COURSE.COUR_CODE%TYPE;
    V_STARTDATE TBL_COURSE.STARTDATE%TYPE;
    V_ENDDATE   TBL_COURSE.ENDDATE%TYPE;
    
    USER_DEFINE_ERROR  EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION;
BEGIN
    -- ������û��, �����ڵ�
    SELECT REG_DATE, COUR_CODE INTO V_REG_DATE, V_COUR_CODE
    FROM TBL_REGIST
    WHERE REG_CODE = (SELECT REG_CODE
                      FROM TBL_QUIT
                      WHERE QUIT_CODE = V_QUIT_CODE);
    
    -- ����������, ������
    SELECT STARTDATE, ENDDATE INTO V_STARTDATE, V_ENDDATE 
    FROM TBL_COURSE
    WHERE COUR_CODE = V_COUR_CODE;

    -- �������ڰ� ������û ��¥���� �����ϰ�� ����
    IF (V_QUIT_DATE < V_REG_DATE)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- �������ڰ� ���������Ϻ��� �����̰ų� �������� ������ ��� ����
    IF ((V_QUIT_DATE < V_STARTDATE) OR (V_QUIT_DATE > V_ENDDATE))
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;

    --UPDATE ������
    UPDATE TBL_QUIT
    SET REASON = V_REASON, QUIT_DATE = V_QUIT_DATE
    WHERE QUIT_CODE = V_QUIT_CODE;
    
    COMMIT; 
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20009,'�������ڰ� ������û ��¥���� �����Դϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20010,'�������ڰ� ���������� �����̰ų� ���������� �����Դϴ�.');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;

--���ν��� ȣ��
--EXEC PRC_QUIT_UPDATE(�ߵ����� �ڵ�, ��������, ��������)
EXEC PRC_QUIT_UPDATE(1, '�Ի糯¥�� ������', TO_DATE('2021-12-29', 'YYYY-MM-DD'));

--==============================================================================

--���� �������� ���̺� ���� 

--�� �������� �Է� ���ν���
-- ������ �Ⱓ�� ���� �ȿ� ���� �Ǿ����
-- ������ �̹� �ٸ� ���� �������̸� ����
CREATE OR REPLACE PROCEDURE PRC_OPSUBJECT_INSERT
( V_COUR_CODE      IN TBL_OPSUBJECT.COUR_CODE%TYPE
, V_SUB_CODE       IN TBL_OPSUBJECT.SUB_CODE%TYPE
, V_PRO_ID         IN TBL_OPSUBJECT.PRO_ID%TYPE
, V_STARTDATE      IN TBL_OPSUBJECT.STARTDATE%TYPE
, V_ENDDATE        IN TBL_OPSUBJECT.ENDDATE%TYPE
)
IS
    V_OPSUB_CODE        TBL_OPSUBJECT.OPSUB_CODE%TYPE; --�������� �ڵ� 
    V_COUR_STARTDATE    TBL_COURSE.STARTDATE%TYPE; --������ ������
    V_COUR_ENDDATE      TBL_COURSE.ENDDATE%TYPE;   --������ ������
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2   EXCEPTION;
    
    CURSOR CUR_SDED_SELECT 
    IS
    SELECT STARTDATE,ENDDATE
    FROM TBL_OPSUBJECT
    WHERE PRO_ID = V_PRO_ID;
    
    V_SD        TBL_OPSUBJECT.STARTDATE%TYPE; --Ŀ���� ���� ������ 
    V_ED        TBL_OPSUBJECT.ENDDATE%TYPE;
    
BEGIN

    SELECT NVL(MAX(OPSUB_CODE),0) INTO V_OPSUB_CODE
    FROM TBL_OPSUBJECT;
    
    SELECT STARTDATE,ENDDATE INTO V_COUR_STARTDATE,V_COUR_ENDDATE
    FROM TBL_COURSE
    WHERE COUR_CODE = V_COUR_CODE;
    
    --���� ��¥�� ���� �ȿ� ���ԵǾ�� �Ѵ� -> �ƴ� �� ����
    IF( (V_STARTDATE < V_COUR_STARTDATE) OR (V_ENDDATE > V_COUR_ENDDATE)
       OR (V_STARTDATE > V_COUR_ENDDATE) )
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --�Է��� ������ �ش糯¥�� �̹� �������̸� ����
     OPEN CUR_SDED_SELECT;
        LOOP
            
            FETCH CUR_SDED_SELECT INTO V_SD,V_ED; --���ǽ��� �Ȱ��� ������ ��¥ �̾Ƴ� 
        
            IF( (V_SD <= V_STARTDATE AND V_STARTDATE <= V_ED) OR
               (V_SD <= V_ENDDATE AND V_ENDDATE <= V_ED) OR
                (V_STARTDATE <= V_SD AND V_ENDDATE > V_ED))
                THEN RAISE USER_DEFINE_ERROR2;
            END IF;
            
            EXIT WHEN CUR_SDED_SELECT%NOTFOUND;
        END LOOP;

    CLOSE CUR_SDED_SELECT;
    
    
    INSERT INTO TBL_OPSUBJECT(OPSUB_CODE,COUR_CODE,SUB_CODE,PRO_ID,ALLOT_CODE,STARTDATE,ENDDATE)
    VALUES (V_OPSUB_CODE +1 , V_COUR_CODE, V_SUB_CODE, V_PRO_ID, NULL,V_STARTDATE, V_ENDDATE);
     
   EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20008,'������ �����Ⱓ�� ���� �Ⱓ ���� ���ԵǾ�� �մϴ�!');
                 ROLLBACK;
        WHEN USER_DEFINE_ERROR2
                THEN RAISE_APPLICATION_ERROR(-20017,'�ش� ������ �ش� ��¥�� �̹� �������Դϴ�!');
                     ROLLBACK;
    
    COMMIT;
END;

--���ν��� ȣ��
--EXEC PRC_OPSUBJECT_INSERT(�����̸�, �����ȣ, ����ID, ���������, ���� ������)

--------------------------------------------------------------------------------

--�� �������� ������ ���� ���ν���
-- �������� UPDATE ���ν��� -> ������ -> �ʿ��� ��� ��� ������ ������ ������ �� �ִ�.
-- �����Ϸ��� ������ �������� ������ ��¥�� ���ؼ� ��ġ�� ���ܹ߻�
CREATE OR REPLACE PROCEDURE PRC_OPSUBJECT_UPDATE
( V_OPSUB_CODE        IN TBL_OPSUBJECT.OPSUB_CODE%TYPE --�������� �ڵ� 
 ,V_PRO_ID            IN TBL_OPSUBJECT.PRO_ID%TYPE --������ ����ID �Ű����� 
)
IS
    
    RESULT            NUMBER; -- �Ű������� ���� ����ID�� �����ϴ��� ���� ���� ���� 
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2   EXCEPTION;
    
    V_STARTDATE     TBL_OPSUBJECT.STARTDATE%TYPE;
    V_ENDDATE       TBL_OPSUBJECT.ENDDATE%TYPE; --�Է¹��� ���������� �ش� ��¥���� ���� 
    
    CURSOR CUR_SDED_SELECT 
    IS
    SELECT STARTDATE,ENDDATE
    FROM TBL_OPSUBJECT
    WHERE PRO_ID = V_PRO_ID;
    
    V_SD        TBL_OPSUBJECT.STARTDATE%TYPE; --Ŀ���� ���� ������ 
    V_ED        TBL_OPSUBJECT.ENDDATE%TYPE;
    
    
BEGIN
    
    --�Է��� ����ID�� ���� ���̺� ������...
    SELECT COUNT(*) INTO RESULT
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;
    
    IF(RESULT = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    SELECT STARTDATE,ENDDATE INTO V_STARTDATE,V_ENDDATE
    FROM TBL_OPSUBJECT
    WHERE OPSUB_CODE = V_OPSUB_CODE;
    
     OPEN CUR_SDED_SELECT;
        LOOP
            
            FETCH CUR_SDED_SELECT INTO V_SD,V_ED; --���ǽ��� �Ȱ��� ������ ��¥ �̾Ƴ� 
        
            IF( (V_SD <= V_STARTDATE AND V_STARTDATE <= V_ED) OR
               (V_SD <= V_ENDDATE AND V_ENDDATE <= V_ED) OR
                (V_STARTDATE <= V_SD AND V_ENDDATE > V_ED))
                THEN RAISE USER_DEFINE_ERROR2;
            END IF;
            
            EXIT WHEN CUR_SDED_SELECT%NOTFOUND;
        END LOOP;

    CLOSE CUR_SDED_SELECT;
    
    
    --UPDATE ���� 
    UPDATE TBL_OPSUBJECT
    SET PRO_ID = V_PRO_ID
    WHERE OPSUB_CODE = V_OPSUB_CODE; 
    
    COMMIT;
    
   EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20004,'���̵� �������� �ʽ��ϴ�.');
                 ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20017,'�ش� ������ �ش� ��¥�� �̹� �������Դϴ�!');
                 ROLLBACK;
END;

--���ν��� ȣ��
--EXEC PRC_OPSUBJECT_UPDATE(���������ڵ�, ����ID);
EXEC PRC_OPSUBJECT_UPDATE(10013,'hjkim');

--------------------------------------------------------------------------------

--�� �������� ���� ���� ���ν���
CREATE OR REPLACE PROCEDURE PRC_OPSUB_ALLOT_UPDATE
( V_PRO_ID            IN TBL_OPSUBJECT.PRO_ID%TYPE     --������ ����ID 
 ,V_OPSUB_CODE        IN TBL_OPSUBJECT.OPSUB_CODE%TYPE --�������� �ڵ�
 ,V_ALLOT_CODE        IN TBL_OPSUBJECT.ALLOT_CODE%TYPE --������ ����
)
IS
    RESULT            NUMBER;
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2   EXCEPTION;
    
BEGIN
    
    --���� �Ϸ��� ���� ID + ���� �����Ͱ� �ִ��� Ȯ��  
    SELECT COUNT(*) INTO RESULT
    FROM TBL_OPSUBJECT
    WHERE PRO_ID = V_PRO_ID AND OPSUB_CODE = V_OPSUB_CODE;
    
    IF(RESULT =0) --������ ���� 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --�Է��Ϸ��� ������ ���� �����Ͱ� �ִ��� Ȯ�� 
    SELECT COUNT(*) INTO RESULT  
    FROM TBL_ALLOT
    WHERE ALLOT_CODE = V_ALLOT_CODE;
    
    IF(RESULT =0) --������ ���� 
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    --UPDATE ���� 
    UPDATE TBL_OPSUBJECT
    SET ALLOT_CODE = V_ALLOT_CODE
    WHERE OPSUB_CODE = V_OPSUB_CODE; 
    
   EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20018,'���� Ȥ�� ������ ��ȿ���� �ʽ��ϴ�!');
                 ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20019,'�ش� ���� ������ �������� �ʽ��ϴ�!');
                 ROLLBACK;
END;

--���ν��� ȣ��
--EXEC PRC_OPSUB_ALLOT_UPDATE(����ID, ���������ڵ�, �����ڵ�)
EXEC PRC_OPSUB_ALLOT_UPDATE('jhlim', 10003, 1);

--------------------------------------------------------------------------------

--�� �������� ���� ���ν���
--�������� ���� => �� �ش� ������ �������̸� �� ���� , ���� ���̸� �� ���� 
--������ �����ϸ� �ش� ������ �ö��ִ� ������û�� �����ؾ���
CREATE OR REPLACE PROCEDURE PRC_OPSUB_DELETE
(
    V_OPSUB_CODE    TBL_OPSUBJECT.OPSUB_CODE%TYPE
) 
IS 
    CCHECK         VARCHAR2(40); --���� ����Ȯ�� ���� 
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    
    SELECT FN_COURSE(COUR_CODE) INTO CCHECK
    FROM TBL_OPSUBJECT
    WHERE OPSUB_CODE = V_OPSUB_CODE;
    
    IF(CCHECK = '������' OR CCHECK = '���� ����')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --�ڽ� ���� ����
    DELETE
    FROM TBL_GRADE
    WHERE OPSUB_CODE = V_OPSUB_CODE;
     
    --������� 
    DELETE
    FROM TBL_OPSUBJECT
    WHERE OPSUB_CODE = V_OPSUB_CODE;
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20016,'�̹� ������ �����Դϴ�.');
            ROLLBACK;
            
END;

--���ν��� ȣ��
--EXEC PRC_OPSUB_DELETE(�������� �ڵ�)

--==============================================================================

--���� ���� ���̺� ����  

--�� ���� �Է� ���ν���
-- ������ ����ó���ϴ� ���ν��� -> �⺻���� �����ϹǷ� UPDATE
CREATE OR REPLACE PROCEDURE PRC_GRADE_UPDATE
( V_GRADE_CODE   IN TBL_GRADE.GRADE_CODE%TYPE   
, V_ATTEND       IN TBL_GRADE.ATTEND%TYPE
, V_PRACTICE     IN TBL_GRADE.PRACTICE%TYPE
, V_WRITTEN      IN TBL_GRADE.WRITTEN%TYPE
)
IS
    RESULT  NUMBER;
    USER_DEFINE_ERROR   EXCEPTION;    
BEGIN
    --���� ���̺��� �����ڵ尡 �����ϴ��� ��ȸ
    SELECT COUNT(*) INTO RESULT  
    FROM TBL_GRADE
    WHERE GRADE_CODE = V_GRADE_CODE;
    
    IF(RESULT =0) --������ ���� 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- UPDATE ������ ���� -> �������̺��� 
    UPDATE TBL_GRADE
    SET ATTEND =V_ATTEND , WRITTEN = V_WRITTEN , PRACTICE = V_PRACTICE
    WHERE GRADE_CODE = V_GRADE_CODE; 
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20020,'�Է��� �ڵ尡 �������� �ʽ��ϴ�.');
                 ROLLBACK;
    COMMIT;
END;

-- ���ν��� ȣ��
--EXEC PRC_GRADE_UPDATE(�����ڵ�, �������, �Ǳ�����, �ʱ�����);
EXEC PRC_GRADE_UPDATE(1, 100, 80, 90);
