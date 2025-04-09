select * from biblioteca.livro;
select * from biblioteca.emprestimo;
select * from biblioteca.usuario;

/*ALTER TABLE biblioteca.usuario
	ADD COLUMN telefone VARCHAR(11) NOT NULL;

ALTER TABLE biblioteca.usuario
	DROP COLUMN telefone;*/

/*ALTER TABLE biblioteca.emprestimo
	ADD COLUMN idlivro int references biblioteca.livro(id)*/
	
INSERT INTO biblioteca.livro
	(nome, autor, ano_publicacao, genero, quantidade_estoque, editora)
VALUES	
	('A metamorfose: DIE VERWANDLUNG','Franz Kafka','2019','Novela','125','Principis'),
	('O Pequeno Príncipe','Antoine Saint-Exupery','2024','Fabula','211','HarperKids'),
	('Cem anos de solidão','Gabriel García Márquez','1977','Novela','98','Record'),
	('O Hobbit','J.R.R. Tolkien','2019','Fantasia','351','HarperCollins'),
	('Cartas de um diabo a seu aprendiz','C. S. Lewis','2017','Novela','55','Thomas Nelson Brasil'),
	('Rambo: First Blood','David Morrell','2025','Novela','76','Pipoca e Nanquim'),
	('Amar, verbo intransitivo','Mario de Andrade','2025','Romance','43','Antofágica'),
	('Memórias Póstumas de Brás Cubas','Machado de Assis','2025','Novela','198','Editora Garnier'),
	('A revolução dos bichos: Um conto de fadas','George Orwell','2007','Novela','97','Companhia das Letras'),
	('Admirável mundo novo','Aldous Huxley','2014','Ficção Científica','132','Biblioteca Azul');

INSERT INTO biblioteca.usuario
	(nome, cpf, email, telefone, endereco)
VALUES	
	('Bruno Ventura Gross','36967531816','bvgross@gmail.com','24999150402','Rua João Rodrigues Batista, 59, Chácara Flora, Petrópolis - RJ'),
	('Erika Ventura Gross','23544869910','evg@gmail.com','61999112545','Condomínio Por do Sol, Jardim Botânico, Brasília - DF'),
	('Rayca Thais Barbosa','52203563000','raycabarbosa@gmail.com','21996808730','Rua Joao Barbosa, Jardim, Terasópolis - RJ'),
	('Cauã Pacheco','68462201022','cauapacheco@hotmail.com','24998515445','Travessa André Ribeiro, Vila, Teresópolis - RJ'),
	('Lívia Verissimo Raissinger','35887745000','liviaraissinger@gmail.com','24998750401','Rua Rodrigo Goulart, Vila Mimosa, Petrópolis - RJ');

INSERT INTO biblioteca.emprestimo
	(data_emprestimo, data_devolucao, status, idusuario, idlivro)
VALUES
	('2025-01-02','2025-01-02','emprestado','1','2'),
	('2024-08-17','2024-09-10','devolvido','3','4'),
	('2023-04-12','2023-08-18','devolvido','5','8');

DELETE FROM 
	biblioteca.usuario
WHERE
	id = 1; -- NÃO FOI POSSÍVEL DELETAR ESSE USÁRIO POIS ELE ESTÁ REFERENCIADO NA TABELA EMPRESTIMO