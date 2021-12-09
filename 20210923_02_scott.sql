SELECT USER
FROM DUAL;
--==>> SCOTT


--�� �ǽ� ���̺� ����(TBL_TEST2) �� �θ� ���̺�
CREATE TABLE TBL_TEST2
( CODE  NUMBER
, NAME  VARCHAR2(40)
, CONSTRAINT TEST2_CODE_PK PRIMARY KEY(CODE)
);
--==>> Table TBL_TEST2��(��) �����Ǿ����ϴ�.

--�� �ǽ� ���̺� ����(TBL_TEST3) �� �ڽ� ���̺�
CREATE TABLE TBL_TEST3
( SID   NUMBER
, CODE  NUMBER
, SU    NUMBER
, CONSTRAINT TEST3_SID_PK PRIMARY KEY(SID)
, CONSTRAINT TEST3_CODE_FK FOREIGN KEY(CODE)
             REFERENCES TBL_TEST2 (CODE)
);
--==>> Table TBL_TEST3��(��) �����Ǿ����ϴ�.

--�� ������ �Է�
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(1, '�����');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(2, '��Ź��');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(3, '������');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 2

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	�����
2	��Ź��
3	������
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� ������ �Է�
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(1, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(2, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(3, 2, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(4, 3, 40);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(5, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(6, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(7, 3, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(8, 3, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(9, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(10, 3, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(11, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(12, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(13, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(14, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(15, 3, 20);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 15

SELECT *
FROM TBL_TEST3;
--==>>
/*
1	1	20
2	1	20
3	2	30
4	3	40
5	2	20
6	2	20
7	3	20
8	3	20
9	2	20
10	3	20
11	2	20
12	2	20
13	1	20
14	2	20
15	3	20
*/

SELECT T2.SID, T1.CODE, T2.SU, T1.NAME
FROM TBL_TEST2 T1 JOIN TBL_TEST3 T2
    ON T1.CODE = T2.CODE;
--==>>
/*
1	1	20	�����
2	1	20	�����
3	2	30	��Ź��
4	3	40	������
5	2	20	��Ź��
6	2	20	��Ź��
7	3	20	������
8	3	20	������
9	2	20	��Ź��
10	3	20	������
11	2	20	��Ź��
12	2	20	��Ź��
13	1	20	�����
14	2	20	��Ź��
15	3	20	������
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.


-- �θ� ���̺�(TBL_TEST2)���� ����� ����
DELETE
FROM TBL_TEST2
WHERE CODE=1;
--==>> ���� �߻�
/*
ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found
*/

DELETE 
FROM TBL_TEST3
WHERE CODE=1;
--==>> 3�� �� ��(��) �����Ǿ����ϴ�.


SELECT T2.SID, T1.CODE, T2.SU, T1.NAME
FROM TBL_TEST2 T1 JOIN TBL_TEST3 T2
    ON T1.CODE = T2.CODE;
--==>>
/*
3	2	30	��Ź��
4	3	40	������
5	2	20	��Ź��
6	2	20	��Ź��
7	3	20	������
8	3	20	������
9	2	20	��Ź��
10	3	20	������
11	2	20	��Ź��
12	2	20	��Ź��
14	2	20	��Ź��
15	3	20	������
*/


COMMIT;
--==>> Ŀ�� �Ϸ�.


DELETE
FROM TBL_TEST2
WHERE CODE=1;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


SELECT *
FROM TBL_TEST2;
--==>>
/*
2	��Ź��
3	������
*/


COMMIT;
--==>> Ŀ�� �Ϸ�.


SELECT *
FROM TBL_TEST2
WHERE CODE = 2;
--==>> 2	    ��Ź��


DELETE
FROM TBL_TEST2
WHERE CODE = 2;
--==>> ���� �߻�
/*
ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found
*/


SELECT *
FROM TBL_TEST2
WHERE CODE = 3;
--==>> 3	������


DELETE
FROM TBL_TEST2
WHERE CODE = 3;
--==>> ���� �߻�
/*
ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found
*/


--�� Ʈ���� �ۼ� ���� �ٽ� �׽�Ʈ

DELETE
FROM TBL_TEST2
WHERE CODE = 3;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_TEST2;
--==>> 2    	��Ź��

SELECT *
FROM TBL_TEST3;
--==>>
/*
3	2	30
5	2	20
6	2	20
9	2	20
11	2	20
12	2	20
14	2	20
*/


DELETE
FROM TBL_TEST2
WHERE CODE = 2;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_TEST2;

SELECT *
FROM TBL_TEST3;


TRUNCATE TABLE TBL_�԰�;
--==>> Table TBL_�԰���(��) �߷Ƚ��ϴ�.

TRUNCATE TABLE TBL_���;
--==>> Table TBL_�����(��) �߷Ƚ��ϴ�.

UPDATE TBL_��ǰ
SET ������ = 0;
--==>> 21�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT *
FROM TBL_�԰�;
SELECT *
FROM TBL_���;
SELECT *
FROM TBL_��ǰ;


INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
VALUES(1, 'C001', SYSDATE, 100, 1800);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

UPDATE TBL_��ǰ
SET ������ = 35
WHERE ��ǰ�ڵ� = 'C001';

INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
VALUES(2, 'C002', SYSDATE, 100, 1600);

DELETE
FROM TBL_�԰�
WHERE �԰��ȣ = 1;

INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
VALUES(4, 'C001', SYSDATE, 1, 1100);

INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
VALUES(5, 'C001', SYSDATE, 1, 1100);

INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
VALUES(6, 'C001', SYSDATE, 1, 1100);

UPDATE TBL_�԰�
SET �԰���� = 2
WHERE �԰��ȣ = 1;

DELETE 
FROM TBL_�԰�
WHERE �԰��ȣ = 1; 

INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
VALUES(7, 'C001', SYSDATE, 1, 1100);

UPDATE TBL_�԰�
SET �԰���� = 2
WHERE �԰��ȣ = 1;

INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, �������, ������, ���ܰ�)
VALUES(1, 'C001', SYSDATE, 10, 2100);

INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, �������, ������, ���ܰ�)
VALUES(2, 'C001', SYSDATE, 1, 2100);

INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, �������, ������, ���ܰ�)
VALUES(3, 'C001', SYSDATE, 1, 2100);

INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, �������, ������, ���ܰ�)
VALUES(4, 'C001', SYSDATE, 1, 2100);

UPDATE TBL_���
SET ������ = 200000
WHERE ����ȣ = 6;

INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, �������, ������, ���ܰ�)
VALUES(7, 'C001', SYSDATE, 1000, 2100);


DELETE 
FROM TBL_���
WHERE ����ȣ = 6; 


--------------------------------------------------------------------------------
SELECT INSA_PACK.FN_GENDER('751212-1234567') RESULT
FROM DUAL;
--==>> ����

SELECT NAME, SSN, INSA_PACK.FN_GENDER(SSN) "����"
FROM TBL_INSA;



