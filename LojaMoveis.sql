create database LojaMoveis;
use LojaMoveis;

CREATE TABLE Motorista (
    CodMot INT PRIMARY KEY,
    CPF NUMERIC(11),
    CNH NUMERIC(10),
    Nome VARCHAR(50),
    Endereco VARCHAR(100)
);

INSERT INTO Motorista VALUES 
(17, 10065456443, 103439212, 'Victor Hugo', 'TCM'), 
(22, 13316364420, 123456789, 'Erick Herllan', 'AG'),
(37, 18345934596, 564586403, 'Elenilson', 'JP'),
(87, 90845934742, 774598421, 'Paulo Santos', 'GBA');

CREATE TABLE Entrega (
    Hora TIME,
    Data DATE, 
    NumVen INT,
    Placa CHAR(7),
    CodMot INT,
    PRIMARY KEY (Hora, Data, NumVen, Placa, CodMot)
);

INSERT INTO Entrega VALUES
('12:00', '2025-07-18', 99, 'HD65R', 17),
('13:00', '2025-07-19', 1000, 'YRG32F', 22),
('19:00', '2025-07-20', 1, 'UHK08A', 37),
('13:50', '2027-10-10', 4, 'WHG32N', 100);  -- Motorista inexistente

CREATE TABLE Vendedor(
    CodVdd INT PRIMARY KEY,
    CPF NUMERIC(11),
    V_comissao NUMERIC(4,2),
    Nome VARCHAR(50), 
    Endereco VARCHAR(100)
);

INSERT INTO Vendedor VALUES
(9, 14800913403, 19.90, 'Pedro', 'Mari'),
(7, 21203892550, 24.99, 'Davi', 'Cuitegi'),
(2, 18929302920, 0.99, 'Jardelly', 'Guarabira');

CREATE TABLE Cliente (
    CodCli INT PRIMARY KEY,
    Nome VARCHAR(50),
    Telefone CHAR(10),
    Endereco VARCHAR(100),
    CPF NUMERIC(11),
    Email VARCHAR(50)
);

INSERT INTO Cliente VALUES
(1, 'Adrielle', '8340028922', 'Guarabira', 1028627491, 'adr@gmail.com'),
(2, 'Thayná', '8316540928', 'Alagoinha', 428374918, 'thayna@gmail.com'),
(3, 'Jenni', '8356174029', 'Guarabira', 95738926586, 'jenni@gmail.com');

CREATE TABLE Venda(
    NumVen INT PRIMARY KEY,
    Valor_total NUMERIC(11,2),
    CodVdd INT,
    CodCli INT
);

INSERT INTO Venda VALUES
(99, 150.50, 7, 1),
(1000, 7500.00, 9, 2),
(1, 10.00, 2, 3);

-- INNER JOIN: mostra apenas as vendas com cliente e vendedor existentes
SELECT ve.NumVen, c.Nome AS Cliente, vdd.Nome AS Vendedor
FROM Venda ve
INNER JOIN Cliente c ON ve.CodCli = c.CodCli
INNER JOIN Vendedor vdd ON ve.CodVdd = vdd.CodVdd;

-- LEFT JOIN: mostra todas as entregas, mesmo que não tenham motoristass
SELECT m.Nome AS Motorista, e.NumVen
FROM Entrega e LEFT JOIN Motorista m ON m.CodMot = e.CodMot;

-- RIGHT JOIN: mostra todos os motoristas, mesmo que não tenha entregas
SELECT m.Nome AS Motorista, e.NumVen
FROM Entrega e RIGHT JOIN Motorista m ON m.CodMot = e.CodMot;

-- FULL OUTER JOIN: mostra todos os motoristas e todas as entregas, relacionados ou não
SELECT m.Nome AS Motorista, e.NumVen
FROM Motorista m
FULL OUTER JOIN Entrega e ON m.CodMot = e.CodMot;


-- CONSULTAS COM FUNÇÕES AGREGADAS (GROUP BY, AVG, SUM, COUNT)

-- Total de vendas por vendedor
SELECT vdd.Nome AS Vendedor, SUM(ve.Valor_total) AS TotalVendas
FROM Venda ve
JOIN Vendedor vdd ON ve.CodVdd = vdd.CodVdd
GROUP BY vdd.Nome;

-- Quantidade de entregas por motorista (incluindo os que não entregaram nada)
SELECT m.Nome AS Motorista, COUNT(e.NumVen) AS QtdeEntregas
FROM Motorista m
LEFT JOIN Entrega e ON m.CodMot = e.CodMot
GROUP BY m.Nome;

-- Valor médio gasto por cliente
SELECT c.Nome AS Cliente, AVG(ve.Valor_total) AS MediaGasto
FROM Venda ve
JOIN Cliente c ON ve.CodCli = c.CodCli
GROUP BY c.Nome;
