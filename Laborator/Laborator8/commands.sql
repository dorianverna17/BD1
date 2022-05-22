-- ex1
select a.ename, b.grade, c.dname
from emp a join salgrade b
	on a.sal between b.losal and b.hisal
	join dept c
		on a.deptno = c.deptno
where
	a.hiredate > (select hiredate from emp
			where ename='ALLEN')
	AND
	b.grade = 2;

/*
pt fiecare angajat care castiga mai mult decat media salariilor din firma sa se afiseze
nume, numele sefului sau si cat castiga
*/
select a.ename, sef.ename, a.sal
from emp a join emp sef
	on a.mgr = sef.empno
where
	a.sal > (select avg(sal) from emp);

/*
sa se afiseze pt toti angajatii din dep lui blake si martin
(numele, den dep si salariu)
*/
select a.ename, d.dname, a.sal
from emp a join dept d
	on a.deptno = d.deptno
where
	a.deptno in (select deptno from emp
			where ename in ('BLAKE', 'MARTIN'));

/*
sa se selecteze pt fiecare angajat care castiga un salariu mai mare decat seful lui
numele, salariul
*/
select a.ename, a.sal
from emp a
where
	a.sal > (select b.sal
		from emp b
		where b.empno = a.mgr);

/*
sa se selecteze pt fiecare angajat aflat in gradul 2 salarial si care castiga mai
mult decat media salariilor din departamentul din care face parte (numele, gradul salarial)
si salariul)
*/
select a.ename, b.grade, a.sal
from emp a join salgrade b
	on a.sal between b.losal and b.hisal
where
	b.grade = 2 and
	a.sal > (select avg(c.sal)
		from emp c
		where a.deptno=c.deptno);
	

-- example1
select a.ename, a.sal
from emp a
where
	a.sal=(select MAX(sal) from emp);

-- example2
select a.ename, a.sal
from emp a
where
	a.sal=(select MAX(sal) from emp
		where
		sal!=(select MAX(sal) from emp));

-- example3
select a.ename, a.sal
from emp a
where
	3>=(select COUNT(DISTINCT B.SAL)
	   from emp b
	   where
		b.sal>a.sal);

-- example4
select a.ename, a.sal
from emp a
where
	3=(select COUNT(DISTINCT B.SAL)
	   from emp b
	   where
		b.sal>a.sal);

/*
pt fiecare angajat care castiga mai mult decat seful lui sa afisam numele, venitul lui
si salariul mediu pe companie
*/
select a.ename, a.sal + nvl(a.comm, 0) venit, avgs.medie
from emp a, (select avg(sal) medie from emp) avgs
where
	a.sal + nvl(a.comm, 0) > (select b.sal+nvl(b.comm, 0)
				  from emp b
				  where b.empno=a.mgr);


/*
sa se selecteze pt fiecare angajat care are un venit mai mare decat blake
numele, salariul, salariul lui blake, diferenta intre salariul angajatului si blake
si denumirea departamentului lui blake
*/
select a.ename, a.sal, t_blake.sal_blake, (a.sal - t_blake.sal_blake) diferenta, t_blake.dept_blake 
from emp a,
	(select b.sal sal_blake, d.dname dept_blake, b.comm comm
	from emp b join dept d
		on b.deptno=d.deptno	
	where
		b.ename='BLAKE') t_blake
where
	a.sal + nvl(a.comm,0) > t_blake.sal_blake + nvl(t_blake.comm, 0);

/*
pt fiecare angajat care nu face parte din departamentul angajatului cu cel mai mare
salariu si nu a venit in firma in luna decembrie, indiferent de an, afisati, numele
angajatului, denumirea departamentului sau, luna angajarii, venitul sau si plafonul
salarial (gradul salarial). Se va rezolva prin doua metode (varia join)
*/

-- selectam angajatul cu cel mai mare salariu
SELECT a.ename
FROM emp a
WHERE a.sal = (SELECT max(sal)
			   FROM emp);

-- selectam angajatii care nu au venit in firma in luna decembrie
SELECT a.ename
FROM emp a
WHERE NOT extract (MONTH from a.hiredate) = 12;

-- selectam angajatii care nu fac parte din departamentul angajatului cu cel mai mare salariu
SELECT *
FROM emp a 
WHERE NOT a.deptno = (SELECT a1.deptno
					  FROM emp a1
					  WHERE a1.sal = (SELECT max(sal)
			   						  FROM emp));

-- selectam angajatii care satisfac cele spuse mai sus
SELECT *
FROM emp a 
WHERE (NOT a.deptno = (SELECT a1.deptno
					  FROM emp a1
					  WHERE a1.sal = (SELECT max(sal)
			   						  FROM emp)))
	  AND NOT extract (MONTH from a.hiredate) = 12;

-- selectam informatiile potrivite pentru acesti angajati
SELECT
	a.ename nume,
	d.dname departament,
	extract (MONTH from a.hiredate) luna_angajarii,
	a.sal + nvl(a.comm, 0) venit,
	(SELECT grad
	FROM grila_salariu
	WHERE a.sal >= nivel_inf AND a.sal <= nivel_sup) grad
FROM emp a natural join dept d 
WHERE (NOT deptno = (SELECT a1.deptno
					  FROM emp a1
					  WHERE a1.sal = (SELECT max(sal)
			   						  FROM emp)))
	  AND NOT extract (MONTH from a.hiredate) = 12;

-- variem join-ul (metoda 2)
SELECT
	a.ename nume,
	d.dname departament,
	extract (MONTH from a.hiredate) luna_angajarii,
	a.sal + nvl(a.comm, 0) venit,
	g.grad grad
FROM emp a inner join dept d on a.deptno=d.deptno
		   inner join grila_salariu g on a.sal >= g.nivel_inf AND a.sal <= g.nivel_sup
WHERE (NOT a.deptno = (SELECT a1.deptno
					  FROM emp a1
					  WHERE a1.sal = (SELECT max(sal)
			   						  FROM emp)))
	  AND NOT extract (MONTH from a.hiredate) = 12;

