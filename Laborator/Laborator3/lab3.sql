SELECT EMPNO, ENAME, JOB, SAL
	from emp
	where MGR=&MGR;

SET VERIFY OFF

SELECT EMPNO, ENAME, '&JOB' JOB, SAL
	from emp
	where JOB=&JOB;

SELECT ENAME, JOB, &SAL SAL
	from &tabel
	where &nume_coloana = &valoare_coloana;

SELECT ENAME, JOB, &&venit_lunar venit_lunar
	from EMP
	where &venit_lunar > 2000;

UNDEFINE venit_lunar

SELECT EMPNO, ENAME, JOB, HIREDATE
	FROM EMP
	WHERE JOB='&1' AND HIREDATE>'&2'
	ORDER BY HIREDATE;

ACCEPT functie_ang char prompt 'Introduceti functia angajatului:'

SELECT ENAME, SAL, COMM
	FROM EMP
	WHERE JOB='&functie_ang';

UNDEFINE functie_ang

ACCEPT id_ang char prompt 'Introduceti ecusonul angajatului:'
ACCEPT nume char prompt 'Introduceti numele angajatului:'
ACCEPT functie char prompt 'Introduceti functia angajatului:'
ACCEPT salariu char prompt 'Introduceti salariul angajatului:' hide

INSERT INTO EMP(EMPNO, ENAME, JOB, SAL)
	VALUES(&id_ang, '&nume', '&functie', &salariu);

UNDEFINE id_ang
UNDEFINE functie
UNDEFINE nume
UNDEFINE salariu


define procent_prima = 0.15
define id_dep = 20

SELECT ENAME, SAL, SAL*&procent_prima prima
	FROM EMP
	WHERE DEPTNO=&id_dep;

undefine procent_prima
undefine id_dep