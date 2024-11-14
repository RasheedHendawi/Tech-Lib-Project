
SELECT 
    B.BookID,
    B.Title,
    B.Author,
    B.ISBN,
    B.PublishedDate,
    B.Genre,
    L.DateBorrowed,
    L.DueDate,
    L.DateReturned
FROM 
    Books B
JOIN 
    Loans L ON B.BookID = L.BookID
JOIN 
    Borrowers BR ON L.BorrowerID = BR.BorrowerID
WHERE 
    BR.BorrowerID = 5
ORDER BY 
    L.DateBorrowed DESC;
