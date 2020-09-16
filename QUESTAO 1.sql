-- CRIANDO O BANCO --
create schema biblioteca_vinicius_vieira;
use biblioteca_vinicius_vieira;

-- CRIANDO AS TABELAS --
create table LIVRO (
	Cod_livro CHAR(5) not null,
	Titulo VARCHAR(40) not null,
	Nome_editora VARCHAR(15) not null,
	PRIMARY KEY(Cod_livro)
);

create table LIVRO_AUTOR(
	Cod_livro CHAR(5) not null,
	Nome_autor VARCHAR(40),
	PRIMARY KEY(Cod_livro, Nome_autor)
);

create table EDITORA(
	Nome_editora VARCHAR(15) not null,
	Endereco VARCHAR(100) not null,
	Telefone CHAR(10),
	PRIMARY KEY(Nome_editora)
);

create table LIVRO_COPIAS(
	Cod_livro CHAR(5) not null,
	Cod_unidade CHAR(3) not null,
	Qt_copia INT not null DEFAULT 0,
	PRIMARY KEY(Cod_livro, Cod_unidade)
);

create table LIVRO_EMPRESTIMO(
	Cod_livro CHAR(5) not null,
	Cod_unidade CHAR(3) not null,
	Nmr_cartao CHAR(11) not null,
	Data_emprestimo DATE NOT NULL,
	Data_devolucao DATE not null,
	PRIMARY KEY(Cod_livro, Cod_unidade, Nmr_cartao)
);

create table UNIDADE_BIBLIOTECA(
	Cod_unidade CHAR(3) not null,
	Nome_unidade VARCHAR(20) not null,
	Endereco VARCHAR(80) not null,
	PRIMARY KEY(Cod_unidade)
);

create table USUARIO(
	Nmr_cartao CHAR(11) not null,
	Nome VARCHAR(60) not null,
	Endereco VARCHAR(80) not null,
	Telefone VARCHAR(11) not null,
    PRIMARY KEY(Nmr_cartao)
);

alter table LIVRO add foreign key(Nome_editora) references EDITORA(Nome_editora);
alter table LIVRO_AUTOR add foreign key(Cod_livro) references LIVRO(Cod_livro);
alter table LIVRO_COPIAS add foreign key(Cod_livro) references LIVRO(Cod_livro);
alter table LIVRO_COPIAS add foreign key(Cod_unidade) references UNIDADE_BIBLIOTECA(Cod_unidade);
alter table LIVRO_EMPRESTIMO add foreign key(Cod_livro) references LIVRO(Cod_livro);
alter table LIVRO_EMPRESTIMO add foreign key(Cod_unidade) references UNIDADE_BIBLIOTECA(Cod_unidade);
alter table LIVRO_EMPRESTIMO add foreign key(Nmr_cartao) references USUARIO(Nmr_cartao);


-- populando as tabelas --
insert into EDITORA values
	('Saraiva', 'Rua Miguel Arcanjo, 897, São Paulo - SP', '1127569393'),
    ('Pearson', 'Fitfy Street Avenue, 1239, Anchorage - AK', '1203456987'),
	('Globo', 'Av Conde da Boa Vista, 1343, Recife - PE', '8134520909');

insert into USUARIO values
	('01234567890', 'Vinícius Vieira', 'Rua Cinquenta e Quatro, 9, São Francisco, Cabo - PE', '81985288103'),
	('96325874101', 'Roberta Gouveia', 'Rua do Sol, 132, Boa Vista, Recife - PE', '81985639897');

insert into LIVRO values
	('09xe3', 'Cinco minutos', 'Saraiva'),
	('er342', 'Dom Casmurro', 'Globo'),
	('1wks2', 'A Moreninha', 'Pearson');

insert into UNIDADE_BIBLIOTECA values
	('ae3', 'Biblioteca Setorial', 'Prox ao CEGOE'),
	('fa4', 'Biblioteca Centrao', 'Prox à Reitoria');

insert into LIVRO_AUTOR values
	('09xe3', 'José de Alencar'),
	('er342', 'Machado de Assis'),
	('1wks2', 'Joaquim Manuel de Macedo');

insert into LIVRO_COPIAS values
	('er342', 'ae3', 2),
	('09xe3', 'ae3', 4),
	('1wks2', 'ae3', 1),
	('er342', 'fa4', 5),
	('09xe3', 'fa4', 0),
	('1wks2', 'fa4', 3);

insert into LIVRO_EMPRESTIMO values
	('1wks2', 'fa4', '01234567890', '2020-09-16', '2020-09-30'),
	('09xe3', 'ae3', '96325874101', '2020-09-16', '2020-09-30'),
	('er342', 'fa4', '01234567890', '2020-09-16', '2020-09-30');
