CREATE TABLE departamente
(
	id_departament NUMBER(2) NOT NULL,
	denumire_departament VARCHAR2(30),
	telefon VARCHAR2(10)
);

CREATE TABLE grila_salariu
(
	grad NUMBER(2),
	nivel_inferior NUMBER,
	nivel_superior NUMBER
);

CREATE TABLE angajati
(
	id_angajat NUMBER(4) NOT NULL,
	nume VARCHAR2(30),
	prenume VARCHAR2(30),
	functie VARCHAR2(20),
	id_sef NUMBER(4),
	data_angajarii DATE DEFAULT SYSDATE,
	salariu NUMBER(7, 2) DEFAULT 2000,
	comision NUMBER(7, 2),
	id_departament NUMBER
);

-- Primary Keys
ALTER TABLE departamente ADD CONSTRAINT pk_departamente PRIMARY KEY (id_departament);

ALTER TABLE grila_salariu ADD CONSTRAINT pk_grila PRIMARY KEY (grad);

ALTER TABLE angajati ADD CONSTRAINT pk_grila PRIMARY KEY (id_angajat);

-- Foreign Keys
ALTER TABLE angajati ADD CONSTRAINT fk_ang__dep FOREIGN KEY (id_departament)
	REFERENCES departamente(id_departament);

ALTER TABLE angajati ADD CONSTRAINT fk_ang__dep FOREIGN KEY (id_departament)
	REFERENCES departamente(id_departament); 

-- Unique
ALTER TABLE departamente ADD CONSTRAINT uq_denumire UNIQuE (denumire_departament);

ALTER TABLE angajati ADD CONSTRAINT uq_nume UNIQUE (nume, prenume);

-- DROP TABLES
DROP TABLE angajati;
DROP TABLE departamente;
DROP TABLE grila_salariu;

-- Inserare date
INSERT INTO grila_salariu VALUES(1, 1, 1000);
INSERT INTO grila_salariu VALUES(1, 1001, 2000);

INSERT INTO departamente VALUES(10, 'Proiectare Software', '3212121');
INSERT INTO departamente VALUES(20, 'Asigurarea Calitatii', '3212122');
INSERT INTO departamente VALUES(20, 'Asigurarea Calitatii', '3212122');

