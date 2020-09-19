use empresa_vinicius_vieira;

SELECT 
	FUNCIONARIO.Pnome 
FROM
	FUNCIONARIO JOIN TRABALHA_EM ON FUNCIONARIO.Cpf=TRABALHA_EM.Fcpf
	JOIN PROJETO ON TRABALHA_EM.Pnr=PROJETO.Projnumero
WHERE
	DEPARTAMENTO.Dnumero=4 AND
	TRABALHA_EM.Horas>15.0 AND
	PROJETO.Projnome='Informatização';


-- b --
SELECT
	FUNCIONARIO.Pnome
FROM 
	FUNCIONARIO JOIN DEPENDENTE ON FUNCIONARIO.Cpf=DEPENDENTE.Fcpf
WHERE 
	FUNCIONARIO.Sexo=DEPENDENTE.Sexo;

-- c --