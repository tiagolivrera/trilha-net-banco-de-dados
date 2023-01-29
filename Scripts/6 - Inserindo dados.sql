INSERT INTO Clientes (Nome, Sobrenome, Email, AceitaComunicados, DataCadastro)
VALUES ('Thyago', 'Freitas', 'thyago.olifreitas@gmail.com', 1, GETDATE())

SELECT * FROM Clientes WHERE Nome = 'Thyago'