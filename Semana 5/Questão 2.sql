BEGIN;

-- a --
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



-- 	b 	--

-- I --

--			CLAUSULA WHERE				--
SELECT nome_programador, nome_startup
FROM Programador as p, Startup as s 
WHERE p.id_startup = s.id_startup;


--			INNER JOIN					--
SELECT p.nome_programador, s.nome_startup
FROM Programador as p JOIN Startup as s 
USING (id_startup);


--			junção natural				--
SELECT nome_programador, nome_startup
FROM Programador NATURAL JOIN Startup;



--	II 	--
SELECT nome_programador, linguagem
FROM Programador 
	RIGHT JOIN Programador_Linguagem USING(id_programador)
	NATURAL JOIN Linguagem_Programacao;



--	III  --
SELECT nome_programador, linguagem
FROM Programador 
	LEFT JOIN Programador_Linguagem USING(id_programador)
	LEFT JOIN Linguagem_Programacao USING(id_linguagem);


-- IV --
SELECT nome_programador
FROM Programador 
WHERE id_programador NOT IN (
	SELECT id_programador
	FROM Programador_Linguagem
);


-- V --
SELECT nome_startup, nome_programador
FROM Startup LEFT JOIN Programador USING(id_startup);


-- VI --
SELECT nome_startup
FROM Startup as s
WHERE not exists (
		SELECT nome_programador
		FROM Programador as p
		WHERE p.id_startup = s.id_startup
	  );



-- 	c 	--
-- 		full outer join 	--
SELECT id_startup, nome_programador, id_linguagem
FROM Programador as p LEFT JOIN Programador_Linguagem as pl
USING(id_programador)
UNION ALL
SELECT id_startup, nome_programador, id_linguagem
FROM Programador as p RIGHT JOIN Programador_Linguagem as pl
USING(id_programador)
WHERE p.id_programador IS NULL;

-- Este relatório mostra o id da startup na qual o funcionário trabalha, o nome do funcionário e o id da linguagem que ele programa. Nos campos onde aparece null, é porque ele não programa em uma das linguagens cadastradas no sistema.