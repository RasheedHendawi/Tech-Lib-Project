WITH BorrowedBooks AS (
    SELECT 
        BorrowerID,
        COUNT(BookID) AS BooksBorrowed
    FROM 
        Loans
    WHERE 
        DateReturned IS NULL
    GROUP BY 
        BorrowerID
),
ActiveBorrowers AS (

    SELECT 
        BR.BorrowerID,
        BR.FirstName,
        BR.LastName,
        BR.Email,
        BB.BooksBorrowed
    FROM 
        BorrowedBooks BB
    JOIN 
        Borrowers BR ON BB.BorrowerID = BR.BorrowerID
    WHERE 
        BB.BooksBorrowed >= 2
)


SELECT 
    BorrowerID,
    FirstName,
    LastName,
    Email,
    BooksBorrowed
FROM 
    ActiveBorrowers
ORDER BY 
    BooksBorrowed DESC;
