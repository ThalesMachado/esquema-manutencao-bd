create schema manutencao;
drop table if exists manutencao.cliente;
create table manutencao.cliente(
	cid serial primary key,
	cpf char(11),
	nome varchar(100),
	endereco varchar(100),
	telefone varchar(15)
);

drop table if exists manutencao.computador;
create table manutencao.computador(
	pcid serial primary key,
	serial_number varchar(10),
	processor_name varchar(50),
	memory_gb int check(memory_gb > 0),
	disk_gb int check(disk_gb > 0)
);

drop table if exists manutencao.manutencao;
create table manutencao.manutencao(
	mid serial primary key,
	cid bigint not null references manutencao.cliente(cid),
	pcid bigint not null references manutencao.computador(pcid),
	mao_obra decimal(10,2) default 0.0,
	preco_pecas decimal(10,2) default 0.0,
	num_pecas_usadas integer default 0,
	valor_manutencao decimal(10, 2) default 0.0
);

drop table if exists manutencao.peca;
create table manutencao.peca(
	pid serial primary key,
	nome varchar(30),
	descricao varchar(50),
	preco decimal(10,2) check(preco > 0)
);

drop table if exists manutencao.peca_usada;
create table manutencao.peca_usada(
	mid bigint references manutencao.manutencao(mid),
	pid bigint references manutencao.peca(pid),
	qtd int,
	primary key(mid, pid)
);
	