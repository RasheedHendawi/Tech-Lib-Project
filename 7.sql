create function fn_BookBorrowingFrequency
(
	@BookID int
)
returns int
as
begin
	declare @BorrowingCount int;
	select 
		@BorrowingCount = COUNT(*)
	from
		Loans
	where BookID=@BookID;
	return @BorrowingCount;
end