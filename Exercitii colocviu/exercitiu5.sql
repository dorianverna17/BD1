/*
Afisati toti angajatii din departamentul cu cei mai multi angajati care nu s-au angajat in
lunile de iarna (Dec, Ian si Febr). Se va afisa denumire departament, nume angajat, data
angajarii, ordonati dupa data angajarii crescator.
Antetul listei este den_dep, nume, data_ang.
Pentru testare, se va utiliza baza de date formata din tabelele EMP, DEPT si SALGRADE.
*/

-- grupare departament numar de angajati
select count(*) nr_angajati
from emp
group by deptno;

-- grupare departament numar de angajati
-- numaram doar angajatii care nu s-au angajat in lunile de iarna
select count(*) nr_angajati
from
	(
		select * from emp
		WHERE
			EXTRACT (MONTH from hiredate) NOT in (12, 1, 2)
	)
group by deptno;

-- afisam maximul pentru query-ul anterior
select MAX(nr_angajati)
FROM
(
	select count(*) nr_angajati
	from
	(
		select * from emp
		WHERE
			EXTRACT (MONTH from hiredate) NOT in (12, 1, 2)
	)
	group by deptno
);

-- selectam departamentele cu nr maxim de angajati
select
	deptno
from
	(
		select * from emp
		WHERE
			EXTRACT (MONTH from hiredate) NOT in (12, 1, 2)
	)
group by deptno
having count(*)=
		(
			select MAX(nr_angajati)
			FROM
			(
			select count(*) nr_angajati
			from
			(
				select * from emp
				WHERE
					EXTRACT (MONTH from hiredate) NOT in (12, 1, 2)
			)
			group by deptno
			)
		);

-- afisam informatiile necesare
select
	d.dname departament,
	a.ename nume_angajat,
	a.hiredate data_angajarii
from emp a inner join dept d on a.deptno=d.deptno
where 
	a.deptno in
	(
		select
		deptno
		from
		(
			select * from emp
			WHERE
				EXTRACT (MONTH from hiredate) NOT in (12, 1, 2)
		)
		group by deptno
		having count(*)=
		(
			select MAX(nr_angajati)
			FROM
			(
			select count(*) nr_angajati
			from
			(
				select * from emp
				WHERE
					EXTRACT (MONTH from hiredate) NOT in (12, 1, 2)
			)
			group by deptno
			)
		)
	);
