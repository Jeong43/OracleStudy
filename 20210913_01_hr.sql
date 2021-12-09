SELECT USER
FROM DUAL;
--=>> HR

-- �� EMPLOYEES ���̺���  SALARY ��
--    �� �μ��� �̸����� �ٸ� �λ���� �����Ͽ� ������ �� �ֵ��� �Ѵ�.
--    Finance �� 10%
--    Executive �� 15%
--    Accounting �� 20%
--    (������ ���� �� ��� Ȯ�� �� ROLLBACK)

-- ������ [���� Ǯ��]
UPDATE EMPLOYEES
SET SALARY = DECODE(DEPARTMENT_ID, (SELECT DEPARTMENT_ID
                                   FROM DEPARTMENTS
                                   WHERE DEPARTMENT_NAME = ('Finance')), SALARY * 1.1
                                , (SELECT DEPARTMENT_ID
                                   FROM DEPARTMENTS
                                   WHERE DEPARTMENT_NAME = ('Executive')), SALARY * 1.15
                                , (SELECT DEPARTMENT_ID
                                   FROM DEPARTMENTS
                                   WHERE DEPARTMENT_NAME = ('Accounting')), SALARY * 1.2 )
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting')); 
--==>> 11�� �� ��(��) ������Ʈ�Ǿ����ϴ�.


-- ������ [�Բ� Ǯ��]
UPDATE EMPLOYEES
SET SALARY =  CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                       FROM DEPARTMENTS
                                       WHERE DEPARTMENT_NAME = ('Finance'))
                                THEN SALARY * 1.1
                                WHEN (SELECT DEPARTMENT_ID
                                       FROM DEPARTMENTS
                                       WHERE DEPARTMENT_NAME = ('Executive'))
                                THEN SALARY * 1.15
                                WHEN (SELECT DEPARTMENT_ID
                                       FROM DEPARTMENTS
                                       WHERE DEPARTMENT_NAME = ('Accounting'))
                                THEN SALARY * 1.2
                                ELSE SALARY
              END
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting')); 


-- Ȯ��
SELECT FIRST_NAME, DEPARTMENT_ID, SALARY      
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting'));
--==>> ���� ��
/*
Steven	    90	24000
Neena	    90	17000
Lex     	90	17000
Nancy	    100	12008
Daniel	    100	9000
John	        100	8200
Ismael	    100	7700
Jose Manuel	100	7800
Luis	        100	6900
Shelley	    110	12008
William	    110	8300
*/
--==>> ���� ��
/*
Steven	    90	27600
Neena	    90	19550
Lex     	90	19550
Nancy	    100	13208.8
Daniel	    100	9900
John        	100	9020
Ismael	    100	8470
Jose Manuel	100	8580
Luis	        100	7590
Shelley	    110	14409.6
William	    110	9960
*/

ROLLBACK;
--==>> �ѹ� �Ϸ�.



--���� DELETE ����--
/*
1. ���̺��� ������ ��(���ڵ�)�� �����ϴµ� ����ϴ� ����.

2. ���� �� ����
DELETE [FROM] ���̺��
[WHERE ������];
*/

SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 198	Donald	OConnell	DOCONNEL	650.507.9833	07/06/21	SH_CLERK	2600		124	50

DELETE
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

ROLLBACK;
--==>> �ѹ� �Ϸ�.



--�� EMPLOYEES ���̺��� �������� ������ �����Ѵ�.
--   ��, �μ����� 'IT'�� ���� �����Ѵ�.

--�� �����δ� EMPLOYEES ���̺��� �����Ͱ�(�����ϰ��� �ϴ� ���)
--   �ٸ� ���̺�(Ȥ�� �ڱ� �ڽ� ���̺�)�� ���� �������ϴ� ���
--   �������� ���� �� �ִٴ� ����� �����ؾ� �ϸ�...
--   �׿� ���� ������ �˾ƾ� �Ѵ�.

DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> ���� �߻�
/*
ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found
*/


SELECT FIRST_NAME, DEPARTMENT_ID 
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> ���� ��
/*
Alexander	60
Bruce	    60
David	    60
Valli	    60
Diana	    60
*/


--���� ��(VIEW) ����--
/*
1. ��(VIEW)�� �̹� Ư���� �����ͺ��̽� ���� �����ϴ�
   �ϳ� �̻��� ���̺��� ����ڰ� ��� ���ϴ� �����͵鸸��
   ��Ȯ�ϰ� ���ϰ� �������� ���Ͽ� ������ ���ϴ� �÷��鸸 ��Ƽ�
   �������� ������ ���̺�� ���Ǽ� �� ���ȿ� ������ �ִ�.

   ������ ���̺��̶� �䰡 ������ �����ϴ� ���̺�(��ü)�� �ƴ϶�
   �ϳ� �̻��� ���̺��� �Ļ��� �� �ٸ� ������ �� �� �ִ� ����̸�
   �� ������ �����س��� SQL �����̶�� �� �� �ִٴ� ���̴�.
   
2. ���� �� ����
CREATE [OR REPLACE] VIEW ���̸�
[(ALISA[, ALIAS, ...])]
AS
��������(SUBQUERY)
[WITH CHECK OPTION]
[WITH READ ONLY];
*/


--�� ��(VIEW) ����
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+);
--==>> View VIEW_EMPLOYEES��(��) �����Ǿ����ϴ�.


SELECT *
FROM VIEW_EMPLOYEES;

DESC VIEW_EMPLOYEES;


--�� ��(VIEW) �ҽ� Ȯ��                 -- CHECK~!!!
SELECT VIEW_NAME, TEXT                  -- TEXT
FROM USER_VIEWS                         -- USER_VIEWS              
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';

--==>> 
/*
"SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
      , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+)"
*/