# trilha-net-banco-de-dados

Repositório com scripts para prática com SQL Server e o Microsoft SQL Server Management Studio baseado no projeto da [trilha-net-banco-de-dados](https://github.com/digitalinnovationone/trilha-net-banco-de-dados) da Digital Innovation One.

### 1. Ordenando os resultados

Dado uma tabela Clientes, podemos visualizar seu conteúdo usando a função SELECT, e eles estarão ordenados usando ORDER BY e a propriedade de interesse (nome, sobrenome, email, etc), podendo, inclusive, ordenar usando múltiplas propriedades, como no exemplo abaixo:

```sql
SELECT * FROM Clientes
ORDER BY Nome, Sobrenome
```

Podemos definir a ordem ascendente ou decrescente de como os dados devem ser visualizados (por padrão é crescente - ASC)

```sql
SELECT * FROM Clientes
ORDER BY Nome DESC
```

### 2. Refinando a busca com WHERE

Podemos usar a função WHERE para reduzir a quantidade de resultados a partir de uma determinada característica de interesse.

```sql
SELECT * FROM Clientes
WHERE Nome = 'Adam' AND Sobrenome = 'Reynolds'
ORDER BY Nome, Sobrenome
```

No exemplo acima, selecionamos todos os resultados da tabela Cliente onde que contenham o campo Nome igual a 'Adam'e Sobrenome igual a 'Reynolds'.

### 3. Retornando resultados específicos com LIKE

Facilita a busca quando se deseja obter dados que atendam a uma determinada característica. No exemplo abaixo, a query resulta em todos os clientes que iniciem com a letra 'G' (case insensitive).

```sql
SELECT * FROM Clientes
WHERE Nome LIKE 'G%'
ORDER BY Nome, Sobrenome
```

### 4. Realizando um INSERT

Para realizar um INSERT, é necessário as funções INSERT INTO, a tabela na qual se deseja inserir, e os valores.

```sql
INSERT INTO Clientes (Nome, Sobrenome, Email, AceitaComunicados, DataCadastro)
VALUES ('Thyago', 'Freitas', 'thyago.olifreitas@gmail.com', 1, GETDATE())
```

Os nomes das colunas no insert é opcional, porém caso não esteja explícito, deve-se obedecer a ordem dos campos que está na tabela. Por exemplo, a seguinte query tem um resultado equivalente ao anterior:

```sql
INSERT INTO Clientes VALUES ('Thyago', 'Freitas', 'thyago.olifreitas@gmail.com', 1, GETDATE())
```

Caso escreva os nomes dos campos no INSERT, é possível modificar a ordem dos campos no valor inserido sem modificar no resultado. Por exemplo, a seguinte query também dará uma saída equivalente as anteriores:

```sql
INSERT INTO Clientes (Sobrenome, Nome, DataCadastro, Email, AceitaComunicados)
VALUES ('Freitas', 'Thyago', GETDATE(), 'thyago.olifreitas@gmail.com', 1)
```

Porém, a seguinte query resultará em erro:

```sql
INSERT INTO Clientes VALUES ('Freitas', 'Thyago', GETDATE(), 'thyago.olifreitas@gmail.com', 1)
```

### 5. Atualizando uma entrada com UPDATE

A função UPDATE requer a tabela e as colunas com os dados que devem ser alterados. Tenha cuidado para restringir adequadamente a entrada usando o WHERE, senão corre risco de alterar todos os dados da tabela (o famoso update sem where).

```sql
UPDATE Clientes
SET Email = 'emailatualizado@gmail.com',
    AceitaComunicados = 0
WHERE Id = 12
```

### 6. Deletando um registro

A função DELETE requer apenas a tabela, mas é importante definir quais as entradas específicas que devem ser removidas, caso contrário há risco de remover todos os dados.

```sql
DELETE Clientes
WHERE Id = 12
```

### 7. Criando breakpoints usando BEGIN TRAN e ROLLBACK

Funções específicas, como UPDATE e DELETE podem trazer riscos consideráveis aos dados armazenados. Por isso, é importante usar essas funções de forma responsável. Uma das formas de aplicá-las de forma a diminuir seu impacto é utilizando um breakpoint, ou seja, uma maneira de retornar ao estado anterior da operação, de forma que o programador consiga testar se a mudança feita no banco de dados é a de fato pretendida. Podemos utilizar o rollback da seguinte forma:

```sql
BEGIN TRAN
DELETE Clientes
WHERE Id = 12
ROLLBACK
```

### 8. Contando a quantidade de registros com COUNT

Em tabelas com muitos registros, fica inviável saber a quantidade de entradas apenas "rolando" pela interface do Management Studio, então podemos usar a função COUNT para retornar a quantidade de registros, e podemos usar a função WHERE para saber o número de entradas que atendam determinadas características.

```sql
SELECT COUNT(*) QuantidadeProdutos FROM Produtos

SELECT COUNT(*) QuantidadeProdutosTamanhoM FROM Produtos WHERE Tamanho = 'M'
```

OBS.: Os campos 'QuantidadeProdutos' e 'QuantidadeProdutosTamanhoM' são opcionais, servem para criar um nome para a coluna com o resultado da função COUNT.


### 9. Somando valores com SUM

A função SUM recebe como entrada uma coluna da tabela cujos valores sejam numéricos e retorna a sua soma. Semelhante às funções anteriores, podemos usar WHERE para somar registros que atendam a determinadas características.

```sql
SELECT SUM(Preco) PrecoTotal FROM Produtos

SELECT SUM(Preco) PrecoProdutosTamanhoM FROM Produtos WHERE Tamanho = 'M'
```

### 10. Calculando máximo, mínimo e média com MAX, MIN e AVG

Semelhante a função SUM, podemos calcular os valores máximo, mínimo e média com MAX, MIN e AVG respectivamente, em colunas com valores numéricos.

```sql
SELECT MAX(Preco) ProdutoMaisCaro FROM Produtos

SELECT MAX(Preco) ProdutoMaisCaroTamanhoM FROM Produtos WHERE Tamanho = 'M'

SELECT MIN(Preco) ProdutoMaisBarato FROM Produtos

SELECT MIN(Preco) ProdutoMaisBaratoTamanhoM FROM Produtos WHERE Tamanho = 'M'

SELECT AVG(Preco) MediaPrecoProdutos FROM Produtos
```

### 11. Concatenando colunas

Podemos usar a chamada da função SELECT para definir como os dados serão retornados. No exemplo abaixo, é possível concatenar as colunas 'Nome' e 'Cor' em uma nova coluna denominada 'NomeCorProduto' com ambos os dados.

```sql
SELECT 
	'Nome: ' + Nome + ' Cor: ' + Cor NomeCorProduto
FROM Produtos
```

### 12. Tornando nomes maiúsculos ou minúsculos com UPPER e LOWER

```sql
SELECT 
	UPPER(Nome) NomeMaiusculo,
	LOWER(Cor) CorMinusculo
FROM Produtos
```

### 13. Adicionando uma nova coluna a tabela

Utilizando o Management Studio, é possível adicionar uma nova coluna de forma visual, ou alternativamente, podemos utilizar a função ADD para adicionar uma nova coluna alterando a tabela.

```sql
ALTER TABLE Produtos
ADD DataCadastro DATETIME2
```

### 14. Formatando uma data

Às vezes é necessário obter um formato de data em um padrão diferente do que foi gravado no banco de dados, então podemos usar a função FORMAT passando um formato definido para retornar o resultado desejado.

```sql
SELECT 
	UPPER(Nome) NomeMaiusculo,
	LOWER(Cor) CorMinusculo,
	FORMAT(DataCadastro, 'dd-MM-yyyy') DataCadastroPadraoBR
FROM Produtos
```

### 15. Agrupando dados usando GROUP BY

No exemplo abaixo, queremos uma tabela que mostre os tamanhos dos produtos e a quantidade de produtos de cada tamanho, ordenado pela quantidade. O operador '<>' é igual a '!=', e significa que os produtos onde o campo tamanho é vazio não serão incluídos no resultado.

```sql
SELECT
	Tamanho,
	COUNT(*) Quantidade
FROM Produtos
WHERE Tamanho <> ''
GROUP BY Tamanho 
ORDER BY Quantidade
```

### 16. Criando uma tabela

Na situação onde, por exemplo, desejamos acrescentar um endereço ao cliente, podemos alterar a tabela cliente para que contenha os novos dados. Porém, caso os clientes antigos não tenham endereço, a nova tabela terá vários campos nulos, e um cliente com mais de um endereço criaria uma redundância desnecessária. Para resolver esse problema, podemos criar uma tabela de endereços, com o id do cliente sendo uma chave estrangeira dessa nova tabela.

```sql
CREATE TABLE Enderecos (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	IdCliente int NULL,
	Rua varchar(255) NULL,
	Bairro varchar(255) NULL,
	Cidade varchar(255) NULL,
	Estado char(2) NULL,

	CONSTRAINT FK_Enderecos_Clientes FOREIGN KEY(IdCliente)
	REFERENCES Clientes(Id)
)
```

### 17. Realizando um JOIN

De acordo com o caso anterior, agora ha duas tabelas contendo as informações completas dos clientes (Clientes e Enderecos). Porém, podemos retornar essas informações no mesmo resultado unindo as tabelas usando JOIN através de um campo em comum entre elas, que geralmente trata-se do conjunto chave primária e chave estrangeira. No exemplo abaixo, para obter as informações completas do cliente de id = 4, une-se as tabelas usando a chave primária Id de clientes e a chave estrangeira IdCliente de enderecos.

```sql
SELECT * FROM Clientes
INNER JOIN Enderecos ON Clientes.Id = Enderecos.IdCliente
WHERE Clientes.Id = 4
```

Porém, usando essa abordagem, o resultado terá o id de ambas as tabelas. Para especificar como desejamos a resposta, podemos explicitar os campos de interesse:

```sql
SELECT
	Clientes.Nome,
	Clientes.Sobrenome,
	Clientes.Email,
	Enderecos.Rua,
	Enderecos.Bairro,
	Enderecos.Cidade,
	Enderecos.Estado
FROM 
	Clientes
INNER JOIN Enderecos ON Clientes.Id = Enderecos.IdCliente
WHERE Clientes.Id = 4
```

Utilizando C e E como alias para Clientes e Enderecos, podemos definir a query da seguinte forma:

```sql
SELECT
	C.Nome,
	C.Sobrenome,
	C.Email,
	E.Rua,
	E.Bairro,
	E.Cidade,
	E.Estado
FROM 
	Clientes C
INNER JOIN Enderecos E ON C.Id = E.IdCliente
WHERE C.Id = 4
```

### 18. Adicionando regras com ***constraints***

Constraints são restrições criadas no banco de dados para impedir que dados inválidos sejam cadastrados, garantindo a sua qualidade e integridade. 

1. **NOT NULL**

   A constraint NOT NULL faz com que o banco de dados não aceite dados cujo determinado campo seja nulo ou omitido. No exemplo abaixo, os campos Id, Nome e Preco possuem essa constraint, e portanto, são obrigatórios.


    ```sql
    CREATE TABLE Produtos (
        Id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
        Nome varchar(255) NOT NULL,
        Cor varchar(50) NULL,
        Preco decimal(13, 2) NOT NULL,
        Tamanho varchar(5) NULL,
        Genero char(1) NULL
    )
    ```

2. **UNIQUE**

    A constraint UNIQUE identifica de forma única cada registro em uma tabela de um banco de dados. No exemplo acima, a coluna Nome pode ser considerada UNIQUE (cada produto tem um único nome). Nesse caso, podemos alterar a tabela Produtos da seguinte forma:

    ```sql
    ALTER TABLE Produtos
    ADD UNIQUE(Nome)
    ```

3. **CHECK**

    A constraint CHECK define uma condição que cada linha deve atender. Por exemplo, no caso acima, pode-se atribuir qualquer letra para o gênero, mas para restringir para três casos (unissex, masculino e feminino), podemos escrever a seguinte condição com CHECK:

    ```sql
    ALTER TABLE Produtos
    ADD CHECK(Genero = 'U' OR Genero = 'M' OR Genero = 'F')
    ```

    Podemos ainda atribuir nomes às constraints da seguinte forma:

    ```sql
    ALTER TABLE Produtos
    ADD CONSTRAINT CHK_ColunaGenero CHECK(Genero = 'U' OR Genero = 'M' OR Genero = 'F')
    ```

4. **DEFAULT**

    A constraint DEFAULT é usada para inserir um valor padrão especificado em uma coluna. O valor padrão será adicionado a todos os novos registros caso nenhum outro valor seja especificado na hora de inserir dados. No exemplo acima, digamos que por padrão, a coluna DataCadastro da tabela Produtos recebe a data atual. Portanto, podemos alterar a tabela da seguinte forma:

    ```sql
    ALTER TABLE Produtos
    ADD DEFAULT GETDATE() FOR DataCadastro
    ```

5. ***PRIMARY KEY e FOREIGN KEY***

    A constraint PRIMARY KEY (Chave Primária) identifica de forma única cada registro em uma tabela de banco de dados. Ela deve sempre conter valores únicos e geralmente se refere ao id. Uma FOREIGN KEY (Chave Estrangeira) em uma tabela é um campo que aponta para uma chave primária em outra tabela. Desta forma, é usada para criar os relacionamentos entre as tabelas no banco de dados.

### 19. Apagando uma ***constraint***

Digamos que em uma determinada etapa do desenvolvimento, definimos que o gênero do produto só poderia ser definido por três letras, assim como explicamos anteriormente:

```sql
ALTER TABLE Produtos
ADD CONSTRAINT CHK_ColunaGenero CHECK(Genero = 'U' OR Genero = 'M' OR Genero = 'F')
```

Porém, descobriu-se que essa regra não faz mais sentido. Então, podemos remover a regra da seguinte forma:

```sql
ALTER TABLE Produtos
DROP CONSTRAINT CHK_ColunaGenero
```

Caso a constraint não tenha sido nomeada, será necessário descobrir qual foi o nome que o banco de dados atribuiu a mesma.


### 20. Criando ***Stored Procedures***

Stored procedures são funções que utilizamos para otimizar o processo de tarefas repetitivas, como inserção de registros. Abaixo há um exemplo de procedure para inserção de um novo produto no banco de dados:

```sql
CREATE PROCEDURE InserirNovoProduto
@Nome varchar(255),
@Cor varchar(50),
@Preco decimal,
@Tamanho varchar(5),
@Genero char(1)

AS

INSERT INTO Produtos (Nome, Cor, Preco, Tamanho, Genero)
VALUES (@Nome, @Cor, @Preco, @Tamanho, @Genero)
```

Com a procecdure acima, para inserir um novo produto podemos fazer:

```sql
EXEC InserirNovoProduto
    'Nome do novo produto',
    'COLORIDO',
    50,
    'G',
    'U'
```

Alternativamente, podemos escrever:

```sql
EXEC InserirNovoProduto
    @Nome = 'Nome do novo produto',
    @Cor = 'COLORIDO',
    @Preco = 50,
    @Tamanho = 'G',
    @Genero = 'U'
```

Também é possível criar uma procedure para facilitar uma busca recorrente no lugar do SELECT. Por exemplo, a seguinte query:

```sql
SELECT * FROM Produtos WHERE Tamanho = 'M'
```

Pode ser escrita na forma de procedure da seguinte maneira:

```sql
CREATE PROCEDURE ObterProdutosPorTamanho
@TamanhoProduto VARCHAR(5)

AS

SELECT * FROM Produtos WHERE Tamanho = @TamanhoProduto
```

Então podemos executar a procedure da seguinte forma:

```sql
EXEC ObterProdutosPorTamanho 'M'
```

Para obter todos os produtos, podemos escrever a seguinte procedure:

```sql
CREATE PROCEDURE ObterTodosProdutos
AS
SELECT * FROM Produtos
```

### 21. Functions

Functions são semelhantes a procedures no sentido de que podem ser salvas diretamente no banco de dados, porém aceitam apenas entradas como parâmetros e sempre devem ter retorno. Por exemplo, digamos que queremos uma função que calcule um desconto no preço do produto. Podemos escrevê-la da seguinte forma:

```sql
CREATE FUNCTION CalcularDesconto(@Preco DECIMAL(13, 2), @Porcentagem INT)
RETURNS DECIMAL(13,2)

BEGIN
    RETURN @Preco - @Preco / 100 * @Porcentagem
END
```

Aplicando um desconto de 10% em todos os produtos de tamanho M, temos:

```sql
SELECT
    Nome,
    Preco,
    dbo.CalcularDesconto(Preco, 10) PrecoComDesconto
FROM Produtos WHERE Tamanho = 'M'
```

### 22. Comandos DDL (*Data Definition Language*)

1. **CREATE TABLE**
    Sintaxe:
    ```sql
    CREATE TABLE nome_tabela (campo e tipo campo)
    ```
    Exemplo:
    ```sql
    CREATE TABLE tb_pessoa(
        id bigint,
        nome varchar(50),
        endereco text,
        telefone int
    );
    ```

2. **DROP TABLE**
    Sintaxe:
    ```sql
    DROP TABLE nome_tabela
    ```
    Exemplo:
    ```sql
    DROP TABLE tb_pessoa
    ```

3. **ALTER TABLE**
    Sintaxe:
    ```sql
    ALTER TABLE nome_tabela
    ```
    Exemplo:
    ```sql
    ALTER TABLE tb_pessoa
    ADD COLUMN sexo boolean; -- Postgres
    ADD sexo BIT             -- SQL Server, não existe dado do tipo booleano
    ```

4. **TRUNCATE**



