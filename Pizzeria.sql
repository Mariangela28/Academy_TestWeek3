CREATE DATABASE PizzeriaDaLuigi

CREATE TABLE Pizza(
Codice_Pizza INT IDENTITY(1, 1),
Nome VARCHAR(50) NOT NULL,
Prezzo DECIMAL(4,2) NOT NULL,
CONSTRAINT PK_Pizza PRIMARY KEY (Codice_Pizza)

);

CREATE TABLE Ingrediente(
Codice_Ingrediente INT IDENTITY (1, 1),
Nome VARCHAR (50) NOT NULL,
Costo DECIMAL(4,2) NOT NULL,
Scorte INT,
CONSTRAINT PK_Ingrediente PRIMARY KEY (Codice_Ingrediente),

);


CREATE TABLE Pizza_Ingrediente(
CODICE_INGREDIENTE INT NOT NULL,
CODICE_PIZZA INT NOT NULL,
CONSTRAINT FK_Ingrediente FOREIGN KEY (CODICE_INGREDIENTE) REFERENCES Ingrediente(Codice_Ingrediente),
CONSTRAINT FK_Pizza FOREIGN KEY (CODICE_PIZZA) REFERENCES Pizza(Codice_Pizza)
);

CREATE INDEX Pizze_NDX
ON Pizza(Nome ASC)

CREATE INDEX Ingredienti_NDX
ON Ingrediente(Codice_Ingrediente ASC)

