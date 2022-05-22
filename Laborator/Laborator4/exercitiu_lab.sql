/*
Sa se scrie o cerere SQL care face o lista cu bonusul acordat angajatilor care
au venit in acelasi an cu presedintele in companie, nu au primit comision si au venitul lunar
strict mai mic decat 3000
Bonusul este de 10% din venitul lunar (venit lunar = salariu + comision). Presedintele si
directorii nu primesc bonus

Antetul listei: nume, functie, data angajare, venit lunar, comision, bonus.
Rezolvati prin cel putin 4 metode diferite
*/

-- metoda1
SELECT
	ENAME AS nume,
	JOB AS functie,
	HIREDATE AS "Data Angajarii",
	SAL + nvl(COMM, 0) AS "Venit Lunar",
	COMM AS comision,
	10 / 100 * (SAL + nvl(COMM, 0)) AS bonus
FROM EMP
WHERE
	HIREDATE LIKE '%81' AND
	(COMM = 0 OR COMM IS NULL) AND
	SAL + nvl(COMM, 0) < 3000 AND
	JOB NOT LIKE 'PRESIDENT' AND
	JOB NOT LIKE 'MANAGER'
ORDER BY ENAME;

-- metoda2
SELECT
	ENAME AS nume,
	JOB AS functie,
	HIREDATE AS "Data Angajarii",
	SAL + nvl(COMM, 0) AS "Venit Lunar",
	COMM AS comision,
	10 / 100 * (SAL + nvl(COMM, 0)) AS bonus
FROM EMP
WHERE
	(HIREDATE >= '01-JAN-1981' AND HIREDATE <= '31-DEC-1981') AND
	(COMM = 0 OR COMM IS NULL) AND
	SAL + nvl(COMM, 0) < 3000 AND
	lower(JOB) != 'president' AND
	lower(JOB) != 'manager'
ORDER BY ENAME;

-- metoda3
SELECT
	ENAME AS nume,
	JOB AS functie,
	HIREDATE AS "Data Angajarii",
	SAL + nvl(COMM, 0) AS "Venit Lunar",
	COMM AS comision,
	10 / 100 * (SAL + nvl(COMM, 0)) AS bonus
FROM EMP
WHERE
	(HIREDATE BETWEEN '01-JAN-1981' AND '31-DEC-1981') AND
	nvl(COMM, 0) = 0 AND
	SAL + nvl(COMM, 0) < 3000 AND
	lower(JOB) != 'president' AND
	lower(JOB) != 'manager'
ORDER BY ENAME;

-- metoda4
SELECT
	ENAME AS nume,
	JOB AS functie,
	HIREDATE AS "Data Angajarii",
	SAL + nvl(COMM, 0) AS "Venit Lunar",
	COMM AS comision,
	10 / 100 * (SAL + nvl(COMM, 0)) AS bonus
FROM EMP
WHERE
	(HIREDATE BETWEEN '01-JAN-1981' AND '31-DEC-1981') AND
	nvl(COMM, 0) = 0 AND
	(SAL + nvl(COMM, 0) BETWEEN 0 AND 2999) AND
	UPPER(JOB) NOT IN ('PRESIDENT', 'MANAGER')
ORDER BY ENAME;

-- metoda5
SELECT
	ENAME AS nume,
	JOB AS functie,
	HIREDATE AS "Data Angajarii",
	SAL + nvl(COMM, 0) AS "Venit Lunar",
	COMM AS comision,
	10 / 100 * (SAL + nvl(COMM, 0)) AS bonus
FROM EMP
WHERE
	HIREDATE LIKE '%&an_angajare' AND
	nvl(COMM, 0) = 0 AND
	SAL + nvl(COMM, 0) < 3000 AND
	UPPER(JOB) NOT IN ('PRESIDENT', 'MANAGER')
ORDER BY ENAME;