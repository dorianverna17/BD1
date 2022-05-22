SELECT SIGN(-12) from dual;

SELECT ABS(-12) from dual;

select CEIL(14.2) from dual;

DEFINE pi = '(select asin(1)*2 from dual)'

select SIN(30*&pi/180) sin from dual;

select COS(60*&pi/180) cos from dual;

select TAN(135*&pi/180) tan from dual;

select SINH(1) sinh from dual;

select COSH(0) cosh from dual;

select TANH(0.5) tanh from dual;

select ASIN(0.5) asin from dual;

select ACOS(0) acos from dual;

select ATAN(1) atan from dual;

select EXP(4) exp from dual;

select POWER(3, 2) power from dual;

select SQRT(9) sqrt from dual;

select LN(95) ln from dual;

select LOG(10, 100) log from dual;

select MOD(14, 5) mod from dual;

select ROUND(15.193, 1) from dual;

select ROUND(15.193) from dual;

select ROUND(15.193, -1) from dual;

select TRUNC(15.193, 1) from dual;

select TRUNC(15.193) from dual;

select TRUNC(15.193, -1) from dual;

-- pt siruri de caractere
select CHR(75) from dual;

select CONCAT(CONCAT(ENAME, ' este '), JOB) ANG_FUNC
	from EMP
	WHERE EMPNO=7839;

select INITCAP(ENAME) ex_initcap
	from EMP
	WHERE EMPNO = 7839;

select REPLACE('JACK si JUE', 'J', 'BL') EX_REPLACE
	from dual;

select RPAD(ENAME, 10, '*') EX_RPAD
	from EMP where DEPTNO = 10;

select LPAD(ENAME, 10, '*') EX_LPAD
	from EMP where DEPTNO = 10;

select RTRIM('Popescu', 'scu') from dual;

select SUBSTR('Popescu', 2, 3) from dual;

select INSTR('Protopopescu', 'op', 3, 2) from dual;

select LENGTH('analyst') from dual;

select TRANSLATE('Oana are mere', 'Om', 'p') from dual;

-- pt date calendaristice
SELECT ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 3) data_mod
	from EMP
	where DEPTNO = 10;

SELECT ENAME, HIREDATE, LAST_DAY(HIREDATE) ultima_zi
	from EMP
	WHERE DEPTNO = 10;

SELECT NEXT_DAY('24-MAR-2014', 'MONDAY') urmatoarea_luni
	from dual;

SELECT ENAME, HIREDATE,
	MONTHS_BETWEEN('01-JAN-2014', HIREDATE) luni_vechime1,
	MONTHS_BETWEEN(HIREDATE, '01-JAN-2014') luni_vechime2
from EMP
where DEPTNO = 10;

SELECT
	HIREDATE,
	ROUND(HIREDATE, 'YEAR') rot_an
from EMP
WHERE EMPNO = 7369;

SELECT
	HIREDATE,
	ROUND(HIREDATE, 'MONTH') rot_luna
from EMP
WHERE EMPNO = 7369;

SELECT
	HIREDATE,
	TRUNC(HIREDATE, 'YEAR') rot_an
from EMP
WHERe EMPNO = 7369;

SELECT
	HIREDATE,
	TRUNC(HIREDATE, 'MONTH') rot_luna
from EMP
WHERe EMPNO = 7369;

select SYSDATE from dual;

select EXTRACT(DAY from sysdate) from dual;

select EXTRACT(MONTH from sysdate) from dual;

select EXTRACT(YEAR from sysdate) from dual;

SELECT
	HIREDATE,
	HIREDATE + 7,
	HIREDATE - 7,
	sysdate - HIREDATE
from EMP
where HIREDATE like '%JUN%';

alter session set NLS_DATE_FORMAT='DD-MM-YYYY';
select sysdate from dual;

alter session set NLS_DATE_FORMAT='DD-MM-YYYY HH24:MI:SS';
select sysdate from dual;

alter session set NLS_DATE_FORMAT='DD-MONTH-YYYY';
select replace(sysdate, ' ', '') from dual;

-- exercitiu laborator
SELECT
	UPPER(a1.ENAME) nume,
	EXTRACT(DAY from a1.HIREDATE) ziua_angajarii,
	LOWER(d.DEPTNO) departament,
	SUBSTR(a2.ENAME, 0, 1) initiala_numelui
FROM
	EMP a1,
	EMP a2,
	DEPT d
WHERE
	LENGTH(a1.ENAME) = 4 AND
	a1.MGR = a2.EMPNO AND
	a1.deptno = d.deptno;

SELECT
	UPPER(a1.ENAME) nume,
	EXTRACT(DAY from a1.HIREDATE) ziua_angajarii,
	LOWER(d.DEPTNO) departament,
	SUBSTR(a2.ENAME, 0, 1) initiala_numelui
FROM
	dept d,
	emp a1
		INNER JOIN emp a2
			ON a1.MGR = a2.EMPNO
WHERE
	LENGTH(a1.ENAME) = 4 AND
	a1.deptno = d.deptno;