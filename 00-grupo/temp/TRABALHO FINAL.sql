---------------------------------------------------------------------------------
--CRIAR DATABASE
--CREATE DATABASE ProjetoFinal;


---------------------------------------------------------------------------------
--CRIAR SCHEMA
CREATE SCHEMA clinica;



---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--TABELAS DEPENDENTES E "PRINCIPAL" ENDEREÇO
CREATE TABLE IF NOT EXISTS clinica.bairro
(
    id_bairro serial PRIMARY KEY,
    bairro varchar(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS clinica.cidade
(
    id_cidade serial PRIMARY KEY,
    cidade varchar(100) NOT NULL,
    uf varchar(2) NOT NULL
);
CREATE TABLE IF NOT EXISTS clinica.tipo_logradouro
(
    id_tipo_logradouro serial PRIMARY KEY,
    tipo_logradouro varchar(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS clinica.logradouro
(
    id_logradouro serial PRIMARY KEY,
    id_tipo_logradouro int NOT NULL,
    FOREIGN KEY (id_tipo_logradouro) REFERENCES clinica.tipo_logradouro(id_tipo_logradouro),
    logradouro_nome varchar(150) NOT NULL
);

CREATE TABLE IF NOT EXISTS clinica.cep
(
    id_cep serial PRIMARY KEY,
    cep varchar(9) NOT NULL,
    id_logradouro int NOT NULL,
    id_tipo_logradouro int NOT NULL,
    FOREIGN KEY (id_logradouro) REFERENCES clinica.logradouro(id_logradouro),
    FOREIGN KEY (id_tipo_logradouro) REFERENCES clinica.tipo_logradouro(id_tipo_logradouro)
);

CREATE TABLE IF NOT EXISTS clinica.endereco
(
    id_endereco serial PRIMARY KEY,
    numero bigint,
    complemento varchar(100),
    id_cidade int NOT NULL,
    id_bairro int NOT NULL,
    id_cep int NOT NULL,
    id_tipo_logradouro int NOT NULL,
    id_logradouro int NOT NULL,
    FOREIGN KEY (id_cidade) REFERENCES clinica.cidade(id_cidade),
    FOREIGN KEY (id_bairro) REFERENCES clinica.bairro(id_bairro),
    FOREIGN KEY (id_cep) REFERENCES clinica.cep(id_cep),
    FOREIGN KEY (id_tipo_logradouro) REFERENCES clinica.tipo_logradouro(id_tipo_logradouro),
    FOREIGN KEY (id_logradouro) REFERENCES clinica.logradouro(id_logradouro)
);


---------------------------------------------------------------------------------
--TABELAS DEPENDENTES E "PRINCIPAL" PACIENTE
CREATE TABLE IF NOT EXISTS clinica.email
(
    id_email serial PRIMARY KEY,
    email varchar(80) NOT NULL
);

CREATE TABLE IF NOT EXISTS clinica.telefone
(
    id_telefone serial PRIMARY KEY,
    telefone varchar(14) NOT NULL
);

CREATE TABLE IF NOT EXISTS clinica.paciente
(
    id_paciente serial PRIMARY KEY,
    nome_paciente varchar(100) NOT NULL,
    cpf varchar(14) UNIQUE NOT NULL,
    data_nascimento date NOT NULL,
    id_endereco int NOT NULL,
    historico_consultas text,
    FOREIGN KEY (id_endereco) REFERENCES clinica.endereco(id_endereco)
);

ALTER TABLE clinica.email ADD COLUMN id_paciente INT;

ALTER TABLE clinica.email
ADD CONSTRAINT id_paciente 
FOREIGN KEY (id_paciente) REFERENCES clinica.paciente(id_paciente) 
ON DELETE CASCADE;

ALTER TABLE clinica.telefone ADD COLUMN id_paciente INT;

ALTER TABLE clinica.telefone
ADD CONSTRAINT id_paciente 
FOREIGN KEY (id_paciente) REFERENCES clinica.paciente(id_paciente) 
ON DELETE CASCADE;

ALTER TABLE clinica.paciente ADD COLUMN id_email INT;

ALTER TABLE clinica.paciente
ADD CONSTRAINT id_email 
FOREIGN KEY (id_email) REFERENCES clinica.email(id_email) 
ON DELETE CASCADE;

ALTER TABLE clinica.paciente ADD COLUMN id_telefone INT;

ALTER TABLE clinica.paciente
ADD CONSTRAINT id_telefone 
FOREIGN KEY (id_telefone) REFERENCES clinica.telefone(id_telefone) 
ON DELETE CASCADE;


---------------------------------------------------------------------------------
--TABELA DENTISTAS
CREATE TABLE IF NOT EXISTS clinica.dentistas (
    id_dentista SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    cro VARCHAR(20) UNIQUE NOT NULL,
    especialidade VARCHAR(50) NOT NULL
);

---------------------------------------------------------------------------------
--TABELAS DEPENDENTES E "PRINCIPAL" HORÁRIOS 
CREATE TABLE IF NOT EXISTS clinica.hora (
    id_hora SERIAL PRIMARY KEY,            
    hora VARCHAR(11) NOT NULL   --"10:00-11:00": padrão de formatação 
);

CREATE TABLE IF NOT EXISTS clinica.dia (
    id_dia SERIAL PRIMARY KEY,                
    dia_semana VARCHAR(50) NOT NULL                  
);

CREATE TABLE IF NOT EXISTS clinica.horario (
    id_horario SERIAL PRIMARY KEY,         
    id_hora INT NOT NULL,                     
    id_dia INT NOT NULL,
	id_dentista INT NOT NULL,
	FOREIGN KEY (id_hora) REFERENCES clinica.hora (id_hora),
	FOREIGN KEY (id_dia) REFERENCES clinica.dia (id_dia),
	FOREIGN KEY (id_dentista) REFERENCES clinica.dentistas (id_dentista)
);

---------------------------------------------------------------------------------
--TABELA CONSULTAS
CREATE TABLE IF NOT EXISTS clinica.consultas(
    id_consulta SERIAL PRIMARY KEY NOT NULL,
    data_consulta DATE NOT NULL,
    descricao_consulta VARCHAR(200) DEFAULT NULL,
    prescricao VARCHAR(200) DEFAULT NULL,
    id_paciente INT NOT NULL,
    id_dentista INT NOT NULL,
    id_horario INT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES clinica.paciente(id_paciente),
    FOREIGN KEY (id_dentista) REFERENCES clinica.dentistas(id_dentista),
    FOREIGN KEY (id_horario) REFERENCES clinica.horario(id_horario)
);

---------------------------------------------------------------------------------
--TABELAS PROCEDIMENTOS E PROCEDIMENTOS REALIZADOS
CREATE TABLE IF NOT EXISTS clinica.procedimentos(
    id_procedimento SERIAL PRIMARY KEY,
    nome_procedimento VARCHAR(100) NOT NULL,
    descricao_procedimento VARCHAR(200),
    tempo_procedimento DOUBLE PRECISION NOT NULL
);

CREATE TABLE IF NOT EXISTS clinica.procedimentos_realizados(
    id_procedimentos_realizados SERIAL PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_procedimento INT NOT NULL,
	id_consulta INT NOT NULL,
    FOREIGN KEY(id_paciente) REFERENCES clinica.paciente(id_paciente),
    FOREIGN KEY(id_procedimento) REFERENCES clinica.procedimentos(id_procedimento),
	FOREIGN KEY(id_consulta) REFERENCES clinica.consultas(id_consulta)
);



---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--INSERIR DADOS

---------------------------------------------------------------------------------
--ENDERECO
INSERT INTO clinica.bairro (bairro)
VALUES
('Flamengo'),
('Botafogo'),
('Madureira'),
('Maracanã'),
('Méier'),
('Centro'),
('Caxambi'),
('Copacabana'),
('Barra da Tijuca'),
('Olaria');

INSERT INTO clinica.cidade (cidade, uf)
VALUES
('Rio de Janeiro', 'RJ'),
('São Paulo', 'SP'),
('Petrópolis', 'RJ'),
('Tersópolis', 'RJ'),
('Nova Friburgo', 'RJ');

INSERT INTO clinica.tipo_logradouro (tipo_logradouro)
VALUES
('Rua'),
('Avenida'),
('Travessa'),
('Praça'),
('Servidão'),
('Estrada');

INSERT INTO clinica.logradouro (logradouro_nome, id_tipo_logradouro)
VALUES
('A', 1),
('B', 2),
('C', 1),
('D', 4),
('E', 3),
('F', 1),
('G', 1),
('H', 5),
('I', 4),
('J', 1);

INSERT INTO clinica.cep (cep, id_logradouro, id_tipo_logradouro)
VALUES
('11111-111', 1, 1),
('22222-222', 2, 2),
('33333-333', 3, 1),
('44444-444', 4, 4),
('55555-555', 5, 3),
('66666-666', 6, 1),
('77777-777', 7, 1),
('88888-888', 8, 5),
('99999-999', 9, 4),
('00000-000', 10, 1);

INSERT INTO clinica.endereco 
(numero, 
complemento, 
id_cidade, 
id_bairro, 
id_cep, 
id_tipo_logradouro, 
id_logradouro)
VALUES
(100, 'Casa A', 1, 2, 2, 1, 1),
(200, 'Sobreloja', 1 ,3, 5, 2, 2),
(300, 'B', 1, 5, 3, 1, 3),
(400, null, 1, 4, 4, 4, 4),
(500, null, 1, 10, 3, 2, 5),
(600, null, 1, 1, 1, 2, 6),
(700, 'A', 1, 9, 1, 1, 7),
(800, null, 1, 7, 5, 1, 8),
(900, 'Sobreloja', 1, 6, 4, 1, 9),
(001, null, 1, 8, 1, 1, 10);

---------------------------------------------------------------------------------
--PACIENTES
INSERT INTO clinica.email (email)
VALUES
('jose@email.com'),
('leticia@email.com'),
('victor@email.com'),
('laryssa@email.com'),
('Beatriz@email.com'),
('carlos@email.com'),
('marcos@email.com'),
('fernanda@email.com'),
('ricardo@email.com'),
('patricia@email.com'),
('joazinhogmail.com');


INSERT INTO clinica.telefone (telefone)
VALUES
('(11) 9999-8888'),
('(11) 9888-7777'),
('(11) 9777-6666'),
('(11) 9666-5555'),
('(11) 9444-3333'),
('(11) 9555-4444'),
('(11) 9333-2222'),
('(11) 9222-1111'),
('(11) 9111-0000'),
('(11) 9000-9999'),
('(21) 9955-5577');

INSERT INTO clinica.paciente 
(nome_paciente, cpf, data_nascimento, id_endereco, historico_consultas, id_email, id_telefone) 
VALUES
('José Netto', '123.456.789-01', '1980-05-15', 9, null, 1, 2),
('Leticia Teles', '234.567.890-12', '1975-08-20', 1, null, 2, 4),
('Victor Campos', '345.678.901-23', '1990-03-10', 4, null, 3, 9),
('Laryssa Peixoto', '456.789.012-34', '1985-11-25', 5, null, 4, 3),
('Beatriz Pinheiro', '678.901.234-56', '1992-02-18', 8, null, 5, 1),
('Carlos Pereira', '567.890.123-45', '1978-07-30', 10, null, 6, 7),
('Marcos Souza', '789.012.345-67', '1983-09-05', 2, null, 7, 8),
('Fernanda Lima', '890.123.456-78', '1970-12-12', 6, null, 8, 10),
('Ricardo Rocha', '901.234.567-89', '1988-04-22', 3, null, 9, 6),
('Patrícia Nunes', '012.345.678-90', '1995-06-08', 7, null, 10, 5),
('Cleuzinha', '125523', '1987-08-17', 10, null, 11, 11);

---------------------------------------------------------------------------------
--DENTISTAS
INSERT INTO clinica.dentistas (nome, cpf, cro, especialidade) 
VALUES
('Dr. Roberto Alves', '111.222.333-44', 'CRO-SP 12345', 'Ortodontia'),
('Dra. Sandra Gomes', '222.333.444-55', 'CRO-SP 23456', 'Endodontia'),
('Dr. Marcelo Castro', '333.444.555-66', 'CRO-SP 34567', 'Periodontia'),
('Dra. Luciana Ferreira', '444.555.666-77', 'CRO-SP 45678', 'Implantodontia'),
('Dr. Eduardo Santos', '555.666.777-88', 'CRO-SP 56789', 'Ortodontia'),
('Dra. Camila Oliveira', '666.777.888-99', 'CRO-SP 67890', 'Dentística'),
('Dr. Fernando Lima', '777.888.999-00', 'CRO-SP 78901', 'Cirurgia'),
('Dra. Beatriz Rocha', '888.999.000-11', 'CRO-SP 89012', 'Endodontia'),
('Dr. Gustavo Nunes', '999.000.111-22', 'CRO-SP 90123', 'Periodontia'),
('Dra. Helena Costa', '000.121.222-33', 'CRO-SP 10234', 'Implantodontia');

---------------------------------------------------------------------------------
--HORARIOS
INSERT INTO clinica.hora (hora)
VALUES
('08:00-09:00'),
('09:00-09:00'),
('10:00-09:00'),
('11:00-09:00'),
('13:00-09:00'),
('14:00-09:00'),
('15:00-09:00'),
('06:00-09:00');

INSERT INTO clinica.dia (dia_semana)
VALUES
('domingo'),
('segunda-feira'),
('terça-feira'),
('quarta-feira'),
('quinta-feira'),
('sexta-feira'),
('sábado');

INSERT INTO clinica.horario (id_dentista, id_dia, id_hora)
VALUES
(1, 2, 3),
(1, 4, 3),
(2, 3, 5),
(3, 5, 7),
(3, 5, 8),
(3, 6, 5),
(4, 2, 4),
(5, 3, 5),
(5, 6, 2),
(6, 4, 1),
(7, 5, 3),
(8, 5, 4),
(9, 2, 7),
(9, 2, 8),
(10, 3, 7);

INSERT INTO clinica.procedimentos (nome_procedimento, descricao_procedimento, tempo_procedimento)
VALUES
('Consulta Inicial', 'Avaliação inicial do paciente', '0.5'),
('Limpeza Dental', 'Remoção de tártaro e polimento dos dentes', '0.75'),
('Restauração', 'Tratamento de cárie com resina composta', '0.4'),
('Canal', 'Tratamento endodôntico', '1.5'),
('Extração', 'Remoção de dente', '0.5'),
('Aparelho Ortodôntico', 'Colocação ou manutenção de aparelho', '0.5'),
('Clareamento', 'Clareamento dental a laser', '1'),
('Implante', 'Instalação de implante dentário', '2'),
('Raio-X Panorâmico', 'Exame radiográfico completo', '0.3'),
('Moldagem', 'Obtenção de moldes para prótese', '0.5');

---------------------------------------------------------------------------------
--CONSULTAS

INSERT INTO clinica.consultas 
(data_consulta, 
descricao_consulta, 
prescricao,
id_paciente,
id_dentista,
id_horario)
VALUES
('2021-08-17', NULL, NULL, 1, 1, 1),
('2025-01-10', NULL, NULL, 3, 3, 5),
('2024-02-11', NULL, NULL, 6, 2, 3),
('2020-11-01', NULL, NULL, 5, 7, 11),
('2019-08-12', NULL, NULL, 10, 6, 10),
('2024-11-28', NULL, NULL, 8, 10, 15),
('2024-09-29', NULL, NULL, 6, 9, 13),
('2023-07-08', NULL, NULL, 7, 3, 4),
('2022-05-05', '', '', 9, 1, 2),
('2021-06-30', '', '', 1, 3, 5);

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--REQUISITOS NÃO FUNCIONAIS

---------------------------------------------------------------------------------
--DOIS INDICES COERENTES (NA COLUNA CPF E NAS COLUNAS DATA_CONSULTA / ID_DENTISTA)
CREATE INDEX idx_paciente_cpf ON clinica.paciente (cpf);
CREATE INDEX idx_consultas_data_dentista ON clinica.consultas (data_consulta, id_dentista);


---------------------------------------------------------------------------------
--3 ATUALIZAÇÕES DE REGISTROS COM CONDIÇÕES
UPDATE clinica.telefone
SET telefone = '99999-1234'
WHERE id_paciente = 5;

UPDATE clinica.endereco
SET id_cep = 10, numero = 500, complemento = 'apto 101'
WHERE id_endereco = (SELECT id_endereco from clinica.paciente where id_paciente = 2);

UPDATE clinica.procedimentos
SET nome_procedimento = 'Nova Limpeza Dental'
WHERE id_procedimento = 3;


---------------------------------------------------------------------------------
--3 DELETES DE REGISTROS COM CONDIÇÕES

DELETE FROM clinica.email
WHERE email NOT LIKE '%@%';

DELETE FROM clinica.consultas 
WHERE data_consulta < NOW() - INTERVAL '2 years';

DELETE FROM clinica.paciente
WHERE LENGTH(cpf) < 11;


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--5 CONSULTAS CONTEXTUALIZADAS

---------------------------------------------------------------------------------
--1

SELECT d.especialidade, COUNT(c.id_consulta) AS consultas
FROM clinica.dentistas d
LEFT JOIN clinica.consultas c ON d.id_dentista = c.id_dentista
GROUP BY d.especialidade
ORDER BY consultas DESC;

---------------------------------------------------------------------------------
--2

SELECT d.nome, COUNT(c.id_consulta) AS total_consultas
FROM clinica.dentistas d
LEFT JOIN clinica.consultas c ON d.id_dentista = c.id_dentista
GROUP BY d.nome
ORDER BY total_consultas DESC;

---------------------------------------------------------------------------------
--3

SELECT p.nome_paciente, COUNT(c.id_consulta) AS total_consultas
FROM clinica.paciente p
LEFT JOIN clinica.consultas c ON p.id_paciente = c.id_paciente
GROUP BY p.nome_paciente
ORDER BY total_consultas DESC;

---------------------------------------------------------------------------------
--4



---------------------------------------------------------------------------------
--5