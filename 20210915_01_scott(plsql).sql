SELECT USER
FROM DUAL;
--==>> SCOTT



--���� FUNCTION (�Լ�) ���� --

-- 1. �Լ��� �ϳ� �̻��� PL/SQL ������ ������ �����ƾ����
--    �ڵ带 �ٽ� ����� �� �ֵ��� ĸ��ȭ �ϴµ� ���ȴ�.
--    ����Ŭ������ ����Ŭ�� ���ǵ� �⺻ ���� �Լ��� ����ϰų�
--    ���� ������ �Լ��� ���� �� �ִ�. (�� ����� ���� �Լ�)
--    �� ����� ���� �Լ��� �ü�ƴ �Լ�ó�� �������� ȣ���ϰų�
--    ���� ���ν���ó�� EXEXCUTE ���� ���� ������ �� �ִ�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] FUNCTION �Լ���
[(
    �Ű�����1 �ڷ���
  , �Ű�����2 �ڷ���
)]
RETURN ������Ÿ��
IS
    -- �ֿ� ���� ����(��������)
BEGIN
    -- ���๮
    ...
    RETURN (��);
    
    [EXCEPTION]
        -- ���� ó�� ����;
END;
*/

--�� ����� ���� �Լ�(������ �Լ�)��
--   IN �Ķ����(�Է� �Ű�����)�� ����� �� ������
--   �ݵ�� ��ȯ�� ���� ������Ÿ���� RETRUN ���� �����ؾ� �ϰ�,
--   FUNCTION �� �ݵ�� ���� ���� ��ȯ�Ѵ�.


--�� TBL_INSA ���̺���
--   �ֹε�Ϲ�ȣ�� ������ ������ ��ȸ�Ѵ�.

SELECT *
FROM TBL_INSA;

SELECT NAME, SSN, DECODE( SUBSTR(SSN, 8 , 1), '1', '����', '2', '����', 'Ȯ�κҰ�' ) "����"
FROM TBL_INSA;

/*
         �� �ֹε�Ϲ�ȣ
        \  /
    ----    ---------
    |               |
    ------------    -
                /  \
                 �� ����
*/

--�� FUNCTION ����
-- �Լ���: FN_GENDER()
--                  �� SSN(�ֹε�Ϲ�ȣ) �� 'YYMMDD-NNNNNNN'

CREATE OR REPLACE FUNCTION FN_GENDER
( VSSN  VARCHAR2     -- �Ű�����: �ڸ���(����) ���� ����
)
RETURN VARCHAR2      -- ��ȯ �ڷ���: �ڸ���(����) ���� ����
IS
    -- �ֿ� ���� ����
    VRESULT VARCHAR2(20);
BEGIN
    -- ���� �� ó��
    IF ( SUBSTR(VSSN, 8, 1) IN ('1', '3') )
        THEN VRESULT := '����';
    ELSIF ( SUBSTR(VSSN, 8, 1) IN ('2', '4') )
        THEN VRESULT := '����';
    ELSE 
        VRESULT := '����Ȯ�κҰ�';
    END IF;
    
    -- ���� ����� ��ȯ
    RETURN VRESULT;
END;
--==>> Function FN_GENDER��(��) �����ϵǾ����ϴ�.


--�� ������ ���� �� ���� �Ű�����(�Է� �Ķ����)�� �Ѱܹ޾�
--   A�� B ���� ���� ��ȯ�ϴ� ����� ���� �Լ��� �ۼ��Ѵ�.
--   �Լ���: FN_POW()
/*
��� ��)
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000
*/

-- [���� Ǯ��]
CREATE OR REPLACE FUNCTION FN_POW
( NUM1      NUMBER
, NUM2      NUMBER
)
RETURN NUMBER
IS
    -- �ֿ� ���� ����
    RESULT  NUMBER  := 1;
    CNT     NUMBER  := 0;
BEGIN    
    -- ���๮
    FOR CNT IN 1 .. NUM2 LOOP
        RESULT := RESULT * NUM1;
    END LOOP;
    
    -- ���� ����� ��ȯ
    RETURN RESULT;
END;


-- [�Բ� Ǯ��]
CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER)
RETURN NUMBER
IS
    V_RESULT  NUMBER  := 1;   -- ������
    V_NUM     NUMBER;
BEGIN    
    FOR V_NUM IN 1 .. B LOOP
        V_RESULT := V_RESULT * A;
    END LOOP;
    
    -- CHECK~!!!
    RETURN V_RESULT;
END;
--==>> Function FN_POW��(��) �����ϵǾ����ϴ�.



