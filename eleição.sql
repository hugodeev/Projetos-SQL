
CREATE DATABASE Eleições;
USE Eleições;

CREATE TABLE candidates (
    candidate_name VARCHAR(100) PRIMARY KEY,
    party VARCHAR(50)
);

CREATE TABLE regions (
    region_name VARCHAR(100) PRIMARY KEY
);

CREATE TABLE votes (
    vote_id INT PRIMARY KEY,
    candidate_name VARCHAR(100),
    region_name VARCHAR(100),
    vote_count INT,
    FOREIGN KEY (candidate_name) REFERENCES candidates(candidate_name),
    FOREIGN KEY (region_name) REFERENCES regions(region_name)
);

INSERT INTO candidates (candidate_name, party) 
VALUES
('Alice', 'Partido A'),
('Bob', 'Partido B'),
('Charlie', 'Partido C');

INSERT INTO regions (region_name)
 VALUES
('Região Norte'),
('Região Sul');

INSERT INTO votes (vote_id, candidate_name, region_name, vote_count)
VALUES
(1, 'Alice', 'Região Norte', 500),
(2, 'Bob', 'Região Norte', 300),
(3, 'Alice', 'Região Sul', 200),
(4, 'Charlie', 'Região Norte', 150),
(5, 'Bob', 'Região Sul', 250),
(6, 'Charlie', 'Região Sul', 400);


SELECT * FROM candidates;
SELECT * FROM regions;
SELECT * FROM votes;

-- Questão 1: Total de votos por candidato
SELECT candidate_name, SUM(vote_count) AS Votos_Por_Candidato
FROM votes
GROUP BY candidate_name;

-- Questão 2: Média de votos por região
SELECT region_name, ROUND(AVG(vote_count), 2) AS MediaDeVotos 
FROM votes
GROUP BY region_name;

-- Questão 3: Candidatos com o maior número de votos em uma única região
SELECT *
FROM votes
WHERE vote_count IN (
    SELECT MAX(vote_count)
    FROM votes
    GROUP BY region_name
);

-- Questão 4: Região com o maior número de votos
SELECT region_name, SUM(vote_count) AS Total_Votos 
FROM votes 
GROUP BY region_name 
ORDER BY Total_Votos DESC
LIMIT 1;

-- Questão 5: Candidato com o maior número de votos
SELECT candidate_name, SUM(vote_count) AS total_votos
FROM votes 
GROUP BY candidate_name 
ORDER BY total_votos DESC
LIMIT 1;

-- Questão 6: Candidatos com mais de 500 votos
SELECT candidate_name, SUM(vote_count) AS Total_votos
FROM votes
GROUP BY candidate_name 
HAVING SUM(vote_count) > 500;

-- Questão 7: Número de votos por região e por candidato
SELECT candidate_name, region_name, vote_count
FROM votes
ORDER BY region_name, vote_count DESC;

-- Outras consultas

-- Consulta 1: Candidatos com média maior que 200 votos
SELECT candidate_name, ROUND(AVG(vote_count), 2) AS media_votos
FROM votes
GROUP BY candidate_name
HAVING AVG(vote_count) > 200;

-- Consulta 2: Mostrando cada Função
SELECT
    MIN(vote_count) AS MenorVotos,
    MAX(vote_count) AS MaiorVotos,
    ROUND(AVG(vote_count), 2) AS MediaVotos,
    SUM(vote_count) AS TotalVotos
FROM votes;
