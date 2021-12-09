SELECT USER
FROM DUAL;
--==>> SCOTT


--�� TBL_�԰� ���̺��� �԰������ ����(����)�ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� ��: PRC_�԰�_UPDATE(�԰��ȣ, �������԰����);

--�� TBL_��� ���̺��� �������� �����ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� ��: PRC_���_DELETE(����ȣ);

--�� TBL_�԰� ���̺��� �԰������ �����ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� ��: PRC_�԰�_DELETE(�԰��ȣ);

--------------------------------------------------------------------------------

--�� TBL_�԰� ���̺��� �԰������ ����(����)�ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� ��: PRC_�԰�_UPDATE(�԰��ȣ, �������԰����);

CREATE OR REPLACE PROCEDURE PRC_�԰�_UPDATE
( 
  V_�԰��ȣ        IN TBL_�԰�.�԰��ȣ%TYPE
, V_�������԰����  IN TBL_�԰�.�԰����%TYPE
)

IS
    V_������         TBL_��ǰ.������%TYPE;
    V_�����԰����     TBL_�԰�.�԰����%TYPE;
    V_��ǰ�ڵ�          TBL_�԰�.��ǰ�ڵ�%TYPE;

    USER_DIFINE_ERROR   EXCEPTION;
    
BEGIN
    --�� ������ ������ �� �ֱ�
    SELECT �԰����, ��ǰ�ڵ� INTO V_�����԰����, V_��ǰ�ڵ�
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;

    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;

    --�� ���ν��� ���࿩�� �Ǵ�
    IF (V_������ - V_�����԰���� + V_�������԰���� < 0)
        THEN RAISE USER_DIFINE_ERROR;
    END IF;
    
    --�� UPDATE
    UPDATE TBL_�԰�
    SET �԰���� = V_�������԰����
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    UPDATE TBL_��ǰ
    SET ������ = ������ - V_�����԰���� + V_�������԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;

    --�� COMMIT
    COMMIT;
    
    --�� ����ó��
    EXCEPTION
        WHEN USER_DIFINE_ERROR 
            THEN RAISE_APPLICATION_ERROR(-20003, '��� �����մϴ�.');
                 ROLLBACK;
        WHEN OTHERS 
            THEN ROLLBACK;
END;
--==>> Procedure PRC_�԰�_UPDATE��(��) �����ϵǾ����ϴ�.



--�� TBL_��� ���̺��� �������� �����ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� ��: PRC_���_DELETE(����ȣ);

CREATE OR REPLACE PROCEDURE PRC_���_DELETE
( 
  V_����ȣ  IN TBL_���.����ȣ%TYPE
)

IS 
    V_��ǰ�ڵ�  TBL_���.��ǰ�ڵ�%TYPE;
    V_������  TBL_���.������%TYPE;

BEGIN    
    --�� ������ ������ �� �ֱ�
    SELECT ��ǰ�ڵ�, ������ INTO V_��ǰ�ڵ�, V_������
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;


    --�� DELECT, UPDATE
    DELETE
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --�� COMMIT
    COMMIT;

    --�� EXCEPTION
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
END;
--==>> Procedure PRC_���_DELETE��(��) �����ϵǾ����ϴ�.



--�� TBL_�԰� ���̺��� �԰������ �����ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� ��: PRC_�԰�_DELETE(�԰��ȣ);

CREATE OR REPLACE PROCEDURE PRC_�԰�_DELETE
(
  V_�԰��ȣ    IN TBL_�԰�.�԰��ȣ%TYPE
)
IS
    V_��ǰ�ڵ�        TBL_�԰�.��ǰ�ڵ�%TYPE;
    V_�԰����        TBL_�԰�.�԰����%TYPE;
    V_������        TBL_��ǰ.������%TYPE;
    
    USER_DIFINE_ERROR   EXCEPTION;

BEGIN
    --�� ������ ������ �� �ֱ�
    SELECT ��ǰ�ڵ�, �԰���� INTO V_��ǰ�ڵ�, V_�԰����
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;


    --�� ���ν��� ���࿩�� �Ǵ�
    IF(V_������ < V_�԰����)
        THEN RAISE USER_DIFINE_ERROR;
    END IF;   


    --�� DELETE, UPDATE
    DELETE
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    UPDATE TBL_��ǰ
    SET ������ = ������ - V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    
    --�� Ŀ��
    COMMIT;
    
    
    --�� ����ó��
    EXCEPTION
        WHEN USER_DIFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003, '��� �����մϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_�԰�_DELETE��(��) �����ϵǾ����ϴ�.


