
CREATE DATABASE Cliente;
USE Cliente;

CREATE TABLE Clientess (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,  
    email VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL
);

INSERT INTO Clientess (nome, cpf, email, data_nascimento)
VALUES 
    ('Hugo', '489.258.644-75', 'fullano@gamail.com', '2000-07-20'),
    ('Davi', '303.654.432-55', 'alguem@gmail.com', '2005-12-30'),
    ('Herllan', '540.436.766-23', 'herlan@gmail.com', '2015-03-18');

SELECT * FROM Clientess;

CREATE TABLE Endereços (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    rua VARCHAR(30) NOT NULL,
    numero INT NOT NULL,
    bairro VARCHAR(30) NOT NULL,
    complemento VARCHAR(20),
    cidade VARCHAR(30) NOT NULL,
    uf CHAR(2) NOT NULL,
    cep CHAR(15) NOT NULL,
    ponto_referencia VARCHAR(100),
    regiao varchar(30),
    FOREIGN KEY (id_cliente) REFERENCES Clientess(id_cliente) ON DELETE CASCADE
);

INSERT INTO Endereços (id_cliente, rua, numero, bairro, complemento, cidade, uf, cep, ponto_referencia, regiao)
VALUES 
    (1, 'Santa Rita', 77, 'centro', 'casa', 'Guarabira', 'PB', '58200-000', 'próximo a capela',  'Nordeste'),
    (1, 'Rua das Flores', 129, 'centro', 'casa', 'Tacima', 'PB', '58200-000', 'próximo a igreja', 'Nordeste'),
    
    (2, 'Pedras de Fogos', 190, 'centro', 'casa', 'Belém', 'PB', '58285-000', 'próximo ao Banco do Brasil', 'Nordeste'),
    (2, 'Água e Pão', 177, 'centro', 'hotel', 'Belém', 'PB', '58285-000', 'próximo ao Açaí', 'Nordeste'),
    
    (3, 'Serra de Montanhas', 43, 'centro', 'hotel', 'Nova Cruz', 'RN', '59230-000', 'próximo ao Mercado Bezerra', 'Nordeste'),
    (3, 'Monte Gimarí', 89, 'centro', 'casa', 'Natal', 'RN', '59010-100', 'próximo à Eletrolar', 'Nordeste');

SELECT * FROM Endereços;
