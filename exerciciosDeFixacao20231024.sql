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
