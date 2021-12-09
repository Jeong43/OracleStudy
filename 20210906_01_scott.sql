SELECT USER
FROM DUAL;
--==>> SCOTT


SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750
20	    10875
30	    9400
(null)	29025
*/

SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750        -- �μ���ȣ�� 10���� �������� �޿���
20	    10875       -- �μ���ȣ�� 20���� �������� �޿���
30	    9400        -- �μ���ȣ�� 30���� �������� �޿���
(null)	8000        -- �μ���ȣ�� �������� �ʴ� ������(null)�� �޿���
(null)	37025       -- ��� �μ��� �������� �޿���
*/


-- ������ ��ȸ�� ������
/*
10	        8750        -- �μ���ȣ�� 10���� �������� �޿���
20	        10875       -- �μ���ȣ�� 20���� �������� �޿���
30	        9400        -- �μ���ȣ�� 30���� �������� �޿���
����	    8000        -- �μ���ȣ�� �������� �ʴ� ������(null)�� �޿���
���μ�    	37025       -- ��� �μ��� �������� �޿���
*/
-- �̿� ���� ��ȸ�ϰ��� �Ѵ�.

SELECT CASE DEPTNO WHEN NULL
                   THEN '����'
                   ELSE DEPTNO
       END "�μ���ȣ"
FROM TBL_EMP;
--==>> ���� �߻�
/*
ORA-00932: inconsistent datatypes: expected CHAR got NUMBER
00932. 00000 -  "inconsistent datatypes: expected %s got %s"
*Cause:    
*Action:
46��, 29������ ���� �߻�
*/

SELECT CASE DEPTNO WHEN NULL
                   THEN '����'
                   ELSE TO_CHAR(DEPTNO)
       END "�μ���ȣ"
FROM TBL_EMP;
--==>>
/*
20
30
30
20
30
30
10
20
10
30
20
30
20
10
*/

SELECT CASE WHEN DEPTNO IS NULL
            THEN '����'
            ELSE TO_CHAR(DEPTNO)
       END "�μ���ȣ"
FROM TBL_EMP;
/*
20
30
30
20
30
30
10
20
10
30
20
30
20
10
����
����
����
����
����
*/

SELECT CASE WHEN DEPTNO IS NULL
            THEN '����'
            ELSE TO_CHAR(DEPTNO)
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750
20	    10875
30	    9400
����	8000
����	37025
*/


--�� GROPING()
SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���", GROUPING(DEPTNO)
FROM TBL_EMP
GROUP BY DEPTNO;
--==>>
/*
30	    9400	0
(null)	8000	0
20	    10875	0
10	    8750    	0
*/


SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���", GROUPING(DEPTNO)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750	    0
20	    10875	0
30	    9400	0
(null)	8000	0
(null)	37025	1
*/



--�� �Ʒ��� ���� ��ȸ�ϰ��� �Ѵ�.
/*
10	        8750        -- �μ���ȣ�� 10���� �������� �޿���
20	        10875       -- �μ���ȣ�� 20���� �������� �޿���
30	        9400        -- �μ���ȣ�� 30���� �������� �޿���
����	    8000        -- �μ���ȣ�� �������� �ʴ� ������(null)�� �޿���
���μ�    	37025       -- ��� �μ��� �������� �޿���
*/

SELECT CASE WHEN T.�׷�ܰ� = 1     THEN '���μ�'
            WHEN T.�μ���ȣ IS NULL THEN '����'
            ELSE TO_CHAR(T.�μ���ȣ)
       END "�μ���ȣ"
     , T.�޿���
FROM 
(
    SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���", GROUPING(DEPTNO) "�׷�ܰ�"
    FROM TBL_EMP
    GROUP BY ROLLUP(DEPTNO)
) T;



SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
            ELSE '���μ�' 
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	        8750
20	        10875
30	        9400
����	    8000
���μ�	    37025
*/


--�� TBL_SAWON ���̺��� ������ ���� ��ȸ�� �� �ֵ���
--   �������� �ۼ��Ѵ�.
/*
----------------------
    ����      �޿���
----------------------
    ��        XXXX
    ��        XXXX
    �����  XXXX
----------------------
*/


