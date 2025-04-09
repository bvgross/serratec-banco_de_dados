--CREATE DATABASE ProjetoFinal;
CREATE SCHEMA clinica;

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

-------------------------------------------------------

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

-------------------------------------------------------

CREATE TABLE IF NOT EXISTS clinica.dentistas (
    id_dentista SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    cro VARCHAR(20) UNIQUE NOT NULL,
    especialidade VARCHAR(50) NOT NULL
);

-------------------------------------------------------

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
    FOREIGN KEY(id_paciente) REFERENCES clinica.paciente(id_paciente),
    FOREIGN KEY(id_procedimento) REFERENCES clinica.procedimentos(id_procedimento)
);

-------------------------------------------------------

CREATE TABLE IF NOT EXISTS clinica.hora (
    id_hora SERIAL PRIMARY KEY,            
    hora VARCHAR(11) NOT NULL   --"10:00-11:00" 
);

CREATE TABLE IF NOT EXISTS clinica.dia (
    id_dia SERIAL PRIMARY KEY,                
    dia_semana VARCHAR(50) NOT NULL                  
);

CREATE TABLE IF NOT EXISTS clinica.horario (
    id_horario SERIAL PRIMARY KEY,         
    id_hora INT NOT NULL,                     
    id_dia INT NOT NULL,                     
	FOREIGN KEY (id_hora) REFERENCES clinica.hora (id_hora),
	FOREIGN KEY (id_dia) REFERENCES clinica.dia (id_dia)
);

-------------------------------------------------------

CREATE TABLE IF NOT EXISTS clinica.consultas(
    id_consulta SERIAL PRIMARY KEY NOT NULL,
    data_consulta DATE NOT NULL,
    descricao_consulta VARCHAR(200) DEFAULT NULL,
    prescricao VARCHAR(200) DEFAULT NULL,
    id_paciente INT NOT NULL,
    id_dentista INT NOT NULL,
    id_horario INT NOT NULL,
    id_procedimentos_realizados INT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES clinica.paciente(id_paciente),
    FOREIGN KEY (id_dentista) REFERENCES clinica.dentistas(id_dentista),
    FOREIGN KEY (id_horario) REFERENCES clinica.horario(id_horario),
    FOREIGN KEY (id_procedimentos_realizados) REFERENCES clinica.procedimentos_realizados(id_procedimentos_realizados)
)