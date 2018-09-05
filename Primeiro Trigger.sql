create or replace function manutencao.atualiza_num_pecas() returns trigger as $atualiza_num_pecas$
	declare
	teste int;
	begin	
		update manutencao.manutencao
		set num_pecas_usadas = num_pecas_usadas + new.qtd
		where new.mid = mid;
		return new;
	end;	
$atualiza_num_pecas$ language plpgsql;

create trigger atualiza_num_pecas before insert on manutencao.peca_usada for each row execute procedure manutencao.atualiza_num_pecas();
