

create table endereço(
	id_cidade int not null, 
    nome varchar(20) not null,
    estado varchar(20) not null,
    pais varchar(20) not null,
    cep int not null,
    primary key(id_cidade)
 );
 
 
	select * from endereço;