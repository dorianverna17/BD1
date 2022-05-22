-- ex1
SELECT ENAME, DEPTNO, SAL
	FROM EMP
	WHERE DEPTNO='&1' AND (12 * (SAL + nvl(COMM, 0)))>'&2';

-- ex2

ACCEPT numar_departament char prompt 'Introduceti numarul departamentului:'
ACCEPT venit_mediu_anual char prompt 'Introduceti venitul mediu anual:'

SELECT ENAME, DEPTNO, (12 * (SAL + nvl(COMM, 0)))
	FROM EMP
	WHERE DEPTNO=&numar_departament AND (12 * (SAL + nvl(COMM, 0)))>&venit_mediu_anual;

UNDEFINE numar_departament
UNDEFINE venit_mediu_anual

-- ex3

SELECT ENAME, &&numar_departament numar_departament, (12 * (SAL + nvl(COMM, 0)))
	FROM EMP
	WHERE DEPTNO=&numar_departament AND (12 * (SAL + nvl(COMM, 0))) > &&venit_mediu_anual;

undefine numar_departament
undefine venit_mediu_anual

-- ex4

SELECT ENAME, DEPTNO, (12 * (SAL + nvl(COMM, 0)))
	FROM EMP
	WHERE DEPTNO=&numar_departament AND (12 * (SAL + nvl(COMM, 0))) > &venit_mediu_anual;

/*
Sa se scrie o cerere SQL care face o lista cu toti analistii care au venit in
companie dupa presedinte si nu au primit comision.
Antetul listei este urmat.:
nume, functie, data angajare, salariu, data angajara presedinte
Numele jobului si data de angajare a presedintelui se vor citi de la tastura
Sa se rezolve in 4 varainte diferite
*/

-- var 1
accept functie char prompt 'Introduceti numele job-ului:'
accept angajare_presedinte char prompt 'Introduceti data angajarii presedintelui:'

SELECT ENAME, JOB, SAL, '&angajare_presedinte' as DATA
	FROM EMP
	WHERE JOB='&functie' AND HIREDATE>'&angajare_presedinte';

undefine functie
undefine angajare_presedinte

-- var 2

SELECT ENAME, JOB, SAL, '&2' as DATA
	FROM EMP
	WHERE JOB='&1' AND HIREDATE>'&2';

-- var 3

SELECT ENAME, JOB, SAL, '&&data_angajare_presedinte' as DATA
	FROM EMP
	WHERE JOB='&&functie' AND HIREDATE>'&data_angajare_presedinte';
