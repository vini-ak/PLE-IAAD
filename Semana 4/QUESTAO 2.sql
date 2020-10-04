CREATE SCHEMA compras;
USE compras;

CREATE TABLE Cliente(
	CodCli INT NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	Email VARCHAR(40) NOT NULL,
	Telefone VARCHAR(11),
	PRIMARY KEY(CodCli)
);

CREATE TABLE Produto(
	CodProd INT NOT NULL,
	Descricao VARCHAR(100),
	PRIMARY KEY(CodProd)
);

CREATE TABLE Pedido(
	NumPedido INT NOT NULL,
	CodCli INT NOT NULL,
	Data DATE,
	PRIMARY KEY(NumPedido)
);

CREATE TABLE ItemPedido(
	NumPedido INT NOT NULL,
	NumItem INT NOT NULL,
	CodProd INT NOT NULL,
	Quantidade INT NOT NULL,
	PrecoUnitario FLOAT(7,2) NOT NULL,
	PRIMARY KEY(NumPedido, NumItem)
);


-- POPULANDO AS TABELAS --
INSERT INTO Cliente VALUES 
	(01, 'Vinícius Vieira', 'vinicius.vdes@gmail.com', '81985288103'),
	(02, 'Roberta Gouveia', 'roberta@ufrp.com', '81998745612'),
	(03, 'Manuela Goes', 'manu.goes@hotmail.com', '81981818181');

INSERT INTO Produto VALUES
	(01, 'Arroz'),
	(02, 'Feijão'),
	(03, 'Biscoito'),
	(04, 'Café'),
	(05, 'Açúcar');

INSERT INTO Pedido VALUES 
	(01, 01, '2020-09-12'),
	(02, 01, '2020-09-13'),
	(03, 02, '2020-09-20');

INSERT INTO ItemPedido VALUES
	(01,01,04,1, 3.00),
    (02,02,05,2, 2.00),
    (03,03,01,2, 9.00),
    (02,02,05,2, 4.00);


-- ADICIONANDO AS CHAVES ESTRANGEIRAS --

ALTER TABLE Pedido ADD FOREIGN KEY(CodCli) REFERENCES Cliente(CodCli);
ALTER TABLE ItemPedido ADD FOREIGN KEY(NumPedido) REFERENCES Pedido(NumPedido);
ALTER TABLE ItemPedido ADD FOREIGN KEY(CodProd) REFERENCES Produto(CodProd);


-- CRIANDO TRIGGER PARA REMOÇÃO
DELIMITER $
CREATE TRIGGER DELETE_PEDIDOS BEFORE DELETE
ON Pedido
FOR EACH ROW
BEGIN
	DELETE FROM ItemPedido WHERE NumPedido = old.NumPedido;
END$
DELIMITER ;

-- ATIVAND A TRIGGER
delete from pedido where numpedido = 1;

select * from produto;
select * from itempedido;



drop trigger atualizando_codprod;

DELIMITER $
CREATE TRIGGER atualizando_codprod BEFORE UPDATE
ON produto
FOR EACH ROW
BEGIN
	UPDATE itempedido
    set CodProd = new.CodProd
    where new.CodProd = Codprod;
END$
DELIMITER ;

update produto set CodProd = 50 where CodProd = 1;

select * from produto;
select * from itempedido;