CREATE TRIGGER trg_UpdateBookStatus
ON Loans
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Books
    SET CurrentStatus = 'Borrowed'
    FROM Books B
    JOIN inserted i ON B.BookID = i.BookID;

    UPDATE Books
    SET CurrentStatus = 'Available'
    FROM Books B
    JOIN inserted i ON B.BookID = i.BookID
    WHERE i.DateReturned IS NOT NULL;
END;
