DECLARE @j INT = 1;
WHILE @j <= 1000
BEGIN
    INSERT INTO Borrowers (FirstName, LastName, Email, DateOfBirth, MembershipDate)
    VALUES (
        CONCAT('FirstName', @j),                                 -- FirstName
        CONCAT('LastName', @j),                                  -- LastName
        CONCAT('user', @j, '@example.com'),                      -- Email
        DATEADD(YEAR, -FLOOR(RAND() * 50 + 18), GETDATE()),      -- DateOfBirth (age 18-68)
        DATEADD(DAY, -FLOOR(RAND() * 365 * 5), GETDATE())        -- MembershipDate (within the last 5 years)
    );
    SET @j = @j + 1;
END;
