select P.pid
from manutencao.peca P
where P.pid not in (select pu.pid from manutencao.peca_usada as pu)