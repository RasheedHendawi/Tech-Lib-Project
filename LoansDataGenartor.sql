DECLARE @k INT = 1;
WHILE @k <= 1000
BEGIN
    DECLARE @BookID INT = FLOOR(RAND() * 1000) + 1;
    DECLARE @BorrowerID INT = FLOOR(RAND() * 1000) + 1;
    DECLARE @DateBorrowed DATE = DATEADD(DAY, -FLOOR(RAND() * 365), GETDATE());
    DECLARE @DueDate DATE = DATEADD(DAY, 14, @DateBorrowed);
    DECLARE @DateReturned DATE = NULL;

    IF RAND() > 0.5
        SET @DateReturned = DATEADD(DAY, FLOOR(RAND() * 14), @DueDate);

    INSERT INTO Loans (BookID, BorrowerID, DateBorrowed, DueDate, DateReturned)
    VALUES (@BookID, @BorrowerID, @DateBorrowed, @DueDate, @DateReturned);

    SET @k = @k + 1;
END;
