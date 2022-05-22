-- primul ex

/* metoda 1 */
select d.dname,
	a.job,
	count(a.empno) nr_ang
from emp a
	natural join dept d
group by d.dname,
	a.job
having count(a.empno)=(select max(count(empno))
			from emp
			group by deptno, job);

SELECT MAX((SELECT (COUNT(empno))
	    FROM emp
	    WHERE deptno=s.deptno AND
		  job=s.job
	    GROUP BY deptno,
		     job)) max_count
FROM emp s;

/* metoda 2 */
SELECT d.dname,
       a.job,
       COUNT(a.empno) nr_ang
FROM emp a
     NATURAL JOIN dept d
GROUP BY d.dname, a.job
HAVING COUNT(a.empno) = (
SELECT MAX((SELECT (COUNT(empno))
	    FROM emp
	    WHERE deptno=s.deptno AND
		  job=s.job
	    GROUP BY deptno,
		     job)) max_count
FROM emp s);

-- ex 2
select d.dname,
       a.ename,
       a.job,
       a.comm
from emp a
       INNER JOIN dept d
	on a.deptno=d.deptno
group by d.dname,
	 a.ename,
         a.job,
	 a.comm
HAVING MAX(a.comm) IN (SELECT MAX(comm)
		       from emp
		       where deptno=&depno
		       group by deptno)
order by 2;

-- ex3
select a.ename,
       a.job,
       a.hiredate,
       a.sal
from emp a,
     (select deptno,
	     MAX(sal) sal_MAX_dep
      FROM emp
      GROUP BY deptno) b
GROUP BY a.ename,
	 a.job,
	 a.hiredate,
	 a.sal
HAVING a.sal=MAX(b.sal_MAX_dep)
ORDER BY a.ename;

-- ex4
SELECT ename NUME_ANG,
       (SELECT ename
	FROM emp
	WHERE empno=a.mgr) NUME_SEF
FROM emp a
WHERE deptno=20
ORDER BY ename;

-- ex5
select deptno, ename, job
from emp a
where deptno IN (10, 20)
ORDER BY (SELECT count(*)
	  from emp b
	  where a.deptno=b.deptno) DESC;

-- ex6
select deptno,
       ename,
       job,
       sal
from emp
where sal>SOME(SELECT DISTINCT sal
	       FROM emp
	       WHERE job='SALESMAN')
ORDER BY deptno, ename;

-- ex7
select deptno,
       ename,
       job,
       sal
from emp
where sal>=ALL(SELECT DISTINCT sal
	       FROM emp
	       WHERE job='SALESMAN')
ORDER BY deptno, ename;

-- ex8
select d.deptno,
       d.dname
from dept d
where exists(select ename
	     from emp
	     where deptno=d.deptno)
order by deptno;

-- ex9
SELECT deptno,
       empno,
       ename,
       job,
       mgr
from emp a
where not exists(select mgr
		 from emp
		 where empno=a.mgr)
order by deptno;

-- ex10
SELECT deptno,
       empno,
       ename,
       job,
       mgr
from emp a
where mgr not in (select distinct mgr from emp)
order by deptno;

-- aplicatie 1
select distinct job functie,
       (select avg(sal)
	from emp
	group by job
	having job = a.job) venit_lunar_mediu
from emp a;

-- exercitiu lab
/*
Sa se faca o lista cu sefii de departament care au cei mai multi subalterni fara comision
Antet lista: den dep sef, nume sef, nume subaltern, data angajare subaltern,
comision subaltern
*/

-- afisam toti managerii de departament
SELECT *
FROM emp a
WHERE a.empno in (SELECT DISTINCT mgr
				  FROM emp);
				
-- numaram toti subalternii unui manager (il hardcodam pe cel cu empno 7566)
SELECT count(*)
FROM emp b
WHERE b.mgr = 7566;

-- afisam numarul de subalterni al fiecarui sef de departament
SELECT
	a.ename,
	(SELECT count(*)
	 FROM emp b
	 WHERE b.mgr = a.empno) numar_subalterni
FROM emp a
WHERE a.empno in (SELECT DISTINCT mgr
				  FROM emp);

-- afisam numarul de subalterni al fiecarui sef de departament (subalterni care nu au comision)
SELECT
	a.ename,
	(SELECT count(*)
	 FROM emp b
	 WHERE b.mgr = a.empno
	 	   AND nvl(b.comm, 0)=0) numar_subalterni
FROM emp a
WHERE a.empno in (SELECT DISTINCT mgr
				  FROM emp);

-- ii afisam doar pe cei care au numarul maxim de astfel de subalterni
-- !!! nu afisam presedintele
SELECT
	a.empno
FROM emp a
WHERE a.empno in (SELECT DISTINCT mgr
				  FROM emp)
	  AND a.job NOT LIKE 'PRESIDENT'
	  AND (SELECT count(*)
	 	   FROM emp b
	 	   WHERE b.mgr = a.empno
	 	   		AND nvl(b.comm, 0)=0) =
		  (SELECT MAX(max_subalterni)
		  	FROM (SELECT (SELECT count(*) FROM emp d WHERE d.mgr = c.empno AND nvl(d.comm, 0)=0) max_subalterni
			  FROM emp c
			  WHERE c.empno in (SELECT DISTINCT mgr
				  	FROM emp)
					AND c.job NOT LIKE 'PRESIDENT'));

-- afisam subalternii pentru sefii de departament de mai sus
SELECT
	ename
FROM emp
where mgr in (SELECT
				a.empno
			  FROM emp a
			  WHERE a.empno in (SELECT DISTINCT mgr
				  			    FROM emp)
	  				AND a.job NOT LIKE 'PRESIDENT'
	  				AND (SELECT count(*)
	 	   				 FROM emp b
	 	   				 WHERE b.mgr = a.empno
	 	   					   AND nvl(b.comm, 0)=0) =
		  				(SELECT MAX(max_subalterni)
		  				FROM (SELECT (SELECT count(*) FROM emp d WHERE d.mgr = c.empno AND nvl(d.comm, 0)=0) max_subalterni
			  				  FROM emp c
			  				  WHERE c.empno in (SELECT DISTINCT mgr
				  								FROM emp)
									AND c.job NOT LIKE 'PRESIDENT')));

-- afisam informatiile necesare pentru acesti subalterni
SELECT
	f.dname departament_sef,
	g.ename nume_sef,
	a.ename nume_subaltern,
	a.hiredate data_angajare,
	nvl(a.comm, 0) comision
FROM emp a inner join dept f on a.deptno=f.deptno 
		   inner join emp g on a.mgr = g.empno
where a.mgr in (SELECT
				a.empno
			  FROM emp a
			  WHERE a.empno in (SELECT DISTINCT mgr
				  			    FROM emp)
	  				AND a.job NOT LIKE 'PRESIDENT'
	  				AND (SELECT count(*)
	 	   				 FROM emp b
	 	   				 WHERE b.mgr = a.empno
	 	   					   AND nvl(b.comm, 0)=0) =
		  				(SELECT MAX(max_subalterni)
		  				FROM (SELECT (SELECT count(*) FROM emp d WHERE d.mgr = c.empno AND nvl(d.comm, 0)=0) max_subalterni
			  				  FROM emp c
			  				  WHERE c.empno in (SELECT DISTINCT mgr
				  								FROM emp)
									AND c.job NOT LIKE 'PRESIDENT')));