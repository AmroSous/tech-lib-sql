-- Popular Genre Analysis using Joins and Window Functions: 
-- Identify the most popular genre for a given month.

USE [LibraryManagement]
GO 

DECLARE @Year INT = 2023; 
DECLARE @Month INT = 10;

WITH GenrePopularity AS (
	SELECT 
		b.Genre AS Genre, 
		COUNT(l.LoanID) AS LoanCount
	FROM 
		[dbo].[Books] b
	JOIN 
		[dbo].[Loans] l ON b.BookID = l.BookID
	WHERE 
		YEAR(l.DateBorrowed) = @Year
		AND MONTH(l.DateBorrowed) = @Month 
	GROUP BY 
		b.Genre
), 
RankedGenres AS (
	SELECT 
		Genre,
		LoanCount,
		RANK() OVER (ORDER BY LoanCount DESC) AS GenreRank
	FROM 
		GenrePopularity
)

SELECT 
	Genre, 
	LoanCount, 
	GenreRank 
FROM 
	RankedGenres
WHERE 
	GenreRank = 1; -- this is the most popular genre