SELECT CASE GROUPING(T.����) WHEN 0 THEN T.����
            ELSE '�����'
       END "����"
     , SUM(T.�޿�) "�޿���"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '3') THEN '��'
                WHEN SUBSTR(JUBUN, 7, 1) IN('2', '4') THEN '��'
                ELSE 'Ȯ�κҰ�'
           END "����"
         , SAL "�޿�"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>>
/*
��	        20000
��	        21000
�����	    41000
*/



--�� TBL_SAWON ���̺��� ������ ���� ���ɴ뺰 �ο��� ���·�
--   ��ȸ�� �� �ֵ��� �������� �ۼ��Ѵ�.
/*
------------------------------------------
���ɴ�             �ο���
------------------------------------------
10                  X
20                  X
30                  X
40                  X
50                  X
��ü                XX
------------------------------------------
*/

SELECT *
FROM TBL_SAWON;

--�� ���� Ǯ��
SELECT CASE GROUPING(T.���ɴ�) WHEN 0 THEN TO_CHAR(T.���ɴ�)
                              ELSE '��ü'
       END "���ɴ�"
     , COUNT(T.���ɴ�) "�ο���"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN TRUNC((EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900) + 1), -1)  
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                THEN TRUNC((EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000) + 1), -1)
                ELSE -1
           END "���ɴ�"  -- ���̸� ����
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.���ɴ�);


--�� �Բ� Ǯ��
-- ���1. (INLINE VIEW �� �� �� ��ø)
SELECT CASE GROUPING(Q.���ɴ�) WHEN 0 THEN TO_CHAR(Q.���ɴ�)
                              ELSE '��ü'
       END "���ɴ�"
     , COUNT(Q.���ɴ�) "�ο���"
FROM 
(
    SELECT CASE WHEN T.���� >= 50 THEN 50
                WHEN T.���� >= 40 THEN 40
                WHEN T.���� >= 30 THEN 30
                WHEN T.���� >= 20 THEN 20
                WHEN T.���� >= 10 THEN 10            
                ELSE 0
           END "���ɴ�"
    FROM
    (
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '2')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                    WHEN SUBSTR(JUBUN, 7, 1) IN('3', '4')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                    ELSE 0
               END "����"
        FROM TBL_SAWON
    ) T
) Q
GROUP BY ROLLUP(Q.���ɴ�);


-- ���2. (INLINE VIEW �� �� �� ���)
SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '2')
                  THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                  WHEN SUBSTR(JUBUN, 7, 1) IN('3', '4')
                  THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                  ELSE 0
            END, -1) "���ɴ�" 
FROM TBL_SAWON;


SELECT TRUNC(23, -1) "Ȯ��"
FROM DUAL;
--==>> 20 �� 23���� ���ɴ�


--�� ROLLUP Ȱ�� �� CUBE
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10		(null)      8750    -- 10�� �μ� ��� ������ �޿���
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20		(null)      10875   -- 20�� �μ� ��� ������ �޿���
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	    5600
30      (null)		9400    -- 30�� �μ� ��� ������ �޿���
(null)  (null)		29025   -- ��� �μ� ��� ������ �޿���
*/


SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10		(null)      8750        -- 10�� �μ� ��� ������ �޿���
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20		(null)      10875       -- 20�� �μ� ��� ������ �޿���
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	    5600
30		(null)      9400        -- 30�� �μ� ��� ������ �޿���
(null)	ANALYST	    6000        -- ��� �μ� ANALYST ������ �޿���
(null)	CLERK	    4150        -- ��� �μ� CLERK ������ �޿���
(null)	MANAGER	    8275        -- ��� �μ� MANAGER ������ �޿���
(null)	PRESIDENT	5000        -- ��� �μ� PRESIDENT ������ �޿���
(null)	SALESMAN	    5600        -- ��� �μ� SALESMAN ������ �޿���
(null)  (null)		29025       -- ��� �μ� ��� ������ �޿���
*/


--�� ROLLUP() �� CUBE() ��
--   �׷��� �����ִ� ����� �ٸ���. --����

-- ROLLUP(A, B, C)
-- �� (A, B, C) / (A, B) / (A) / ()

