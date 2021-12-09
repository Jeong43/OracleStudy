--�� ���ӵ� ����� ��ȸ
SELECT USER
FROM DUAL;
--==>> SYS


--�� ����Ŭ ����� ���� ����(SCOTT)
CREATE USER scott
IDENTIFIED BY tiger;
--==>> User SCOTT��(��) �����Ǿ����ϴ�.


--�� ������ ����Ŭ ����� ����(SCOTT)�� ���� �ο�
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO SCOTT;
--==>> Grant��(��) �����߽��ϴ�.


--�� ������ ����Ŭ ����� ����(SCOTT)�� �⺻ ���̺������̽� ����
ALTER USER SCOTT DEFAULT TABLESPACE USERS;      --����Ŭ�� �⺻������ �ִ� ���̺� �����̽��� �̸�
--==>> User SCOTT��(��) ����Ǿ����ϴ�.


--�� ������ ����Ŭ ����� ����(SCOTT)�� �ӽ� ���̺������̽� ����
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;
--==>> User SCOTT��(��) ����Ǿ����ϴ�.