CREATE PROCEDURE sp_GetOverdueBorrowersAndBooks
AS
BEGIN
    SET NOCOUNT ON;

    CREATE TABLE #OverdueBorrowers (
        BorrowerID INT,
        FirstName NVARCHAR(50),
        LastName NVARCHAR(50),
        Email NVARCHAR(100)
    );

    INSERT INTO #OverdueBorrowers (BorrowerID, FirstName, LastName, Email)
    SELECT 
        DISTINCT BR.BorrowerID,
        BR.FirstName,
        BR.LastName,
        BR.Email
    FROM 
        Borrowers BR
    JOIN 
        Loans L ON BR.BorrowerID = L.BorrowerID
    WHERE 
        L.DueDate < GETDATE() AND L.DateReturned IS NULL;

    SELECT 
        OB.BorrowerID,
        CONCAT(OB.FirstName, ' ', OB.LastName) AS BorrowerName,
        OB.Email AS BorrowerEmail,
        B.BookID,
        B.Title AS BookTitle,
        L.DateBorrowed,
        L.DueDate,
        DATEDIFF(DAY, L.DueDate, GETDATE()) AS OverdueDays
    FROM 
        #OverdueBorrowers OB
    JOIN 
        Loans L ON OB.BorrowerID = L.BorrowerID
    JOIN 
        Books B ON L.BookID = B.BookID
    WHERE 
        L.DueDate < GETDATE() AND L.DateReturned IS NULL
    ORDER BY 
        OB.BorrowerID, OverdueDays DESC;

    DROP TABLE #OverdueBorrowers;
END;


