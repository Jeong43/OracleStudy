SELECT USER
FROM DUAL;
--==>> SCOTT

/*
--���� UPDATE ����--
1. ���̺��� ���� �����͸� �����ϴ� ����.

2. ���� �� ����
UPDATE ���̺��
SET �÷��� = �����Ұ�[, �÷��� = �����Ұ�, �÷��� =�����Ұ�]
[WHERE ������]

*/



--�� TBL_SAWON ���̺��� �����ȣ 1003�� ����� 
--   �ֹι�ȣ�� ��9907222234567�� �� �����Ѵ�.
UPDATE TBL_SAWON
SET JUBUN = 9907222234567
WHERE SANO = 1003;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_SAWON;

COMMIT;

--�� TBL_SAWON ���̺��� 1005�� ����� �Ի��ϰ� �޿���
--   ���� 2018-02-22, 1200 ���� �����Ѵ�.
UPDATE TBL_SAWON
SET HIREDATE = TO_DATE('2018-02-22', 'YYYY-MM-DD')
  , SAL = 1200
WHERE SANO = 1005;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� TBL_INSA ���̺��� �����͸� ����
CREATE TABLE TBL_INSABACKUP
AS
SELECT *
FROM TBL_INSA;
--==>> Table TBL_INSABACKUP��(��) �����Ǿ����ϴ�.


--�� TBL_INSABACKUP ���̺���
--   ������ ����� ���常 ���� 10% �λ�~!!!
UPDATE TBL_INSABACKUP
SET SUDANG = SUDANG * 1.1
WHERE JIKWI IN ('����', '����');

SELECT *
FROM TBL_INSABACKUP;

SELECT *
FROM TBL_INSA;


--�� TBL_INSABACKUP ���̺��� ��ȭ��ȣ�� 016, 017, 018, 019 �� �����ϴ�
--   ��ȭ��ȣ�� ��� �̸� ��� 010 ���� �����Ѵ�.
UPDATE TBL_INSABACKUP
SET TEL = '010' || SUBSTR(TEL, 4)
WHERE SUBSTR(TEL, 1, 3) IN('016', '017', '018', '019');
--==>> 24�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_INSABACKUP;

COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� TBL_SAWON ���̺� ��� (2021-09-10 16:10)
CREATE TABLE TBL_SAWONBACKUP
AS
SELECT *
FROM TBL_SAWON;
--==>> Table TBL_SAWONBACKUP��(��) �����Ǿ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_SAWONBACKUP;
SELECT *
FROM TBL_SAWON;
--> TBL_SAWON ���̺��� �����͵鸸 ����� ����
--  ��, �ٸ� �̸��� ���̺� ���·� �����͸� �����ص� ��Ȳ

-- UPDATE ó�� ���Ŀ� COMMIT �� �����Ͽ��� ������
-- �鳯 ó���غ���... ROLLBACK �� �Ұ����� ��Ȳ�̴�.
-- ������, TBL_SAWONBACKUP ���̺� �����͸� ����� �ξ���.
-- SANAME �÷��� ���븸 �����Ͽ� �ʶ��� ��� �־��� �� �ִٴ� ���̴�.

UPDATE TBL_SAWON
SET SANAME = (TBL_SAWONBACKUP ���̺��� 1001�� ����� �����);

UPDATE TBL_SAWON
SET SANAME = (TBL_SAWONBACKUP ���̺��� ���� �ڱ� �����ȣ�� �����);

UPDATE TBL_SAWON
SET SANAME = (SELECT SANAME
              FROM TBL_SAWONBACKUP
              WHERE SANO = TBL_SAWON.SANO);

SELECT *
FROM TBL_SAWON;

COMMIT;
--==>> Ŀ�� �Ϸ�.
