/*
pentru acordarea unui bonus la salariu dupa urmatoarele criterii:
- angajatii care au primit comision primesc un bonus egal cu salariul mediu pe companie
- angajatii care nu au primit comision primesc un bonus egal cu salariul minim pe companie
- presedintele si directorii nu primesc bonus
Antetul listei este: denumire dep, nume angajat, job, comision, salariu minim companie, salariu mediu companie, bonus
Obs. salariul si bonusurile se afiseaza fara zecimale
sa se rezolve prin 2 metode
*/

-- met 1
column bonus format 999999999
select d.dname denumire_departament,
	a.ename nume_angajat,
	a.job job,
	a.comm comision,
	(select min (sal) from emp) salariu_minim,
	(select avg (sal) from emp) salariu_mediu,
	(case
		when upper (a.job) = 'PRESIDENT' then 0
		when upper (a.job) = 'MANAGER' then 0
		when nvl(comm, 0) = 0 then (select avg (sal) from emp)
		else (select min (sal) from emp)
	end) bonus
from emp a natural join dept d
group by d.dname, a.ename, a.job, a.comm, a.sal
order by d.dname;

-- met 2
column bonus format 999999999
select d.dname denumire_departament,
	a.ename nume_angajat,
	a.job job,
	a.comm comision,
	(select min (sal) from emp) salariu_minim,
	(select avg (sal) from emp) salariu_mediu,
	decode (job, 'MANAGER', 0,
				 'PRESIDENT', 0,
				 decode (nvl(a.comm, 0), 0, (select avg (sal) from emp), 
					(select min (sal) from emp))
	)  bonus
from emp a natural join dept d
group by d.dname, a.ename, a.job, a.comm, a.sal
order by d.dname;
