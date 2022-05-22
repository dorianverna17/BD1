-- TO_CHAR, TO_DATE, TO_NUMBER

select to_char (sysdate, 'DD-MM-YYYY') data_curenta
from dual;

select to_date ('15112006', 'DD-MM-YYYY') data_ex
from dual;

select to_char (-10000, '$999999.99MI') valoare
from dual;

select to_number ('$10000.00-', '$999999.99MI') valoare
from dual;

-- ex.
select ename, to_char (hiredate, 'DD-MM-YYYY') data_ang
from EMP
where to_char (hiredate, 'YYYY') like '1982';

select ename, to_char (hiredate, 'DD-MM-YYYY') data_ang
from EMP
where to_date (to_char (hiredate, 'YYYY'), 'YYYY') =
	to_date(to_char(1982), 'YYYY');

select ename, to_char (hiredate, 'DD-MM-YYYY') data_ang
from EMP
where to_number (to_char (hiredate, 'YYYY')) = 1982;


-- COLUMN
column numar format 99999
select 123.14 numar from dual;

column numar format 999.99
select 123.14 numar from dual;

column numar format $999.99
select 123.14 numar from dual;

column numar format 00999.99
select 123.14 numar from dual;
select 0.14 numar from dual;

column numar format 9990.99
select 123.14 numar from dual;
select 0.14 numar from dual;

column numar format 09990.99
select 123.14 numar from dual;
select 0.14 numar from dual;

column numar format 999,999,999.99
select 123123123.14 numar from dual;

column numr format 999.99MI
select -123.14 numar from dual;

column numar format 999.99PR
select -123.14 numar from dual;
select 123.14 numar from dual;

column numar format 999.99EEEE
select 123.14 numar from dual;

column numar format B99999.99
select 123 numar from dual;

column numar format 99999D00
select 0.14 numar from dual;
select 123.1 numar from dual;

-- GREATEST si LEAST

select greatest (23, 12, 34, 77, 89, 52) gr
from dual;

select least (23, 12, 34, 77, 89, 52) lst
from dual;

select greatest ('15-JAN-1985', '23-AUG-2001') gr
from dual;

select least ('15-JAN-1985', '23-AUG-2001') lst
from dual;

-- DECODE si CASE

select ename, job, sal,
	decode (job, 'MANAGER', sal*1.25,
		     'ANALYST', sal*1.24,
		     sal/4) prima
from emp
where deptno = 20
order by job;

select ename, job, sal,
	to_char (hiredate, 'YYYY') an_ang,	
	decode (sign (hiredate - to_date('1-JAN-1982')),
		-1, sal*1.25, sal*1.1) prima
from emp
where deptno = 20
order by job;

select
	case lower(loc)
		when 'new york' then 1
		when 'dallas' then 2
		when 'chicago' then 3
		when 'boston' then 4
	end cod_dep
from dept;

select ename
from emp
where empno = (case job
	when 'SALESMAN' then 7844
	when 'CLERK' then 7900
	when 'ANALYST' then 7902
	else 7839
	end);

select
	case
		when lower(loc) = 'new york' then 1
		when deptno = 20
			or lower(loc) = 'dallas' then 2
		when lower(loc) = 'chicago' then 3
		when deptno = 40 then 4
		else 5
	end cod_dep
from dept;

select ename
from emp
where empno = (case
	when job = 'SALESMAN' then 7844
	when job = 'CLERK' then 7900
	when job = 'ANALYST' then 7902
	else 7839
	end);

set null NULL
select ename, comm, nvl(comm, 0) nvl_comm,
	sal + comm "Sal + Com",
	sal + nvl(comm, 0) "sal + nvl_com"
from emp
where deptno = 30;
set null ''

-- functii de grup

select avg (sal) salariu from emp;
select avg (all sal) salariu from emp;
select avg (distinct sal) salariu from emp;

select deptno, avg (sal) from emp
group by deptno
order by 1;

select deptno, avg (sal + nvl(comm, 0))
from emp
group by deptno
having avg (sal + nvl (comm, 0)) > 2000;

select deptno, count(*) nr_ang,
	count (sal) count,
	count (all sal) count_all,
	count (distinct sal) count_distinct
from emp
group by deptno
order by 1;

select deptno,
	count (job) count,
	count (distinct job) count_distinct
from emp
group by deptno
having count (distinct job) >= 2
order by 1;

select d.dname,
	min (a.sal) sal_min,
	min (distinct a.sal) sal_min_d,
	max (a.sal) sal_max,
	max (distinct a.sal) sal_max_d,
	sum (a.sal) sal_sum,
	sum (distinct a.sal) sal_sum_d
from emp a natural join dept d
group by d.dname
order by d.dname;

select deptno,
	variance (sal) sal_varstd,
	variance (distinct sal) sal_varstd_d,
	variance (sal) sal_devstd,
	stddev (distinct sal) sal_devstd_d,
	stddev (comm) com_devstd
from emp
group by deptno
order by 1;


