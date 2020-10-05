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

-- CREATE VIEW Resumo_Departamento (Num_dept, Num_func, Total_sal, Media_sal)
-- AS SELECT Dnr, COUNT(*), SUM(Salario), AVG(Salario)
-- FROM FUNCIONARIO
-- GROUP BY Dnr;



-- 			PRIMEIRA INSTRUÇÃO:		--

-- SELECT * FROM Resumo_Departamento;

-- Equivale a: --
SELECT Dnr, COUNT(*), SUM(Salario), AVG(Salario) 
FROM FUNCIONARIO 
GROUP BY(Dnr);


-- 			SEGUNDA INSTRUÇÃO:  		--

--SELECT Num_dept, Num_func
--FROM Resumo_Departamento
--WHERE Total_sal > 100000;

-- Equivale a: --
SELECT Dnr, COUNT(*)
FROM FUNCIONARIO
GROUP BY(Dnr)
HAVING SUM(Salario) > 100000;


-- 			TERCEIRA INSTRUÇÃO 			--

-- SELECT Num_dept, Media_sal
-- FROM Resumo_Departamento
-- WHERE Num_func > ( SELECT Num_func 
-- 					  FROM Resumo_Departamento
-- 					  WHERE Num_dept=4);


-- Equivale a:
SELECT Dnr, AVG(Salario)
FROM FUNCIONARIO
GROUP BY(Dnr)
HAVING COUNT(*) > (
					SELECT COUNT(*)
					FROM FUNCIONARIO
					WHERE Dnr = 4
					);


-- k --
-- As Views, como o próprio nome sugere, são limitadas a fazer operações de consulta. Por não ser persistida no banco de dados, não seria possível fazer alteração nos seus dados. 


-- L --


-- M --

-- Remover todas as referências de um funcionário do sistema depois que ele for deletado da tabela FUNCIONARIO.
-- A ideia da trigger abaixo é deletar as rows de outras tabelas onde o Cpf de um funcionario é uma chave primária
-- e atualizar nas referências onde o Cpf é uma chave estrangeira.  

-- Contudo a trigger dará um erro por conta do UPDATE em FUNCIONARIO, uma vez que a tabela estaria se auto referenciando
-- Busquei formas de resolver esse problema, mas infelizmente não consegui :/
DELIMITER $
CREATE TRIGGER REMOVER_FUNCIONARIO BEFORE DELETE 
ON FUNCIONARIO
FOR EACH ROW
BEGIN 
	DELETE FROM DEPENDENTE WHERE FCpf = OLD.Cpf ;
	DELETE FROM TRABALHA_EM WHERE FCpf = OLD.Cpf;
    UPDATE DEPARTAMENTO SET Cpf_gerente = NULL WHERE Cpf_gerente = OLD.Cpf;
    UPDATE FUNCIONARIO AS S SET S.Cpf_supervisor = null WHERE Cpf_supervisor = OLD.Cpf ;
END$ 
DELIMITER ;

SELECT * FROM DEPENDENTE WHERE FCpf = '88866555576';
SELECT * FROM TRABALHA_EM WHERE FCpf = '88866555576';

DELETE FROM FUNCIONARIO WHERE Cpf = '88866555576';

SELECT * FROM DEPENDENTE WHERE FCpf = '88866555576';
SELECT * FROM TRABALHA_EM WHERE FCpf = '88866555576';
