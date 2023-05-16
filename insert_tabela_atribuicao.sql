-- Consulta da tabela atribuicao --

SELECT * FROM ibp.atribuicao;

/*
Este script realiza um JOIN entre as tabelas cientistas, regiao, sexo e projetos para copiar os dados para a tabela atribuicao.
Certifique-se de que as tabelas cientistas, regiao, sexo e projetos estejam corretamente populadas antes de executar este script.
*/


INSERT INTO atribuicao (cpf, code_regiao, code_sexo, code_projeto)
SELECT c.cpf, r.code_regiao, s.code_sexo, p.code_projeto
FROM cientistas c
JOIN regiao r ON c.code_regiao = r.code_regiao
JOIN sexo s ON c.code_sexo = s.code_sexo
JOIN projetos p ON c.code_projeto = p.code_projeto;

/*
Este script realiza um CROSS JOIN entre os cientistas e os projetos, inserindo todas as combinações possíveis na tabela atribuicao.
Certifique-se de que as tabelas cientistas, regiao, sexo e projetos estejam corretamente populadas antes de executar este script.
*/


INSERT INTO atribuicao (cpf, code_regiao, code_sexo, code_projeto)
SELECT c.cpf, r.code_regiao, s.code_sexo, p.code_projeto
FROM cientistas c
JOIN regiao r ON c.code_regiao = r.code_regiao
JOIN sexo s ON c.code_sexo = s.code_sexo
CROSS JOIN projetos p;

/*
Parece que a coluna id_atribuicao na tabela atribuicao não está configurada corretamente para ser um campo de autoincremento.
Certifique-se de que a definição da tabela atribuicao contenha a coluna id_atribuicao como INT AUTO_INCREMENT para que os valores sejam gerados automaticamente.

Aqui está o script corrigido:

ALTER TABLE atribuicao MODIFY id_atribuicao INT AUTO_INCREMENT;
*/


ALTER TABLE atribuicao MODIFY COLUMN id_atribuicao INT AUTO_INCREMENT;


INSERT INTO atribuicao (id_atribuicao, cpf, code_regiao, code_sexo, code_projeto)
SELECT NULL, c.cpf, r.code_regiao, s.code_sexo, p.code_projeto
FROM cientistas c
JOIN regiao r ON c.code_regiao = r.code_regiao
JOIN sexo s ON c.code_sexo = s.code_sexo
CROSS JOIN projetos p;

-- Consulta da tabela atribuicao --

select * from atribuicao; 