/*
Sa se selecteze angajatii care au cele mai mari doua venituri din departamentul cu cei
mai multi angajati.
Se va afisa, pentru fiecare angajat, o lista cu antetul:
Nume, Den_departament, Venit
Pentru testare, se va utiliza baza de date formata din tabelele EMP, DEPT si SALGRADE.
*/

-- afisam departamentele in functie de numarul de angajati
select d.dname nume_departament, count(*) numar_angajati 
from emp a inner join dept d on a.deptno=d.deptno
group by d.dname;

-- afisam numarul maxim de angajati care sunt intr-un departament
select MAX(numar_angajati) numar_angajati
from (select d.dname nume_departament, count(*) numar_angajati 
from emp a inner join dept d on a.deptno=d.deptno
group by d.dname);

-- afisam departamentele cu numarul maxim de angajati
select d.dname nume_departament, count(*) numar_angajati
from emp a inner join dept d on a.deptno=d.deptno
group by d.dname 
having count(*) =
	   (select MAX(numar_angajati) numar_angajati
		from (select d.dname nume_departament, count(*) numar_angajati 
		from emp a inner join dept d on a.deptno=d.deptno
		group by d.dname));

-- selectam toate veniturile angajatilor dintr-un anumit departament
-- in ordine
select b.ename nume_angajat, b.sal + nvl(b.comm, 0) venit
from emp b
where b.deptno = 10
order by venit;

-- selectam toate veniturile angajatilor din departamentul cu cei mai multi angajati descrescator
select b.ename nume_angajat, b.sal + nvl(b.comm, 0) venit
from emp b
where b.deptno = 
	(
		select d.deptno
		from emp a inner join dept d on a.deptno=d.deptno
		group by d.deptno 
		having count(*) =
	   		(select MAX(numar_angajati) numar_angajati
			from (select d.dname nume_departament, count(*) numar_angajati 
			from emp a inner join dept d on a.deptno=d.deptno
			group by d.dname))
	)
order by venit desc;

-- selectam doar primele doua randuri de mai sus
select b.ename nume_angajat, f.dname nume_departament, b.sal + nvl(b.comm, 0) venit
from emp b inner join dept f on b.deptno=f.deptno
where b.deptno = 
	(
		select d.deptno
		from emp a inner join dept d on a.deptno=d.deptno
		group by d.deptno 
		having count(*) =
	   		(select MAX(numar_angajati) numar_angajati
			from (select d.dname nume_departament, count(*) numar_angajati 
			from emp a inner join dept d on a.deptno=d.deptno
			group by d.dname))
	)
order by venit desc
fetch first 2 rows only;