--�� ����
-- TBL_INSA ���̺��� �޿� ��� ���� �Լ��� �����Ѵ�.
-- �޿��� ��(�⺻��*12)+���硻�� ������� ������ �����Ѵ�.
-- �Լ���: FN_PAY(�⺻��, ����)
CREATE OR REPLACE FUNCTION FN_PAY(BASIC NUMBER, SUDANG NUMBER)
RETURN NUMBER
IS
    V_RESULT NUMBER;
BEGIN
    V_RESULT := BASIC*12 + NVL(SUDANG, 0);
    
    RETURN V_RESULT;
END;
--==>> Function FN_PAY��(��) �����ϵǾ����ϴ�.

-- Ȯ��
SELECT NAME, BASICPAY, SUDANG, FN_PAY(BASICPAY, SUDANG) "�޿�"
FROM TBL_INSA;
--==>> 
/*
ȫ�浿	2610000	200000	31520000
�̼���	1320000	200000	16040000
�̼���	2550000	160000	30760000
������	1954200	170000	23620400
�Ѽ���	1420000	160000	17200000
�̱���	2265000	150000	27330000
����ö	1250000	150000	15150000
�迵��	950000	145000	11545000
������	840000	220400	10300400
������	2540000	130000	30610000
������	1020000	140000	12380000
���ѱ�	880000	114000	10674000
���̼�	1601000	103000	19315000
Ȳ����	1100000	130000	13330000
������	1050000	104000	12704000
�̻���	2350000	150000	28350000
�����	950000	210000	11610000
�̼���	880000	123000	10683000
�ڹ���	2300000	165000	27765000
������	880000	140000	10700000
ȫ�泲	875000	120000	10620000
�̿���	1960000	180000	23700000
���μ�	2500000	170000	30170000
�踻��	1900000	170000	22970000
�����	1100000	160000	13360000
�����	1050000	150000	12750000
�迵��	2340000	170000	28250000
�̳���	892000	110000	10814000
�踻��	920000	124000	11164000
������	2304000	124000	27772000
����ȯ	2450000	160000	29560000
�ɽ���	880000	108000	10668000
��̳�	1020000	104000	12344000
������	1100000	160000	13360000
������	1050000	140000	12740000
���翵	960400	190000	11714800
�ּ���	2350000	187000	28387000
���μ�	2000000	150000	24150000
�����	2010000	160000	24280000
�ڼ���	2100000	130000	25330000
�����	2300000	150000	27750000
ä����	1020000	200000	12440000
��̿�	1100000	210000	13410000
����ȯ	1060000	220000	12940000
ȫ����	960000	152000	11672000
����	2650000	150000	31950000
�긶��	2100000	112000	25312000
�̱��	2050000	106000	24706000
�̹̼�	1300000	130000	15730000
�̹���	1950000	103000	23503000
�ǿ���	2260000	104000	27224000
�ǿ���	1020000	105000	12345000
��̽�	960000	108000	11628000
����ȣ	980000	114000	11874000
���ѳ�	1000000	104000	12104000
������	1950000	200000	23600000
�̹̰�	2520000	160000	30400000
�����	1950000	180000	23580000
�Ӽ���	890000	102000	10782000
��ž�	900000	102000	10902000
*/


--�� ����
-- TBL_INSA ���̺��� �Ի����� ��������
-- ��������� �ٹ������ ��ȯ�ϴ� �Լ��� �����Ѵ�.
-- ��, �ٹ������ �Ҽ��� ���� ���ڸ����� ����Ѵ�.
-- �Լ���: FN_WORKYEAR(�Ի���)
-- ��: 12.5��, 13.6��
CREATE OR REPLACE FUNCTION FN_WORKYEAR(I DATE)
RETURN NUMBER
IS
    V_RESULT NUMBER;
BEGIN
    V_RESULT := ROUND(MONTHS_BETWEEN(SYSDATE, I)/12, 1);
    
    RETURN V_RESULT;
END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.

