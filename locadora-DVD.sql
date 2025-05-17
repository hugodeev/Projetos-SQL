CREATE DATABASE LocadoraDVD;

USE LocadoraDVD;

-- Tabela CLIENTES
CREATE TABLE CLIENTES (
    codc INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    data_nasc DATE NOT NULL,
    sexo CHAR(1) CHECK (sexo IN ('M', 'F')),
    salario DECIMAL(10, 2) NOT NULL
);

-- Inserindo dados na tabela CLIENTES
INSERT INTO CLIENTES (codc, nome, cpf, data_nasc, sexo, salario)
VALUES 
(1, 'Hugo Matias', '97645239722', '2008-05-15', 'M', 1200.00),
(2, 'Davi Moura', '77452790722', '2010-08-20', 'M', 3000.00),
(3, 'Pedro', '32497530292', '2010-08-20', 'M', 300.00),
(4, 'Thayná', '83248652800', '2010-02-23', 'F', 2300.00),
(5, 'Jardelly', '16417824582', '2009-01-10', 'F', 4300.00);

SELECT * FROM CLIENTES;

-- Tabela DVD
CREATE TABLE DVD (
    codd INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    genero VARCHAR(50) NOT NULL,
    duracao TIME NOT NULL, -- Alterado para armazenar duração no formato HH:MM:SS
    situacao VARCHAR(100) NOT NULL
);

-- Inserindo dados na tabela DVD
INSERT INTO DVD (codd, titulo, genero, duracao, situacao)
VALUES 
(5, 'Moana 2', 'animação', '01:35:00', 'Disponível'),
(3, 'Homem Aranha', 'aventura', '01:20:15', 'Disponível'),
(4, 'Truque de Mestre', 'ação', '02:40:00', 'Indisponível'),
(1, 'Incrível Hulk', 'mistério', '01:07:00', 'Disponível'),
(2, 'Simpsons', 'comédia', '01:30:09', 'Indisponível');

SELECT * FROM DVD;

-- Tabela LOCACOES
CREATE TABLE LOCACOES (
    codc INT NOT NULL,
    codd INT NOT NULL,
    data DATE NOT NULL,
    PRIMARY KEY (codc, codd, data),
    FOREIGN KEY (codc) REFERENCES CLIENTES(codc) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (codd) REFERENCES DVD(codd) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Inserindo dados na tabela LOCACOES
INSERT INTO LOCACOES (codc, codd, data)
VALUES 
(1, 5, '2024-12-01'),
(2, 3, '2024-12-02'),
(3, 4, '2024-12-03'),
(4, 1, '2024-12-04'),
(5, 2, '2024-12-05');

SELECT * FROM LOCACOES;
