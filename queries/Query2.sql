-- Active Borrowers with CTEs: Identify borrowers who've borrowed 2 or more books 
-- but haven't returned any using CTEs.

USE [LibraryManagement]
GO

WITH BorrowedBooks AS (
    SELECT 
        br.BorrowerID,
        br.FirstName,
        br.LastName,
        COUNT(l.LoanID) AS BookCount
    FROM 
        [dbo].[Borrowers] br
    JOIN 
        [dbo].[Loans] l ON br.BorrowerID = l.BorrowerID
    WHERE 
        l.DateReturned IS NULL
    GROUP BY 
        br.BorrowerID, br.FirstName, br.LastName
)

SELECT 
    BorrowerID,
    FirstName,
    LastName,
    BookCount
FROM 
    BorrowedBooks
WHERE 
    BookCount >= 2;
