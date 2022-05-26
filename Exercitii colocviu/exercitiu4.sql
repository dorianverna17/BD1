/*
Sa se scrie o cerere SQL*Plus care face o lista cu seful de departament care are cel mai mare
salariu dintre toti sefii care au cel putin 2 subalterni care nu au primit comision.
Antetul listei este urmatorul :
DEN_DEP_SEF NUME_SEF JOB_SEF SAL_SEF NUME_SUB COM_SUB
Seful unui angajat este specificat prin coloana MGR.
Pentru testare, se va utiliza baza de date formata din tabelele EMP, DEPT si SALGRADE.
*/

-- query care intoarce toti sefii de departament
select DISTINCT mgr
from emp;

-- query care intoarece informatiile despre sefii de departament
select a.ename, a.deptno
from emp a 
where a.empno in 
	(
		select DISTINCT mgr
		from emp
	);

-- afisare numar subalterni sef departament
select
	(select count(*)
	from emp
	where mgr=a.empno) numar_subalterni
from emp a
where a.empno = 7839;

-- afisare numar subalterni sef departament (doar cei fara comision)
select
	(select count(*)
	from emp
	where mgr=a.empno
		  AND 
		  nvl(comm, 0)=0) numar_subalterni
from emp a
where a.empno = 7839;

-- afisare sefi departament + cati subalterni fara comision au
select
	a.ename nume,
	d.dname departament,
	(
		select
			(
				select count(*)
				from emp
				where mgr=c.empno
		  			  AND 
		  			  nvl(comm, 0)=0
			)
		from emp c
		where c.empno = a.empno
	) numar_subalterni
from emp a inner join dept d on d.deptno=a.deptno
where a.empno in 
	(
		select DISTINCT mgr
		from emp
	);

-- ii afisam doar pe cei care au cel putin 2 subalterni
select
	a.ename nume,
	d.dname departament,
	(
		select
			(
				select count(*)
				from emp
				where mgr=c.empno
		  			  AND 
		  			  nvl(comm, 0)=0
			)
		from emp c
		where c.empno = a.empno
	) numar_subalterni
from emp a inner join dept d on d.deptno=a.deptno
where a.empno in 
	  (
		select DISTINCT mgr
		from emp
	  )
	  AND
	  (
		select
			(
				select count(*)
				from emp
				where mgr=c.empno
		  			  AND 
		  			  nvl(comm, 0)=0
			)
		from emp c
		where c.empno = a.empno
	  ) >= 2;

-- selectam seful cu salariul cel mai mare
select
	a.empno
from emp a inner join dept d on d.deptno=a.deptno
where a.empno in 
	  (
		select DISTINCT mgr
		from emp
	  )
	  AND
	  (
		select
			(
				select count(*)
				from emp
				where mgr=c.empno
		  			  AND 
		  			  nvl(comm, 0)=0
			)
		from emp c
		where c.empno = a.empno
	  ) >= 2
	  AND
	  a.sal=
	  (
		  select MAX(sal)
		  from
		  (
			  select
					f.sal
					from emp f
					where f.empno in 
	  				(
						select DISTINCT mgr
						from emp
	  				)
	  				AND
	  				(
					select
					(
						select count(*)
						from emp
						where mgr=e.empno
		  			  		  AND 
		  			  		  nvl(comm, 0)=0
					)
					from emp e
					where e.empno = f.empno
	  				) >= 2
		  	)
	  );

-- afisam angajatii care il au ca sef pe acesta
select
	sef.ename nume_sef,
	d.dname nume_departament,
	sef.job job_sef,
	sef.sal sal_sef,
	sub.ename nume_subaltern,
	nvl(sub.comm, 0) comision_subaltern
from emp sub inner join emp sef
		on sef.empno = sub.mgr
			inner join dept d 
		on sef.deptno=d.deptno
where
	sef.empno=
	(
		select
		a.empno
		from emp a inner join dept d on d.deptno=a.deptno
		where a.empno in 
	  	(
			select DISTINCT mgr
			from emp
	  	)
	  	AND
	  	(
			select
			(
				select count(*)
				from emp
				where mgr=c.empno
		  			  AND 
		  			  nvl(comm, 0)=0
			)
		from emp c
		where c.empno = a.empno
	  	) >= 2
	  	AND
	  	a.sal=
	  	(
		  	select MAX(sal)
		  	from
		  	(
			  select
					f.sal
					from emp f
					where f.empno in 
	  				(
						select DISTINCT mgr
						from emp
	  				)
	  				AND
	  				(
					select
					(
						select count(*)
						from emp
						where mgr=e.empno
		  			  		  AND 
		  			  		  nvl(comm, 0)=0
					)
					from emp e
					where e.empno = f.empno
	  				) >= 2
		  	)
	  	)
	);
