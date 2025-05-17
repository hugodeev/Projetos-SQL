create database Aluno;

use aluno;

create table cidade (
    id_cidade int not null,
    nome varchar(30) not null,
    primary key (id_cidade)
);


insert into cidade (id_cidade, nome)
values 
(15, 'Tacima'), 
(20, 'Riachão'),
(30, 'Guarabira');


select * from cidade;


create table curso (
    id_curso int not null,
    nome varchar(30) not null,
    id_cidade int not null,
    primary key (id_curso),
    foreign key (id_cidade) references cidade(id_cidade)
);


insert into curso (id_curso, nome, id_cidade) 
values 
(1, 'Informática', 15),
(2, 'Contabilidade', 20),
(3, 'Edificações', 30);


select * from curso;

create table aluno (
    id_aluno int not null,
    nome varchar(30) not null,
    id_curso int not null,
    id_cidade int not null,
    primary key (id_aluno),
    foreign key (id_curso) references curso(id_curso),
    foreign key (id_cidade) references cidade(id_cidade)
);


insert into aluno 
values 
(11, 'Hugo', 1, 15),
(12, 'Calebe', 2, 30),
(13, 'Vitor', 3, 20);


select * from aluno;

select * from aluno where nome like '%Hugo%';
select * from aluno where nome like '%Calebe%';
select * from aluno where nome like '%Vitor%';

update cidade
set nome = 'Belem'
where id_cidade = 15;

update curso
set nome = 'Sistemas para Internet'
where id_curso = 1;

delete from aluno where id_aluno = 13;

select
    a.nome as nome_aluno,
    ci.nome as nome_cidade,
    c.nome as nome_curso
from aluno a
join curso c on a.id_curso = c.id_curso
join cidade ci on a.id_cidade = ci.id_cidade;
