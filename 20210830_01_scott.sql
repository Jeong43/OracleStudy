SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT *
FROM TBL_EMP;

DESC TBL_EMP;

--�� TBL_EMP ���̺��� �Ի����� 1981�� 9�� 28�� �Ի��� ������
--   �����, ������, �Ի��� �׸��� ��ȸ�Ѵ�.

SELECT ENAME "�����", JOB "����", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE = '1981-09-28';
-- Ʋ�� ����(���ڿ�)


--�� TO_DATE()
SELECT ENAME "�����", JOB "����", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE = TO_DATE('1981-09-28', 'YYYY-MM-DD');


--�� ��¥ ���Ŀ� ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.


SELECT ENAME "�����", JOB "����", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE = TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>> MARTIN	SALESMAN	    1981-09-28


--�� TBL_EMP ���̺��� �Ի����� 1981�� 9�� 28�� ����(�ش��� ����)�� �Ի��� ������
--   �����, ������, �Ի��� �׸��� ��ȸ�Ѵ�.
SELECT ENAME "�����", JOB "����", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>>
/*
MARTIN	SALESMAN        	1981-09-28
SCOTT	ANALYST	        1987-07-13
KING    	PRESIDENT	    1981-11-17
ADAMS	CLERK	        1987-07-13
JAMES	CLERK	        1981-12-03
FORD    	ANALYST	        1981-12-03
MILLER	CLERK	        1982-01-23
*/

--�� ����Ŭ������ ��¥ �������� ũ�� �񱳰� �����ϴ�.
--   ����Ŭ���� ��¥ �����Ϳ� ���� ũ�� �� ��
--   ���ź��� �̷��� �� ū ������ �����Ͽ� ó���ϰ� �ȴ�.


--�� TBL_EMP ���̺��� �Ի����� 1981�� 4�� 2�Ϻ���
--   1981�� 9�� 28�� ���̿� �Ի��� ��������
--   �����, ������, �Ի��� �׸��� ��ȸ�Ѵ�. (�ش��� ����)

SELECT ENAME "�����", JOB "����", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02', 'YYYY-MM-DD') 
        AND HIREDATE <= TO_DATE('1981-09-28', 'YYYY-MM-DD');






