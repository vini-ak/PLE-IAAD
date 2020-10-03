BEGIN;

-- CRIANDO BANCO --
create schema if not exists BD_Startup;
use BD_Startup;

-- CRIANDO TABELAS --
CREATE TABLE Startup (
	id_startup int not null auto_increment,
	nome_startup varchar(20) not null,
	PRIMARY KEY(id_startup)
);

CREATE TABLE Linguagem_Programacao (
	id_linguagem int not null auto_increment,
	linguagem varchar(15) not null,
	PRIMARY KEY(id_linguagem)
);

CREATE TABLE Programador(
	id_programador int not null auto_increment,
	id_startup int not null,
	nome_programador varchar(50) not null,
	PRIMARY KEY(id_programador)
);

CREATE TABLE Programador_Linguagem (
	id_programador int not null,
	id_linguagem int not null,
	PRIMARY KEY(id_programador, id_linguagem)
);

-- POPULANDO TABELAS

INSERT INTO Startup (nome_startup) VALUES
	('Startup 1'),
	('Startup 2'),
	('Startup 3'),
	('Startup 4'),
	('Startup 5'),
	('Startup 6');

INSERT INTO Linguagem_Programacao (linguagem) VALUES
	('Python'),
	('PHP'),
	('Java'),
	('Swift'),
	('C#'),
	('Javascript');

INSERT INTO Programador (id_startup, nome_programador) VALUES
	(1, 'João'),
	(2, 'Paula'),
	(3, 'Renata'),
	(4, 'Felipe'),
	(4, 'Ana'),
	(1, 'Alexandre');

INSERT INTO Programador_Linguagem (id_programador, id_linguagem) VALUES
	(1, 1),
	(1, 2),
	(2, 3),
	(3, 4),
	(3, 5),
	(4, 5);

-- APLICANDO CHAVES ESTRANGEIRAS ÀS TABELAS
ALTER TABLE Programador ADD FOREIGN KEY(id_startup) REFERENCES Startup(id_startup);
ALTER TABLE Programador_Linguagem ADD FOREIGN KEY(id_programador) REFERENCES Programador(id_programador);
ALTER TABLE Programador_Linguagem ADD FOREIGN KEY(id_linguagem) REFERENCES Linguagem_Programacao(id_linguagem);
COMMIT;