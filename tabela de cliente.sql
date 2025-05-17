
create table cliente(
	id_cliente int not null,
    nome varchar(30) not null,
    telefone int not null,
    id_cidade int not null,
    foreign key(id_cidade) references cidade(id),
    primary key(id_cliente)
 );
 
 insert into cliente(id_cliente, nome, telefone, id_cidade)
 values( 139, 'Hugho', 8398726242, 3);
 
select * from cliente;


