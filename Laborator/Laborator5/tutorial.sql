-- cross join
SELECT ENAME, JOB, DNAME
FROM EMP, DEPT
WHERE JOB = 'ANALYST';

SELECT ENAME, JOB, DNAME
FROM EMP
	CROSS JOIN DEPT
WHERE JOB = 'ANALYST';

-- inner join

-- equi join

-- metoda 1
SELECT
	a.deptno,
	d.dname,
	a.ename,
	a.job
FROM
	emp a,
	dept d
WHERE
	a.deptno = d.deptno
	AND a.deptno = 10
ORDER BY 3;

-- metoda 2
SELECT
	emp.deptno,
	dept.dname,
	emp.ename,
	emp.job
FROM
	emp,
	dept
WHERE
	emp.deptno = dept.deptno
	AND emp.deptno = 10
ORDER BY 3;

-- metoda 3
SELECT
	a.deptno,
	d.dname,
	a.ename,
	a.job
FROM
	emp a,
	JOIN dept d
		ON a.deptno = d.deptno
WHERE
	a.deptno = 10
ORDER BY 3;

-- metoda 4
SELECT
	a.deptno,
	d.dname,
	a.ename,
	a.job
FROM
	emp a,
	INNER JOIN dept d
		ON a.deptno = d.deptno
WHERE
	a.deptno = 10
ORDER BY 3;

-- metoda 5
SELECT
	deptno,
	d.dname,
	a.ename,
	a.job
FROM
	emp a
	INNER JOIN dept d
		USING (deptno)
WHERE
	deptno = 10
ORDER BY 3;

-- metoda 6
SELECT
	deptno,
	d.dname,
	a.ename,
	a.job
FROM
	emp a
	JOIN dept d
		USING (deptno)
WHERE
	deptno = 10
ORDER BY 3;

-- natural join
SELECT
	deptno,
	dname,
	ename,
	job
FROM
	emp
	NATURAL JOIN dept d
WHERE
	deptno = 10
ORDER BY 3;

-- Non-Equi Join
-- metoda 1
SELECT a.ename, a.sal, g.grad
FROM EMP a, grila_salariu g
WHERE
	a.sal BETWEEN g.nivel_inf AND g.nivel_sup
AND a.deptno = 20;

-- metoda 2
SELECT a.ename, a.sal, g.grad
FROM emp a
	INNER JOIN grila_salariu g
		ON a.sal BETWEEN g.nivel_inf AND g.nivel_sup
AND a.deptno = 20;

-- metoda 3
SELECT a.ename, a.sal, g.grad, d.dname
FROM emp a, grila_salariu g, dept d
WHERE
	a.sal BETWEEN g.nivel_inf AND g.nivel_sup
	AND d.deptno = a.deptno
AND a.deptno = 20
ORDER BY 3, 1;

-- metoda 4
SELECT a.ename, a.sal, g.grad, d.dname
FROM emp a
	INNER JOIN grila_salariu g
		ON a.sal BETWEEN g.nivel_inf AND g.nivel_sup
	INNER JOIN dept d
		ON d.deptno = a.deptno
WHERE a.deptno = 20
ORDER BY 3, 1;

-- metoda 5
SELECT a.ename, a.sal, g.grad, d.dname
FROM emp a
	JOIN grila_salariu g
		ON a.sal >= g.nivel_inf AND a.sal <= g.nivel_sup
	JOIN dept d
		ON d.deptno = a.deptno
WHERE a.deptno = 20
ORDER BY 3, 1;

-- self join
-- metoda 1
SELECT
	a1.ename "Nume Angajat",
	a1.job "Functie Angajat",
	a2.ename "Nume Sef",
	a2.job "Functie Sef"
FROM
	emp a1,
	emp a2
WHERE
	a1.mgr = a2.empno
	AND a1.deptno = 10;

-- metoda 2
SELECT
	a1.ename "Nume Angajat",
	a1.job "Functie Angajat",
	a2.ename "Nume Sef",
	a2.job "Functie Sef"
FROM
	emp a1
		INNER JOIN emp a2
		ON a1.mgr = a2.empno
WHERE
	a1.mgr = a2.empno
	AND a1.deptno = 10;

-- Outer Join
-- Left Outer Join
-- metoda 1
SELECT d.deptno, d.dname, a.ename, a.job
FROM dept d, emp a
WHERE d.deptno = a.deptno(+)
ORDER BY a.deptno;

-- metoda 2
SELECT d.deptno, d.dname, a.ename, a.job
FROM dept d
	LEFT OUTER JOIN emp a
		ON d.deptno = a.deptno
ORDER BY a.deptno;

-- Right Outer Join
-- Full Outer Join
SELECT a.ename, a.sal, g.grad
FROM grila_salariu g
	FULL OUTER JOIN emp a
		ON a.sal*2 BETWEEN g.nivel_inf AND g.nivel_sup
ORDER BY a.ename;


SELECT d.dname, a.ename, a.sal, g.grad
FROM grila_salariu g
	FULL OUTER JOIN emp a
		RIGHT OUTER JOIN dept d
			ON d.deptno = a.deptno
		ON a.sal*2 BETWEEN g.nivel_inf AND g.nivel_sup
ORDER BY d.dname, a.ename, g.grad;

SELECT d.dname, a.ename, a.sal, g.grad
FROM emp a
	FULL OUTER JOIN grila_salariu g
		ON a.sal*2 BETWEEN g.nivel_inf AND g.nivel_sup
	FULL OUTER JOIN dept d
		ON d.deptno = a.deptno		
ORDER BY d.dname, a.ename, g.grad;

