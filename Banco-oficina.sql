/* Criação do Banco de dados Oficina */
create database Oficina;

/* Comando para abrir nosso banco de dados*/
use Oficina;

/* Tabela Cliente */
create table Cliente(
    id_cliente int not null auto_increment primary key,
    nome varchar(30) not null,
    telefone varchar(15) not null,
    email varchar(30)
);

/* Inserindo valores na tabela Cliente */
insert into Cliente(nome, telefone, email)
values
('João Pedro', '83-98122345', 'joao123425p@gmail.com'),
('João Paulo', '83-98111154', 'paulo12345@gmail.com'),
('Gabriel Silva', '83-98120084', 'silva54672@gmail.com'),
('Davi Gustavo', '83-98122327', 'gustavo0098@gmail.com'),
('Erick Herllan', '83-9837422', 'herlann1@gmail.com');

/* Tabela Mecanico */
create table Mecanico(
    id_mecanico int not null auto_increment primary key,
    nome varchar(30) not null,
    data_nasc date not null,
    salario float not null,
    telefone varchar(15) not null,
    email varchar(30) not null,
    cpf char(14) not null
);

/* Inserindo valores na tabela Mecanico */
insert into Mecanico(nome, data_nasc, salario, telefone, email, cpf)
values
('Miguel Souza', '1985-06-12', 3500.00, '83-98765432', 'miguelmec@gmail.com', '123.456.789-00'),
('Carlos Lima', '1992-08-25', 4200.50, '83-98111222', 'carlosmec@gmail.com', '987.654.321-11'),
('Guilherme Pereira', '1970-01-03', 4200.50, '83-98111222', 'guilhermemec@gmail.com', '767.654.541-65'),
('Joaquim byts', '1999-09-29', 4200.50, '83-98111222', 'joaquimmec@gmail.com', '438.674.087-86'),
('Felipe Andrade', '1988-11-10', 3800.75, '83-98223344', 'felipemec@gmail.com', '456.789.123-22');

/* Tabela Endereço Cliente */
create table EnderecoCliente(
    id_cliente int,
    cidade varchar(20) not null,
    rua varchar(30) not null,
	numero int not null,
    estado varchar(20) not null,
    pais varchar(20) not null,
    cep varchar(15) not null,
    foreign key (id_cliente) references Cliente(id_cliente)
);

/* Inserindo valores na tabela Endereco */
insert into EnderecoCliente(id_cliente, cidade, rua, numero, estado, pais, cep )
values
(4, 'Tacima', 'Rua Santa Rita', 77, 'Paraíba', 'Brasil', '58293-000'),
(1,'Guarabira', 'Rua Das Flores', 132, 'Paraíba','Brasil', '58200-000'),
(2, 'Alagoa Grande', 'Rua Matriz', 1007, 'Paraíba', 'Brasil', '58388-000'),
(3, 'Campina Grande', 'Rua Nordeste', 10, 'Paraíba', 'Brasil', '58400-000'),
(5, 'João Pessoa', 'Rua Santa Maria', 06, 'Paraíba', 'Brasil', '58000-000');

/* Tabela Endereço Mecanico */
create table EnderecoMecanico(
	id_mecanico int,
    cidade varchar(20) not null,
	rua varchar(40) not null,
	numero int not null,
    estado varchar(20) not null,
    pais varchar(20) not null,
    cep varchar(15) not null,
    foreign key (id_mecanico) references Mecanico(id_mecanico)
);

/* Inserindo valores na tabela Endereco */
insert into EnderecoMecanico(id_mecanico, cidade, rua, numero, estado, pais, cep)
values
(5, 'São Bento', 'Rua João Ferreira', 45, 'Paraíba', 'Brasil', '45643-0340'),
(3, 'Dona Inês', 'Rua Vicente', 101, 'Paraíba', 'Brasil', '17087-087'),
(1, 'Riachão', 'Rua Das Graças', 11,  'Paraíba', 'Brasil', '64328-102'),
(4, 'Santa Rita', 'Rua sem SAIDA', 677,  'Paraíba', 'Brasil', '19410-000'),
(2, 'Pilões', 'Rua Palestina', 243,  'Paraíba', 'Brasil', '43002-043');


/* Tabela Veiculo */
create table Veiculo(
    id_cliente int not null,
    id_veiculo int not null auto_increment primary key,
    placa varchar(10) not null,
    modelo varchar(20) not null,
    foreign key (id_cliente) references Cliente(id_cliente)
);

/* Inserindo valores na tabela Veiculo */
insert into Veiculo(id_cliente, placa, modelo)
values
(1, 'ABC-1234', 'Fiat Uno'),
(2, 'XYZ-5678', 'Chevrolet Onix'),
(3, 'JKL-9101', 'Honda Civic'),
(3, 'MNO-1121', 'Toyota Corolla'),
(2, 'PQR-3141', 'Volkswagen Gol');

/* Tabela Ferramentas */
create table Ferramentas(
    ferramenta varchar(30) not null primary key,
    preco_compra float not null,
    data_compra date not null,
    condicao varchar(15) default 'Bom ou Ruim'
); 

/* Inserindo valores na tabela Ferramentas */
insert into Ferramentas(ferramenta, preco_compra, data_compra, condicao)
values
('Chave de Roda', 50.00, '2024-01-15', '75% - Bom'),
('Macaco Hidráulico', 300.00, '2024-02-10', '95% - Bom'),
('Compressor de Ar', 1200.00, '2024-03-05', '60% - Ruim'),
('Chave de Fenda', 20.00, '2024-01-20', '15% - Ruim'),
('Martelo de Borracha', 35.00, '2024-02-25', '47% - Ruim');

/* Criação da Tabela de manutenção de veículos */
create table Manutencao(
id_veiculo int, 
id_mecanico int,
data_inicio date not null,
situacao varchar(30) not null,
estado varchar(30) default 'Em análise',
foreign key (id_veiculo) references Veiculo(id_veiculo),
foreign key (id_mecanico) references Mecanico(id_mecanico)
);

/* Inserindo valores na tabela de manutenção */
insert into Manutencao(id_veiculo, id_mecanico, data_inicio, situacao, estado) 
values 
(3, 5, '2025-01-02', 'Troca do Para-choque', 'Em andamento...'),
(4, 1, '2025-02-15', 'Troca de óleo', 'Encerrado'),
(2, 3, '2025-02-15', 'Troca da suspensão', 'Encerrado'),
(5, 2, '2025-02-15', 'Restauração da Bateria', 'Em andamento...'),
(1, 4, '2024-11-25', 'troca de óleo', 'Em andamento...');


/* Consultando todas as tabelas */
select * from Cliente;
select * from Mecanico;
select * from EnderecoCliente;
select * from EnderecoMecanico;
select * from Veiculo;
select * from Ferramentas;
select *from Manutencao;