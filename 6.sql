CREATE FUNCTION fn_CalculateOverdueFees
(
	@LoanID INT
)
RETURNS DECIMAL (10,2)
AS
BEGIN
	DECLARE @DueDate DATE;
	DECLARE @DateReturned DATE;
	DECLARE @OverdueDays INT;
	DECLARE @Fee DECIMAL(10,2) = 0;

	SELECT
		@DueDate = DueDate,
		@DateReturned = ISNULL(DateReturned,GETDATE())
	From
		Loans
	Where
		LoanID = @LoanID

	set @OverdueDays = DATEDIFF(DAY, @DueDate, @DateReturned);
	if @OverdueDays > 0
	Begin
		if @OverdueDays<=30
			set @Fee=@OverdueDays;
			else
			set @Fee = 30*1 + (@OverdueDays-30)*2;
	end
	return @Fee
end



