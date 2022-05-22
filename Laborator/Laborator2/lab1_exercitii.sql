SELECT ename, job, hiredate, sal, nvl(comm, 0) as comision,
	sal + nvl(comm, 0) as venit_lunar, deptno
FROM EMP
WHERE hiredate > '01-JAN-80' AND hiredate < '31-DEC-81'

SELECT ename, job, hiredate, sal, nvl(comm, 0) as COMISION,
	sal + nvl(comm, 0) as VENIT_LUNAR, DEPTNO
FROM EMP
WHERE HIREDATE LIKE '%81'

ALTER SESSION SET nls_date_format='DD-MM-YYYY';

SELECT ename, job, hiredate, sal, nvl(comm,0) as COMISION,
	sal+nvl(comm,0) as VENIT_LUNAR, DEPTNO
FROM EMP
WHERE HIREDATE LIKE '%1981'

SELECT ename, job, hiredate, nvl(comm,0) as COMISION from EMP
WHERE nvl(comm,0)=0

select ename, job, hiredate, comm as COMISION from EMP
WHERE comm is NULL OR comm=0
