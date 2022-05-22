-- ex1
SELECT
	id_ang AS ecuson,
	nume,
	functie,
	salariu,
	id_dep departament,
	data_ang "Data Angajarii"
FROM angajati1
WHERE
	data_ang < '01-JAN-1982' AND
	(comision = 0 OR comision IS NULL)
ORDER BY nume;

-- ex2
SELECT
	id_ang AS ecuson,
	nume,
	functie,
	salariu,
	id_dep departament,
	data_ang "Data Angajarii"
FROM angajati1
WHERE
	id_sef IS NULL AND salariu > 3000
ORDER BY id_dep;

-- ex3
SELECT
	nume,
	functie,
	salariu + nvl(comision,0) * 12 AS "Venit Anual"
FROM angajati1
WHERE
	id_dep=&numar_departament AND
	functie NOT LIKE 'MANAGER'
ORDER BY id_dep;

-- ex4
SELECT
	id_dep departament,
	nume,
	salariu,
	data_ang as "Data Angajarii"
FROM angajati1
WHERE
	data_ang LIKE '%81' AND
	(id_dep=&numar_departament1 OR
	id_dep=&numar_departament2)
ORDER BY id_dep;
