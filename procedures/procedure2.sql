-- Database Function - Calculate Overdue Fees:
-- Function Name: fn_CalculateOverdueFees
-- Purpose: Compute overdue fees for a given loan.
-- Parameter: LoanID
-- Implementation: Charge fees based on overdue days: $1/day for up to 30 days, $2/day after.
-- Return: Overdue fee for the LoanID.

USE [LibraryManagement]
GO

CREATE FUNCTION dbo.fn_CalculateOverdueFees
(
    @LoanID numeric(18, 0) 
)
RETURNS decimal(10, 2)  
AS
BEGIN
    DECLARE @DueDate date;         
    DECLARE @DateReturned date;    
    DECLARE @CurrentDate date;    
    DECLARE @OverdueDays int;     
    DECLARE @Fee decimal(10, 2); 

    SET @CurrentDate = GETDATE(); 

    SELECT 
        @DueDate = DueDate, 
        @DateReturned = DateReturned 
    FROM dbo.Loans 
    WHERE LoanID = @LoanID;

    IF @DateReturned IS NULL 
    BEGIN
        SET @OverdueDays = DATEDIFF(DAY, @DueDate, @CurrentDate);
    END
    ELSE
    BEGIN
        SET @OverdueDays = 0;  
    END

    IF @OverdueDays > 0
    BEGIN
        IF @OverdueDays <= 30
        BEGIN
            SET @Fee = @OverdueDays * 1.00; 
        END
        ELSE
        BEGIN
            SET @Fee = (30 * 1.00) + ((@OverdueDays - 30) * 2.00);
        END
    END
    ELSE
    BEGIN
        SET @Fee = 0.00; 
    END

    RETURN @Fee; 
END
GO
