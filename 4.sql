WITH MonthlyGenreFrequency AS (
    SELECT 
        B.Genre,
        COUNT(L.LoanID) AS GenreBorrowCount
    FROM 
        Books B
    JOIN 
        Loans L ON B.BookID = L.BookID
    WHERE 
        L.DateBorrowed BETWEEN '2024-07-01' AND '2024-07-31' 
    GROUP BY 
        B.Genre
),
RankedGenres AS (
    SELECT 
        Genre,
        GenreBorrowCount,
        RANK() OVER (ORDER BY GenreBorrowCount DESC) AS GenreRank
    FROM
        MonthlyGenreFrequency
)
SELECT 
    Genre,
    GenreBorrowCount
FROM 
    RankedGenres
WHERE 
    GenreRank = 1;