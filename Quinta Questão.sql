select PC.pcid, PC.serial_number, PC.processor_name, PC.memory_gb as memoria, PC.disk_gb as disco --retorna somente as informações do pc
from ((select R1.mid --quer o id da manutencao pelas queries abaixo
	from (select count(P.pid) as soma_pecas --conta a quantidade total de pecas
		from manutencao.peca as P) as R,
		(select count(distinct PU.pid) as pecas_usds, PU.mid --pelo id da manutencao conta a as pecas distintas usadas em cada manutencao
		from manutencao.peca_usada as PU
		group by PU.mid) as R1
	where R.soma_pecas = R1.pecas_usds) as R2 --ve que manutencao usou a soma total de pecas e junta
	inner join manutencao.manutencao as M on M.mid = R2.mid) as R3 --junta a manutencao com quem usou tudo
	inner join manutencao.computador as PC on PC.pcid = R3.pcid  --junta a manutencao com o pc
	
