create database AluguelVeiculos;
use AluguelVeiculos;

-- tabela de clientes
create table Cliente (
  id_cliente serial primary key,
  nome varchar(100) not null,
  cpf varchar(14) unique not null,
  telefone varchar(20),
  email varchar(100)
);

-- tabela cliente
insert into Cliente (nome, cpf, telefone, email) values
('calebe matias', '111.111.111-11', '83999990000', 'calebe@email.com'),
('victor hugo', '222.222.222-22', '83999991111', 'victor@email.com'),
('davi santiago', '333.333.333-33', '83999992222', 'davi@email.com'),
('pedro gabriel', '444.444.444-44', '83999993333', 'pedro@email.com'),
('jardelly enedino', '555.555.555-55', '83999994444', 'jardelly@email.com');

select * from Cliente;

-- tabela de veículos
create table Veiculo (
  id_veiculo serial primary key,
  modelo varchar(100) not null,
  marca varchar(50),
  ano int,
  categoria varchar(50),
  preco_diaria numeric(10,2), -- 10 digitos no total e duas casas decimal
  disponivel boolean default true -- define o valor padrão de uma coluna
);

-- tabela veiculo
insert into Veiculo (modelo, marca, ano, categoria, preco_diaria, disponivel) values
('ecosport', 'ford', 2020, 'suv', 150.00, true),
('civic', 'honda', 2019, 'sedan', 180.00, true),
('hb20', 'hyundai', 2021, 'hatch', 120.00, true),
('tracker', 'chevrolet', 2022, 'suv', 200.00, true),
('onix', 'chevrolet', 2020, 'hatch', 110.00, true);

select * from Veiculo;

-- tabela de aluguéis
create table Aluguel (
  id_aluguel serial primary key,
  id_cliente int references cliente(id_cliente),
  id_veiculo int references veiculo(id_veiculo),
  data_inicio date not null,
  data_fim date not null,
  valor_total numeric(10,2)
);

-- tabela aluguel
insert into Aluguel (id_cliente, id_veiculo, data_inicio, data_fim, valor_total) values
(1, 1, '2025-08-01', '2025-08-05', 600.00),
(2, 2, '2025-08-02', '2025-08-04', 360.00),
(1, 3, '2025-08-06', '2025-08-08', 240.00),
(4, 4, '2025-08-01', '2025-08-10', 2000.00),
(5, 1, '2025-08-05', '2025-08-12', 1050.00),
(2, 4, '2025-08-11', '2025-08-15', 1000.00),
(1, 2, '2025-08-16', '2025-08-20', 5200.00),
(3, 2, '2025-08-21', '2025-08-25', 900.00);

select * from Aluguel;


-- 1. Nome do cliente e modelo do veículo alugado - OK
create view cliente_modelo as
select c.nome, v.modelo
from Aluguel a left join cliente c on a.id_cliente = c.id_cliente
left join veiculo v on a.id_veiculo = v.id_veiculo;

select * from cliente_modelo;

-- 2. Aluguéis com valor acima de R$ 1000,00 - OK
create view alugueis_maiores_1000 as
select c.nome, v.modelo, a.valor_total
from aluguel a left join cliente c on a.id_cliente = c.id_cliente
left join veiculo v on a.id_veiculo = v.id_veiculo
where a.valor_total > 1000;

select * from alugueis_maiores_1000;

-- 3. Veículos que nunca foram alugados - OK
create view veiculos_nunca_alugados as
select v.*
from veiculo v left join aluguel a on v.id_veiculo = a.id_veiculo
where a.id_veiculo is null;

select * from veiculos_nunca_alugados;

-- 4. Clientes que já alugaram veículos da categoria SUV - OK
create view clientes_suv as
select distinct c.nome, c.email
from aluguel a join cliente c on a.id_cliente = c.id_cliente
join veiculo v on a.id_veiculo = v.id_veiculo
where v.categoria = 'suv';

select * from clientes_suv;

-- 5. Valor total de todos os aluguéis já feitos
create view total_alugueis as
select sum(valor_total) as total from aluguel;

select * from total_alugueis;

-- 6. Quantidade de veículos alugados por categoria
create view veiculos_por_categoria as
select v.categoria, count(distinct a.id_veiculo) as total
from veiculo v left join aluguel a on v.id_veiculo = a.id_veiculo
group by v.categoria;

select * from veiculos_por_categoria;

-- 7. Os 5 clientes que mais gastaram em aluguéis
create view top5_clientes as
select c.nome, sum(a.valor_total) as total
from cliente c left join aluguel a on c.id_cliente = a.id_cliente
group by c.id_cliente, c.nome
order by total desc
limit 5;

select * from top5_clientes;

-- 8. Média de gasto por cliente em aluguéis
create view media_por_cliente as
select c.nome, avg(a.valor_total) as media
from cliente c left join aluguel a on c.id_cliente = a.id_cliente
group by c.id_cliente, c.nome;

select * from media_por_cliente;

-- 9. Faturamento total agrupado por mês
create view faturamento_mes as
select date_format(data_inicio, '%Y-%m') as mes, sum(valor_total) as total
from aluguel
group by mes;

select * from faturamento_mes;

-- 10. Detalhes dos aluguéis com nome do cliente e veículo
create view detalhes_aluguel as
select c.nome, v.modelo, a.data_inicio, a.data_fim, a.valor_total
from aluguel a left join cliente c on a.id_cliente = c.id_cliente
left join veiculo v on a.id_veiculo = v.id_veiculo;

select * from detalhes_aluguel;

-- 11. Faturamento total agrupado por categoria de veículo
create view faturamento_categoria as
select v.categoria, sum(a.valor_total) as total
from aluguel a right join veiculo v on a.id_veiculo = v.id_veiculo
group by v.categoria;

select * from faturamento_categoria;

-- 12. Clientes que gastaram mais de R$ 5000,00 no total
create view clientes_mais_5000 as
select c.nome, sum(a.valor_total) as total
from cliente c left join aluguel a on c.id_cliente = a.id_cliente
group by c.id_cliente, c.nome
having total > 5000;

select * from clientes_mais_5000;

-- 13. Os 3 veículos mais alugados
create view top3_veiculos as
select v.modelo, count(a.id_aluguel) as vezes
from veiculo v left join aluguel a on v.id_veiculo = a.id_veiculo
group by v.id_veiculo, v.modelo
order by vezes desc
limit 3;

select * from top3_veiculos;

