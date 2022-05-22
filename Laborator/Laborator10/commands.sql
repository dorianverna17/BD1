-- ex1
create table studenti1
(
	facultate char(30) default 'Automatica si Calculatoare',
	catedra char(20),
	cnp number(13),
	nume varchar2(30),
	data_nasterii date,
	an_univ number(4) default 2019,
	medie_admitere number(4, 2),
	discip_oblig varchar2(20) default 'Matematica',
	discip_opt varchar(20) default 'Fizica',
	operator varchar2(20) default user,
	data_op timestamp default sysdate
);

-- ex2
create table dept_20
as
select deptno, ename, hiredate, sal + nvl(comm, 0) venit
from emp
where deptno=20;

-- ex3
create table dept_30
(
	id default 30,
	nume not null,
	data_ang,
	prima
)
as
select deptno, ename, hiredate,
	round(0.15*(sal + nvl(comm, 0)), 0)
from emp
where deptno = 30;

-- ex4
create table functii
(
	cod number(2) constraint pk_cod primary key,
	functie varchar2(20),
	data_vigoare date default sysdate
);

-- ex5
create table persoane
(
	nume varchar2(20),
	prenume varchar(20),
	serie_ci varchar2(2),
	cod_ci number(6),
	cnp number(13),
	constraint pk_persoane primary key(serie_ci, cod_ci, cnp)
);

-- ex6
create table angajati2
(
	id_ang number(4)
		constraint pk_id_ang2
		primary key,
	id_sef number(4),
	id_dep number(2)
		constraint fk_id_dep2
		references dept(deptno),
	nume varchar(20),
	functie varchar2(9),
	data_ang date,
	salariu number(7, 2),
	comision number(7, 2),
	constraint fk_id_sef2
		foreign key(id_sef)
		references angajati2(id_ang)
);

-- ex7
create table angajati3_1
(
	id_ang number(4) constraint pk_id_ang3 primary key,
	nume varchar(10) constraint ck_nume check(nume=upper(nume)),
	functie varchar2(10),
	id_sef number(4) constraint fk_id_sef3 references angajati3_1(id_ang),
	data_ang date default sysdate,
	salariu number(7, 2) constraint nn_salariu not null,
	comision number(7, 2),
	id_dep number(2) constraint nn_id_dep3 not null,
	constraint fk_id_dep3 foreign key (id_dep)
		references dept(deptno),
	constraint ck_comision check(comision <= salariu)
);

-- ex8
create table example6
(
	colA number(2), col2 number(2), col3 number(2),
	col4 number(2), col5 number(2), col6 number(2),
	col7 number(2), col8 number(2), col9 number(2)
);

alter table example6 rename to exampleAlter;

alter table exampleAlter rename column colA to col1;

alter table exampleAlter modify (col1 varchar2(20));

alter table exampleAlter modify (col2 varchar2(20), col3 date);

alter table exampleAlter set unused(col4);

alter table exampleAlter set unused(col5, col6);

alter table exampleAlter drop unused columns;

alter table exampleAlter add
(col4 varchar2(20), col5 varchar2(20), col6 varchar2(20));

alter table exampleAlter drop column col7;

alter table exampleAlter drop (col8, col9);

alter table exampleAlter add constraint pk_coll_alter primary key (col1);

alter table exampleAlter add constraint pk_col12_alter primary key (col1, col2);

alter table exampleAlter add constraint fk_col21 foreign key (col2)
	references exampleAlter(col1);

alter table exampleAlter add constraint fk_col34_12 foreign key (col3, col4)
	references exampleAlter(col1, col2);

alter table exampleAlter add constraint uq_col3_alter unique(col3);

alter table exampleAlter add constraint uq_col45_alter unique(col4, col5);

alter table exampleAlter disable constraint uq_col3_alter;

alter table exampleAlter enable constraint uq_col3_alter;

alter table exampleAlter drop constraint uq_col3_alter;

-- ex9
create table dept2
(
	id_dep number(2),
	dname varchar2(14)
);

insert into dept2 values(50, 'IT');

insert into dept2(id_dep) values(60);

select * from dept2;

