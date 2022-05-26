/*
Sa se selecteze angajatii care au cele mai mari trei venituri din departamentul angajatului cu
cei mai multi subordonati direct.
Nume, Den_departament, Venit
Seful unui angajat este specificat prin coloana MGR.
*/

-- cautam subordonatii unui angajat
select ename
from emp
where mgr = 7698;

-- numaram acesti subordonati
select count(*)
from
(
	select ename
	from emp
	where mgr = 7698
);

-- facem asta pentru fiecare angajat
select
	a.ename nume,
	(case
		when a.empno in (
						select
							mgr id
						from
						(
						select mgr, count(*) nr_subordonati
						from emp
						group by mgr
						)
					  ) then
					  (
						  (
							select
								nr_subordonati
							from
							(
							select mgr, count(*) nr_subordonati
							from emp
							group by mgr
							)
							where mgr=a.empno
					  	  )
					  )
		else 0
	end) numar_subordonati
from emp a;

-- selectam angajatul cu cei mai multi subordonati
select
	c.deptno
from emp c
where
	(
		select count(*)
		from
		(
			select ename
			from emp
			where mgr = c.empno
		)
	)=
	(
		select MAX(numar_subordonati)
		FROM
		(
			select a.ename nume,
			(case
			when a.empno in (
							select mgr id from
							(
								select mgr, count(*) nr_subordonati
								from emp
								group by mgr
							)
					  		) then (
						  	(
								select nr_subordonati
								from (
								select mgr, count(*) nr_subordonati
								from emp
								group by mgr)
								where mgr=a.empno
					  	  	)
					  		)
			else 0
			end) numar_subordonati
		from emp a
		)
	);

-- selectam toti angajatii din departamentul respectiv
select
	f.ename nume,
	g.dname departament,
	f.sal + nvl(f.comm, 0) venit
from emp f inner join dept g on f.deptno = g.deptno
where f.deptno=
	(
select
	c.deptno
from emp c
where
	(
		select count(*)
		from
		(
			select ename
			from emp
			where mgr = c.empno
		)
	)=
	(
		select MAX(numar_subordonati)
		FROM
		(
			select a.ename nume,
			(case
			when a.empno in (
							select mgr id from
							(
								select mgr, count(*) nr_subordonati
								from emp
								group by mgr
							)
					  		) then (
						  	(
								select nr_subordonati
								from (
								select mgr, count(*) nr_subordonati
								from emp
								group by mgr)
								where mgr=a.empno
					  	  	)
					  		)
			else 0
			end) numar_subordonati
		from emp a
		)
	)
	)
order by 3 desc
fetch first 3 rows only;
