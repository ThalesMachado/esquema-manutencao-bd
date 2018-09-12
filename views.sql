create or replace view valor_de_manutencao_por_cliente as
select c.nome, c.cpf, sum(m.valor_manutencao) valor_total, (sum(m.valor_manutencao) / count(m.valor_manutencao)) valor_medio
from evilwithin.cliente c, evilwithin.manutencao m
group by m.cid

create view evilwithin.dados_de_manutencao as
select c.nome, c.cpf, pc.serial_number, m.num_pecas_usadas, count(pu.pid)
from evilwithin.cliente as c 
inner join evilwithin.manutencao as m on c.cid = m.cid
inner join evilwithin.computador as pc on pc.pcid = m.pcid, evilwithin.peca_usada as pu
group by pu.mid