--------------------------------------------------------------------------------

--���� CURSOR(Ŀ��) ����--

-- 1. ����Ŭ���� �ϳ��� ���ڵ尡 �ƴ� ���� ���ڵ�� ������ �۾� ��������
--    SQL ���� �����ϰ� �� �������� �߻��� ������ �����ϱ� ���Ͽ�
--    Ŀ��(CURSOR)�� ����ϸ�, Ŀ������ �Ͻ��� Ŀ���� ����� Ŀ���� �ִ�.

-- 2. �Ͻ��� Ŀ���� ��� SQL ���� �����ϸ�,
--    SQL �� ���� �� ���� �ϳ��� ��(ROW)�� ����ϰ� �ȴ�.
--    �׷��� SQL ���� ������ �����(RESULT SET)��
--    ���� ��(ROW)�� ������ ���
--    Ŀ��(CURSOR)�� ��������� �����ؾ� ���� ��(ROW)�� �ٷ� �� �ִ�.

SET SERVEROUTPUT ON;
--==>> �۾��� �Ϸ�Ǿ����ϴ�.

--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� ��)
DECLARE 
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA
    WHERE NUM=1001;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ', ' || V_TEL);
END;
--==>> ȫ�浿, 011-2356-4528


--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� ��)
DECLARE 
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ', ' || V_TEL);
END;
--==>> ���� �߻�
/*
ORA-01422: exact fetch returns more than requested number of rows
*/


--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� ��)
-- [���� Ǯ��]
DECLARE 
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    
    N       TBL_INSA.NUM%TYPE;
    N1      TBL_INSA.NUM%TYPE;
    N2      TBL_INSA.NUM%TYPE;
BEGIN
    SELECT MIN(NUM) INTO N1
    FROM TBL_INSA;    
    SELECT MAX(NUM) INTO N2
    FROM TBL_INSA;

    FOR N IN N1..N2 LOOP
        SELECT NAME, TEL INTO V_NAME, V_TEL
        FROM TBL_INSA
        WHERE NUM = N;
        
        DBMS_OUTPUT.PUT_LINE(V_NAME || ', ' || V_TEL);
    END LOOP;
END;


-- [�Բ� Ǯ��]
DECLARE 
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    
    V_NUM   TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL INTO V_NAME, V_TEL
        FROM TBL_INSA
        WHERE NUM = V_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_NAME || ', ' || V_TEL);
        
        EXIT WHEN V_NUM >= 1062;
        
        V_NUM := V_NUM + 1;
    END LOOP;
END;

