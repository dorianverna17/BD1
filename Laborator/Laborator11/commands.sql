SET LINESIZE 90
SET PAGESIZE 30

COL A FORMAT A20 HEADING 'Departament'
COL B FORMAT A30 HEADING 'Nume'
COL C FORMAT A20 HEADING 'Functie'
COL D FORMAT A10 HEADING 'Data|Angajare' JUSTIFY CENTER
COL E FORMAT 9999 HEADING 'Prima' JUSTIFY RIGHT
COL F NOPRINT NEW_VALUE Z
BREAK ON A SKIP 1 ON REPORT
COMPUTE SUM LABEL'Total:' OF E ON A REPORT

TTITLE LEFT 'Pag.' SQL.PNO CENTER UNDERLINE 'STAT DE PRIME'
BTITLE LEFT 'Data:' Z RIGHT 'DIRECTOR ECONOMIC'

SELECT d.dname A, a.ename B, a.job C,
	to_char(a.hiredate, 'DD.MM.YYYY') D,
	months_between(sysdate, a.hiredate) E,
	to_char(sysdate, 'DD/MM/YYYY') F
FROM emp a, dept d
where a.deptno = d.deptno
AND ((months_between(sysdate, a.hiredate) = (
	SELECT max(months_between(sysdate, hiredate))
	from emp
	where deptno=d.deptno))
OR empno IN (SELECT DISTINCT mgr from emp))
Order by A, B
/
TTITLE OFF
BTITLE OFF
CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTE

/*
Enunt:
Sa se faca un raport cu angajatii care au vechimea mai mare decat vechimea sefului direct (cel de pe coloana mgr) si nu au primit comision
Titlul raportului: Lista vechime angajati
Antetul: Denumire departament subaltern, nume subaltern, vechime subaltern, nume sef, vechime sef, salariu subaltern
(vechimea apare in ani intregi de vechime).
*/

-- query care preia seful direct al fiecarui angajat
SELECT DISTINCT a.ename "Nume angajat", d.ename "Nume sef"
from emp a, emp d
where a.mgr = d.empno;

-- query care preia vechimea in luni a fiecarui angajat
select a.ename "Nume angajat", ROUND(months_between(sysdate, a.hiredate)) "Vechime luni"
from emp a;

-- query care preia seful direct al fiecarui angajat care are vechimea mai mare decat a sefului direct
SELECT DISTINCT a.ename "Nume angajat", d.ename "Nume sef"
FROM emp a, emp d
WHERE a.mgr = d.empno
AND (select ROUND(months_between(sysdate, hiredate))
	from emp
	where empno=a.empno) >
    (select ROUND(months_between(sysdate, hiredate))
	from emp
	where empno=d.empno);

-- query care preia angajatii care au vechimea mai mare decat seful + nu au comision
-- si afiseaza informatiile necesare in antet
SELECT DISTINCT dpt.dname "Departament",
	        a.ename "Nume angajat",
		(ROUND(ROUND(months_between(sysdate, a.hiredate)) / 12)) "Vechime subaltern",
		d.ename "Nume sef",
		(ROUND(ROUND(months_between(sysdate, d.hiredate)) / 12)) "Vechime sef",
		a.sal "Salariu subaltern"
FROM emp a natural join dept dpt,
     emp d
WHERE a.mgr = d.empno
AND (select ROUND(months_between(sysdate, hiredate))
	from emp
	where empno=a.empno) >
    (select ROUND(months_between(sysdate, hiredate))
	from emp
	where empno=d.empno)
AND nvl(a.comm, 0)=0;

-- varianta finala
SET LINESIZE 110
SET PAGESIZE 30

COL A FORMAT A20 HEADING 'Departament'
COL B FORMAT A20 HEADING 'Subaltern'
COL C FORMAT 99 HEADING 'Vechime subaltern' JUSTIFY RIGHT
COL D FORMAT A10 HEADING 'Nume sef' JUSTIFY CENTER
COL E FORMAT 99 HEADING 'Vechime sef' JUSTIFY RIGHT
COL F FORMAT 9999 HEADING 'Salariu Subaltern' JUSTIFY RIGHT
COL G NOPRINT NEW_VALUE Z
BREAK ON A SKIP 1 ON REPORT
COMPUTE SUM LABEL'Total:' OF F ON A REPORT

TTITLE LEFT 'Pag.' SQL.PNO CENTER UNDERLINE 'Lista vechime angajati'
BTITLE LEFT 'Data:' Z RIGHT 'DIRECTOR ECONOMIC'

SELECT DISTINCT dpt.dname A,
	        a.ename B,
		(ROUND(months_between(sysdate, a.hiredate) / 12)) C,
		d.ename D,
		(ROUND(months_between(sysdate, d.hiredate) / 12)) E,
		a.sal F,
		to_char(sysdate, 'DD/MM/YYYY') G
FROM emp a natural join dept dpt,
     emp d
WHERE a.mgr = d.empno
AND (select ROUND(months_between(sysdate, hiredate))
	from emp
	where empno=a.empno) >
    (select ROUND(months_between(sysdate, hiredate))
	from emp
	where empno=d.empno)
AND nvl(a.comm, 0)=0
/
TTITLE OFF
BTITLE OFF
CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTE