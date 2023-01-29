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



