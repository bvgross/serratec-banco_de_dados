create schema if not exists biblioteca;

create table if not exists biblioteca.livro (
	id SERIAL primary key,
	autor VARCHAR(100) not null,
	ano_publicacao INT not null,
	genero VARCHAR(50) not null,
	quantidade_estoque INT not null
);

create table if not exists biblioteca.usuario (
	id SERIAL primary key,
	nome VARCHAR(100) not null,
	cpf INT unique,
	email VARCHAR(100) unique,
	telefone INT not null,
	endereco VARCHAR(100) not null
);

create type biblioteca.estado as ENUM('emprestado', 'devolvido');

create table if not exists biblioteca.emprestimo (
	id SERIAL primary key,
	CONSTRAINT fk_usuario
		FOREIGN KEY(id)
			REFERENCES biblioteca.usuario(id),
	CONSTRAINT fk_livro
		FOREIGN KEY(id)
			REFERENCES biblioteca.livro(id),
	data_emprestimo DATE not null,
	data_devolucao DATE,
	status biblioteca.estado not null
);

alter table biblioteca.livro
	add column editora VARCHAR(100);