INSERT INTO Pizza VALUES ('Margherita', 5.0);
INSERT INTO Pizza VALUES ('Bufala', 7.0);
INSERT INTO Pizza VALUES ('Diavola', 6.0);
INSERT INTO Pizza VALUES ('Quattro stagioni', 6.5);
INSERT INTO Pizza VALUES ('Porcini', 7.0);
INSERT INTO Pizza VALUES ('Dioniso', 8.0);
INSERT INTO Pizza VALUES ('Ortolana', 8.0);
INSERT INTO Pizza VALUES ('Patate e salsiccia', 6.0);
INSERT INTO Pizza VALUES ('Pomodorini', 6.0);
INSERT INTO Pizza VALUES ('Quattro formaggi', 7.5);
INSERT INTO Pizza VALUES ('Caprese', 7.5);
INSERT INTO Pizza VALUES ('Zeus', 7.5);
INSERT INTO Ingrediente VALUES ('Pomodoro', 0.5, 20);
INSERT INTO Ingrediente VALUES ('Pomodoro', 0.5, 20);
INSERT INTO Ingrediente VALUES ('Pomodoro', 0.5, 20);
INSERT INTO Ingrediente VALUES ('Pomodoro', 0.5, 20);
INSERT INTO Ingrediente VALUES ('Pomodoro', 0.5, 20);
INSERT INTO Ingrediente VALUES ('Pomodoro', 0.5, 20);
INSERT INTO Ingrediente VALUES ('Pomodoro', 0.5, 20);
INSERT INTO Ingrediente VALUES ('Mozzarella', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Mozzarella', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Mozzarella', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Mozzarella', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Mozzarella', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Mozzarella', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Mozzarella', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Mozzarella', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Mozzarella', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Mozzarella', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Mozzarella', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Mozzarella di Bufala', 2.0, 10);
INSERT INTO Ingrediente VALUES ('Spianata piccante', 7.0, 5);
INSERT INTO Ingrediente VALUES ('Funghi', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Carciofi', 2.0, 30);
INSERT INTO Ingrediente VALUES ('Cotto', 3.0, 30);
INSERT INTO Ingrediente VALUES ('Olive', 0.5, 10);
INSERT INTO Ingrediente VALUES ('Funghi porcini', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Stracchino', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Speck', 5.0, 20);
INSERT INTO Ingrediente VALUES ('Rucola', 1.0, 30);
INSERT INTO Ingrediente VALUES ('Grana', 3.0, 10);
INSERT INTO Ingrediente VALUES ('Verdure di stagione', 2.0, 10);
INSERT INTO Ingrediente VALUES ('Patate', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Salsiccia', 3.0, 7);
INSERT INTO Ingrediente VALUES ('Pomodorini', 1.0, 50);
INSERT INTO Ingrediente VALUES ('Ricotta', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Provola', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Gorgonzola', 15.0, 10);
INSERT INTO Ingrediente VALUES ('Grana', 10.0, 10);
INSERT INTO Ingrediente VALUES ('Pomodoro fresco', 1.0, 50);
INSERT INTO Ingrediente VALUES ('Basilico', 1.0, 10);
INSERT INTO Ingrediente VALUES ('Bresaola', 10.0, 20);
INSERT INTO Ingrediente VALUES ('Rucola', 1.0, 20);

INSERT INTO Pizza_Ingrediente VALUES (1, 1)
INSERT INTO Pizza_Ingrediente VALUES (1, 8)



SELECT * FROM Pizza
SELECT * FROM Ingrediente
SELECT * FROM Pizza_Ingrediente

--PROCEDURE
--Inserimento nuova pizza(nome, prezzo)
CREATE PROCEDURE [InserimentoPizza] 
@Nome VARCHAR(50), 
@Prezzo DECIMAL(4,2)
AS
BEGIN
begin try

INSERT INTO Pizza VALUES (@Nome, @Prezzo)
end try
begin catch
SELECT ERROR_LINE(), ERROR_MESSAGE(), ERROR_SEVERITY()
END CATCH
END

EXEC [InserimentoPizza]  'Fresca', 6.50

--Assegnazione di un ingrediente a una pizza (codice pizza, codice ingrediente)
CREATE PROCEDURE [InserisciIngrediente]
@codicePizza INT,
@codiceIngrediente INT
AS
BEGIN
begin try
DECLARE @CodicePizza INT
DECLARE @CodiceIngrediente INT
SELECT @Ingrediente = CodiceIngrediente
FROM Ingrediente i 
WHERE i.Codice_Ingrediente = @codiceIngrediente 
SELECT @codicePizza = p.Codice_Pizza
from Pizza p
where p.Nome = @codicePizza
INSERT INTO Pizza_Ingrediente values (@codiceIngrediente, @codicePizza)
end try
begin catch
SELECT ERROR_LINE(), ERROR_MESSAGE(), ERROR_SEVERITY()
end catch
END 

--Eliminazione di un ingrediente da una pizza(codice pizza, codice ingrediente)
CREATE PROCEDURE [EliminazioneIngrediente]
@Codice_Pizza INT,
@Codice_Ingrediente INT
AS
BEGIN
BEGIN TRY
DELETE FROM Pizza_Ingrediente
WHERE CODICE_INGREDIENTE = @CodiceIngrediente and CODICE_PIZZA = @CodicePizza
END TRY
BEGIN CATCH
SELECT ERROR_LINE(), ERROR_MESSAGE()
 
END CATCH
END

EXEC [EliminazioneIngrediente] @Codice_Ingrediente = 'Speck'


--incremento 
--???


--FUNZIONI
--tabella listino pizze ordinato alfabeticamente(nessun parametro)
CREATE FUNCTION Listino_Pizze()
RETURNS TABLE
AS
RETURN
SELECT p.Nome, p.Prezzo
FROM Pizza p


SELECT * FROM dbo.Listino_Pizze()
ORDER BY Nome

--tabella listino pizze (nome , prezzo) contenenti un ingrediente (codice, ingrediente)
CREATE FUNCTION ListaPizze(@codice_ingrediente)
RETURNS TABLE 
AS
RETURN
SELECT p.Nome, p.Prezzo
FROM Pizza p
JOIN Pizza_Ingrediente i
ON i.Codice_Pizza = p.Codice_Pizza
WHERE i.CODICE_INGREDIENTE = @codice_ingrediente

SELECT * FROM dbo.ListaPizze 

--tabella listno pizze che non contengono un certo ingrediente (codice, ingrediente)
CREATE FUNCTION ListaPizzeSenzaI(@codice_ingrediente)
RETURNS TABLE 
AS
RETURN
SELECT p.Nome, p.Prezzo
FROM Pizza p
JOIN Pizza_Ingrediente i
ON i.CODICE_PIZZA = p.Codice_Pizza
WHERE p.Nome NOT IN
(
SELECT Nome
FROM dbo.Lista_Pizze(@codice_ingrediente)
)
SELECT * FROM dbo.ListaPizzeSenzaI(1)

--calcolo numero pizze contenenti un ingrediente(codice ingrediente)
CREATE FUNCTION Numero_Pizze(@ingrediente INT)
RETURNS INT
AS
BEGIN
DECLARE @nPizze int
SELECT @nPizze = count(*)
FROM Pizza as p
JOIN Pizza_Ingrediente as i
ON p.Codice_Pizza = i.CODICE_PIZZA
JOIN Ingrediente in
ON i.CODICE_INGREDIENTE = in.Codice_ingrediente
WHERE i.Nome = @ingrediente
RETURN @nPizze
END

SELECT dbo.Numero_Pizze(1)

--calcolo numero pizze non contenenti un ingrediente(codice ingrediente)
CREATE FUNCTION Numero_PizzeSenza(@ingrediente INT)
RETURNS INT
AS
BEGIN
DECLARE @nPizze int
SELECT @nPizze = count(*)
FROM Pizza as p
JOIN Pizza_Ingrediente as i
ON p.Codice_Pizza = i.CODICE_PIZZA
JOIN Ingrediente in
ON i.CODICE_INGREDIENTE = in.Codice_ingrediente
WHERE i.Nome = @ingrediente
RETURN @nPizze
END
SELECT dbo.Numero_PizzeSenza(1)

--calcolo numero ingredienti contenuto in una pizza
CREATE FUNCTION ContaIngredienti(@codice_pizza INT)
RETURNS INT
AS BEGIN
DECLARE
@NIngredienti int
SELECT @NIngredienti = count(*)
FROM
(
SELECT *
FROM Pizza_Ingrediente ing
WHERE ing.CODICE_PIZZA = @codice_pizza
) ingredienti
return @NIngredienti
END



--realizzare una view che rappresenta il menu con tutte le pizze
CREATE VIEW [Menu] 
AS 
SELECT p.Nome as 'Nome pizza', p.Prezzo, i.Nome AS 'Ingredienti'
FROM dbo.Pizza AS p
JOIN dbo.Ingrediente AS i
ON i.CODICE_PIZZA = p.Codice_Pizza

SELECT * FROM [Menu]


