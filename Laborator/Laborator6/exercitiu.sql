/*
Sa scrie SQL care face o lista cu numarul de aparitii ale ultimelor doua litere din
numele angajatului, exact in ordinea literelor, care se regasesc in job-ul angajatului,
exact in acea ordine si succesive.

Antetul este urmatorul: nume angajat, job, nr aparitii.
Sa se rezolve prin cel putin doua metode distincte folosind diverse functii sql
*/

-- met1
SELECT
	ENAME nume_angajat,
	JOB job,
	(LENGTH(JOB) - 
	LENGTH(REPLACE(JOB, SUBSTR(ENAME, LENGTH(ENAME) - 1, LENGTH(ENAME)), '')))/2 numar_aparitii
FROM EMP;

-- met2
define func = "(LENGTH(JOB) - LENGTH(REPLACE(JOB, SUBSTR(ENAME, LENGTH(ENAME) - 1, LENGTH(ENAME)), '')))/2"

SELECT
	ENAME nume_angajat,
	JOB job,
	&func numar_aparitii
FROM EMP;