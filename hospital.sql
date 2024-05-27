CREATE DATABASE IF NOT EXISTS hospital;

USE hospital;

CREATE TABLE IF NOT EXISTS medicos (
	id_medicos int NOT NULL UNIQUE AUTO_INCREMENT,
    crm int NOT NULL UNIQUE,
    cpf int NOT NULL UNIQUE,
    nome varchar(255) NOT NULL,
    data_nascimento date,
    sexo enum('masculino', 'feminino', 'outros') NOT NULL,
	naturalidade varchar(100) default 'Brasil',
    telefone int NOT NULL,
    telefone_reserva int,
    email varchar(255) NOT NULL,
    especialidade varchar(255) NOT NULL,
    PRIMARY KEY (id_medicos)
);

CREATE TABLE IF NOT EXISTS pacientes (
	id_pacientes int NOT NULL UNIQUE AUTO_INCREMENT,
    cpf int NOT NULL UNIQUE,
    nome varchar(255) NOT NULL,
    data_nascimento date NOT NULL,
    endereco varchar(255) NOT NULL,
    telefone int NOT NULL,
    email varchar(255),
    convenio varchar(255),
    PRIMARY KEY(id_pacientes)
);

CREATE TABLE IF NOT EXISTS consultas (
	id_consultas int NOT NULL UNIQUE AUTO_INCREMENT,
    data_hora datetime NOT NULL,
    responsavel varchar(255) NOT NULL,
    especialidade varchar(255) NOT NULL,
    paciente varchar(255) NOT NULL,
    convenio varchar(255),
    PRIMARY KEY (id_consultas),
    id_medicos int NOT NULL UNIQUE,
    id_pacientes int NOT NULL UNIQUE,
    FOREIGN KEY (id_medicos) REFERENCES medicos(id_medicos),
    FOREIGN KEY (id_pacientes) REFERENCES pacientes(id_pacientes)
);

CREATE TABLE IF NOT EXISTS receitas (
	id_receitas int NOT NULL UNIQUE AUTO_INCREMENT,
    medicamentos varchar(255),
    quantidade int,
    instrucoes varchar(255),
    PRIMARY KEY (id_receitas),
    id_consultas int NOT NULL UNIQUE,
    FOREIGN KEY (id_consultas) REFERENCES consultas(id_consultas)
);

CREATE TABLE IF NOT EXISTS internacao (
	id_internacao int NOT NULL UNIQUE AUTO_INCREMENT,
    data_entrada datetime NOT NULL,
    data_prev_alta datetime NOT NULL,
    data_alta datetime NOT NULL,
    procedimento varchar(255),
    PRIMARY KEY (id_internacao)
);

CREATE TABLE IF NOT EXISTS enfermeiro (
	id_enfermeiro int NOT NULL UNIQUE AUTO_INCREMENT,
    nome varchar(255) NOT NULL,
    cpf int NOT NULL UNIQUE,
    cre int NOT NULL UNIQUE,
    PRIMARY KEY (id_enfermeiro),
    id_internacao int NOT NULL UNIQUE,
    FOREIGN KEY (id_internacao) REFERENCES internacao(id_internacao)
);

CREATE TABLE IF NOT EXISTS quarto (
	id_quartos int NOT NULL UNIQUE AUTO_INCREMENT,
    numero int NOT NULL UNIQUE,
    tipo varchar (255) NOT NULL,
    PRIMARY KEY (id_quartos),
    id_internacao int NOT NULL UNIQUE,
    FOREIGN KEY (id_internacao) REFERENCES internacao(id_internacao)
);

CREATE TABLE IF NOT EXISTS tipos_quarto (
	id_tipo_quarto int NOT NULL UNIQUE AUTO_INCREMENT,
    descricao varchar(255) NOT NULL,
    valor_diaria varchar(255) NOT NULL,
    PRIMARY KEY (id_tipo_quarto),
    id_quarto int NOT NULL UNIQUE,
    FOREIGN KEY (id_quarto) REFERENCES quarto(id_quartos)
);