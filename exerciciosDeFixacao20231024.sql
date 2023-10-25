DELIMITER //
CREATE TRIGGER data_hora AFTER INSERT ON Clientes FOR EACH ROW
BEGIN
  INSERT INTO Auditoria (mensagem) VALUES (CONCAT('Novo cliente inserido em ', NOW()));
END;
//DELIMITER ;

INSERT INTO Clientes (nome)
VALUES ('Maria Eduarda');
SELECT * FROM clientes;
SELECT * FROM Auditoria;

-- 02
DELIMITER //
CREATE TRIGGER excluir_cliente BEFORE DELETE ON Clientes FOR EACH ROW
BEGIN
  INSERT INTO Auditoria (mensagem) VALUES (CONCAT('Tentativa de excluir cliente ', OLD.nome));
END;
//DELIMITER ;

DELETE FROM Clientes WHERE nome = 'Maria Eduarda';
SELECT * FROM Auditoria;

-- 03 
DELIMITER //
CREATE TRIGGER mudar_nome AFTER UPDATE ON Clientes FOR EACH ROW
BEGIN
  INSERT INTO Auditoria (mensagem) VALUES (CONCAT('O nome do cliente foi alterado de "', OLD.nome, '" para "', NEW.nome));
END;
//DELIMITER ;

INSERT INTO Clientes (nome)
VALUES ('Maria Eduarda');

UPDATE Clientes SET nome = 'Duda';
SELECT * FROM Auditoria;

-- 04
DELIMITER //
CREATE TRIGGER nao_atualizar BEFORE UPDATE ON Clientes FOR EACH ROW
BEGIN
    IF NEW.nome IS NULL OR NEW.nome = '' THEN
        INSERT INTO Auditoria (mensagem)
        VALUES (CONCAT('Tentativa inválida de atualização do nome do cliente para vazio ou nulo'));
        SET NEW.nome = OLD.nome;
    END IF;
END;
//DELIMITER ;

UPDATE Clientes SET nome = '';
SELECT * FROM Auditoria;

-- 05 
DELIMITER //
CREATE TRIGGER produtos_em_estoque AFTER INSERT ON Pedidos FOR EACH ROW
BEGIN
    UPDATE Produtos
    SET estoque = estoque - NEW.quantidade
    WHERE id = NEW.produto_id;

    IF (SELECT estoque FROM Produtos WHERE id = NEW.produto_id) < 5 THEN
        INSERT INTO Auditoria (mensagem)
        VALUES (CONCAT('Estoque do produto ficou abaixo de 5 unidades.'));
    END IF;
END;
//DELIMITER ;
