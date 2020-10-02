use empresa_vinicius_vieira;

-- É importante lembrar que estou usando o banco que criei para a atividade da semana 3 --


ALTER TABLE DEPARTAMENTO MODIFY COLUMN Dnome VARCHAR(30);
INSERT INTO DEPARTAMENTO VALUES
	('Recursos_Humanos', 02, '88866555576', '2020-10-01'),		-- Fernando --
	('Tecnologia_Informacao', 03, '33344555587', '2020-10-01');   -- Ronaldo --


-- QUERIES DE CONSULTA --
SELECT Dnome
FROM 
	DEPARTAMENTO
WHERE 
	Dnumero NOT IN (SELECT Dnr
FROM 
	FUNCIONARIO);	-- V, retorna Recursos_Humanos e Tecnologia_Informacao


SELECT 
	Dnome
FROM 
	DEPARTAMENTO, FUNCIONARIO
WHERE 
	Dnumero = Dnr AND Cpf IS NULL;  -- F. Essa query busca os departamentos que tenham funcionarios com CPF nulo


SELECT 
	Dnome 
FROM 
	DEPARTAMENTO D
WHERE 
	NOT EXISTS (
		SELECT *
		FROM FUNCIONARIO F
		WHERE F.Dnr = D.Dnumero
	);	-- V, a condição aninhada primeiro faz o join das tabelas por meio do numero do departamento e seleciona aqueles departamentos que não possuem empregados


SELECT Dnome
FROM DEPARTAMENTO LEFT JOIN FUNCIONARIO ON Dnumero = Dnr
WHERE Dnr IS NULL; -- Faz o left join das tabelas e seleciona as rows que tiverem o dnr do funcionario nulo


SELECT Dnome
FROM DEPARTAMENTO, FUNCIONARIO
WHERE Dnumero != Dnr; -- Acaba selecionando o nome do departamento de cada funcionario. Logo, não inclui Tecnologia_Informacao ou Recursos_Humanos