-- Ȯ��
SELECT NAME, IBSADATE, FN_WORKYEAR(IBSADATE) "�ٹ����"
FROM TBL_INSA;
--==>>
/*
ȫ�浿	1998-10-11	22.9
�̼���	2000-11-29	20.8
�̼���	1999-02-25	22.6
������	2000-10-01	21
�Ѽ���	2004-08-13	17.1
�̱���	2002-02-11	19.6
����ö	1998-03-16	23.5
�迵��	2002-04-30	19.4
������	2003-10-10	17.9
������	1997-08-08	24.1
������	2000-07-07	21.2
���ѱ�	1999-10-16	21.9
���̼�	1998-06-07	23.3
Ȳ����	2002-02-15	19.6
������	1999-07-26	22.1
�̻���	2001-11-29	19.8
�����	2000-08-28	21.1
�̼���	2004-08-08	17.1
�ڹ���	1999-12-10	21.8
������	2003-10-10	17.9
ȫ�泲	2001-09-07	20
�̿���	2003-02-25	18.6
���μ�	1995-02-23	26.6
�踻��	1999-08-28	22.1
�����	2000-10-01	21
�����	2002-08-28	19.1
�迵��	2000-10-18	20.9
�̳���	2001-09-07	20
�踻��	2000-09-08	21
������	1999-10-17	21.9
����ȯ	2001-01-21	20.7
�ɽ���	2000-05-05	21.4
��̳�	1998-06-07	23.3
������	2005-09-26	16
������	2002-05-16	19.3
���翵	2003-08-10	18.1
�ּ���	1998-10-15	22.9
���μ�	1999-11-15	21.8
�����	2003-12-28	17.7
�ڼ���	2000-09-10	21
�����	2001-12-10	19.8
ä����	2003-10-17	17.9
��̿�	2003-09-24	18
����ȯ	2004-01-21	17.7
ȫ����	2003-03-16	18.5
����	1999-05-04	22.4
�긶��	2001-07-15	20.2
�̱��	2001-06-07	20.3
�̹̼�	2000-04-07	21.4
�̹���	2003-06-07	18.3
�ǿ���	2000-06-04	21.3
�ǿ���	2000-10-10	20.9
��̽�	1999-12-12	21.8
����ȣ	1999-10-16	21.9
���ѳ�	2004-06-07	17.3
������	2004-08-13	17.1
�̹̰�	1998-02-11	23.6
�����	2003-08-08	18.1
�Ӽ���	2001-10-10	19.9
��ž�	2001-10-10	19.9
*/

--------------------------------------------------------------------------------

--�� ����
-- 1. INSERT, UPDATE, DELETE, (MERGE)   �� �߰�, ����, ����, (����)
--==>> DML(Data Manipulation Language)
-- COMMIT / ROLLBACK �� �ʿ��ϴ�.

-- 2. CREATE, DROP, ALTER, (TRUNCATE)   �� ����, ����, ����, (�߶󳻱�)
--==>> DDL(Data Definition Language)     �� ������ ���Ǿ�
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 3. GRANT, REVOKE
--==>> DCL(Data Control Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

--4. COMMIT, ROLLBACK
--==>> TCL(Transaction Control Language)

-- ���� PL/SQL�� �� DML��, TCL���� ��� �����ϴ�.
-- ���� PL/SQL�� �� DML��, DDL��, DCL��, TCL�� ��� �����ϴ�.

--------------------------------------------------------------------------------

--���� PROCEDURE(���ν���) ����--

-- 1. PL/SQL ���� ���� ��ǥ���� ������ ������ ���ν�����
--    �����ڰ� ���� �ۼ��ؾ� �ϴ� ������ �帧�� 
--    �̸� �ۼ��Ͽ� �����ͺ��̽� ���� ������ �ξ��ٰ�
--    �ʿ��� ������ ȣ���Ͽ� ������ �� �ֵ��� ó���� �ִ� �����̴�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] PROCEDURE ���ν�����
[( 
    �Ű����� IN ������Ÿ��           �� �Է� (���� ����)
  , �Ű����� OUT ������Ÿ��          �� ���
  , �Ű����� INOUT ������Ÿ��        �� �����
)]
IS
    -- �ֿ� ���� ����
BEGIN
    -- ���� ����
    ...
    [EXCEPTION]
        -- ���� ó�� ����    
END;
*/

-- �� FUNCTION �� ������ ��...
--    ��RETURN ��ȯ�ڷ����� �κ��� �������� ������,
--    ��RETRUN���� ��ü�� �������� ������,
--    ���ν��� ���� �� �Ѱ��ְ� �Ǵ� �Ű������� ������
--    IN, OUT, INOUT ���� ���еȴ�.

-- 3. ����(ȣ��)
/*
EXEC[UTE] ���ν�����[(�μ�1, �μ�2, ...)];
*/

--�� INSERT ���� ������ ���ν����� �ۼ� ( �� INSERT ���ν��� )

-- ���ν��� ����
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_INSERT
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
    -- �ֿ� ���� ����
BEGIN
    -- TBL_IDPW ���̺� ������ �Է�
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS ���̺� ������ �Է�
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    -- Ŀ��
    COMMIT;
    
