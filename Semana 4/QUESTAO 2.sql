CREATE SCHEMA compras;
USE compras;

CREATE TABLE Cliente(
	CodCli,
	Nome,
	Email,
	Telefone,
	PRIMARY KEY(CodCli)
);

CREATE TABLE Produto(
	CodProd,
	Descricao,
	PRIMARY KEY(CodProd)
);

CREATE TABLE Pedido(
	NumPedido,
	CodCli,
	Data,
	PRIMARY KEY(NumPedido)
);

CREATE TABLE ItemPedido(
	NumPedido,
	NumItem,
	CodProd,
	Quantidade,
	PrecoUnitario,
	PRIMARY KEY(NumPedido, NumItem)
);

ALTER TABLE Pedido ADD FOREIGN KEY(CodCli) REFERENCES Cliente(CodCli);
ALTER TABLE ItemPedido ADD FOREIGN KEY(NumPedido) REFERENCES Pedido(NumPedido);
ALTER TABLE ItemPedido ADD FOREIGN KEY(CodProd) REFERENCES Produto(CodProd);