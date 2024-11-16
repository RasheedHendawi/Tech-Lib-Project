WITH AuthorBorrowingFrequency AS 
(
	SELECT
	B.Author,
	COUNT(L.LoanID) AS BorrowingCount
	FROM
	BOOKS B
	JOIN
	Loans L ON B.BookID = L.BookID
	GROUP BY
	B.Author
)
SELECT
	Author,
	BorrowingCOUNT,
	DENSE_RANK() OVER (ORDER BY BorrowingCOUNT DESC) AS AuthorRank
	FROM
	AuthorBorrowingFrequency
	ORDER BY
	AuthorRank;