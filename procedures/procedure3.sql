-- Database Function - Book Borrowing Frequency:
-- Function Name: fn_BookBorrowingFrequency
-- Purpose: Gauge the borrowing frequency of a book.
-- Parameter: BookID
-- Implementation: Count the number of times the book has been issued.
-- Return: Borrowing count of the book.

USE [LibraryManagement]
GO

CREATE FUNCTION dbo.fn_BookBorrowingFrequency
(
    @BookID numeric(18, 0) 
)
RETURNS int 
AS
BEGIN
    DECLARE @BorrowingCount int; 

    SELECT @BorrowingCount = COUNT(*)
    FROM dbo.Loans
    WHERE BookID = @BookID;

    RETURN @BorrowingCount;
END
GO
