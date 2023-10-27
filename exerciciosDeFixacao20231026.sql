CREATE TRIGGER cliente_insert_trigger
AFTER INSERT ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem) VALUES (CONCAT('Novo cliente inserido em ', NOW()));
END;

CREATE TRIGGER cliente_delete_trigger
BEFORE DELETE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem) VALUES (CONCAT('Tentativa de exclusão de cliente em ', NOW()));
END;


CREATE TRIGGER cliente_nome_validacao_trigger
BEFORE UPDATE ON Clientes
FOR EACH ROW
BEGIN
    IF NEW.nome IS NULL OR NEW.nome = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é permitido atualizar o nome para NULL ou uma string vazia.';
    END IF;
END;
