CREATE TABLE clinica.procedimentos(
	id_procedimento SERIAL PRIMARY KEY,
	nome_procedimento VARCHAR(100) NOT NULL,
	descricao_procedimento VARCHAR(200),
	tempo_procedimento DOUBLE PRECISION NOT NULL
);

CREATE TABLE procedimentos_realizados(
	id_procedimentos_realizados SERIAL PRIMARY KEY,
	--id_pacientes INT NOT NULL,
	id_procedimento INT NOT NULL,
	--FOREIGN KEY(id_pacientes) REFERENCES clinica.pacientes(id_pacientes),
	FOREIGN KEY(id_procedimento) REFERENCES clinica.procedimentos(id_procedimento)
);