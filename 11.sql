create procedure sp_BorrowedBooksReport
	@StartDate DATE,
	@EndDate DATE
as
begin
	set nocount on;
	select
	B.BookID,
    B.Title AS BookTitle,
    CONCAT(BR.FirstName, ' ', BR.LastName) AS BorrowerName,
    BR.Email AS BorrowerEmail,
    L.DateBorrowed,
    L.DueDate,
    ISNULL(L.DateReturned, 'Not Returned') AS DateReturned
    FROM 
        Books B
    JOIN 
        Loans L ON B.BookID = L.BookID
    JOIN 
        Borrowers BR ON L.BorrowerID = BR.BorrowerID
    WHERE 
        L.DateBorrowed BETWEEN @StartDate AND @EndDate
    ORDER BY 
        L.DateBorrowed ASC;
end;
