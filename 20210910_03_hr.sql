SELECT USER
FROM DUAL;
--==>> HR

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

--�� EMPLOYEES ���̺��� ������ SALARY �� 10% �λ��Ѵ�.
--   ��, �μ����� 'IT'�� ���� �����Ѵ�.
--   (���� ������ ã�� �μ���ȣ�� �Է��ϴ� ���� �ƴ�.
--    ����, ��� Ȯ�� �� ROLLBACK)

UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> 5�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT EMPLOYEE_ID, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> ���� ��
/*
103	9000
104	6000
105	4800
106	4800
107	4200
*/

--==>> ���� ��
/*
103	9900
104	6600
105	5280
106	5280
107	4620
*/

ROLLBACK;


--�� EMPLOYEES ���̺��� JOB_TITLE�� ��Sales Manager���� �������
--   SALARY �� �ش� ����(����)�� �ְ� �޿�(MAX_SALALY)�� �����Ѵ�.
--   ��, �Ի����� 2006�� ����(�ش�⵵ ����) �Ի��ڿ� ���Ͽ�
--   ������ �� �ֵ��� ó���Ѵ�.
--   (��� Ȯ�� �� ROLLBACK)

-- ���� ����
UPDATE EMPLOYEES
SET SALARY = (Salese Manager �� MAX_SALARY)
WHERE JOB_ID =(Salese Manager �� JOB_ID)
  AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;
  
-- Salese Manager �� MAX_SALARY
SELECT MAX_SALARY
FROM JOBS
WHERE JOB_TITLE = 'Sales Manager';  
--==>> 20080

-- Salese Manager �� JOB_ID
SELECT JOB_ID
FROM JOBS
WHERE JOB_TITLE = 'Sales Manager';
--==>> SA_MAN  


UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
             FROM JOBS
             WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;
--  AND EXTRACT(YEAR FROM HIRE_DATE) < 2006;
--==>> 3�� �� ��(��) ������Ʈ�Ǿ����ϴ�.  


SELECT SALARY
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND EXTRACT(YEAR FROM HIRE_DATE) < 2006;
--==>> ���� ��
/*
14000
13500
12000
*/

--==>> ���� ��
/*
20080
20080
20080
*/

ROLLBACK;



