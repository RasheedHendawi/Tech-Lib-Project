WITH BorrowingFrequency AS (
    SELECT 
        BorrowerID,
        COUNT(LoanID) AS TotalBorrows
    FROM 
        Loans
    GROUP BY 
        BorrowerID
)
SELECT 
    BR.BorrowerID,
    BR.FirstName,
    BR.LastName,
    BR.Email,
    BF.TotalBorrows,
    RANK() OVER (ORDER BY BF.TotalBorrows DESC) AS BorrowingRank
FROM 
    BorrowingFrequency BF
JOIN 
    Borrowers BR ON BF.BorrowerID = BR.BorrowerID
ORDER BY 
    BorrowingRank;
