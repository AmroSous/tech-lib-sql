-- Stored Procedure - Add New Borrowers:
-- Procedure Name: sp_AddNewBorrower
-- Purpose: Streamline the process of adding a new borrower.
-- Parameters: FirstName, LastName, Email, DateOfBirth, MembershipDate.
-- Implementation: Check if an email exists; if not, add to Borrowers. If existing, return an error message.
-- Return: The new BorrowerID or an error message.

USE [LibraryManagement]
GO

CREATE PROCEDURE sp_AddNewBorrower
    @FirstName nchar(10),
    @LastName nchar(10),
    @Email nchar(50),
    @DateOfBirth date,
    @MembershipDate date,
    @NewBorrowerID numeric(18, 0) OUTPUT,
    @ErrorMessage nvarchar(255) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SET @NewBorrowerID = NULL;
    SET @ErrorMessage = NULL;

    IF EXISTS (SELECT 1 FROM [dbo].[Borrowers] WHERE Email = @Email)
    BEGIN
        SET @ErrorMessage = 'Error: Email already exists.';
        RETURN;
    END

    INSERT INTO [dbo].[Borrowers] (FirstName, LastName, Email, DateOfBirth, MembershipDate)
    VALUES (@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate);

    SET @NewBorrowerID = SCOPE_IDENTITY();
END
GO
