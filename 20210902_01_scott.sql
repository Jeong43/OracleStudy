--�� TBL_FILES ���̺��� ������� ���� ���� ��ȸ�� �� �ֵ��� 
--   �������� �����Ѵ�.

-- �����
SELECT FILENO "���Ϲ�ȣ"
     , SUBSTR(FILENAME, LENGTH(FILENAME)-INSTR(REVERSE(FILENAME), '\', 1) + 2) "���ϸ�"
FROM TBL_FILES;

--INSTR(REVERSE(FILENAME), '\', 1) 
--> �ڿ������� '\' �� �ִ� ��ġ
--LENGTH(FILENAME)-INSTR(REVERSE(FILENAME), '\', 1)+2   
--> �տ������� ù ���ڰ� �����ϴ� ��ġ('\'�� ù ���� ������ 2 ����)


-- ����� / ������ �ؼ�
SELECT FILENO "���Ϲ�ȣ"
     , REVERSE(SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1)-1)) "���ϸ�"
FROM TBL_FILES;

--INSTR(REVERSE(FILENAME), '\', 1)  
--> �ڿ������� '\' �� �ִ� ��ġ
--SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1)-1)
--> �Ųٷ� �� ���ϸ�


--�� LPAD()
--> Byte ������ Ȯ���Ͽ� ���ʺ��� ���ڷ� ä��� ����� ���� �Լ�
SELECT 'ORACLE' "1"
     , LPAD('ORACLE', 10, '*') "2"
FROM DUAL;
--==>> ORACLE	****ORACLE
--> �� 10Byte ������ Ȯ���Ѵ�.                      �� �� ��° �Ķ���� ���� ����...
--  �� Ȯ���� ������ 'ORACLE' ���ڿ��� ��´�.      �� ù ��° �Ķ���� ���� ����...
--  �� ���� �ִ� Byte ������ ���ʺ��� �� ��° �Ķ���� ������ ä���
--  �� �̷��� ������ ���� ������� ��ȯ�Ѵ�.


--�� BPAD()
--> Byte ������ Ȯ���Ͽ� �����ʺ��� ���ڷ� ä��� ����� ���� �Լ�
SELECT 'ORACLE' "1"
     , RPAD('ORACLE', 10, '*') "2"
FROM DUAL;
--==>> ORACLE	ORACLE****
--> �� 10Byte ������ Ȯ���Ѵ�.                      �� �� ��° �Ķ���� ���� ����...
--  �� Ȯ���� ������ 'ORACLE' ���ڿ��� ��´�.      �� ù ��° �Ķ���� ���� ����...
--  �� ���� �ִ� Byte ������ �����ʺ��� �� ��° �Ķ���� ������ ä���
--  �� �̷��� ������ ���� ������� ��ȯ�Ѵ�.


--�� LTRIM()
SELECT 'ORAORAORACLEORACLE' "1"      -- ���� ���� ����Ŭ ����Ŭ
     , LTRIM('ORAORAORACLEORACLE', 'ORA') "2"
     , LTRIM('AAAORAORAORACLEORACLE', 'ORA') "3"        -- �� ���ھ� ó��
     , LTRIM('oRAoRAoRACLEoRACLE', 'ORA') "4"           -- ��ҹ��� ����
     , LTRIM('ORA ORAORACLEORACLE', 'ORA') "5"          -- ���鵵 ó�� ����
     , LTRIM('          ORA ORA ORACLEORACLE', ' ') "6"
     , LTRIM('                       ORACLE') "7"       -- ���� ���� ���� �Լ��� Ȱ��(�� ��° �Ķ���� ����)
FROM DUAL;
--==>> 
/*
ORAORAORACLEORACLE	CLEORACLE	CLEORACLE	oRAoRAoRACLEoRACLE	 ORAORACLEORACLE	ORA ORA ORACLEORACLE	ORACLE
*/
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ��� �������
--  ���ʺ��� ���������� �� ��° �Ķ���� ������ ������ ���ڿ� ���� ���ڰ� ������ ���
--  �̸� ������ ������� ��ȯ�Ѵ�.
--  ��, �ϼ������� ó������ �ʴ´�.

SELECT LTRIM('�̱���̱�����̱���̱�����̱���̹��̱��', '�̱��') "TEST"
FROM DUAL;
--==>>���̱��

--�� RTRIM()
SELECT 'ORAORAORACLEORACLE' "1"      -- ���� ���� ����Ŭ ����Ŭ
     , RTRIM('ORAORAORACLEORACLE', 'ORA') "2"
     , RTRIM('AAAORAORAORACLEORACLE', 'ORA') "3"        -- �� ���ھ� ó��
     , RTRIM('oRAoRAoRACLEoRACLE', 'ORA') "4"           -- ��ҹ��� ����
     , RTRIM('ORA ORAORACLEORACLE', 'ORA') "5"          -- ���鵵 ó�� ����
     , RTRIM('          ORA ORA ORACLEORACLE', ' ') "6"
     , RTRIM('ORACLE                       ') "7"       -- ������ ���� ���� �Լ��� Ȱ��(�� ��° �Ķ���� ����)
FROM DUAL;
--==>>
/*
ORAORAORACLEORACLE	ORAORAORACLEORACLE	AAAORAORAORACLEORACLE	oRAoRAoRACLEoRACLE	
ORA ORAORACLEORACLE	          ORA ORA ORACLEORACLE	ORACLE                     
*/
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ��� �������
--  �����ʺ��� ���������� �� ��° �Ķ���� ������ ������ ���ڿ� ���� ���ڰ� ������ ���
--  �̸� ������ ������� ��ȯ�Ѵ�.
--  ��, �ϼ������� ó������ �ʴ´�.


--�� TRANSLATE()
--> 1:1 �� �ٲپ��ش�.
SELECT TRANSLATE('MY ORACLE SERVER'
                , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                , 'abcdefghijklmnopqrstuvwxyz') "RESULT"
FROM DUAL;
--==>> my oracle server

SELECT TRANSLATE('010-8743-7042'
                , '0123456789'
                , '�����̻�����ĥ�ȱ�') "RESULT"
FROM DUAL;
--==>> ���Ͽ�-��ĥ���-ĥ������


--�� REPLACE()
SELECT REPLACE('MY ORACLE ORAHOME', 'ORA', '����')
FROM DUAL;
--==>> MY ����CLE ����HOME


--------------------------------------------------------------------------------

-- ���� ���õ� �Լ���

--�� ROUND() �ݿø��� ó�����ִ� �Լ�
SELECT 48.678 "1"
     , ROUND(48.678, 2) "2"     -- �Ҽ��� ���� ��°�ڸ����� ǥ��(�� ��° �ڸ����� �ݿø�)
     , ROUND(48.674, 2) "3"
     , ROUND(48.674, 1) "4"
     , ROUND(48.674, 0) "5"     -- ������ ǥ��
     , ROUND(48.674) "6"        -- �� ��° �Ķ���� ���� 0�� ��� ���� ����
     , ROUND(48.674, -1) "7"  
     , ROUND(48.674, -2) "8"  
     , ROUND(48.674, -3) "9"  
FROM DUAL;
--==>> 48.678	48.68	48.67	48.7	49	49	50	0	0


--�� TRUNC() ������ ó�����ִ� �Լ�
SELECT 48.678 "1"
     , TRUNC(48.678, 2) "2"     -- �Ҽ��� ���� ��°�ڸ����� ǥ��
     , TRUNC(48.674, 2) "3"
     , TRUNC(48.674, 1) "4"
     , TRUNC(48.674, 0) "5" 
     , TRUNC(48.674) "6"        -- �� ��° �Ķ���� ���� 0�� ��� ���� ����
     , TRUNC(48.674, -1) "7"  
     , TRUNC(48.674, -2) "8"  
     , TRUNC(48.674, -3) "9"  
FROM DUAL;
--==>> 48.678	48.67	48.67	48.6	48	48	40	0	0


--�� MOD() �������� ��ȯ�ϴ� �Լ�
SELECT MOD(5, 2) "RESULT"
FROM DUAL;
--==>> 1
--> 5�� 2�� ���� ������ ����� ��ȯ


--�� POWER() ������ ����� ��ȯ�ϴ� �Լ�
SELECT POWER(5, 3) "RESULT"
FROM DUAL;
--==>> 125
--> 5�� 3���� ����� ��ȯ


--�� SQRT() ��Ʈ ������� ��ȯ�ϴ� �Լ�
SELECT SQRT(2)
FROM DUAL;
--==>> 1.41421356237309504880168872420969807857
--> ��Ʈ 2�� ���� ����� ��ȯ


--�� LOG() �α� �Լ�
--   (�� ����Ŭ�� ���α׸� �����ϴ� �ݸ�, MSSQL �� ���α�, �ڿ��α� ��� �����Ѵ�.)
SELECT LOG(10, 100), LOG(10, 20)
FROM DUAL;
--==>> 2	1.30102999566398119521373889472449302677


--�� �ﰢ�Լ�
-- ����, �ڽ���, ź��Ʈ ���� ��ȯ�Ѵ�.
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
--==>>
/*
0.8414709848078965066525023216302989996233	
0.5403023058681397174009366074429766037354	
1.55740772465490223050697480745836017308
*/


--�� �ﰢ�Լ��� ���Լ� (����: -1 ~ 1)
--   �����, ���ڽ���, ��ź��Ʈ ������� ��ȯ�Ѵ�.
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
--==>>
/*
0.52359877559829887307710723054658381405	
1.04719755119659774615421446109316762805	
0.4636476090008061162142562314612144020295
*/


--�� SIGN()      ����, ��ȣ, Ư¡
--> ���� ������� ����̸� 1, 0�̸� 0, �����̸� -1 �� ��ȯ�Ѵ�.
SELECT SIGN(5-2), SIGN(5-5), SIGN(5-8)
FROM DUAL;
--==>> 1	0	-1


--�� ASCII(), CHR() �� ���� �����ϴ� ������ �Լ�
SELECT ASCII('A') "RESULT1", CHR(65) "RESULT2"
FROM DUAL;
--==>> 65	A
-- ASCII() : �Ű������� �Ѱܹ��� ������ �ƽ�Ű�ڵ� ���� ��ȯ�Ѵ�.
-- CHR()   : �Ű������� �Ѱܹ��� ���ڸ� �ƽ�Ű�ڵ� ������ ���ϴ� ���ڸ� ��ȯ�Ѵ�.


--------------------------------------------------------------------------------


--�� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� ��¥ ������ �⺻ ������ DAY(�ϼ�)�̴�~!!! CHECK~!!!               �ڡڡ�

SELECT SYSDATE "1", SYSDATE+1 "2", SYSDATE-2 "3", SYSDATE+3 "4"
FROM DUAL;
--==>>
/*
2021-09-02 10:35:37	    -- ����
2021-09-03 10:35:37	    -- 1�� ��
2021-08-31 10:35:37	    -- 2�� ��
2021-09-05 10:35:37     -- 3�� ��
*/


--�� �ð� ���� ����
SELECT SYSDATE "1", SYSDATE + 1/24 "2", SYSDATE - 2/24 "3"
FROM DUAL;
--==>>
/*
2021-09-02 10:38:40	    -- ����
2021-09-02 11:38:40	    -- 1�ð� ��
2021-09-02 08:38:40     -- 2�ð� ��
*/


--�� ���� �ð���... ���� �ð� ���� 1�� 2�ð� 3�� 4�� �ĸ� ��ȸ�Ѵ�.
/*
---------------------------------------------------
        ����ð�                ���� �� �ð�
---------------------------------------------------
    2021-09-02 10:41:38	    2021-09-03 12:44:42
---------------------------------------------------
*/
-- ��� ��
SELECT SYSDATE "���� �ð�"
     , SYSDATE + 1 + 2/24 + 3/(24*60) + 4/(24*60*60) "���� �� �ð�"
FROM DUAL;

-- ��� ��
SELECT SYSDATE "���� �ð�"
     , SYSDATE + ((24*60*60) + (2*60*60) + (3*60) + 4) / (24*60*60) "���� �� �ð�"
     --             1��          2�ð�      3��     4��
FROM DUAL;
--==>>
/*
2021-09-02 11:06:08	
2021-09-03 13:09:12
*/


--�� ��¥ - ��¥ = �ϼ�
-- ex) (2021-12-28) - (2021-09-02)
--        ������        ������
SELECT TO_DATE('2021-12-28', 'YYYY-MM-DD') - TO_DATE('2021-09-02', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 117


--�� ������ Ÿ���� ��ȯ
SELECT TO_DATE('2021-09-02', 'YYYY-MM-DD') "���"     -- ��¥ �������� ��ȯ
FROM DUAL;
--==>> 2021-09-02 00:00:00

SELECT TO_DATE('2021-13-02', 'YYYY-MM-DD') "���"
FROM DUAL;
--==>> ���� �߻�
/*
ORA-01843: not a valid month
01843. 00000 -  "not a valid month"
*Cause:    
*Action:
*/

SELECT TO_DATE('2021-09-31', 'YYYY-MM-DD') "���"
FROM DUAL;
--==>> ���� �߻�
/*
ORA-01839: date not valid for month specified
01839. 00000 -  "date not valid for month specified"
*Cause:    
*Action:
*/

SELECT TO_DATE('2021-02-29', 'YYYY-MM-DD') "���"
FROM DUAL;
--==>> ���� �߻�
/*
ORA-01839: date not valid for month specified
01839. 00000 -  "date not valid for month specified"
*Cause:    
*Action:
*/

SELECT TO_DATE('2020-02-29', 'YYYY-MM-DD') "���"
FROM DUAL;
--==>> 2020-02-29 00:00:00


--�� TO_DATE() �Լ��� ���� ���� Ÿ���� ��¥ Ÿ������ ��ȯ�� ������ ��
--   ���������� �ش� ��¥�� ���� ��ȿ�� �˻簡 �̷������~!!!


--�� ADD_MONTHS()    ���� ���� �����ִ� �Լ�
SELECT SYSDATE "1"
     , ADD_MONTHS(SYSDATE, 2) "2"
     , ADD_MONTHS(SYSDATE, 3) "3"
     , ADD_MONTHS(SYSDATE, -2) "4"
     , ADD_MONTHS(SYSDATE, -3) "5"
FROM DUAL;
--==>>
/*
2021-09-02 11:18:29	    �� ����
2021-11-02 11:18:29	    �� 2���� ��
2021-12-02 11:18:29	    �� 3���� ��
2021-07-02 11:18:29	    �� 2���� ��
2021-06-02 11:18:29	    �� 3���� ��
*/
--> �� ���ϰ� ����


--�� ��¥�� ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� MONTHS_BETWEEN()
-- ù ��° ���ڰ����� �� ��° ���ڰ��� �� ���� ���� ��ȯ
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-31', 'YYYY-MM-DD')) "���Ȯ��"
FROM DUAL;
--==>> 231.079832362604540023894862604540023895

--> ���� ���� ���̸� ��ȯ�ϴ� �Լ�
-- �� ������� ��ȣ�� ��-���� ��ȯ�Ǿ��� ��쿡��
--    ù ��° ���ڰ��� �ش��ϴ� ��¥����
--    �� ��° ���ڰ��� �ش��ϴ� ��¥�� ���̷������ �ǹ̷� Ȯ���� �� �ִ�.


SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2021-12-28', 'YYYY-MM-DD')) "���Ȯ��"
FROM DUAL;
--==>> -3.82335125448028673835125448028673835125
--> �������� �����Ϻ��� �̷�


--�� NEXT_DAY()
-- ù ��° ���ڰ��� ���� ��¥�� ���ƿ��� ���� ���� ���� ��ȯ
SELECT NEXT_DAY(SYSDATE, '��') "���1", NEXT_DAY(SYSDATE, '��') "���2"
FROM DUAL;
--==>> 2021-09-04	2021-09-06


--�� �߰� ���� ���� ����
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� ���� ������ ���� �� ���� �������� �ٽ� �� �� ��ȸ
SELECT NEXT_DAY(SYSDATE, '��') "���1", NEXT_DAY(SYSDATE, '��') "���2"
FROM DUAL;
--==>> ���� �߻�
/*
ORA-01846: not a valid day of the week
01846. 00000 -  "not a valid day of the week"
*Cause:    
*Action:
*/


SELECT NEXT_DAY(SYSDATE, 'SAT') "���1", NEXT_DAY(SYSDATE, 'MON') "���2"
FROM DUAL;
--==>> 2021-09-04	2021-09-06


--�� �߰� ���� ���� ����
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� LAST_DAY()
-- �ش� ��¥�� ���ԵǾ� �ִ� �� ���� ������ ���� ��ȯ�Ѵ�.
SELECT LAST_DAY(SYSDATE) "��� Ȯ��"
FROM DUAL;
--==>> 2021-09-30

SELECT LAST_DAY(TO_DATE('2020-02-05', 'YYYY-MM-DD')) "��� Ȯ��"
FROM DUAL;
--==>> 2020-02-29

SELECT LAST_DAY(TO_DATE('2021-02-05', 'YYYY-MM-DD')) "��� Ȯ��"
FROM DUAL;
--==>> 2021-02-28



--�� ���úη�... ����ȣ ����... ���뿡 �� ����(?)����.
--   ���� �Ⱓ�� 22������ �Ѵ�.

-- 1. ���� ���ڸ� ���Ѵ�.

-- 2. �Ϸ� ���ڲ��� 3�� �Ļ縦 �ؾ� �Ѵٰ� �����ϸ�
--    ��ȣ�� �� ���� �Ծ�� ���� �����ٱ�.

SELECT ADD_MONTHS(SYSDATE, 22) "���� ����",
       (ADD_MONTHS(SYSDATE, 22) - SYSDATE) *3 "����"
FROM DUAL;



--�� ���� ��¥ �� �ð����κ���... ������(2021-12-28 18:00:00) ����
--   ���� �Ⱓ��... ������ ���� ���·� ��ȸ�� �� �ֵ��� �Ѵ�.
/*
--------------------------------------------------------------------------------
����ð�            | ��������             | �� | �ð� | �� | ��
--------------------------------------------------------------------------------
2021-09-02 12:08:23 | 2021-12-28 18:00:00 |116 |  4  | 42  | 37
--------------------------------------------------------------------------------
*/
ALTER SESSION SET NLS_DATE_FORMAT = "YYYY-MM-DD HH24:MI:SS";
--==>> Session��(��) ����Ǿ����ϴ�.

-- �� ���� Ǯ��
SELECT SYSDATE "����ð�"
     , TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "��������"
     , TRUNC(TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) "��"
     , TRUNC(MOD((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE)*24, 24)) "��"
     , TRUNC(MOD((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE)*24*60, 60)) "��"
     , TRUNC(MOD((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE)*24*60*60, 60)) "��"
FROM DUAL;
--==>> 2021-09-02 15:30:23	2021-12-28 18:00:00	    117	    2	    29	    37


-- �� �Բ� Ǯ��
--��1�� 2�ð� 3�� 4�ʡ���... ���ʡ��� ȯ���ϸ�...
SELECT (1��) + (2�ð�) + (3��) + (4��)
FROM DUAL;

SELECT (1*24*60*60) + (2*60*60) + (3*60) + (4)
FROM DUAL;
--==>> 93784


-- 61�� �� 1�� 1��
SELECT MOD(61, 60)
FROM DUAL;


-- ��93784���ʸ� �ٽ� ��, �ð�, ��, �ʷ� ȯ���ϸ�...
SELECT TRUNC(TRUNC(TRUNC(93784/60)/60)/24) "��"
     , MOD(TRUNC(TRUNC(93784/60)/60), 24) "�ð�"
     , MOD(TRUNC(93784/60), 60) "��"
     , MOD(93784, 60) "��"
FROM DUAL;


-- �� �Բ� Ǯ��
-- �����ϱ��� ���� �Ⱓ Ȯ��(��¥ ����) �� ����: �ϼ�
SELECT �������� - ��������
FROM DUAL;

-- ��������
SELECT TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
FROM DUAL;
--==>> 2021-12-28 18:00:00 �� ��¥ ����

-- ��������
SELECT SYSDATE
FROM DUAL;
--==>> 2021-09-02 15:21:19 �� ��¥ ����

-- �����ϱ��� ���� �Ⱓ Ȯ��(��¥ ����) �� ����: �ϼ�
SELECT TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE
FROM DUAL;
--==>> 117.109537037037037037037037037037037037 �� ����: �ϼ� �� ���� ����
--==>> �����ϱ��� ���� �ϼ�

-- �����ϱ��� ���� �Ⱓ Ȯ��(��¥ ����) �� ����: ��
SELECT (�����ϱ��� ���� �ϼ�) * �Ϸ縦 �����ϴ� ��ü ��
FROM DUAL;

SELECT (TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)
FROM DUAL;
--==>> 10118171.99999999999999999999999999999998 �� ����: �ϼ� �� ���� ����
--==>> �����ϱ��� ���� ��


--�� �� �Ŀ� �ֱ�
SELECT SYSDATE "����ð�"
     , TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
     , TRUNC(TRUNC(TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60)/60)/24) "��"
     , MOD(TRUNC(TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60)/60), 24) "�ð�"
     , MOD(TRUNC(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60), 60) "��"
     , TRUNC(MOD(((TO_DATE('2021-12-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)), 60)) "��"
FROM DUAL;
--==>> 2021-09-02 15:29:04	2021-12-28 18:00:00	    117	    2	    30	    56



--�� ����
-- ������ �¾�� �������...
-- �󸶸�ŭ�� ��, �ð�, ��, �ʸ� ��Ҵ���... (��� �ִ���...)
-- ��ȸ�ϴ� �������� �����Ѵ�.
/*
------------------------------------------------------------------------
���� �ð�           | �¾ �ð�        | ��    | �� | �� | ��
------------------------------------------------------------------------
2021-09-02 15:36:44 |1994-05-13 12:00:00 |	9974 |	3 |	36 | 44
------------------------------------------------------------------------
*/
-- ��
SELECT SYSDATE "���� �ð�"
     , TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS') "�¾ �ð�"
     , TRUNC(SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) "��"
     , TRUNC(MOD((SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24, 24)) "��"
     , TRUNC(MOD((SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60, 60)) "��"
     , TRUNC(MOD((SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))*24*60*60, 60)) "��"
FROM DUAL;


-- ��
-- �Ⱓ Ȯ��(��¥ ����) �� ����: �ϼ�
SELECT SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS') "��"
FROM DUAL;

-- �Ⱓ Ȯ��(��¥ ����) �� ����: ��
SELECT (SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60) "��"
FROM DUAL;

-- ����
SELECT SYSDATE "����ð�"
     , TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS') "�¾ �ð�"
     , TRUNC(TRUNC(TRUNC(((SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60)/60)/24) "��"
     , MOD(TRUNC(TRUNC(((SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60)/60), 24) "�ð�"
     , MOD(TRUNC(((SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60), 60) "��"
     , TRUNC(MOD(((SYSDATE-TO_DATE('1994-05-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60)), 60)) "��"
FROM DUAL;



---�� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.

-- �� ��¥ �����͸� ������� �ݿø�, ������ ������ �� �ִ�.

--�� ��¥ �ݿø�
SELECT SYSDATE "1"                      -- 2021-09-02 �� �⺻ ���� ��¥
     , ROUND(SYSDATE, 'YEAR') "2"       -- 2022-01-01 �� �⵵���� ��ȿ�� ������(��ݱ�, �Ϲݱ� ����)
     , ROUND(SYSDATE, 'MONTH') "3"      -- 2021-09-01 �� ������ ��ȿ�� ������(15�� ����)
     , ROUND(SYSDATE, 'DD') "4"         -- 2021-09-03 �� ��¥���� ��ȿ�� ������(���� ����)
     , ROUND(SYSDATE, 'DAY') "5"        -- 2021-09-05 �� ��¥���� ��ȿ�� ������(������ ����)
FROM DUAL;

--�� ��¥ ����
SELECT SYSDATE "1"                      -- 2021-09-02 �� �⺻ ���� ��¥
     , TRUNC(SYSDATE, 'YEAR') "2"       -- 2021-01-01 �� �⵵���� ��ȿ�� ������
     , TRUNC(SYSDATE, 'MONTH') "3"      -- 2021-09-01 �� ������ ��ȿ�� ������
     , TRUNC(SYSDATE, 'DD') "4"         -- 2021-09-02 �� ��¥���� ��ȿ�� ������(�Ϸ� ����)
     , TRUNC(SYSDATE, 'DAY') "5"        -- 2021-08-29 �� ��¥���� ��ȿ�� ������(�� ����)
FROM DUAL;


--------------------------------------------------------------------------------

--���� ��ȯ �Լ� ����--

--TO_CHAR()   : ���ڳ� ��¥ �����͸� ���� Ÿ������ ��ȯ�����ִ� �Լ�
--TO_DATE()   : ���� ������(��¥ ����)�� ��¥ Ÿ������ ��ȯ�����ִ� �Լ�
--TO_NUMBER() : ���� ������(���� ����)�� ���� Ÿ������ ��ȯ�����ִ� �Լ�

--�� ��¥�� ��ȭ ������ ���� �ʴ� ���
--   ���� �������� ���� ������ ������ �� �ִ�.

ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session��(��) ����Ǿ����ϴ�.

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
--==>> Session��(��) ����Ǿ����ϴ�.

ALTER SESSION SET NLS_CURRENCY = '\';   -- ȭ�� ��(��)
--==>> Session��(��) ����Ǿ����ϴ�.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.


SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')   -- 2021-09-02
     , TO_CHAR(SYSDATE, 'YYYY')         -- 2021
     , TO_CHAR(SYSDATE, 'YEAR')         -- TWENTY TWENTY-ONE �� ������ 'KOREAN' �̿��� ������ ������ ��� ����
     , TO_CHAR(SYSDATE, 'MM')           -- 09
     , TO_CHAR(SYSDATE, 'MONTH')        -- 9�� 
     , TO_CHAR(SYSDATE, 'MON')          -- 9�� -->����
     , TO_CHAR(SYSDATE, 'DD')           -- 02
     , TO_CHAR(SYSDATE, 'DAY')          -- �����
     , TO_CHAR(SYSDATE, 'DY')           -- ��
     , TO_CHAR(SYSDATE, 'HH24')         -- 16
     , TO_CHAR(SYSDATE, 'HH')           -- 04
     , TO_CHAR(SYSDATE, 'HH AM')        -- 04 ����
     , TO_CHAR(SYSDATE, 'HH PM')        -- 04 ����
     , TO_CHAR(SYSDATE, 'MI')           -- 30               �� ��
     , TO_CHAR(SYSDATE, 'SS')           -- 05               �� ��
     , TO_CHAR(SYSDATE, 'SSSSS')        -- 59405            �� ���� �귯�� ��ü ��
     , TO_CHAR(SYSDATE, 'Q')            -- 3                �� �б�
FROM DUAL;


SELECT 2021 "1", '2021' "2"
     , TO_NUMBER('23') "2", '23' "1"
FROM DUAL;
-- ���� �������� ���� ����, ����



-- �� EXTRACT()
SELECT TO_CHAR(SYSDATE, 'YYYY') "1"     -- 2021     �� ������ �����Ͽ� ���� Ÿ������...
     , TO_CHAR(SYSDATE, 'MM') "2"       -- 09       �� ���� �����Ͽ� ���� Ÿ������...
     , TO_CHAR(SYSDATE, 'DD') "3"       -- 02       �� ���� �����Ͽ� ���� Ÿ������...
     , EXTRACT(YEAR FROM SYSDATE) "4"   -- 2021     �� ������ �����Ͽ� ���� Ÿ������...
     , EXTRACT(MONTH FROM SYSDATE) "5"  -- 9        �� ���� �����Ͽ� ���� Ÿ������...
     , EXTRACT(DAY FROM SYSDATE) "6"    -- 2        �� ���� �����Ͽ� ���� Ÿ������...
FROM DUAL;
--> ��, ��, �� ���� �ٸ� ���� �Ұ�


-- �� TO_CHAR() Ȱ�� �� ���� ���� ǥ�� ����� ��ȯ
SELECT 60000 "1"
     , TO_CHAR(60000) "2"
     , TO_CHAR(60000, '99,999') "3"
     , TO_CHAR(60000, '$99,999') "4"
     , TO_CHAR(60000, 'L99,999') "5"            --> '���'�� �´���ִ� ��ȭ ����(�پ��� ȭ�� ǥ���ϱ� ���� ������ Ȯ���ص�)
     , LTRIM(TO_CHAR(60000, 'L99,999')) "6"     --> ������ LTRIM() �Լ��� �Բ� ���� ��찡 ����.
FROM DUAL;


--�� ��¥ ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� ���� �ð��� �������� 1�� 2�ð� 3�� 4�� �ĸ� ��ȸ�Ѵ�.
SELECT SYSDATE "���� �ð�"
     , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "1��2�ð�3��4�� ��"
FROM DUAL;


--�� ���� �ð��� �������� 1�� 2���� 3�� 4�ð� 5�� 6��
--   TO_YMINTERVAL(), TO_DSINTERVAL() : ����, ����
SELECT SYSDATE "���� �ð�"
     , SYSDATE + TO_YMINTERVAL('01-02') + TO_DSINTERVAL('003 04:05:06') "���� ���"
FROM DUAL;
--==>> 
/*
2021-09-02 17:06:42	
2022-11-05 21:11:48
*/


--------------------------------------------------------------------------------

--�� CASE ���� (���ǹ�, �б⹮)
/*
CASE
WHEN
TEHN
ELSE
END
*/

SELECT CASE 5+2 WHEN 7 THEN '5+2=7' ELSE '5+2�� �����' END "��� Ȯ��"
FROM DUAL;
--==>> 5+2=7

SELECT CASE 5+2 WHEN 9 THEN '5+2=7' ELSE '5+2�� �����' END "��� Ȯ��"
FROM DUAL;
--==>> 5+2�� �����

SELECT CASE 1+1 WHEN 2 THEN '1+1=2'
                WHEN 3 THEN '1+1=3'
                WHEN 4 THEN '1+1=4'
                ELSE '�����'
       END "��� Ȯ��"
FROM DUAL;
--==> 1+1=2


--�� DECODE()
SELECT DECODE(5-2, 1, '5-2=1', 2, '5-2=2', 3, '5-3=3', '5-2�� �����') "��� Ȯ��"
FROM DUAL;
--==>> 5-3=3


SELECT CASE WHEN 5<2 THEN '5<2'
            WHEN 5>2 THEN '5>2'
            ELSE '�� �Ұ�'
       END "��� Ȯ��"
FROM DUAL;
--==>> 5>2


SELECT CASE WHEN 5<2 OR 3>1 THEN '��������'
            WHEN 5>2 OR 2=3 THEN '��������'
            ELSE '���� ����'
        END "��� Ȯ��"
FROM DUAL;
--==>> ��������
-- JAVA �� SCE �� �����.


SELECT CASE WHEN 3<1 AND 5<2 OR 3>1 AND 2=2 THEN '�ش�����'
            WHEN 5<2 AND 2=3 THEN '��������'
            ELSE '���ϸ���'
       END "��� Ȯ��"        
FROM DUAL;
--==>> �ش�����

SELECT CASE WHEN 3<1 AND (5<2 OR 3>1) AND 2=2 THEN '�ش�����'
            WHEN 5<2 AND 2=3 THEN '��������'
            ELSE '���ϸ���'
       END "��� Ȯ��"        
FROM DUAL;
--==>> ���ϸ���


--�� ����
-- TBL_SAWON ���̺��� Ȱ���Ͽ� ������ ���� �׸���� ��ȸ�Ѵ�.

-- �����ȣ, �����, �ֹι�ȣ, ����, ���� ����, �Ի���
-- , ����������, �ٹ��ϼ�, �����ϼ�, �޿�, ���ʽ�

-- ��, ���糪�̴� �ѱ����� ������ ���� ������ �����Ѵ�.
-- ����, ������������ �ش� ������ ���̰� �ѱ����̷� 60���� �Ǵ� ��(����)��
-- �� ������ �Ի� ��, �Ϸ� ������ �����Ѵ�.
-- �׸���, ���ʽ��� 1000�� �̻� 2000�� �̸� �ٹ��� �����
-- �� ������ ���� �޿� ���� 30% ����,
-- 2000�� �̻� �ٹ��� ������
-- �� ������ ���� �޿� ���� 50% ������ �� �� �ֵ��� ó���Ѵ�.


SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ" 
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '3') THEN '��'
            WHEN SUBSTR(JUBUN, 7, 1) IN('2', '4') THEN '��'
       END "����"
     , EXTRACT(YEAR FROM SYSDATE) - (CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '2')
                                              THEN 1900 + TO_NUMBER(SUBSTR(JUBUN, 1, 2))
                                         WHEN SUBSTR(JUBUN, 7, 1) IN('3', '4')
                                              THEN 2000 + TO_NUMBER(SUBSTR(JUBUN, 1, 2))
                                    END) + 1 "����"           -- ���� �⵵ - ź���� + 1
     , HIREDATE "�Ի���"
     , TO_DATE(CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '2') THEN '19'
                    WHEN SUBSTR(JUBUN, 7, 1) IN('3', '4') THEN '20'
               END
               || SUBSTR(JUBUN, 1, 2) || '-' || SUBSTR(JUBUN, 3, 2) || '-' || SUBSTR(JUBUN, 5, 2))
        + TO_YMINTERVAL('59-00') "����������"            -- ����� + 59��
     , TRUNC(SYSDATE - HIREDATE) "�ٹ��ϼ�"
     , TRUNC(TO_DATE(CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '2') THEN '19'
                          WHEN SUBSTR(JUBUN, 7, 1) IN('3', '4') THEN '20'
                    END
                    || SUBSTR(JUBUN, 1, 2) || '-' || SUBSTR(JUBUN, 3, 2) || '-' || SUBSTR(JUBUN, 5, 2))
            + TO_YMINTERVAL('59-00') - SYSDATE) "�����ϼ�"      --���������� - ������
     , SAL "�޿�" 
     , CASE WHEN TRUNC(SYSDATE - HIREDATE)>=1000 AND TRUNC(SYSDATE - HIREDATE)<2000
                    THEN SAL*0.3
            WHEN TRUNC(SYSDATE - HIREDATE)>=2000 
                    THEN SAL*0.5
            ELSE 0
       END "���ʽ�"
FROM TBL_SAWON;









