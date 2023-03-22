/*
	This function is used to split the string from anything. Just we have to pass the separator
*/

CREATE FUNCTION [dbo].[SplitString]
(
	@Str		NVARCHAR(MAX),
	@Separator	CHAR(1)
)
RETURNS TABLE
AS
RETURN
(
	WITH Tokens(P, A, B)	AS
	(
		SELECT
			CAST(1 AS BIGINT),
			CAST(1 AS BIGINT),
			CHARINDEX(@Separator, @Str)
		UNION ALL
		SELECT
			P + 1,
			B + 1,
			CHARINDEX(@Separator, @Str, B + 1)
		FROM Tokens
		WHERE B > 0
	)
	SELECT
		P - 1		AS 'ItemIndex',
		SUBSTRING(@Str, A, CASE WHEN B > 0 THEN B - A ELSE LEN(@Str) END)		AS 'Item'
	FROM Tokens
);

/*
	Below is the example in which we are splitting the string on enter.
*/

GO

SELECT * FROM [dbo].[SplitString] ('God is One. 
Hare Krishna', CHAR(10))