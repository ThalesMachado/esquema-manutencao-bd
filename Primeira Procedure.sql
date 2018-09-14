CREATE DEFINER=`aluno`@`%` PROCEDURE `atualizar_valor_total`()
BEGIN
	declare current_user_cid bigint;
    declare current_user_cpf char(11);
    declare current_user_nome varchar(255);
	declare current_computer bigint;
    declare serial_number varchar(255);
    declare valor_total decimal(10, 2);
    declare pid bigint;
	declare clientes cursor for
		select nome, cid, cpf from evilwithin.cliente;
        
	open clientes;
    repeat
		fetch clientes into current_user_nome,
			current_user_cid, current_user_cpf;
		set valor_total = (select sum(m.valor_manutencao)
			from evilwithin.manutencao as m
            having m.cid = current_user_cid);
		set pid = (select pid from evilwithin.manutencao
			where cid = current_user_cid limit 1);
		set serial_number = (select pc.serial_number
			from evilwithin.computador as pc
			where pid = pc.pid);
		insert into evilwithin.valor_total_cliente(nome, cpf, numero_serie, valor_total, cid)
        values(current_user_name, current_user_cpf, serial_number, current_user_cid);
        until done
        end repeat;
END
