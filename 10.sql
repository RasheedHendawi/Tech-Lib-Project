WITH BorrowerAgeGroups AS (
    SELECT 
        BR.BorrowerID,
        CASE 
            WHEN DATEDIFF(YEAR, BR.DateOfBirth, GETDATE()) BETWEEN 0 AND 10 THEN '(0,10)'
            WHEN DATEDIFF(YEAR, BR.DateOfBirth, GETDATE()) BETWEEN 11 AND 20 THEN '(11,20)'
            WHEN DATEDIFF(YEAR, BR.DateOfBirth, GETDATE()) BETWEEN 21 AND 30 THEN '(21,30)'
            WHEN DATEDIFF(YEAR, BR.DateOfBirth, GETDATE()) BETWEEN 31 AND 40 THEN '(31,40)'
            WHEN DATEDIFF(YEAR, BR.DateOfBirth, GETDATE()) BETWEEN 41 AND 50 THEN '(41,50)'
            WHEN DATEDIFF(YEAR, BR.DateOfBirth, GETDATE()) BETWEEN 51 AND 60 THEN '(51,60)'
            ELSE '(60+)' 
        END AS AgeGroup
    FROM 
        Borrowers BR
),
GenreBorrowingCounts AS (
    SELECT 
        BAG.AgeGroup,
        B.Genre,
        COUNT(L.LoanID) AS BorrowCount
    FROM 
        BorrowerAgeGroups BAG
    JOIN 
        Loans L ON BAG.BorrowerID = L.BorrowerID
    JOIN 
        Books B ON L.BookID = B.BookID
    GROUP BY 
        BAG.AgeGroup, B.Genre
),
PreferredGenres AS (

    SELECT 
        GBC.AgeGroup,
        GBC.Genre,
        GBC.BorrowCount,
        RANK() OVER (PARTITION BY GBC.AgeGroup ORDER BY GBC.BorrowCount DESC) AS GenreRank
    FROM 
        GenreBorrowingCounts GBC
)

SELECT 
    AgeGroup,
    Genre AS PreferredGenre,
    BorrowCount AS TotalBorrows
FROM 
    PreferredGenres
WHERE 
    GenreRank = 1
ORDER BY 
    AgeGroup;
