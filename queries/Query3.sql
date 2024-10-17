-- Borrowing Frequency using Window Functions: Rank borrowers based on borrowing frequency.

USE [LibraryManagement]
GO

WITH BorrowingFrequency AS (
    SELECT 
        br.BorrowerID,
        br.FirstName,
        br.LastName,
        COUNT(l.LoanID) AS TotalBorrowed,
        ROW_NUMBER() OVER (ORDER BY COUNT(l.LoanID) DESC) AS BorrowerRank
    FROM 
        [dbo].[Borrowers] br
    LEFT JOIN 
        [dbo].[Loans] l ON br.BorrowerID = l.BorrowerID
    GROUP BY 
        br.BorrowerID, br.FirstName, br.LastName
)

SELECT 
    BorrowerID,
    FirstName,
    LastName,
    TotalBorrowed,
    BorrowerRank
FROM 
    BorrowingFrequency
ORDER BY 
    BorrowerRank; 
