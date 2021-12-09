SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT *
FROM TBL_���;


--�� �ǽ� ���̺� ����(TBL_TEST1)
CREATE TABLE TBL_TEST1
( ID    NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
);
--==>> Table TBL_TEST1��(��) �����Ǿ����ϴ�.

--�� ������ ���̺� �������� �߰�
--   ID �÷��� PK �������� ����
ALTER TABLE TBL_TEST1
ADD CONSTRAINT TEST1_ID_PK PRIMARY KEY(ID);
--==>> Table TBL_TEST1��(��) ����Ǿ����ϴ�.


--�� �ǽ� ���̺� ����(TBL_EVENTLOG)
CREATE TABLE TBL_EVENTLOG
( MEMO  VARCHAR2(200)
, ILJA  DATE DEFAULT SYSDATE
);
--==>> Table TBL_EVENTLOG��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_TEST1;
--==>> ��ȸ ��� ����

SELECT *
FROM TBL_EVENTLOG;
--==>> ��ȸ ��� ����


--�� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� TBL_TEST1 ���̺� ������ �Է�
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1, '����ȣ', '010-1111-1111');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(2, '�����', '010-2222-2222');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� TBL_TEST1 ���̺� ������ ����
UPDATE TBL_TEST1
SET NAME = '����'
WHERE ID = 1;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

--�� TBL_TEST1 ���̺� ������ ����
DELETE
FROM TBL_TEST1
WHERE ID = 1;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_TEST1
WHERE ID = 2;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_TEST1;
--==>> ��ȸ ��� ����

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� TBL_EVENTLOG ���̺� ��ȸ
SELECT *
FROM TBL_EVENTLOG;
--==>>
/*
INSERT �������� ����Ǿ����ϴ�.	2021-09-17 17:19:40
INSERT �������� ����Ǿ����ϴ�.	2021-09-17 17:20:03
UPDATE �������� ����Ǿ����ϴ�.	2021-09-17 17:20:39
DELETE �������� ����Ǿ����ϴ�.	2021-09-17 17:21:30
DELETE �������� ����Ǿ����ϴ�.	2021-09-17 17:21:45
*/

SELECT TO_CHAR(SYSDATE, 'HH24')
FROM DUAL;
--==>> 17   �� ���� Ÿ��

SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'))
FROM DUAL;
--==>> 17   �� ���� Ÿ��


--�� �׽�Ʈ
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(3, '������', '010-3333-3333');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(4, '������', '010-4444-4444');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

UPDATE TBL_TEST1
SET NAME = '��ȿ��'
WHERE ID = 4;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

DELETE
FROM TBL_TEST1
WHERE ID = 4;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_TEST1;
--==>> 3	������	010-3333-3333

COMMIT;


-- ����Ŭ ������ �ð��� ���� 7�� ��� ����
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(5, '���±�', '010-5555-5555');
--==>> ���� �߻�
/*
ORA-20003: �۾��� 8:00 ~ 18:00 ������ �����մϴ�.
*/

UPDATE TBL_TEST1
SET NAME = '���±�'
WHERE ID = 3;
--==>> ���� �߻�
/*
ORA-20003: �۾��� 8:00 ~ 18:00 ������ �����մϴ�.
*/

DELETE
FROM TBL_TEST1
WHERE ID=3;
--==>> ���� �߻�
/*
ORA-20003: �۾��� 8:00 ~ 18:00 ������ �����մϴ�.
*/


--�� Ȯ��
SELECT *
FROM TBL_TEST1;
--==>> 3	������	010-3333-3333








