ALTER TABLE Produtos
ADD DataCadastro DATETIME2

UPDATE Produtos SET DataCadastro = GETDATE()

SELECT * FROM Produtos