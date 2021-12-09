-- 1�� �ּ��� ó��(������ �ּ��� ó��)

/*
������
(������)
�ּ���
ó��
*/

--�� ���� ����Ŭ ������ ������ �ڽ��� ���� ��ȸ
show user;
--==>> USER��(��) "SYS"�Դϴ�.
--sqlplus ������ �� ����ϴ� ���ɾ�

select user
from dual;
--==>> SYS

SELECT USER
FROM DUAL;
--==>> SYS

SELECT 1+2
FROM DUAL;  --DAUL : �������̺�
--==>> 3

SELECT 1 + 2
FROM DUAL;
--==>> 3

SELECT �ֿ밭��F������
FROM DUAL;
--==>> ���� �߻�
/*
ORA-00904: "�ֿ밭��F������": invalid identifier
00904. 00000 -  "%s: invalid identifier"
*Cause:    
*Action:
31��, 8������ ���� �߻�
*/

SELECT "�ֿ밭��F������"
FROM DUAL;
/*
ORA-00904: "�ֿ밭��F������": invalid identifier
00904. 00000 -  "%s: invalid identifier"
*Cause:    
*Action:
42��, 8������ ���� �߻�
*/

SELECT '�ֿ밭��F������'
FROM DUAL;
--==>> �ֿ밭��F������

SELECT '������ ������ ����Ŭ ����'
FROM DUAL;
--==>> ������ ������ ����Ŭ ����

SELECT 3.14 + 1.36
FROM DUAL;
--==>> 4.5

SELECT 1.234 + 2.345
FROM DUAL;
--==>> 3.579

SELECT 10*5
FROM DUAL;
--==>> 50

SELECT 1000/23
FROM DUAL;
--==>> 43.47826086956521739130434782608695652174

SELECT 100 - 23
FROM DUAL;
--==>> 77

SELECT 100 - 5.5
FROM DUAL;
--==>> 94.5

SELECT '����ȭ' + 'ä����'
FROM DUAL;
--==>> ���� �߻�
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/



--�� ���� ����Ŭ ������ �����ϴ� ����� ���� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
SYS	                OPEN
SYSTEM	            OPEN
ANONYMOUS	        OPEN
HR	                OPEN
APEX_PUBLIC_USER	    LOCKED
FLOWS_FILES	        LOCKED
APEX_040000	        LOCKED
OUTLN	            EXPIRED & LOCKED
DIP	                EXPIRED & LOCKED
ORACLE_OCM	        EXPIRED & LOCKED
XS$NULL	            EXPIRED & LOCKED
MDSYS	            EXPIRED & LOCKED
CTXSYS	            EXPIRED & LOCKED
DBSNMP	            EXPIRED & LOCKED
XDB	                EXPIRED & LOCKED
APPQOSSYS	        EXPIRED & LOCKED
*/

SELECT USERNAME, USER_ID, ACCOUNT_STATUS, PASSWORD, LOCK_DATE
FROM DBA_USERS;
--==>>
/*
SYS	                0	        OPEN		
SYSTEM	            5	        OPEN		
ANONYMOUS	        35	        OPEN		
HR	                43	        OPEN		
APEX_PUBLIC_USER	    45	        LOCKED		        14/05/29
FLOWS_FILES	        44	        LOCKED		        14/05/29
APEX_040000	        47	        LOCKED		        14/05/29
OUTLN	            9	        EXPIRED & LOCKED		21/08/24
DIP	                14	        EXPIRED & LOCKED		14/05/29
ORACLE_OCM	        21	        EXPIRED & LOCKED		14/05/29
XS$NULL	            2147483638	EXPIRED & LOCKED		14/05/29
MDSYS	            42	        EXPIRED & LOCKED		14/05/29
CTXSYS	            32	        EXPIRED & LOCKED		21/08/24
DBSNMP	            29	        EXPIRED & LOCKED		14/05/29
XDB	                34	        EXPIRED & LOCKED		14/05/29
APPQOSSYS	        30	        EXPIRED & LOCKED		14/05/29
*/

--> ��DBA_���� �����ϴ� Oracle Data Dictionary View ��
--  ������ ������ �������� �������� ��쿡�� ��ȸ�� �����ϴ�.
--  ������ ������ ��ųʸ� ������ ���� ���ص� ��� ����.


--�� ��HR�� ����� ������ ��� ���·� ����
ALTER USER HR ACCOUNT LOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.

