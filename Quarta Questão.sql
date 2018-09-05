select PC.pcid, PC.serial_number, Pc.processor_name, PC.memory_gb as memoria, PC.disk_gb as disco
from (select R.num_pecas, M.mid, M.pcid
	from (select count(p.pid) as num_pecas, p.mid
		from manutencao.peca_usada as p
		group by p.mid) as R
		inner join
		manutencao.manutencao as M on M.mid = R.mid
	where R.num_pecas >= 4) as R1
	inner join
	manutencao.computador as PC on R1.pcid = PC.pcid