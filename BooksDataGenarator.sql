DECLARE @i INT = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO Books (Title, Author, ISBN, PublishedDate, Genre, ShelfLocation, CurrentStatus)
    VALUES (
        CONCAT('Book Title ', @i),                               -- Title
        CONCAT('Author ', @i),                                   -- Author
        CONCAT('978-', RIGHT('0000000000000' + CAST(ABS(CHECKSUM(NEWID())) % 10000000 AS VARCHAR), 9)), -- ISBN
        DATEADD(YEAR, -FLOOR(RAND() * 100), GETDATE()),          -- PublishedDate
        CASE WHEN @i % 5 = 0 THEN 'Fiction'
             WHEN @i % 5 = 1 THEN 'Non-Fiction'
             WHEN @i % 5 = 2 THEN 'Science'
             WHEN @i % 5 = 3 THEN 'History'
             ELSE 'Philosophy' END,
        CONCAT('Shelf-', FLOOR((@i - 1) / 100)),
        'Available'
    );
    SET @i = @i + 1;
END;
