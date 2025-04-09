CREATE TABLE IF NOT EXISTS vendas.clientes (
	idcliente SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	cpf varchar(11) NOT NULL UNIQUE,
	nascimento DATE NOT NULL,
	sexo char(1)	
);

CREATE TABLE IF NOT EXISTS vendas.emails (
	PRIMARY KEY (email, idcliente),
	email VARCHAR(100) NOT NULL UNIQUE,
	principal bool NOT NULL,
	idcliente int references vendas.clientes(idcliente)
);

CREATE TABLE IF NOT EXISTS vendas.pedidos (
	idpedido SERIAL PRIMARY KEY,
	dataemissao TIMESTAMP WITHOUT TIME ZONE NOT NULL,
	dataentrega TIMESTAMP WITHOUT TIME ZONE NOT NULL,
	idcliente int references vendas.clientes(idcliente),
	idformas int references vendas.formaspgto(idformas)
);

CREATE TABLE IF NOT EXISTS vendas.formaspgto (
	idformas SERIAL PRIMARY KEY,
	descricao VARCHAR(60) NOT NULL,
	nrparcelas INT DEFAULT 1
);

CREATE TABLE IF NOT EXISTS vendas.produtos (
	codigo SERIAL PRIMARY KEY,
	descricao VARCHAR(100) NOT NULL,
	custo DOUBLE PRECISION NOT NULL,
	preco DOUBLE PRECISION NOT NULL
);

CREATE TABLE IF NOT EXISTS vendas.itenspedido (
	iditens SERIAL PRIMARY KEY,
	valorunit INT NOT NULL,
	desconto INT,
	quantidade INT NOT NULL,
	idpedido int references vendas.pedidos(idpedido),
	idproduto int references vendas.produtos(codigo)
);

CREATE TABLE IF NOT EXISTS vendas.telefones (
	PRIMARY KEY(telefone, idcliente),
	telefone VARCHAR(15) NOT NULL,
	tipo CHAR(1),
	contato VARCHAR(100),
	idcliente int references vendas.clientes(idcliente)
);

CREATE TABLE IF NOT EXISTS vendas.enderecocliente (
	cep INT PRIMARY KEY,
	numero INT NOT NULL,
	idcliente int references vendas.clientes(idcliente),
	idendereco int references vendas.endereco(idendereco),
	idbairro int references vendas.bairros(idbairro),
	idcidade int references vendas.cidades(idcidade)
);

CREATE TABLE IF NOT EXISTS vendas.endereco (
	idendereco SERIAL PRIMARY KEY,
	idtiposlogradouro int references vendas.tiposlogradouro(idtiposlogradouro),
	logradouro VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS vendas.tiposendereco (
	idtiposendereco SERIAL PRIMARY KEY,
	logradouro VARCHAR(100) NOT NULL,
	idtiposlogradouro int references vendas.tiposlogradouro(idtiposlogradouro)
);

CREATE TABLE IF NOT EXISTS vendas.tiposlogradouro (
	idtiposlogradouro SERIAL PRIMARY KEY,
	descricao VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS vendas.cidades (
	idcidade SERIAL PRIMARY KEY,
	descricao VARCHAR(100) NOT NULL,
	uf VARCHAR(2) NOT NULL
);

CREATE TABLE IF NOT EXISTS vendas.bairros (
	idbairro SERIAL PRIMARY KEY,
	descricao VARCHAR(100) NOT NULL
);