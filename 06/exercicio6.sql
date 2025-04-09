----------------------------------------------------------------------1
CREATE INDEX idx_livro ON biblioteca.livro(nome);

----------------------------------------------------------------------2
CREATE INDEX idx_emprestimo ON biblioteca.emprestimo(data_emprestimo);

----------------------------------------------------------------------3
CREATE VIEW vw_historico_emprestimos AS
SELECT 
	u.nome AS "Nome", 
	l.nome AS "Título", 
	e.data_emprestimo AS "Data de empréstimo",
	e.data_devolucao AS "Data de devolução"
FROM
	biblioteca.emprestimo e
INNER JOIN
	biblioteca.livro l ON l.id = e.id
INNER JOIN 
	biblioteca.usuario u ON u.id = e.id;
	
----------------------------------------------------------------------4
/*
Os índices melhoram a performance de uma consulta pois a quantidade de
registros que precisam ser lidos da tabela diminuem, sendo necessário
que a busca ocorra somente nos índices criados e não em todos os registros.

Muitos índices podem causar um consumo de armazanamento muito maior sendo
que não são todas as tabelas que trazem os benefícios de ter índices.
*/

----------------------------------------------------------------------5

DROP INDEX idx_livro;

EXPLAIN ANALYZE
SELECT nome FROM biblioteca.livro; 

CREATE INDEX idx_livro ON biblioteca.livro(nome);

EXPLAIN ANALYZE
SELECT nome FROM biblioteca.livro; 