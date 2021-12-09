SELECT USER
FROM DUAL;
--==>> SCOTT

--�� ������ �Լ�(FN_GENDER())�� ����� �۵��ϴ����� ���� Ȯ��
SELECT NAME, SSN, FN_GENDER(SSN) "�Լ�ȣ����"
FROM TBL_INSA;

--�� ������ �Լ�(FN_POW())�� ����� �۵��ϴ����� ���� Ȯ��
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000



-- ���ν��� ���� �ǽ�

-- �ǽ� ���̺� ����(TBL_STUDENTS)
CREATE TABLE TBL_STUDENTS
( ID    VARCHAR2(10)
, NAME  VARCHAR2(40)
, TEL   VARCHAR2(20)
, ADDR  VARCHAR2(100)
);
--==>> Table TBL_STUDENTS��(��) �����Ǿ����ϴ�.

-- �ǽ� ���̺� ����(TBL_IDPW)
CREATE TABLE TBL_IDPW
( ID    VARCHAR2(10)
, PW    VARCHAR2(20)
, CONSTRAINT IDPW_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_IDPW��(��) �����Ǿ����ϴ�.


-- �� ���̺� ������ �Է�
INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
VALUES('superman', '�չ���', '010-1111-1111', '���� ������...');
INSERT INTO TBL_IDPW(ID, PW)
VALUES('superman', 'java006$');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 2

SELECT *
FROM TBL_STUDENTS;
--==>> superman	�չ���	010-1111-1111	���� ������...

SELECT *
FROM TBL_IDPW;
--==>> superman	java006$


-- ���� ������ ���ν���(INSERT ���ν���, �Է� ���ν���)�� �����ϰ� �Ǹ�
EXEC PRO_STUDENTS_INSERT('batman', 'java006$', '���ش�', '010-2222-2222', '��⵵ ����');
-- �̿� ���� ���� �� �ٷ� ���� ���̺� �����͸� ��� ����� �Է��� �� �ִ�.

DESC TBL_STUDENTS;
DESC TBL_IDPW;


--�� ������ ���ν���(PRC_STUDENTS_INSERT())�� ����� �۵��ϴ����� ���� Ȯ��
--   �� ���ν��� ȣ��
EXEC PRC_STUDENTS_INSERT('batman', 'java006$', '���ش�', '010-2222-2222', '��⵵ ����');

SELECT *
FROM TBL_STUDENTS;

SELECT *
FROM TBL_IDPW;


--�� �й�, �̸�, ��������, ��������, �������� �����͸� 
--   �Է� ���� �� �ִ� �ǽ� ���̺� ����(TBL_SUNGJUK)
CREATE TABLE TBL_SUNGJUK
( HAKBUN    NUMBER
, NAME      VARCHAR(40)
, KOR       NUMBER(3)
, ENG       NUMBER(3)
, MAT       NUMBER(3)
, CONSTRAINT SUNGJUK_HAKBUN_PK PRIMARY KEY(HAKBUN)
);
--==>> Table TBL_SUNGJUK��(��) �����Ǿ����ϴ�.

--�� ������ ���̺� �÷� ���� �߰�
--   (������TOT, ��ա�AVG, ��ޡ�GRADE)
ALTER TABLE TBL_SUNGJUK
ADD ( TOT NUMBER(3), AVG NUMBER(4, 1), GRADE CHAR );
--==>> Table TBL_SUNGJUK��(��) ����Ǿ����ϴ�.

--�� ���⼭ �߰��� �÷��� ���� �׸����
--   ���ν��� �ǽ��� ���� �߰��� ���� ��
--   ���� ���̺� ������ ����������, �ٶ��������� ���� �����̴�.

--�� ����� ���̺��� ���� Ȯ��
DESC TBL_SUNGJUK;
--==>>
/*
�̸�     ��?       ����           
------ -------- ------------ 
HAKBUN NOT NULL NUMBER       
NAME            VARCHAR2(40) 
KOR             NUMBER(3)    
ENG             NUMBER(3)    
MAT             NUMBER(3)    
TOT             NUMBER(3)    
AVG             NUMBER(4,1)  
GRADE           CHAR(1)   
*/


--�� ������ ���ν���(PRC_SUNGJUK_INSERT())�� ����� �۵��ϴ����� ���� Ȯ��
--   �� ���ν��� ȣ��
EXEC PRC_SUNGJUK_INSERT(1, '������', 90, 80, 70);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

SELECT *
FROM TBL_SUNGJUK;
--==>> 1	������	90	80	70	240	80	B

EXEC PRC_SUNGJUK_INSERT(2, '��ҿ�', 98, 88, 77);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

SELECT *
FROM TBL_SUNGJUK;
--==>>
/*
1	������	90	80	70	240	80	B
2	��ҿ�	98	88	77	263	87.7	B
*/


--�� ������ ���ν���(PRC_SUNGJUK_UPDATE())�� ����� �۵��ϴ����� ���� Ȯ��
--   �� ���ν��� ȣ��
EXEC PRC_SUNGJUK_UPDATE(2, 100, 100, 100);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

SELECT *
FROM TBL_SUNGJUK;
--==>>
/*
1	������	90	80	70	240	80	B
2	��ҿ�	100	100	100	300	100	A
*/


--�� ������ ���ν���(PRC_STUDENTS_UPDATE())�� ����� �۵��ϴ����� ���� Ȯ��
-- ���� ������ Ȯ��
SELECT *
FROM TBL_STUDENTS;
--==>>
/*
superman	    �չ���	010-1111-1111	����� ������...
batman	    ���ش�	010-2222-2222	��⵵ ����
*/


-- ���ν��� ȣ��(Ʋ�� �н�����)
EXEC PRC_STUDENTS_UPDATE('superman', 'java001', '010-9999-9999', '��õ');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-- ������ Ȯ��
SELECT *
FROM TBL_STUDENTS;
--==>>
/*
superman	    �չ���	010-1111-1111	����� ������...
batman	    ���ش�	010-2222-2222	��⵵ ����
*/


-- ���ν��� ȣ��(��ȿ�� �н�����)
EXEC PRC_STUDENTS_UPDATE('superman', 'java006$', '010-9999-9999', '��õ');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-- ������ Ȯ��
SELECT *
FROM TBL_STUDENTS;
--==>>
/*
superman	    �չ���	010-9999-9999	��õ
batman	    ���ش�	010-2222-2222	��⵵ ����
*/
SELECT MAX(NUM)+1
FROM TBL_INSA;