-- CUBE(A, B, C)
-- �� (A, B, C) / (A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()


--==>> ���� ó�� ������ �ʹ� ���� ������� ��µǱ� ������
--     ������ ���� ���¸� �� ���� ����Ѵ�.
--     ���� �ۼ��ϴ� ������ ��ȸ�ϰ��� �ϴ� �׷츸 ��GROUPING SETS����
--     �̿��Ͽ� �����ִ� ����̴�.

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
                            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
                         ELSE '��ü����'
       END "����" 
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>> 
/*
10	        CLERK	    1300    -> 1. �μ���ȣ�� ������ ��� ���� �͵鳢�� ����
10	        MANAGER	    2450
10	        PRESIDENT	5000
10	        ��ü����	    8750    -> 2. �μ� ��ȣ�� ���� �͵鳢��
20	        ANALYST	    6000
20	        CLERK	    1900
20	        MANAGER	    2975
20	        ��ü����    	10875
30	        CLERK	    950
30	        MANAGER	    2850
30	        SALESMAN    	5600
30	        ��ü����    	9400
����  	    CLERK	    2500
����  	    SALESMAN    	5500
����	    ��ü����    	8000
��ü�μ�	    ��ü����    	37025   -> 3.��ü ��
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
                            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
                         ELSE '��ü����'
       END "����" 
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;

--> �μ���ȣ / ���� / ��ü ��
/*
10	        CLERK	    1300
10	        MANAGER	    2450
10	        PRESIDENT	5000
10	        ��ü����	    8750
20	        ANALYST	    6000
20	        CLERK	    1900
20	        MANAGER	    2975
20	        ��ü����	    10875
30	        CLERK	    950
30	        MANAGER	    2850
30	        SALESMAN    	5600
30	        ��ü����    	9400
����	    CLERK	    2500
����	    SALESMAN    	5500
����	    ��ü����    	8000
��ü�μ�    	ANALYST	    6000
��ü�μ�    	CLERK	    6650
��ü�μ�    	MANAGER	    8275
��ü�μ�    	PRESIDENT	5000
��ü�μ�    	SALESMAN    	11100
��ü�μ�    	��ü����    	37025
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
                            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
                         ELSE '��ü����'
       END "����" 
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), DEPTNO, ())    --ROLLUP() �� ���� ���
ORDER BY 1, 2;


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
                            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
                         ELSE '��ü����'
       END "����" 
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB), ())    --CUBE() �� ���� ���
ORDER BY 1, 2;


--�� TBL_EMP ���̺��� �Ի�⵵�� �ο����� ��ȸ�Ѵ�.
SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;


SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE))
            WHEN 0 THEN TO_CHAR(EXTRACT(YEAR FROM HIREDATE))
            ELSE '��ü'
       END "�Ի�⵵"
     , COUNT(EXTRACT(YEAR FROM HIREDATE)) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE));


SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;

SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;

SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY GROUPING SETS(EXTRACT(YEAR FROM HIREDATE), ())
ORDER BY 1;


-- ����!
SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))      --'1980', '1981', '1982'...
ORDER BY 1;
--==>> ���� �߻�
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
499��, 26������ ���� �߻�
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY CUBE(TO_CHAR(HIREDATE, 'YYYY'))      --'1980', '1981', '1982'...
ORDER BY 1;
--==>> ���� �߻�
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
513��, 26������ ���� �߻�
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY GROUPING SETS(TO_CHAR(HIREDATE, 'YYYY'), ())      --'1980', '1981', '1982'...
ORDER BY 1;
--==>> ���� �߻�
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
527��, 26������ ���� �߻�
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')      --'1980', '1981', '1982'...
ORDER BY 1;
--==>> ���� �߻�
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
541��, 26������ ���� �߻�
*/

--> GROUP BY ���� ������ ����� SELECT���� ����ϴ� ������ �޶� �߻��ϴ� �����ϱ�?

SELECT TO_CHAR(HIREDATE, 'YYYY') "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')      --'1980', '1981', '1982'...
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982    	1
1987	2
2021    	5
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY TO_NUMBER(TO_CHAR(HIREDATE, 'YYYY'))      --'1980', '1981', '1982'...
ORDER BY 1;
--> ���� Ÿ������ �ٲ�µ��� ���� �߻�
--> �Ľ� ���� ������ �߻��ϴ� ���� (�׷���� �� ���� -> ����Ʈ�� ������ �ٸ�.)
--> �׷���� �� �� ����Ʈ �ؾ� �Ѵ�!!

SELECT TO_NUMBER(TO_CHAR(HIREDATE, 'YYYY')) "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY TO_NUMBER(TO_CHAR(HIREDATE, 'YYYY'))      --'1980', '1981', '1982'...
ORDER BY 1;


--------------------------------------------------------------------------------
--���� HAVING ����--
-- ������

--�� EMP ���̺��� �μ���ȣ�� 20, 30�� �μ��� �������
--   �μ��� �� �޿��� 10000 ���� ���� ��츸 �μ��� �� �޿��� ��ȸ�Ѵ�.

SELECT *
FROM EMP;

SELECT DEPTNO "�μ���ȣ"
     , SUM(SAL) "�� �޿�"
FROM EMP
GROUP BY DEPTNO
ORDER BY 1;

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN(20, 30)
      AND SUM(SAL) < 10000
GROUP BY DEPTNO;
--==>> ���� �߻�

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN(20, 30)
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000;
--==>> 30	9400
--> �� �����ϴ� ����
-- WHERE ���� �ش��ϴ� �͸� �޸𸮿� �÷��� �� ó���ϹǷ�
-- ��� HAVING ������ ó���ϴ� �ͺ��� �� ȿ�����̴�.

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING DEPTNO IN(20, 30)
   AND SUM(SAL) < 10000;
--==>> 30	9400


--------------------------------------------------------------------------------

--���� ��ø �׷��Լ� / �м��Լ� ����---

-- �׷� �Լ� 2 LEVEL ���� ��ø�ؼ� ����� �� �ִ�.
-- �̸�����... MSSQL�� �Ұ����ϴ�.

SELECT SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
--==>>
/*
9400
10875
8750
*/

SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>> 10875


-- RANK()
-- DENSE_RANK()
--> ORCLE 9i ���� ����... MSSQL 2005���� ����...

--�� ���� ���������� RANK() �� DENSE_RANK() �� ������ �� ���� ������
--   �̸� ��ü�Ͽ� ������ ������ �� �ִ� ����� �����ؾ� �Ѵ�.

-- ���� ���, �޿��� ������ ���ϰ��� �Ѵٸ�...
-- �ش� ����� �޿����� �� ū ���� �� ������ Ȯ���� ��
-- Ȯ���� ���ڿ� +1 �� �߰� �������ָ� �װ��� �� ����� �ȴ�.

-- 80 90 10 50 �� 50 ���� ���� 2��(80, 90) �� 2 + 1 �� 3��
--          -- 

SELECT ENAME, SAL, 1
FROM EMP;

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;
--==>> 14 �� SMITH�� �޿� ���

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600;
--==>> 7 �� ALLEN�� �޿� ���

SELECT ENAME, SAL, RANK() OVER(ORDER BY SAL DESC)
FROM EMP;


--�� ���� ��� ���� (��� ���� ����)
--   ���� ������ �ִ� ���̺� �÷���
--   ���� ������ ������(WHERE��, HAVING��)�� ���Ǵ� ���
--   �츮�� �� �������� ���� ��� ������� �θ���.

SELECT ENAME "�����", SAL "�޿�", 1 "�޿����"
FROM EMP;

SELECT E1.ENAME "�����", E1.SAL "�޿�", (SELECT COUNT(*) + 1
                                          FROM EMP E2
                                          WHERE E2.SAL > E1.SAL) "�޿����"
FROM EMP E1;
--==>>
/*
SMITH	800	    14
ALLEN	1600	7
WARD	    1250	    10
JONES	2975    	4
MARTIN	1250	    10
BLAKE	2850	    5
CLARK	2450    	6
SCOTT	3000	2
KING    	5000    	1
TURNER	1500    	8
ADAMS	1100	12
JAMES	950	    13
FORD	    3000	2
MILLER	1300	9
*/


--�� EMP ���̺��� �������
--   �����, �޿�, �μ���ȣ, �μ����޿����, ��ü�޿���� �׸��� ��ȸ�Ѵ�.
--   ��, RANK() �Լ��� ������� �ʰ�, ��� ���� ������ Ȱ���� �� �ֵ��� �Ѵ�.

SELECT E1.ENAME "�����", E1.SAL "�޿�", E1.DEPTNO "�μ���ȣ"
     , (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO
              AND E2.SAL > E1.SAL) "�μ����޿����"
     , (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.SAL > E1.SAL) "��ü�޿����"
FROM EMP E1
ORDER BY 3, 2 DESC;


--�� EMP ���̺��� ������� ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
--------------------------------------------------------------------------------
    �����  �μ���ȣ �Ի���     �޿�    �μ����Ի纰�޿�����
--------------------------------------------------------------------------------
    CLARK	10	    1981-06-09  2450    2450
    KING    10      1981-11-17  5000    7450
    MILLER	10	    1982-01-23	1300	8750
    SMITH	20	    1980-12-17	800	    800
    JONES	20	    1981-04-02	2975    	3775
    FORD    	20  	    1981-12-03	3000	6775
    SCOTT	20	    1987-07-13	3000	10875
    ADAMS	20	    1987-07-13	1100	10875
    ALLEN	30	    1981-02-20	1600	1600
    WARD    	30	    1981-02-22	1250	    2850
    BLAKE	30	    1981-05-01	2850	    5700
    TURNER	30	    1981-09-08	1500	    7200
    MARTIN	30	    1981-09-28	1250    	8450
    JAMES	30	    1981-12-03	950	    9400
*/

SELECT ENAME "�����", DEPTNO "�μ���ȣ", HIREDATE "�Ի���", SAL "�޿�"
     , (SELECT SUM(SAL)
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO
              AND E2.HIREDATE <= E1.HIREDATE) "�μ��޿�����"
FROM EMP E1
ORDER BY DEPTNO, HIREDATE;



--�� TBL_EMP ���̺��� �Ի��� ����� ���� ���� ������ ����
--   �Ի����� �ο����� ��ȸ�� �� �ִ� �������� �����Ѵ�.
/*
--------------------------------
    �Ի���        �ο���
--------------------------------
    2021-09         11
--------------------------------
*/
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (5);
--==>> 2021-09	5

SELECT MAX(COUNT(*))
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>> 5

SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM TBL_EMP
                   GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM'));
--==>> 2021-09	5


--------------------------------------------------------------------------------

--���� ROW_NUMBER() ����--
SELECT ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP;

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "�׽�Ʈ"
     , ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP;

--�� �Խ����� �Խù� ��ȣ�� SEQUENCE �� IDENTITY �� ����ϰ� �Ǹ�
--   �Խù��� �������� ���, ������ �Խù��� �ڸ��� ���� ��ȣ�� ����
--   �Խù��� ��ϵǴ� ��Ȳ�� �߻��ϰ� �ȴ�.
--   �̴� ���� ���鿡����... �̰����� ���鿡����... �ٶ������� ���� ��Ȳ�� �� �ֱ� ������
--   ROW_NUMBER() �� ����� ����� �� �� �ִ�.
--   ������ �������� ����� ������ SQUENCE �� IDENTITY �� ���������
--   �ܼ��� �Խù��� ���ȭ�Ͽ� ����ڿ��� ����Ʈ �������� ������ ������
--   ������� �ʴ� ���� ����.


--�� ����
CREATE TABLE TBL_AAA
( NO        NUMBER
, NAME      VARCHAR2(30)
, GRADE     CHAR(10)
);
--==>> Table TBL_AAA��(��) �����Ǿ����ϴ�.

INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(1, '�չ���', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(2, '���ش�', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(3, '������', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(4, '�ּ���', 'D');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(5, '���±�', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(6, '����ȭ', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(7, '�չ���', 'A');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 7

SELECT *
FROM TBL_AAA;
--==>>
/*
1	�չ���	A         
2	���ش�	B         
3	������	A         
4	�ּ���	D         
5	���±�	A         
6	����ȭ	A         
7	�չ���	A         
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.

UPDATE TBL_AAA
SET GRADE = 'A'
WHERE NAME = '�ּ���';
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_AAA;

UPDATE TBL_AAA
SET GRADE = 'A'
WHERE NAME = '�ּ���';
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.


--�� SEQUENCE (������: �ֹ���ȣ) ����
--   �� �������� �ǹ�: 1.(�Ϸ���) �������� ��ǵ�  2(���,�ൿ ����) ����

CREATE SEQUENCE SEQ_BOARD       -- ������ ���� �⺻����(MSSQL �� IDENTITY �� ������ ����)
START WITH 1                    -- ���۰�
INCREMENT BY 1                  -- ������
NOMAXVALUE                      -- �ִ밪 ���� ����
NOCACHE;                        -- ĳ�� ��� ����(����)
--==>> Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.


--�� ���̺� ����(TBL_BOARD)
CREATE TABLE TBL_BOARD              -- TBL_BOARD �̸��� ���̺� ���� �� �Խ���
( NO        NUMBER                  -- �Խù� ��ȣ           -- X
, TITLE     VARCHAR(50)             -- �Խù� ����           -- O
, CONTENTS  VARCHAR(2000)           -- �Խù� ����           -- O
, NAME      VARCHAR(20)             -- �Խù� �ۼ���         -- ��
, PW        VARCHAR(20)             -- �Խù� �н�����       -- ��
, CREATED   DATE DEFAULT SYSDATE    -- �Խù� �ۼ���         -- X
);
--==>> Table TBL_BOARD��(��) �����Ǿ����ϴ�.


--�� ������ �Է� �� �Խ��ǿ� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�ѽ�~1 1��', '���� 1��������', '����ȣ', 'JAVA006$', SYSDATE);
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�ǰ�����', '�ٵ� �ǰ� ì��ô�', '������', 'JAVA006$', SYSDATE);
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������', '���� �� ����', '�մ���', 'JAVA006$', SYSDATE);
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������', '���ڱ� �� ����', '������', 'JAVA006$', SYSDATE);
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�����ϰ� ������', '�ڲ� ������', '��ȿ��', 'JAVA006$', SYSDATE);
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '����', '������� ��� �ϳ���', '������', 'JAVA006$', SYSDATE);
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '����', '������ �����', '��ȿ��', 'JAVA006$', SYSDATE);

SELECT *
FROM TBL_BOARD;
--==>>
/*
1	�ѽ�~1 1��	        ���� 1��������	            ����ȣ	JAVA006$	2021-09-06
2	�ǰ�����            	�ٵ� �ǰ� ì��ô�	        ������	JAVA006$	2021-09-06
3	������	            ���� �� ����	            �մ���	JAVA006$	2021-09-06
4	������	            ���ڱ� �� ����	            ������	JAVA006$	2021-09-06
5	�����ϰ� ������	    �ڲ� ������	                ��ȿ��	JAVA006$	2021-09-06
6	����	                ������� ��� �ϳ���	    ������	JAVA006$	2021-09-06
7	����	                ������ �����	        ��ȿ��	JAVA006$	2021-09-06
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO=5;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������', '�� �׳� �߷���', '������', 'JAVA006$', SYSDATE);


--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO=2;

DELETE
FROM TBL_BOARD
WHERE NO=7;

DELETE
FROM TBL_BOARD
WHERE NO=8;


--�� Ȯ��
SELECT *
FROM TBL_BOARD;


--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���¿�', '�� ������ �־��', '������', 'JAVA006$', SYSDATE);


--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	�ѽ�~1 1��	���� 1��������	        ����ȣ	JAVA006$	2021-09-06
3	������	    ���� �� ����	        �մ���	JAVA006$	2021-09-06
4	������	    ���ڱ� �� ����	        ������	JAVA006$	2021-09-06
6	����	        ������� ��� �ϳ���	������	JAVA006$	2021-09-06
9	���¿�	    �� ������ �־��	        ������	JAVA006$	2021-09-06
*/

--�� Ŀ��
COMMIT;



SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;


--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������', '���� ����', '����ȣ', 'JAVA006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;

DELETE
FROM TBL_BOARD
WHERE NO=3;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
5	������	    ����ȣ	2021-09-06
4	���¿�	    ������	2021-09-06
3	����	        ������	2021-09-06
2	������	    ������	2021-09-06
1	�ѽ�~1 1��	����ȣ	2021-09-06
*/









