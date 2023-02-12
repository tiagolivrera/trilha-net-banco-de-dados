-- Criando uma tabela
CREATE TABLE pessoa (
	id bigint,
	nome varchar(50),
	idade integer
);

-- Adicionando a coluna sexo a tabela pessoa
ALTER TABLE pessoa 
ADD sexo bit; -- SQL Server não possui o tipo boolean, ao invés use o tipo BIT

ALTER TABLE pessoa 
ADD nome_m varchar(50);

-- Modificando o nome de uma coluna no SQL Server
EXEC sp_RENAME 'pessoa.nome_m', 'nome_mae', 'COLUMN'
-- Realizando a mesma operação no Postgres:
-- 		ALTER TABLE pessoa 
-- 		RENAME COLUMN nome_m TO nome_mae;

-- Alterando o tipo de dados de uma coluna
ALTER TABLE pessoa 
ALTER COLUMN nome_mae character;
-- Realizando a mesma operação no Postgres:
--		ALTER TABLE pessoa 
-- 		ALTER COLUMN nome_mae TYPE character;

-- Atribuindo valores default a uma coluna
ALTER TABLE pessoa
ADD DEFAULT 'NULO' FOR nome_mae;
-- Maneira recomendada de adicionar um valor padrão a uma coluna (nomeando a constraint)
ALTER TABLE pessoa ADD CONSTRAINT DF_NomeMae DEFAULT N'NULO' FOR nome_mae;
-- Realizando a mesma operação no Postgres:
--		ALTER TABLE pessoa 
--		ALTER COLUMN nome_mae
--		SET DEFAULT 'NULO';

-- Removendo o valor padrão de uma coluna no SQL server:
-- 		ALTER TABLE pessoa
-- 		DROP DEFAULT FOR nome_mae; -- não funciona! precisa saber o nome da constraint criada para essa coluna pelo SQL Server
-- Buscando informações da tabela pessoa:
sp_help pessoa;
-- Descobre o nome da constraint atribuída aleatoriamente pelo SQL Server para a coluna nome_mae: DF__pessoa__nome_mae__47DBAE45
-- (caso a constraint não tenha sido nomeada explicitamente)
ALTER TABLE pessoa 
DROP DF__pessoa__nome_mae__47DBAE45;
-- Realizando a mesma operação no Postgres:
--		ALTER TABLE pessoa 
--		ALTER COLUMN nome_mae
--		DROP DEFAULT;

-- Renomeando a tabela (alterando a tabela pessoa para tb_pessoa no esquema dbo)
EXEC sp_rename 'dbo.pessoa', 'tb_pessoa';
-- Realizando a mesma operação no Postgres:
--		ALTER TABLE pessoa
--		RENAME TO tb_pessoa;

-- Removendo uma coluna
ALTER TABLE tb_pessoa 
DROP COLUMN nome_mae;

-- Limpando todos os dados da tabela
TRUNCATE TABLE tb_pessoa;
-- Realizando a mesma operação no Postgres:
--		TRUNCATE tb_pessoa;

-- Removendo uma tabela
DROP TABLE tb_pessoa;

