USE [LibraryManagement]
GO

-- Insert 1,000 rows of fictional data into the Borrowers table
DECLARE @Counter INT = 1;

WHILE @Counter <= 1000
BEGIN
    INSERT INTO [dbo].[Borrowers] ([BorrowerID], [FirstName], [LastName], [Email], [DateOfBirth], [MembershipDate])
    VALUES 
    (
        @Counter, 
        LEFT(NEWID(), 10), 
        LEFT(NEWID(), 10), 
        CONCAT(LEFT(NEWID(), 8), '@example.com'),
        DATEADD(DAY, -1 * (ABS(CHECKSUM(NEWID())) % 20000 + 6570), GETDATE()), 
        DATEADD(DAY, -1 * (ABS(CHECKSUM(NEWID())) % 3650), GETDATE()) 
    );

    SET @Counter = @Counter + 1;
END
GO
