CREATE TABLE departamente1 AS
SELECT
	deptno id_dep,
	dname den_dep,
	loc locatie
FROM dept;

CREATE TABLE angajati1 AS
SELECT
	empno id_ang,
	ename nume,
	job functie,
	mgr id_sef,
	hiredate data_ang,
	sal salariu,
	comm comision,
	deptno id_dep
FROM emp;

SELECT * FROM angajati1

SELECT id_dep, den_dep
FROM departamente1;

SELECT
	id_ang||'-'||nume angajat,
	functie,
	data_ang
FROM angajati1
ORDER BY id_ang DESC;

SELECT
	id_ang||'-'||nume angajat,
	functie,
	salariu+nvl(comision, 0) AS "venit lunar",
	'	' AS semnatura
FROM angajati1
ORDER BY id_dep;

SELECT nume, 'cu functie', functie
FROM angajati1;

SELECT
	den_dep||' are codul '||id_dep "Lista Departamente"
FROM departamente
ORDER BY den_dep ASC;


SELECT
	a.id_ang ecuson,
	a.nume,
	a.data_ang AS "Data Angajarii",
	a.salariu
FROM angajati1 a
WHERE id_dep = 10;


SELECT
	id_dep "Nr. departament",
	nume,
	functie,
	salariu,
	data_ang AS "Data Angajarii"
FROM angajati1
WHERE LOWER(functie) = 'manager'
ORDER BY id_dep;


SELECT
	id_dep departament,
	functie,
	nume,
	data_ang AS "Data Angajarii"
FROM angajati1
WHERE data_ang BETWEEN '1-MAY-1981' AND '31-DEC-1981'
ORDER BY 1, 2 DESC;

SELECT
	id_dep departament,
	functie,
	nume,
	data_ang AS "Data Angajarii"
FROM angajati1
WHERE data_ang >= '1-MAY-1981' AND data_ang <= '31-DEC-1981'
ORDER BY 1, 2 DESC;


SELECT
	id_ang AS ecuson,
	nume,
	functie,
	salariu + nvl(comision, 0) "Venit lunar"
FROM angajati1
WHERE id_ang IN (7499, 7902, 7876)
ORDER BY name;


SELECT
	id_ang AS ecuson,
	nume,
	functie,
	salariu + nvl(comision, 0) "Venit lunar"
FROM angajati1
WHERE id_ang = 7499 OR id_ang = 7902 OR id_ang = 7876
ORDER BY name;

SELECT
	id_ang AS ecuson,
	nume,
	functie,
	data_ang AS "Data Angajarii"
FROM angajati1
WHERE data_ang LIKE '%80';


SELECT
	id_ang AS ecuson,
	nume,
	functie,
	data_ang AS "Data Angajarii"
FROM angajati1
WHERE nume LIKE 'F%' AND functie LIKE '_______';


SELECT
	id_ang AS ecuson,
	nume,
	functie,
	salariu,
	comision
FROM angajati1
WHERE
	(comision = 0 OR comision IS NULL) AND
	id_dep = 20
ORDER BY nume;


SELECT
	id_ang AS ecuson,
	nume,
	functie,
	salariu,
	comision
FROM angajati1
WHERE
	(comision != 0 AND comision IS NOT NULL) AND
	functie = UPPER('salesman')
ORDER BY nume;


SELECT
	id_ang AS ecuson,
	nume,
	functie,
	salariu,
	id_dep departament
FROM angajati1
WHERE
	salariu > 1500 AND
	LOWER(functie) = 'manager' OR
	UPPER(functie) = 'ANALYST'
ORDER BY functie, nume DESC;
