-- QUerys para Manutenção
-- Exercício 2
select c.cpf
from	(select R.cid
	from (select count(distinct m.pcid) as num_pcs, m.cid
		from manutencao.manutencao as m
		group by m.cid) as R
	where R.num_pcs > 3) as R2
inner join manutencao.cliente as c on c.cid = R2.cid
