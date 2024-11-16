select
	B.BookID,
    B.Title AS BookTitle,
    BR.BorrowerID,
    CONCAT(BR.FirstName, ' ', BR.LastName) AS BorrowerName,
    BR.Email AS BorrowerEmail,
    L.DateBorrowed,
    L.DueDate,
    DATEDIFF(DAY, L.DueDate, ISNULL(L.DateReturned, GETDATE())) AS OverdueDays
from
	Books B
Join
	Loans L ON B.BookID = L.BookID
join
	Borrowers BR ON L.BorrowerID = BR.BorrowerID
Where
	ISNULL(L.DateReturned, GETDATE()) > L.DueDate 
	AND DATEDIFF(DAY, L.DueDate, ISNULL(L.DateReturned, GETDATE())) > 30
Order by
	OverdueDays DESC;
