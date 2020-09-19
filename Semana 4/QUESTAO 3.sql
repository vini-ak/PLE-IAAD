use empresa_vinicius_vieira;

SELECT 
	FUNCIONARIO.Pnome, FUNCIONARIO.Unome
FROM
	FUNCIONARIO JOIN TRABALHA_EM ON FUNCIONARIO.Cpf=TRABALHA_EM.Fcpf
	JOIN PROJETO ON TRABALHA_EM.Pnr=PROJETO.Projnumero
WHERE
	DEPARTAMENTO.Dnumero=4 AND
	TRABALHA_EM.Horas>15.0 AND
	PROJETO.Projnome='Informatização';


-- b --
SELECT
	FUNCIONARIO.Pnome, FUNCIONARIO.Unome
FROM 
	FUNCIONARIO JOIN DEPENDENTE ON FUNCIONARIO.Cpf=DEPENDENTE.Fcpf
WHERE 
	FUNCIONARIO.Sexo=DEPENDENTE.Sexo;

-- c --
SELECT
	Cpf
FROM
	FUNCIONARIO 
WHERE
	Pnome="Jennifer" AND Unome="Souza";  -- retorna o cpf de nº '98765432168'

SELECT
	*
FROM 
	FUNCIONARIO
WHERE
	Cpf_supervisor='98765432168';


-- d --
UPDATE 
	DEPARTAMENTO
SET
	Cpf_gerente='12345678966', Data_inicio_gerente='2020-09-07'
WHERE
	Dnumero=5;


-- e --
UPDATE
	TRABALHA_EM
SET
	Horas=5.0
WHERE
	Fcpf='99988777767' AND Pnr=10;

-- f --
UPDATE
	FUNCIONARIO JOIN DEPARTAMENTO ON FUNCIONARIO.Dnr=DEPARTAMENTO.Dnumero
SET
	FUNCIONARIO.Salario=FUNCIONARIO.Salario*0.9
WHERE
	DEPARTAMENTO.Dnome='Administração';


-- g --
DELETE FROM 
	DEPARTAMENTO 
WHERE 
	Dnome='Matriz';

-- Essa query infrige a integridade referencial, pois há células de outras tabelas que se referenciam a este departamento.


-- h --