--�� �ٽ� ����� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
        :
    HR	LOCKED
        :
*/


--�� ��HR�� ����� ���� ��� ����
ALTER USER HR ACCOUNT UNLOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.

--�� �ٽ� ����� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
        :
    HR	OPEN
        :
*/       


---------------------------------------------------------------------

-- �� TABLESPACE ����

--�� TABLESPACE��?
--   ���׸�Ʈ(���̺�, �ε���, ...)�� ��Ƶδ�(�����صδ�)
--   ����Ŭ�� �������� ���屸���� �ǹ��Ѵ�.

--INSERT : �����͸� ����, �߰�, ��� ��...
--CREATE : �������� ����, �߰�, ��� ��...

CREATE TABLESPACE TBS_EDUA                  -- CREATE ���� ��ü�� �� ����
DATAFILE 'C:\TESTORADATA\TBS_EDUA01.DBR'    -- ���������� ����Ǵ� ������ ����
SIZE 4M                                     -- ������ ������ ������ �뷮
EXTENT MANAGEMENT LOCAL                     -- ����Ŭ ������ ���׸�Ʈ�� �˾Ƽ� ����
SEGMENT SPACE MANAGEMENT AUTO;              -- ���׸�Ʈ ���� ������ �ڵ����� ����Ŭ ������ ����

--�� ���̺������̽� ���� ������ �����ϱ� ����
--   �������� ��ο� ���͸� ������ ��.

--==>> TABLESPACE TBS_EDUA��(��) �����Ǿ����ϴ�.


-- �� ������ ���̺������̽�(TBS_EDUA) ��ȸ
SELECT *               -- ��� �׸�
FROM DBA_TABLESPACES;
/*
    :
TBS_EDUA    	8192    	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
    :
*/


-- �� �������� ���� �̸� ��ȸ
SELECT *
FROM DBA_DATA_FILES;
/*
    :
C:\TESTORADATA\TBS_EDUA01.DBR	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
    :
*/


-- �� ����Ŭ ����� ���� ����(jmh)
CREATE USER jmh IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_EDUA;
--> jmh ��� ����� ������ ����ڴ�. (�����ϰڴ�.)
-- �� ������ �н������ java006$ �� �����ϰڴ�. (�����ϰڴ�.)
-- �� ������ ���� �����ؼ� �����ϴ� ����Ŭ ��ü��(���׸�Ʈ����)
-- �⺻������ TBS_EDUA ��� ���̺� �����̽��� Ȱ���� �� �ֵ��� �����ϰڴ�.
-- (�� ���̺������̽��� ������ �� �ֵ��� �����ϰڴ�.)
--==>> User JMH��(��) �����Ǿ����ϴ�.


--�� ������ ����Ŭ ����� ����(jmh)�� ����
--   ����Ŭ�� ������ �õ��� ��������... ���� �Ұ�.
--   �� ����: ���� -�׽�Ʈ ����: ORA-01045: user JMH lacks CREATE SESSION privilege; logon denied
-- �� ���� ������ �ο����� ������...

-- �� ������ ����Ŭ ����� ����(jmh)��
--    ���� ������ ������ �� �ֵ��� create session ���� �ο� �� sys ��...
GRANT CREATE SESSION TO jmh;
--==>> Grant��(��) �����߽��ϴ�. 

-----------------------------------------------------------------------
--�� ������ ����Ŭ ����� ����(jmh)�� ���ؼ� ����Ŭ ���� ����~!!!
--   ������, ���̺� ���� �Ұ�(�� ���� �����)

--�� ������ ����Ŭ ����� ����(jmh)�� 
--   �ý��� ���� ���� ��ȸ
SELECT *
FROM DBA_SYS_PRIVS;
/*
            :
JMH	CREATE SESSION	NO
            :
*/


--�� ������ ����Ŭ ����� ����(jmh)��
--   ���̺� ������ ������ �� �ֵ��� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO jmh;
--==>> Grant��(��) �����߽��ϴ�.


--�� ������ ����Ŭ ����� ����(jmh)��
--   ���̺������̽�(TBS_EDUA)���� ����� �� �ִ� ����(�Ҵ緮)
--   �� ũ�⸦ ���������� ����.
ALTER USER jmh
QUOTA UNLIMITED ON TBS_EDUA;
--==>> User JMH��(��) ����Ǿ����ϴ�.





