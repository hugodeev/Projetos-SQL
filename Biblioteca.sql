create database Biblioteca;
use Biblioteca;

CREATE TABLE alunos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    curso VARCHAR(100)
);

INSERT INTO alunos (id, nome, curso) VALUES
(1, 'Victor Hugo', 'Técnico em Informática'),
(2, 'Bruna Silva', 'Direito'),
(3, 'Davi Santiago', 'Medicina'),
(4, 'Jardelly Enedino', 'Engenharia'),
(5, 'Jeniffer Paola', 'Engenharia');

CREATE TABLE livros (
    id INT PRIMARY KEY,
    titulo VARCHAR(150),
    autor VARCHAR(100),
    categoria VARCHAR(50)
);

INSERT INTO livros (id, titulo, autor, categoria) VALUES
(1, 'Introdução à Engenharia', 'Paulo Rezende', 'Engenharia'),
(2, 'Direito Constitucional', 'Maria Helena', 'Direito'),
(3, 'Anatomia Humana', 'Gray', 'Medicina'),
(4, 'História do Brasil', 'Boris Fausto', 'História'),
(5, 'Cálculo I', 'James Stewart', 'Matemática'),
(6, 'Microbiologia Básica', 'Prescott', 'Medicina');

CREATE TABLE emprestimos (
    id INT PRIMARY KEY,
    aluno_id INT,
    livro_id INT,
    data_emprestimo DATE,
    data_devolucao DATE,
    FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    FOREIGN KEY (livro_id) REFERENCES livros(id)
);

INSERT INTO emprestimos (id, aluno_id, livro_id, data_emprestimo, data_devolucao) VALUES
(1, 1, 1, '2025-07-01', '2025-07-15'),
(2, 1, 5, '2025-07-20', NULL),
(3, 2, 2, '2025-06-10', '2025-06-20'),
(4, 3, 3, '2025-05-12', '2025-05-30'),
(5, 3, 6, '2025-07-10', NULL),
(6, 4, 1, '2025-06-01', '2025-06-15'),
(7, 5, 4, '2025-06-20', NULL),
(8, 1, 1, '2025-08-01', NULL),
(9, 3, 3, '2025-08-01', NULL);


-- 1 Liste o nome dos alunos e a quantidade total de livros que cada um pegou emprestado.
SELECT a.nome, COUNT(e.id) AS total_emprestimos -- Colunas que vai aparecer na consulta
FROM alunos a LEFT JOIN emprestimos e ON a.id = e.aluno_id
GROUP BY a.id, a.nome ORDER BY total_emprestimos DESC;

-- 2 Livros mais emprestados (título e número de vezes emprestado), ordenando do mais ao menos emprestado
SELECT l.titulo, COUNT(e.id) AS vezes_emprestado -- Colunas que vai aparecer na consulta
FROM livros l left JOIN emprestimos e ON l.id = e.livro_id
GROUP BY l.id, l.titulo ORDER BY vezes_emprestado DESC;

-- 3 Quantidade total de livros emprestados por curso
SELECT a.curso, COUNT(e.id) AS total_emprestimos -- Colunas que vai aparecer na consulta
FROM alunos a JOIN emprestimos e ON a.id = e.aluno_id
GROUP BY a.curso ORDER BY total_emprestimos DESC;

-- 4 Aluno que mais emprestou livros
SELECT a.nome, COUNT(e.id) AS total_emprestimos -- Colunas que vai aparecer na consulta
FROM alunos a JOIN emprestimos e ON a.id = e.aluno_id
GROUP BY a.id, a.nome ORDER BY total_emprestimos DESC LIMIT 1;

-- 5 Livros que ainda não foram devolvidos (data_devolucao é NULL)
SELECT l.titulo, a.nome AS aluno, e.data_emprestimo -- Colunas que vai aparecer na consulta
FROM emprestimos e JOIN livros l ON e.livro_id = l.id
JOIN alunos a ON e.aluno_id = a.id
WHERE e.data_devolucao IS NULL;

-- 6 Média de livros emprestados por aluno
SELECT ROUND(CAST(COUNT(*) AS FLOAT) / COUNT(DISTINCT aluno_id), 2) AS media_emprestimos_por_aluno -- Colunas que vai aparecer na consulta
FROM emprestimos;

-- 7 Categorias de livros mais populares (baseado na quantidade de empréstimos)
SELECT l.categoria, COUNT(e.id) AS total_emprestimos -- Colunas que vai aparecer na consulta
FROM livros l JOIN emprestimos e ON l.id = e.livro_id
GROUP BY l.categoria ORDER BY total_emprestimos DESC;

