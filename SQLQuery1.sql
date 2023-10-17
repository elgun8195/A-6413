CREATE DATABASE ImdbDb
USE ImdbDb

CREATE TABLE Employee(
Id int primary key identity,
Fullname nvarchar(255) NOT NULL,
Age tinyint NOT NULL,
Email nvarchar(255) NOT NULL UNIQUE,  --ozum maksimum 255 eledim
Salary FLOAT CHECK(Salary BETWEEN 300 AND 2000) NOT NULL
)
DROP TABLE Employee


INSERT INTO Employee
VALUES('Elgun Qocayev',19,'eloqola@gmail.com',1500),
	('Qezenfer Allahveriyev',20,'qezenfer@gmail.com',1600),
		('Cefer Abbasov',21,'Ceferbb@gmail.com', 750),
			('Ilkin Memmedov',23,'ilkinmemmedov@gmail.com',1650),
				('Salmanli Resul',22,'resul1@gmail.com',1450),
					('Jale Memmedova',18,'jalmmd@gmail.com',1900)

INSERT INTO Employee
VALUES('ehedhe',11,'qezenfeüssr@gmail.com',1110.1) 


SELECT * FROM	Employee 

UPDATE Employee Set Salary=2000 WHERE Id=1

SELECT * FROM Employee WHERE Salary>=500 AND Salary<=1500

SELECT Fullname,Email,Salary FROM Employee   ORDER BY Salary DESC  -


CREATE TABLE Directors(
	Id INT PRIMARY KEY IDENTITY,
	Fullname NVARCHAR(100) NOT NULL
)

CREATE TABLE Movies(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(120) NOT NULL UNIQUE,
	RealeseDate DATETIME2 DEFAULT GETDATE(),
	Duration INT NOT NULL,
	Description NVARCHAR(500) NOT NULL,
	ImdbPoint FLOAT NOT NULL CHECK(ImdbPoint >= 0),
	DirectorId INT FOREIGN KEY REFERENCES Directors(Id)
)

CREATE TABLE Genres(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(100) NOT NULL UNIQUE
)

CREATE TABLE MovieGenres(
	Id INT PRIMARY KEY IDENTITY,
	MovieId INT FOREIGN KEY REFERENCES Movies(Id),
	GenreId INT FOREIGN KEY REFERENCES Genres(Id)
)

CREATE TABLE Actors(
	Id INT PRIMARY KEY IDENTITY,
	Fullname NVARCHAR(150) NOT NULL
)

CREATE TABLE MovieActors(
	Id INT PRIMARY KEY IDENTITY,
	MovieId INT FOREIGN KEY REFERENCES Movies(Id),
	ActorId INT FOREIGN KEY REFERENCES Actors(Id)
)

CREATE VIEW v_GetFullMoviesDetail
AS
SELECT M.Name 'Movie', 
	   M.ImdbPoint,
	   G.Name 'Genre',
	   D.Fullname 'Director',
	   A.Fullname 'Actor' 
FROM Movies AS M
JOIN MovieGenres AS MG
ON MG.MovieId = M.Id
JOIN Genres AS G
ON MG.GenreId = G.Id
JOIN Directors AS D
ON M.DirectorId = D.Id
JOIN MovieActors AS MA
ON MA.MovieId = M.Id
JOIN Actors AS A
ON MA.ActorId = A.Id

SELECT * FROM v_GetFullMoviesDetail
WHERE ImdbPoint >= 8.7