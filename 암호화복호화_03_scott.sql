SELECT USER
FROM DUAL;
--==>> SCOTT

--���� ��ȣȭ ��ȣȭ Ȯ�� �ǽ� ����--

--�� ���̺� ����
CREATE TABLE TBL_EXAM
( ID	NUMBER
, PW	VARCHAR2(20)
);
--==>> Table TBL_EXAM��(��) �����Ǿ����ϴ�.


--�� ������ �Է�(��ȣȭ)
--INSERT INTO TBL_EXAM(ID, PW) VALUES(1, 'java006$');
INSERT INTO TBL_EXAM(ID, PW) VALUES(1, CRYPTPACK.ENCRYPT('java006$', '1234'));
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� ������ ��ȸ
SELECT ID, PW
FROM TBL_EXAM;
--==>> 1	j??s
--@ �����ͺ��̽� �����ڵ� ������ �� �� ����! (�ٽ� POINT~!!!)
--@ ����Ŭ���� ǥ���� �� ���� ���ڿ��� ������


--> Ű���� �� ���
SELECT ID, CRYPTPACK.DECRYPT(PW, '1111')
FROM TBL_EXAM;
--==>> 1	???

SELECT ID, CRYPTPACK.DECRYPT(PW, '2222')
FROM TBL_EXAM;
--==>> 1	??D?


--> �ùٸ� Ű���� �Է����� ��
SELECT ID, CRYPTPACK.DECRYPT(PW, '1234')
FROM TBL_EXAM;
--==>> 1	java006$
