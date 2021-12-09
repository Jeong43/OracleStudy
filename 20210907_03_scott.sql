SELECT USER
FROM DUAL;
--==>> SCOTT

--���� UNION / UNION ALL ����--
-- �� �ǽ� ���̺� ����(TBL_JUMUN)
CREATE TABLE TBL_JUMUN              -- �ֹ� ���̺� ����
( JUNO      NUMBER                  -- �ֹ� ��ȣ
, JECODE    VARCHAR2(30)            -- ��ǰ �ڵ�
, JUSU      NUMBER                  -- �ֹ� ����
, JUDAY     DATE DEFAULT SYSDATE    -- �ֹ� ����
);
--==>> Table TBL_JUMUN��(��) �����Ǿ����ϴ�.
-- ���� �ֹ��� �߻����� ��� �ֹ��� ���� �����Ͱ� �Էµ� �� �ִ� ���̺�


--�� ������ �Է� �� ���� �ֹ� �߻�/����
INSERT INTO TBL_JUMUN VALUES
(1, 'Ȩ����', 20, TO_DATE('2001-11-01 09:00:10', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(2, '�������', 10, TO_DATE('2001-11-01 09:23:15', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(3, '������', 30, TO_DATE('2001-11-02 12:00:11', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(4, '��Ĩ', 10, TO_DATE('2001-11-02 15:16:17', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(5, '������', 50, TO_DATE('2001-11-03 10:22:33', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(6, 'Ȩ����', 50, TO_DATE('2001-11-04 11:11:11', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(7, '��Ĩ', 20, TO_DATE('2001-11-06 19:10:10', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(8, '��īĨ', 40, TO_DATE('2001-11-13 09:07:09', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(9, 'Ģ��', 30, TO_DATE('2001-11-15 10:23:09', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(10, '�����', 20, TO_DATE('2001-11-16 14:20:00', 'YYYY-MM-DD HH24:MI:SS'));
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 10

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session��(��) ����Ǿ����ϴ�.

UPDATE TBL_JUMUN
SET JECODE = '������'
WHERE JUNO = 2;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	Ȩ����	20	2001-11-01 09:00:10
2	������	10	2001-11-01 09:23:15
3	������	30	2001-11-02 12:00:11
4	��Ĩ  	10	2001-11-02 15:16:17
5	������	50	2001-11-03 10:22:33
6	Ȩ����	50	2001-11-04 11:11:11
7	��Ĩ  	20	2001-11-06 19:10:10
8	��īĨ	40	2001-11-13 09:07:09
9	Ģ��  	30	2001-11-15 10:23:09
10	�����	20	2001-11-16 14:20:00
*/


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� ������ �߰� �Է� �� 2001�� ���� ���۵� �ֹ���... ����(2021��)���� ��� �߻�~!!!
INSERT INTO TBL_JUMUN VALUES(98785, 'Ȩ����', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98786, '������', 20, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98787, 'Ȩ����', 20, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98788, '�����', 20, SYSDATE); 
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98789, '��Ĩ', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. 

INSERT INTO TBL_JUMUN VALUES(98790, '��Ĩ', 20, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98791, '����Ĩ', 20, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98792, '�Ǻ���', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98793, 'Ȩ����', 30, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98794, 'Ȩ����', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	    Ȩ����	20	2001-11-01 09:00:10
2	    ������	10	2001-11-01 09:23:15
3	    ������	30	2001-11-02 12:00:11
4	    ��Ĩ  	10	2001-11-02 15:16:17
5	    ������	50	2001-11-03 10:22:33
6	    Ȩ����	50	2001-11-04 11:11:11
7	    ��Ĩ	    20	2001-11-06 19:10:10
8	    ��īĨ	40	2001-11-13 09:07:09
9	    Ģ��	    30	2001-11-15 10:23:09
10	    �����	20	2001-11-16 14:20:00
98785	Ȩ����	10	2021-09-07 14:27:11
98786	������	20	2021-09-07 14:27:20
98787	Ȩ����	20	2021-09-07 14:27:27
98788	�����	20	2021-09-07 14:27:32
98789	��Ĩ	    10	2021-09-07 14:28:25
98790	��Ĩ	    20	2021-09-07 14:28:30
98791	����Ĩ	20	2021-09-07 14:29:09
98792	�Ǻ���	10	2021-09-07 14:29:13
98793	Ȩ����	30	2021-09-07 14:30:01
98794	Ȩ����	10	2021-09-07 14:30:11
*/


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� ���ϰ� ���� ���θ� � ��...
--   TBL_JUMUN ���̺��� �ʹ� ���ſ��� ��Ȳ
--   ���ø����̼ǰ��� �������� ���� �ֹ� ������ �ٸ� ���̺� ����� �� �ֵ���
--   �ٽ� �����ϴ� ���� �Ұ����� ��Ȳ
--   �� ���������... ������� ������ �ֹ� �����͵� ��
--      ���� �߻��� �ֹ� ������ �����ϰ� �������� �ٸ� ���̺�(TBL_JUMUNBACKUP)��
--      ������ �̰��� ������ ��ȹ

--�� ���� �ֹ��� �ƴ� �� Ȯ��
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');


--�� ���� ��ȸ ����� TBL_JUMUNBACKUP ���̺� ����
CREATE TABLE TBL_JUMUNBACKUP
AS
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
--==>> Table TBL_JUMUNBACKUP��(��) �����Ǿ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_JUMUNBACKUP;
--==>>
/*
1	Ȩ����	20	2001-11-01 09:00:10
2	������	10	2001-11-01 09:23:15
3	������	30	2001-11-02 12:00:11
4	��Ĩ	    10	2001-11-02 15:16:17
5	������	50	2001-11-03 10:22:33
6	Ȩ����	50	2001-11-04 11:11:11
7	��Ĩ  	20	2001-11-06 19:10:10
8	��īĨ	40	2001-11-13 09:07:09
9	Ģ��	    30	2001-11-15 10:23:09
10	�����	20	2001-11-16 14:20:00
*/
--> TBL_JUMUN ���̺��� ������ ��
--  ���� �ֹ����� �̿��� �����ʹ� ��� TBL_JUMUNBACKUP ���̺� ����� ��ģ ����


--�� TBL_JUMUN ���̺��� ������ ��
--   ����� ��ģ �����͵� ���� �� ���� �ֹ��� �ƴ� ������ ����
DELETE
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
--==>> 10�� �� ��(��) �����Ǿ����ϴ�. (�� 98784 ���� �����Ͱ� �����ƴٰ� ����)

-- ���� ��ǰ �߼��� �Ϸ���� ���� ���� �ֹ� �����͸� �����ϰ�
-- ������ ��� �ֹ� �����͵��� ������ ��Ȳ�̹Ƿ�
-- ���̺��� ��(���ڵ�)�� ������ �پ��� �ſ� �������� ��Ȳ


--�� Ȯ��
SELECT *
FROM TBL_JUMUN;
--==>>
/*
98785	Ȩ����	10	2021-09-07 14:27:11
98786	������	20	2021-09-07 14:27:20
98787	Ȩ����	20	2021-09-07 14:27:27
98788	�����	20	2021-09-07 14:27:32
98789	��Ĩ  	10	2021-09-07 14:28:25
98790	��Ĩ	    20	2021-09-07 14:28:30
98791	����Ĩ	20	2021-09-07 14:29:09
98792	�Ǻ���	10	2021-09-07 14:29:13
98793	Ȩ����	30	2021-09-07 14:30:01
98794	Ȩ����	10	2021-09-07 14:30:11
*/


--�� Ŀ��
COMMIT;

-- �׷���, ���ݱ��� �ֹ� ���� ������ ���� ������
-- ��ǰ�� �� �ֹ������� ��Ÿ���� �� ��Ȳ�� �߻��ϰ� �Ǿ���.
-- �׷��ٸ�... TBL_JUMUNBACKUP ���̺��� ���ڵ�(��)��
-- TBL_JUMUN ���̺��� ���ڵ�(��)�� ���ļ� �ϳ��� ���̺���
-- ��ȸ�ϴ� �Ͱ� ���� ����� Ȯ���� �� �ֵ��� �ؾ� �Ѵ�.

-- �÷��� �÷��� ���踦 ����Ͽ� ���̺��� �����ϰ��� �ϴ� ���
-- JOIN �� ���������
-- ���ڵ�(��)�� ���ڵ�(��)�� �����ϰ��� �ϴ� ���
-- UNION / UNION ALL �� ����� �� �ִ�.


SELECT *
FROM TBL_JUMUNBACKUP
UNION
SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;


--�� ���̺� ���� �ٲٱ�

SELECT *
FROM TBL_JUMUN
UNION
SELECT *
FROM TBL_JUMUNBACKUP;

SELECT *
FROM TBL_JUMUN
UNION ALL
SELECT *
FROM TBL_JUMUNBACKUP;

--�� UNION �� �׻� ������� ù ��° �÷��� ��������
--   �������� ������ �����Ѵ�.
--   UNION ALL �� ���յ� ������� ��ȸ�� ����� ��ȯ�Ѵ�. (���� ����)
--   �̷� ���� ���� ����� �����ϰ� �ִ� UNION �� ���ϰ� �� ũ��.
--   ����, UNION �� ��������� �ߺ��� ���� ������ ���
--   �ߺ��� �����ϰ� 1�� �ุ ��ȸ�� ����� ��ȯ�Ѵ�.

-->  ����, UNION�� ���ϰ� ũ��,
--   �ǹ������� ������ �� ���� UNION ALL�� �� ���� ����!


--�� ���ݱ��� �ֹ����� ��� �����͸� ����
--   ��ǰ�� �� �ֹ����� ��ȸ�ϴ� �������� �����Ѵ�.
/*
------------------------------------
    ��ǰ�ڵ�        �� �ֹ���
------------------------------------
    ...             XX
    ...             XXXX

-------------------------------------
*/

SELECT JECODE "��ǰ�ڵ�", SUM(JUSU) "�� �ֹ���"
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
    UNION ALL
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
)
GROUP BY JECODE;
--==>>
/*
��Ĩ  	60
����Ĩ	20
�����	40
������	10
�Ǻ���	10
��īĨ	40
Ģ��	    30
Ȩ����	140
������	50
������	50
*/


SELECT JECODE "��ǰ�ڵ�", SUM(JUSU) "�� �ֹ���"
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
    UNION 
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
)
GROUP BY JECODE;
--==>>
/*
��Ĩ  	30
����Ĩ	20
������	10
�����	20
�Ǻ���	10
Ģ��    30
��īĨ	40
������	50
������	50
Ȩ����	110
*/
--> �� ������ �ذ��ϴ� �������� UNION �� ����ؼ��� �� �ȴ�.
--  �� JECODE �� JUSU �� ��ȸ�ϴ� �������� �ߺ��� ���� �����ϴ� ��Ȳ �߻�~!!!


--�� INTERSECT / MINUS (�� ������ / ������)
-- TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺���
-- ��ǰ�ڵ�� �ֹ����� ���� �Ȱ��� �ظ� �����ϰ��� �Ѵ�.
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP;
SELECT JECODE, JUSU
FROM TBL_JUMUN;

SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
�����	20
��Ĩ  	10
��Ĩ	    20
Ȩ����	20
*/


--�� TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺���
--   ��ǰ�ڵ�� �ֹ����� ���� �Ȱ��� ���� ������
--   �ֹ���ȣ, ��ǰ�ڵ�, �ֹ���, �ֹ����� �׸����� ��ȸ�Ѵ�.

-- ���� Ǯ��
SELECT T1.*
FROM
(
    SELECT *
    FROM TBL_JUMUN
    UNION
    SELECT *
    FROM TBL_JUMUNBACKUP
) T1
, (
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
) T2
WHERE T1.JECODE = T2. JECODE
  AND T1.JUSU = T2.JUSU;
--==>>
/*
1	    Ȩ����	20	2001-11-01 09:00:10
4	    ��Ĩ	    10	2001-11-02 15:16:17
7	    ��Ĩ	    20	2001-11-06 19:10:10
10	    �����	20	2001-11-16 14:20:00
98787	Ȩ����	20	2021-09-07 14:27:27
98788	�����	20	2021-09-07 14:27:32
98789	��Ĩ	    10	2021-09-07 14:28:25
98790	��Ĩ	    20	2021-09-07 14:28:30
*/


-- ��� 1.
SELECT T2.JUNO "�ֹ���ȣ", T1.JECODE "��ǰ�ڵ�", T1.JUSU "�ֹ�����", T2.JUDAY "�ֹ�����"
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN    
) T1
JOIN
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) T2
ON T1.JECODE = T2.JECODE
   AND T1.JUSU = T2.JUSU;
--==>>
/*
1	    Ȩ����	20	2001-11-01 09:00:10
4	    ��Ĩ  	10	2001-11-02 15:16:17
7	    ��Ĩ  	20	2001-11-06 19:10:10
10	    �����	20	2001-11-16 14:20:00
98787	Ȩ����	20	2021-09-07 14:27:27
98788	�����	20	2021-09-07 14:27:32
98789	��Ĩ  	10	2021-09-07 14:28:25
98790	��Ĩ  	20	2021-09-07 14:28:30
*/
    
    
-- ��� 2.
SELECT T.*
FROM
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN    
) T
--WHERE JECODE IN ('Ȩ����', '��Ĩ', '�����')
--  AND JUSU IN (10, 20)
--WHERE JECODE || JUSU IN ('Ȩ����20', '��Ĩ10', '��Ĩ20', '�����20');
--WHERE CONCAT(JECODE, JUSU) IN ('Ȩ����20', '��Ĩ10', '��Ĩ20', '�����20');
WHERE CONCAT(JECODE, JUSU) =ANY ('Ȩ����20', '��Ĩ10', '��Ĩ20', '�����20');
    

SELECT CONCAT(JECODE, JUSU)
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT CONCAT(JECODE, JUSU)
FROM TBL_JUMUN;
--==>>
/*
�����20
��Ĩ10
��Ĩ20
Ȩ����20
*/
  
    
SELECT T.*
FROM
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN    
) T
WHERE CONCAT(JECODE, JUSU) =ANY (SELECT CONCAT(JECODE, JUSU)
                                FROM TBL_JUMUNBACKUP
                                INTERSECT
                                SELECT CONCAT(JECODE, JUSU)
                                FROM TBL_JUMUN);    
--==>>
/*
1	    Ȩ����	20	2001-11-01 09:00:10
4	    ��Ĩ	    10	2001-11-02 15:16:17
7	    ��Ĩ  	20	2001-11-06 19:10:10
10	    �����	20	2001-11-16 14:20:00
98787	Ȩ����	20	2021-09-07 14:27:27
98788	�����	20	2021-09-07 14:27:32
98789	��Ĩ  	10	2021-09-07 14:28:25
98790	��Ĩ  	20	2021-09-07 14:28:30
*/
    
    
-- MINUS : ������
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
�����	20
��Ĩ  	10
��Ĩ	    20
Ȩ����	20
*/
    
    
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
MINUS
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
������	10
������	50
������	30
Ģ��	    30
��īĨ	40
Ȩ����	50
*/
    
/*
A = {10, 20, 30, 40, 50}
B = {10, 20, 30}

A - B = {40, 50}
*/
    
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
    
-- CHECK~!!!
SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP NATURAL JOIN DEPT;
--> ������� ã��, ��ȸ�ϴ� �÷��� ��� �����;� �ϴ��� �����ؾ� �Ѵ�.
--> ����Ŭ�� ���� ���ϰ� �����Ƿ� �������� �ʴ� ���.

SELECT DEPT.DEPTNO, DNAME, ENAME, SAL
FROM EMP JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP JOIN DEPT
USING(DEPTNO);
--> �����ϴµ� ����ϴ� �÷��� �������� ���
    
    
    
    
    
    
    
    
    