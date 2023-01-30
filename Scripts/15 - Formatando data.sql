SELECT 
	UPPER(Nome) NomeMaiusculo,
	LOWER(Cor) CorMinusculo,
	FORMAT(DataCadastro, 'dd-MM-yyyy') DataCadastroPadraoBR
FROM Produtos