END;
--==>> Procedure PRC_STUDENTS_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_SUNGJUK ���̺� ������ �Է� ��
--   Ư�� �׸��� ������(�й�, �̸�, ��������, ��������, ��������)�� �Է��ϸ�
--   ���������� ����, ���, ��� �׸��� �Բ� �Է� ó���� �� �ֵ��� �ϴ�
--   ���ν����� �����Ѵ�.
--   ���ν����� : PRC_SUNGJUK_INSERT()
/*
���� ��)
EXEC PRC_SUNGJUK_INSERT(1, '������', 90, 80, 70);

���ν��� ȣ��� ó���� ���)
�й�  �̸�  ��������    ��������    ��������    ����  ���  ���
 1   ������    90          80          70        240   80    B
*/
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN      IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME        IN TBL_SUNGJUK.NAME%TYPE
, V_KOR         IN TBL_SUNGJUK.KOR%TYPE
, V_ENG         IN TBL_SUNGJUK.ENG%TYPE
, V_MAT         IN TBL_SUNGJUK.MAT%TYPE
)

IS
    -- �ֿ亯�� ����(��������)
    V_TOT       TBL_SUNGJUK.TOT%TYPE;
    V_AVG       TBL_SUNGJUK.AVG%TYPE;
    V_GRADE     TBL_SUNGJUK.GRADE%TYPE;
    
BEGIN
    -- ���� �� ó��
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    
    IF (V_AVG >= 90) 
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80) 
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70) 
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60) 
        THEN V_GRADE := 'D';
    ELSIF (V_AVG >= 50) 
        THEN V_GRADE := 'E';
    ELSE V_GRADE := 'F';
    END IF;

    -- INSERT ������ ����
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_INSERT��(��) �����ϵǾ����ϴ�.



--�� TBL_SUNGJUK ���̺���
--   Ư�� �л��� ����(�й�, ����, ����, ����)
--   ������ ���� �� ����, ���, ��ޱ��� �����ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� ��: PRC_SUNGJUK_UPDATE()
/*
���� ��)
EXEC PRC_SUNGJUK_UPDATE(2, 100, 100, 100);

���ν��� ȣ��� ó���� ���)
�й�  �̸�  ��������    ��������    ��������    ����  ���  ���
 2   ��ҿ�    100        100         100        300  100    A
 */
 
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR    IN TBL_SUNGJUK.KOR%TYPE
, V_ENG    IN TBL_SUNGJUK.ENG%TYPE
, V_MAT    IN TBL_SUNGJUK.MAT%TYPE
)

IS
    -- �ֿ� ���� ����
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
    
BEGIN
    -- ���� �� ó��
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    
    IF (V_AVG >= 90) 
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80) 
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70) 
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60) 
        THEN V_GRADE := 'D';
    ELSIF (V_AVG >= 50) 
        THEN V_GRADE := 'E';
    ELSE V_GRADE := 'F';
    END IF;

    -- UPDATE ������ ����
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG, MAT = V_MAT
      , TOT = V_TOT, AVG = V_AVG, GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_UPDATE��(��) �����ϵǾ����ϴ�.


--�� TBL_STUDENTS ���̺���
--   ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�) ���ν����� �ۼ��Ѵ�.
--   ��, ID�� PW�� ��ġ�ϴ� ��쿡�� ������ ������ �� �ֵ��� �Ѵ�.
--   ���ν��� �� : PRC_STUDENTS_UPDATE()
/*
���� ��)
EXEC PRC_STUDENTS_UPDATE('superman', 'java006$', '010-9999-9999', '��õ');

���ν��� ȣ��� ó���� ���
superman    �չ���     010-9999-9999       ��õ
*/

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)

IS    
BEGIN
    -- UPDATE ������ ����
    UPDATE (SELECT I.ID, I.PW, S.TEL, S.ADDR
             FROM TBL_IDPW I JOIN TBL_STUDENTS S
             ON I.ID = S.ID) T
    SET T.TEL = V_TEL, T.ADDR = V_ADDR
    WHERE T.ID = V_ID AND T.PW = V_PW;
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.



--�� TBL_INSA ���̺��� ������� �ű� ������ �Է� ���ν����� �ۼ��Ѵ�.
--   NUM NAME SSN IBSADATE CITY TEL BUSEO JIKWI BASICPAY SUDANG
--   ������ ���� �ִ� ��� ���̺� ������ �Է� ��
--   NUM �÷�(�����ȣ)�� ����
--   ���� �ο��� �����ȣ ������ ��ȣ�� �� ���� ��ȣ�� �ڵ�����
--   �Է� ó���� �� �ִ� ���ν����� �����Ѵ�.
--   ���ν��� �� : PRC_INSA_INSERT(NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG);
/*
���� ��)
EXEC PRC_INSA_INSERT('�̴ٿ�', '951027-2234567', SYSDATE, '����', '010-4113-2353', '������', '�븮', 10000000, 2000000);  -- õ��, �̹鸸

���ν��� ȣ��� ó���� ���)
1061 �̴ٿ� 2234567 SYSDATE ���� 010-4113-2353 ������ �븮 10000000 2000000
*/
