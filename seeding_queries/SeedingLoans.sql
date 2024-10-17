USE [LibraryManagement]
GO

-- Insert 1,000 rows of fictional data into the Loans table
DECLARE @Counter INT = 1;

WHILE @Counter <= 1000
BEGIN
    DECLARE @BorrowerID INT = (SELECT TOP 1 BorrowerID FROM [dbo].[Borrowers] ORDER BY NEWID());
    DECLARE @BookID INT = (SELECT TOP 1 BookID FROM [dbo].[Books] ORDER BY NEWID());
    DECLARE @DateBorrowed DATE = DATEADD(DAY, -1 * (ABS(CHECKSUM(NEWID())) % 365), GETDATE()); 
    DECLARE @DueDate DATE = DATEADD(DAY, 14, @DateBorrowed); -- Due date is 14 days after DateBorrowed
    DECLARE @DateReturned DATE = 
        CASE 
            WHEN ABS(CHECKSUM(NEWID())) % 2 = 0 THEN DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 30, @DueDate) 
            ELSE NULL 
        END;

    INSERT INTO [dbo].[Loans] ([LoanID], [BorrowerID], [BookID], [DateBorrowed], [DueDate], [DateReturned])
    VALUES 
    (
        @Counter, 
        @BorrowerID,
        @BookID, 
        @DateBorrowed,
        @DueDate, 
        @DateReturned 
    );

    SET @Counter = @Counter + 1;
END
GO