--==>>
/*
ȫ�浿, 011-2356-4528
�̼���, 010-4758-6532
�̼���, 010-4231-1236
������, 019-5236-4221
�Ѽ���, 018-5211-3542
�̱���, 010-3214-5357
����ö, 011-2345-2525
�迵��, 016-2222-4444
������, 019-1111-2222
������, 011-3214-5555
������, 010-8888-4422
���ѱ�, 018-2222-4242
���̼�, 019-6666-4444
Ȳ����, 010-3214-5467
������, 016-2548-3365
�̻���, 010-4526-1234
�����, 010-3254-2542
�̼���, 018-1333-3333
�ڹ���, 017-4747-4848
������, 011-9595-8585
ȫ�泲, 011-9999-7575
�̿���, 017-5214-5282
���μ�, 
�踻��, 011-5248-7789
�����, 010-4563-2587
�����, 010-2112-5225
�迵��, 019-8523-1478
�̳���, 016-1818-4848
�踻��, 016-3535-3636
������, 019-6564-6752
����ȯ, 019-5552-7511
�ɽ���, 016-8888-7474
��̳�, 011-2444-4444
������, 011-3697-7412
������, 
���翵, 011-9999-9999
�ּ���, 011-7777-7777
���μ�, 010-6542-7412
�����, 010-2587-7895
�ڼ���, 016-4444-7777
�����, 016-4444-5555
ä����, 011-5125-5511
��̿�, 016-8548-6547
����ȯ, 011-5555-7548
ȫ����, 011-7777-7777
����, 017-3333-3333
�긶��, 018-0505-0505
�̱��, 
�̹̼�, 010-6654-8854
�̹���, 011-8585-5252
�ǿ���, 011-5555-7548
�ǿ���, 010-3644-5577
��̽�, 011-7585-7474
����ȣ, 016-1919-4242
���ѳ�, 016-2424-4242
������, 010-7549-8654
�̹̰�, 016-6542-7546
�����, 010-2415-5444
�Ӽ���, 011-4151-4154
��ž�, 011-4151-4444
�̴ٿ�, 010-4113-2353
������, 010-6331-3939


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

CREATE TABLE ���̺��
CREATE USER ������
CREATE INDEX �ε�����
CREATE SEQUENCE ��������


--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� ��)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    
    -- Ŀ�� �̿��� ���� Ŀ�� ���� ����(�� Ŀ�� ����)  CHECK~!!!
    CURSOR CUR_INSA_SELECT
    IS 
    SELECT NAME, TEL
    FROM TBL_INSA;
    
BEGIN    
    -- Ŀ�� ����
    OPEN CUR_INSA_SELECT;
    
    -- Ŀ�� ���� �� ����������� �����͵� ó��(��Ƴ���)
    LOOP
        -- �� �� �� �� ������� �������� ���� �� ��FETCH��
        FETCH CUR_INSA_SELECT INTO V_NAME, V_TEL;
        
        -- �ݺ��� ���������� ������...
        -- Ŀ���κ��� �ƹ� �͵� ã�� ������ ��...
        EXIT WHEN CUR_INSA_SELECT%NOTFOUND;
        
        -- ���
        DBMS_OUTPUT.PUT_LINE(V_NAME || ', ' || V_TEL);    
    END LOOP;
    
    -- Ŀ�� Ŭ����
    CLOSE CUR_INSA_SELECT;
END;

-- CURSOR CUR_INSA_SELECT�� ����ΰ� �Ʒ��� ����.
-- ��, �̷��� ���ǵ� Ŀ���� ����� �Ͱ� ����!
SELECT NAME, TEL
FROM TBL_INSA;
--==>>
/*
ȫ�浿	011-2356-4528
�̼���	010-4758-6532
�̼���	010-4231-1236
������	019-5236-4221
�Ѽ���	018-5211-3542
�̱���	010-3214-5357
����ö	011-2345-2525
�迵��	016-2222-4444
������	019-1111-2222
������	011-3214-5555
������	010-8888-4422
���ѱ�	018-2222-4242
���̼�	019-6666-4444
Ȳ����	010-3214-5467
������	016-2548-3365
�̻���	010-4526-1234
�����	010-3254-2542
�̼���	018-1333-3333
�ڹ���	017-4747-4848
������	011-9595-8585
ȫ�泲	011-9999-7575
�̿���	017-5214-5282
���μ�	
�踻��	011-5248-7789
�����	010-4563-2587
�����	010-2112-5225
�迵��	019-8523-1478
�̳���	016-1818-4848
�踻��	016-3535-3636
������	019-6564-6752
����ȯ	019-5552-7511
�ɽ���	016-8888-7474
��̳�	011-2444-4444
������	011-3697-7412
������	
���翵	011-9999-9999
�ּ���	011-7777-7777
���μ�	010-6542-7412
�����	010-2587-7895
�ڼ���	016-4444-7777
�����	016-4444-5555
ä����	011-5125-5511
��̿�	016-8548-6547
����ȯ	011-5555-7548
ȫ����	011-7777-7777
����	017-3333-3333
�긶��	018-0505-0505
�̱��	
�̹̼�	010-6654-8854
�̹���	011-8585-5252
�ǿ���	011-5555-7548
�ǿ���	010-3644-5577
��̽�	011-7585-7474
����ȣ	016-1919-4242
���ѳ�	016-2424-4242
������	010-7549-8654
�̹̰�	016-6542-7546
�����	010-2415-5444
�Ӽ���	011-4151-4154
��ž�	011-4151-4444
�̴ٿ�	010-4113-2353
������	010-6331-3939
*/


--------------------------------------------------------------------------------

--���� TRIGGER(Ʈ����) ����--

-- �������� �ǹ�: ��Ƽ�. �˹߽�Ű��. �߱��ϴ�. �����ϴ�.

-- 1. TRIGGER(Ʈ����)�� DML �۾� ��, INSERT, UPDATE, DELETE �۾��� �Ͼ ��
--    �ڵ������� ����Ǵ�(���ߵǴ�, �˹ߵǴ�) ��ü��
--    �̿� ���� Ư¡�� �����Ͽ�(�ΰ�����) DML TRIGGER ��� �θ��⵵ �Ѵ�.
--    TRIGGER �� ������ ���Ἲ �� �ƴ϶�
--    ������ ���� �۾����� �θ� ���ȴ�.

