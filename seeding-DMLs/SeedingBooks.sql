USE [LibraryManagement]
GO

-- Insert 1,000 rows of fictional data into the Books table
DECLARE @Counter INT = 1;

WHILE @Counter <= 1000
BEGIN
    INSERT INTO [dbo].[Books] ([BookID], [Title], [Author], [ISBN], [PublishedDate], [Genre], [ShelfLocation], [CurrentStatus])
    VALUES 
    (
        @Counter,
        LEFT(NEWID(), 10), 
        LEFT(NEWID(), 10), 
        ABS(CHECKSUM(NEWID())) % 1000000000000, 
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 10000, '2000-01-01'), 
        CASE ABS(CHECKSUM(NEWID())) % 5
            WHEN 0 THEN 'Fiction    '
            WHEN 1 THEN 'NonFiction '
            WHEN 2 THEN 'SciFi      '
            WHEN 3 THEN 'History    '
            ELSE 'Mystery    '
        END,
        CONCAT('Shelf', ABS(CHECKSUM(NEWID())) % 100),
        CASE ABS(CHECKSUM(NEWID())) % 2
            WHEN 0 THEN 'Available '
            ELSE 'Borrowed  '
        END
    );

    SET @Counter = @Counter + 1;
END
GO
