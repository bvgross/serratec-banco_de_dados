/*
SELECT * FROM biblioteca.usuario;
SELECT * FROM biblioteca.emprestimo;
*/

-------------------------------------------------------1

SELECT * FROM biblioteca.livro;

-------------------------------------------------------2

SELECT 
	l.nome AS nome_do_livro,
	u.nome AS nome_do_usuario
FROM biblioteca.emprestimo e
JOIN biblioteca.livro l ON e.idlivro = l.id
JOIN biblioteca.usuario u ON e.idusuario = u.id
WHERE u.nome = 'Bruno Ventura Gross';

--------------------------------------------------------3

SELECT 
	e.data_emprestimo AS "Data do empréstimo",
	u.nome AS "Usuário",
	l.nome AS "Livro emprestado"
FROM biblioteca.emprestimo e
JOIN biblioteca.livro l ON l.id = e.idlivro
JOIN biblioteca.usuario u ON u.id = e.idusuario
WHERE status = 'emprestado';

--------------------------------------------------------4

SELECT autor,nome FROM biblioteca.livro;

--------------------------------------------------------5

SELECT
	u.id AS id_do_usuario,
	u.nome AS nome_do_usuario,
	l.id AS id_do_livro,
	l.nome AS nome_do_livro,
	e.data_emprestimo as data_do_emprestimo,
	e.status
FROM biblioteca.usuario u
LEFT JOIN biblioteca.emprestimo e ON u.id = e.idusuario
LEFT JOIN biblioteca.livro l ON e.idlivro = l.id
ORDER BY u.nome;
