-- CREATE SCHEMA aula;
CREATE TABLE IF NOT EXISTS aula.curso
(
	id serial primary key,
	nome varchar(100) not null,
	carga_horaria int not null
)
--DROP TABLE aula.curso
CREATE TABLE IF NOT EXISTS aula.docente
(
	id serial primary key,
	nome varchar(100) not null,
	titulacao varchar(50) not null	
)
CREATE TABLE IF NOT EXISTS aula.discente
(
	id serial primary key,
	nome varchar(100) not null,
	curso_id int not null
)
ALTER TABLE aula.discente
       ADD CONSTRAINT fk_discente_curso
       FOREIGN KEY (curso_id)
       REFERENCES aula.curso(id);

ALTER TABLE aula.curso
       ADD COLUMN docent_id INT;
	   
ALTER TABLE aula.curso 
       ADD CONSTRAINT fk_curso_docente
       FOREIGN KEY (id)
       REFERENCES aula.docente(id);