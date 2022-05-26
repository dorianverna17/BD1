/*
Sa se scrie o cerere SQL*Plus care face o lista cu departamentul in care s-au facut cele mai
multe angajari intr-un an. Lista va contine denumirea de departament, anul in care s-au facut
cele mai multe angajari in departamentul respectiv si numarul de angajari.
Antetul listei este urmatorul : DEN_DEP AN NR_ANG
Pentru testare, se va utiliza baza de date formata din tabelele EMP, DEPT si SALGRADE
*/

-- query care preia anul angajarii pentru fiecare angajat
select
	a.ename nume,
	(SELECT EXTRACT(YEAR FROM hiredate)
	from emp
	where a.empno=empno) an_angajare
from emp a;

-- query care numara numarul de angajari dintr-un an
select
	count(*) numar_angajari,
	EXTRACT(YEAR FROM hiredate) an_angajare
from emp
group by EXTRACT(YEAR FROM hiredate);

-- query care selecteaza ce e mai sus, dar pentru un singur departament
select
	count(*) numar_angajari,
	EXTRACT(YEAR FROM hiredate) an_angajare
from
	(
		select *
		from emp
		where deptno=20
	)
group by EXTRACT(YEAR FROM hiredate);

-- query care face asta pentru fiecre departament
select
	count(*) numar_angajari,
	EXTRACT(YEAR FROM hiredate) an_angajare,
	deptno departament
from emp
group by EXTRACT(YEAR FROM hiredate), deptno;

-- query care selecteaza maximul de mai sus
select MAX(numar_angajari)
from
	(
		select
			count(*) numar_angajari,
			EXTRACT(YEAR FROM hiredate) an_angajare,
			deptno departament
		from emp
		group by EXTRACT(YEAR FROM hiredate), deptno
	);

-- query care selecteaza departamentul dat
select
	dname departament,
	count(*) numar_angajari,
	EXTRACT(YEAR FROM hiredate) an_angajare
from emp natural join dept
group by EXTRACT(YEAR FROM hiredate), dname
having
	count(*)=
	(
		select MAX(numar_angajari)
		from
			(
				select
				count(*) numar_angajari,
				EXTRACT(YEAR FROM hiredate) an_angajare,
				deptno departament
				from emp
				group by EXTRACT(YEAR FROM hiredate), deptno
			)
	);
