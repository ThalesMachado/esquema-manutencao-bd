create or replace function manutencao.atualiza_valor_manutencao() returns trigger as $atualiza_valor_manutencao$
	begin
		if (tg_table_name = 'manutencao') then
			new.valor_manutencao = new.mao_obra + new.preco_pecas;
			return new;
		elsif (tg_table_name = 'peca_usada') then
			update manutencao.manutencao
				set preco_pecas = preco_pecas + (new.qtd *(select p.preco from manutencao.peca as p where p.pid = pid limit 1 ))
				where mid = new.mid;
			return new;
		end if;
	end;
$atualiza_valor_manutencao$ language plpgsql;

create trigger atualiza_valor_manutencao before insert or update on manutencao.peca_usada for each row execute procedure manutencao.atualiza_valor_manutencao();
create trigger atualiza_valor_manutencao before insert or update on manutencao.manutencao for each row execute procedure manutencao.atualiza_valor_manutencao();