-- �ڵ����� �Ļ��� �� �� ����
-- �߸��� Ʈ����� ����
-- ������ ���� ���� ���� ����
-- �л� �����ͺ��̽� ��� �󿡼� ���� ���Ἲ ���� ���� (�� �߸��� Ʈ����� ����)
-- ������ ���� ��Ģ ���� ���� (�� ������ ���� ���� ���� ����)
-- ������ �̺�Ʈ �α� ���� (�α�: �α׸� ����� ��)
-- ������ ���� ����
-- ���� ���̺� ���� �������� (���� ���̺�: A�� �ǵ帱 �� B���� ������ ��ħ)
-- ���̺� �׼��� ��� ����

-- 2. TRIGGER �������� COMMIT, ROLLBACK ���� ����� �� ����.

-- 3. Ư¡ �� ����
-- BEFORE STATEMENT TRIGGER
-- SQL ������ ����Ǳ� ���� �� ���忡 ���� �� �� ����

-- BEFORE ROW TRIGGER
-- SQL ������ ����Ǳ� ����(DML �۾��� �����ϱ� ����)
-- �� ��(ROW)�� ���� �� ���� ����

-- AFTER STATEMENT TRIGGER
-- SQL ������ ����� �� �� ���忡 ���� �� �� ����

-- AFTER ROW TRIGGER
-- SQL ������ ����� �Ŀ�(DML �۾��� ������ �Ŀ�)
-- �� ��(ROW)�� ���� �� ���� ����

-- 4. ���� �� ����
/*
CREATE [OR REPLACE] TIGGER Ʈ���Ÿ�
    [BEFORE] | [AFTER]
    �̺�Ʈ1 [OR �̺�Ʈ2 [OR �̺�Ʈ3]] ON ���̺��
    [FOR EACH ROW [WHEN TRIGGER ����]]
[DECLARE]
    -- ���� ����;
BEGIN
    -- ���� ����;
END;    
*/

--���� AFTER STATEMENT TRIGGER ��Ȳ �ǽ� ����--
--�� DML �۾��� ���� �̺�Ʈ ���

-- TBL_TEST1 / TBL_EVENTOG

--�� TRIGGER(Ʈ����) ����(TRG_EVENTLOG)
CREATE OR REPLACE TRIGGER TRG_EVEBTLOG
            AFTER
            INSERT OR UPDATE OR DELETE ON TBL_TEST1     -- CHECK~!!!
DECLARE
BEGIN
    -- �̺�Ʈ ���� ����(���ǹ��� ���� �б�)
    IF (INSERTING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO) 
            VALUES('INSERT �������� ����Ǿ����ϴ�.');
    ELSIF (UPDATING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO) 
            VALUES('UPDATE �������� ����Ǿ����ϴ�.');
    ELSIF (DELETING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO) 
            VALUES('DELETE �������� ����Ǿ����ϴ�.');
    END IF;
    
    --COMMIT;
    -- �� TRIGGER �������� COMMIT ���� ��� �Ұ�~!!! CHECK~!!!
END;    
--==>> Trigger TRG_EVEBTLOG��(��) �����ϵǾ����ϴ�.


--���� BEFORE STATEMENT TRIGGER ��Ȳ �ǽ� ����--
--�� DML �۾� ���� ���� �۾� ���� ���� Ȯ��
--   (���� ��å ���� / ���� ��Ģ ����)

--�� TRIGGER(Ʈ����) �ۼ� (TRG_TEST1_DML)
CREATE OR REPLACE TRIGGER TRG_TEST1_DML
            BEFORE
            INSERT OR UPDATE OR DELETE ON TBL_TEST1
-- DECLARE (���� ����)
BEGIN
    -- ���� Ȯ�� �� �۾� ���� ���� �Ǵ�
--  IF (�ð��� ���� 8�� �����̰ų�... ���� 6�� ���Ķ��...)
--      THEN �۾��� ���� ���ϵ��� ó���ϰڴ�.
    IF ( TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 8 
         OR TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17)
        THEN RAISE_APPLICATION_ERROR(-20003, '�۾��� 8:00 ~ 18:00 ������ �����մϴ�.');
    END IF;
END;    
--==>> Trigger TRG_TEST1_DML��(��) �����ϵǾ����ϴ�.
-- SYSDATE�� Ŭ���̾�Ʈ�� �ƴ϶� '����' �����̴�.







