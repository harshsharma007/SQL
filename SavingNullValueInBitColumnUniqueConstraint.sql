CREATE TABLE #Employee
(
	Id		INT,
	Name	VARCHAR(10),
	Gender	BIT UNIQUE
)

INSERT INTO #Employee VALUES (1, 'A', null)
INSERT INTO #Employee VALUES (1, 'A', 0)
INSERT INTO #Employee VALUES (1, 'B', 1)

SELECT MAX(Name), Name FROM #Employee HAVING COUNT(Name) > 1