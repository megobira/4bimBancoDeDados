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
