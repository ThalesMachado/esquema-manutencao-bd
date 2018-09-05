
select c.cpf, pc.serial_number
from (select m.pcid, count(m.pcid) as num_manutencoes, m.cid
	from manutencao.manutencao as m
	group by m.pcid, m.cid) as R 
	
	inner join
	
	(select pc.pcid, pc.serial_number
	from manutencao.computador as pc) as pc	on R.pcid = pc.pcid

	inner join 

	(select c.cid, c.cpf
	from manutencao.cliente as c) as c on R.cid = c.cid
	
where R.num_manutencoes > 2
