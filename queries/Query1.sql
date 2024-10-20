-- List of Borrowed Books: Retrieve all books borrowed by a specific borrower, 
-- including those currently unreturned.

USE [LibraryManagement]
GO

-- Specific borrower ID 
DECLARE @BorrowerID NUMERIC(18, 0) = 5;

SELECT 
    b.[BookID],
    b.[Title],
    b.[Author],
    b.[ISBN],
    l.[DateBorrowed],
    l.[DueDate],
    l.[DateReturned],
    CASE 
        WHEN l.[DateReturned] IS NULL THEN 'Currently Borrowed'
        ELSE 'Returned'
    END AS [LoanStatus]
FROM 
    [dbo].[Loans] l
JOIN 
    [dbo].[Books] b ON l.[BookID] = b.[BookID]
JOIN 
    [dbo].[Borrowers] br ON l.[BorrowerID] = br.[BorrowerID]
WHERE 
    br.[BorrowerID] = @BorrowerID;
