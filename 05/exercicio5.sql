SELECT * FROM biblioteca.emprestimo;
SELECT * FROM biblioteca.livro;
SELECT * FROM biblioteca.usuario;

--------------------------------------1

SELECT COUNT(*) FROM biblioteca.livro;

--------------------------------------2

SELECT AVG(data_devolucao - data_emprestimo)
FROM biblioteca.emprestimo
WHERE data_devolucao IS NOT NULL;

--------------------------------------3

--mais antigo
SELECT nome 
FROM biblioteca.livro
WHERE ano_publicacao = (SELECT MIN(ano_publicacao) FROM biblioteca.livro);

--mais recente
SELECT nome 
FROM biblioteca.livro
WHERE ano_publicacao = (SELECT MAX(ano_publicacao) FROM biblioteca.livro);

--------------------------------------4

SELECT u.nome AS "Usuário", count(e.id) AS "Qtd. Empréstimos"
FROM biblioteca.usuario u
LEFT JOIN biblioteca.emprestimo e ON u.id = e.idusuario
GROUP BY u.nome
ORDER BY "Qtd. Empréstimos" desc;

--------------------------------------5

SELECT l.genero AS "Gênero", count(e.id) AS "Qtd. Livros"
FROM biblioteca.livro l
LEFT JOIN biblioteca.emprestimo e ON l.id = e.idlivro
GROUP BY l.genero
ORDER BY "Qtd. Livros" desc;