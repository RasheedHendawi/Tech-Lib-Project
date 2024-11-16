CREATE TABLE AuditLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT NOT NULL,
    StatusChange NVARCHAR(50),
    ChangeDate DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_BookStatusChange
ON Books
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditLog (BookID, StatusChange, ChangeDate)
    SELECT 
        i.BookID,
        CONCAT(d.CurrentStatus, ' to ', i.CurrentStatus) AS StatusChange,
        GETDATE() AS ChangeDate
    FROM 
        inserted i
    JOIN 
        deleted d ON i.BookID = d.BookID
    WHERE 
        d.CurrentStatus IN ('Available', 'Borrowed')
        AND i.CurrentStatus IN ('Available', 'Borrowed')
        AND d.CurrentStatus <> i.CurrentStatus;
END;

UPDATE Books
SET CurrentStatus = 'Borrowed'
WHERE BookID = 1;

SELECT * FROM AuditLog;

