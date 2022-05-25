/*
Sa se scrie o cerere SQL*Plus care face o lista cu toti angajatii din companie, locatia
departamentului lor si numarul de angajati din locatia respectiva. Lista va contine numai
angajatii din locatiile care au numar de angajati multiplu de 3. Antetul listei:
- Nume_Angajat
- Locatie_Departament
- Numar_Angajati_Loc
Pentru testare, se va utiliza baza de date formata din tabelele EMP, DEPT si SALGRADE.
*/

-- cerere care afiseaza pentru fiecare angajat locatia
select a.ename nume, d.loc locatie
from emp a inner join dept d on a.deptno=d.deptno;

-- cerere care afiseaza numarul de angajati pentru fiecare locatie
select count(*) numar_angajati, d.loc locatie
from emp a inner join dept d on a.deptno=d.deptno 
group by d.loc;

-- cerere care afiseaza fiecare locatie
-- doar pentru nr de angajati care e multiplu de 3
select count(*) numar_angajati, d.loc locatie
from emp a inner join dept d on a.deptno=d.deptno 
group by d.loc
having MOD(count(*), 3)=0;

-- cerere finala
select
	a.ename nume,
	d.loc locatie,
	(
	select count(*)
	from emp a1 inner join dept d1 on a1.deptno=d1.deptno 
	group by d1.loc
	having d1.loc=d.loc
	) nr_angajati
from emp a inner join dept d on a.deptno=d.deptno 
where d.loc in
	(
		select c.loc
		from emp b inner join dept c on b.deptno=c.deptno 
		group by c.loc
		having MOD(count(*), 3)=0
	);