insert into dept2
select deptno, dname
	from dept
	where deptno in (20, 30);

select * from dept2;
-- ex10
update dept2
set dname = 'HR',
    id_dep = 80
where id_dep = 60;

select * from dept2;

update dept2
set dname = 'Human Res'
where id_dep = 80;

select * from dept2;

update dept2
set (id_dep, dname) = (select deptno, dname
		       from dept
		       where deptno = 10)
where id_dep = 20;

select * from dept2;


--ex11
delete from dept2
where id_dep = 80;

select * from dept2;

delete from dept2
where (id_dep, dname) in (select deptno, dname
			  from dept
			  where deptno in (10, 30));

select * from dept2;

delete from dept2;

-- ex12
create sequence seq_id_dep
start with 1
increment by 10
nocache
nocycle;

alter sequence seq_id_dep cycle;

insert into dept2
values(seq_id_dep.nextval, 'test');

drop sequence seq_id_dep;

-- ex13
create or replace view view_dept
	as select deptno, dname from dept;

select * from view_dep;

insert into view_dept values(80, 'test');

select * from view_dept;

update view_dept set den_dep='HR' where id_dep = 80;

select * from view_dept;

delete from view_dept where deptno = 80;

drop view view_dept;

/*ex
Sa se creeze o tabela sefi
den dept, nume sef, numar subalterni
tabela se va popula cu date in momentul in care se creeaza si va contine date despre
sefii de departamentcare fac parte din departamentul cu cei mai multi angajati
*/

-- query care selecteaza numarul de angajati al fiecaruli departament
select deptno, count(*)
	from emp
	group by deptno;

-- query care selecteaza departamentul cu nr maxim de angajati
select max(count(empno))
	from emp
	group by deptno;

-- query care intoarce departamentul cu cei mai multi angajati
select deptno
from (select deptno, count(*) no_emp
      from emp
      group by deptno) t
      where t.no_emp = (select max(count(empno))
		  from emp
		  group by deptno);

-- query care preia sefii din departamentul 30
select ename
from emp
where deptno = 30 and empno in (select mgr
				from emp
				where deptno = 30);

-- query care preia sefii din departamentul cu cei mai multi angajati
select ename
from emp
where deptno = (select deptno
		from (select deptno, count(*) no_emp
      		      from emp
                      group by deptno) t
                      where t.no_emp = (select max(count(empno))
		                        from emp
		                        group by deptno))
      and
      empno in (select mgr
		from emp
		where deptno = (select deptno
				from (select deptno, count(*) no_emp
      		      		      from emp
                                      group by deptno) t
                      		      where t.no_emp = (select max(count(empno))
		                                        from emp
		                                        group by deptno)));

-- query care returneaza numarul de subalterni ai unui angajat
select count(*)
from emp
where mgr = 7698;

-- query care afiseaza informatiile necesare despre sefi
select d.dname, a.ename, (select count(*)
			from emp
			where mgr = a.empno) nr_subalterni
from emp a
	natural join dept d
where deptno = (select deptno
		from (select deptno, count(*) no_emp
      		      from emp
                      group by deptno) t
                      where t.no_emp = (select max(count(empno))
		                        from emp
		                        group by deptno))
      and
      empno in (select mgr
		from emp
		where deptno = (select deptno
				from (select deptno, count(*) no_emp
      		      		      from emp
                                      group by deptno) t
                      		      where t.no_emp = (select max(count(empno))
		                                        from emp
		                                        group by deptno)));


-- query pt crearea tabelei
create table sefi
as
select d.dname, a.ename, (select count(*)
			from emp
			where mgr = a.empno) nr_subalterni
from emp a
	natural join dept d
where deptno = (select deptno
		from (select deptno, count(*) no_emp
      		      from emp
                      group by deptno) t
                      where t.no_emp = (select max(count(empno))
		                        from emp
		                        group by deptno))
      and
      empno in (select mgr
		from emp
		where deptno = (select deptno
				from (select deptno, count(*) no_emp
      		      		      from emp
                                      group by deptno) t
                      		      where t.no_emp = (select max(count(empno))
		                                        from emp
		                                        group by deptno)));
