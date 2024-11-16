create procedure sp_AddNewBorrower
@FirstName NVARCHAR(50),
@lastName NVARCHAR(50),
@Email NVARCHAR(100),
@DateOfBirth DATE,
@MemberShipDate DATE,
@NewBorrowerID INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (
	SELECT 1
	FROM Borrowers
	WHERE Email = @Email
	)
	BEGIN
	RAISERROR ('BORROWER WITH THIS EMAIL ALREADY EXISTS.',16,1);
	RETURN
	END

	INSERT INTO Borrowers VALUES(@FirstName,@lastName,@Email,@DateOfBirth,@MemberShipDate);
	SET @NewBorrowerID = SCOPE_IDENTITY();
	RETURN;
END
	


DECLARE @NewBorrower INT;

EXEC sp_AddNewBorrower
    @FirstName = 'RASHEED',
    @LastName = 'HENDAWI',
    @Email = 'RASHEED.HENDAWI@example.com',
    @DateOfBirth = '1990-05-15',
    @MembershipDate = '2023-11-14',
    @NewBorrowerID = @NewBorrower OUTPUT;

SELECT @NewBorrower AS NewBorrower;
