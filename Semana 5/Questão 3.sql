BEGIN;
USE empresa_vinicius_vieira;

-- a --
SELECT Dnome, COUNT(*)
FROM DEPARTAMENTO AS D JOIN FUNCIONARIO AS F ON D.Dnumero = F.Dnr
GROUP BY (D.Dnome)
HAVING AVG(F.Salario) > 30000.00;

-- b --
SELECT Dnome, COUNT(*)
FROM DEPARTAMENTO AS D JOIN FUNCIONARIO AS F ON D.Dnumero = F.Dnr
WHERE F.Sexo = 'M' AND F.Salario > 30000
GROUP BY (D.Dnome);

-- c --
SELECT Pnome, Dnr
FROM FUNCIONARIO
WHERE Dnr =  (
		SELECT Dnr
		FROM FUNCIONARIO
		WHERE Salario = (
						SELECT Max(Salario) 
						FROM FUNCIONARIO
						)
		);

-- d --
SELECT Pnome
FROM FUNCIONARIO
WHERE Cpf_supervisor = (
						SELECT Cpf 
						FROM FUNCIONARIO
						WHERE Cpf = '88866555576'
						);


-- e --
SELECT Pnome
FROM FUNCIONARIO
WHERE Salario > 10000 + (SELECT MIN(Salario) FROM FUNCIONARIO);

-- f --
CREATE VIEW GERENTE(Nome_departamento, Nome_gerente, Salario_gerente)
AS SELECT DEPARTAMENTO.Dnome, FUNCIONARIO.Pnome, FUNCIONARIO.Salario
   FROM DEPARTAMENTO INNER JOIN FUNCIONARIO 
   ON FUNCIONARIO.Cpf = DEPARTAMENTO.Cpf_gerente;

-- g --
CREATE VIEW PESQUISA(Nome_funcionario, Nome_supervisor, Salario)
AS SELECT F.Pnome, S.Pnome, F.Salario
   FROM FUNCIONARIO AS F JOIN FUNCIONARIO AS S
   ON F.Cpf_supervisor = S.Cpf
   JOIN DEPARTAMENTO AS D
   ON F.Dnr = D.Dnumero
   WHERE D.Dnome = 'Pesquisa';

-- h --
CREATE VIEW PROJETO_VIEW(Nome_projeto, Nome_departamento, Qnt_funcionarios, Total_horas)
AS SELECT P.Projnome, D.Dnome, COUNT(T.Pnr), SUM(T.Horas)
   FROM PROJETO AS P JOIN DEPARTAMENTO AS D
   ON D.Dnumero = P.Dnum
   JOIN TRABALHA_EM AS T
   ON P.Projnumero = T.Pnr
   GROUP BY(P.Projnumero);

-- i --
CREATE VIEW PROJETO_VIEW_HORAS(Nome_projeto, Nome_departamento, Qnt_funcionarios, Total_horas)
AS SELECT P.Projnome, D.Dnome, COUNT(T.Pnr), SUM(T.Horas)
   FROM PROJETO AS P JOIN DEPARTAMENTO AS D
   ON D.Dnumero = P.Dnum
   JOIN TRABALHA_EM AS T
   ON P.Projnumero = T.Pnr
   WHERE ( SELECT COUNT(Pnr) FROM TRABALHA_EM ) > 1
   GROUP BY(P.Projnumero);

-- j --
