/*
Sa se creeze o tabela angajari cu urmatoarea structura: an, data_angajare,
denumire departament, nume, salariu
In aceasta tabela se vor insera date pentru angajatii care au venit in firma
in prima luna in care s-au facut angajari din fiecare an
*/

-- query in care selectam fiecare an in care s-a angajat fiecare angajat
select
	a.ename nume,
	extract (YEAR from a.hiredate) an_angajare
from emp a;

-- selectam fiecare an in care s-au facut angajari
select
	extract (YEAR from a.hiredate) an_angajare
from emp a
group by extract (YEAR from a.hiredate);

-- query care selecteaza lunile in care s-au facut angajari intr-un anumit an
-- hardcodam 1987
select
	extract (MONTH from a.hiredate) luna_angajare
from emp a
where extract (YEAR from a.hiredate) = 1987;

-- query care selecteaza prima luna in care s-au facut angajari pentru fiecare an
-- hardcodam 1987
select MIN(luna_angajare) prima_luna
from
	(
	select
		extract (MONTH from a.hiredate) luna_angajare
	from emp a
	where extract (YEAR from a.hiredate) = 1987
	);

-- facem asta pentru fiecare an in care s-au facut angajari
select
	extract (YEAR from a.hiredate) an_angajare,
	(
		select MIN(luna_angajare) prima_luna
		from
		(
			select
				extract (MONTH from b.hiredate) luna_angajare
			from emp b
			where extract (YEAR from b.hiredate) = extract (YEAR from a.hiredate)
		)
	) prima_luna
from emp a
group by extract (YEAR from a.hiredate);

-- selectam angajatii care au venit in firma in acel an si in luna aceea
select
	extract (YEAR from c.hiredate) an,
	c.hiredate data_angajare,
	d.dname departament,
	c.ename nume,
	c.sal salariu
from emp c inner join dept d on c.deptno=d.deptno 
where extract (MONTH from c.hiredate) = 
	(
		select
			prima_luna
		from
			(
				select
					extract (YEAR from a.hiredate) an_angajare,
					(
						select MIN(luna_angajare) prima_luna
						from
						(
							select
								extract (MONTH from b.hiredate) luna_angajare
							from emp b
							where extract (YEAR from b.hiredate) = extract (YEAR from a.hiredate)
						)
					) prima_luna
				from emp a
				group by extract (YEAR from a.hiredate)
			) f
		where extract (YEAR from c.hiredate) = f.an_angajare
	);