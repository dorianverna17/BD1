/*
Sa se scrie o cerere SQL care face o lista cu toti directorii din companie care au
salariul mai mare decat jumatate din salariul presedintelui si au venit in companie inaintea lui.
Lista se ordoneaza dupa den de departament si are urmat antet:
denumire_departament_director, nume_director, job, data_angajare, salariu_director, salariu presedinte.
*/

-- metoda 1 -> self join
SELECT
	d.dname "Departament Director",
	a1.ename "Nume Director",
	a1.job "Job",
	a1.hiredate "Data Angajare",
	a1.sal "Salariu Director",
	a2.sal "Salariu Presedinte"
FROM
	emp a1,
	emp a2,
	dept d
WHERE
	a1.job = 'MANAGER' AND
	a2.job = 'PRESIDENT' AND
	a1.sal > (a2.sal / 2) AND
	a1.deptno = d.deptno AND
	a1.hiredate < a2.hiredate
ORDER BY d.dname;

-- metoda 2 -> self join
SELECT
	d.dname "Departament Director",
	a1.ename "Nume Director",
	a1.job "Job",
	a1.hiredate "Data Angajare",
	a1.sal "Salariu Director",
	a2.sal "Salariu Presedinte"
FROM
	dept d,
	emp a1
		INNER JOIN emp a2
			ON a1.job = 'MANAGER' AND
			   a2.job = 'PRESIDENT' AND
			   a1.sal > (a2.sal / 2) AND
			   a1.hiredate < a2.hiredate
WHERE
	a1.deptno = d.deptno
ORDER BY d.dname;
