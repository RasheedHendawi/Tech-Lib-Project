
CREATE INDEX idx_Books_Title ON Books (Title);

CREATE INDEX idx_Books_Genre ON Books (Genre);

CREATE INDEX idx_Books_CurrentStatus ON Books (CurrentStatus);
---- Book table indexing.


CREATE UNIQUE INDEX idx_Borrowers_Email ON Borrowers (Email);

CREATE INDEX idx_Borrowers_LastName ON Borrowers (LastName);
------ Borrower table indexing.
 
CREATE INDEX idx_Loans_BookID ON Loans (BookID);


CREATE INDEX idx_Loans_BorrowerID ON Loans (BorrowerID);


CREATE INDEX idx_Loans_DueDate_DateReturned ON Loans (DueDate, DateReturned);


CREATE INDEX idx_Loans_DateBorrowed ON Loans (DateBorrowed);
--- Loans Table Indexing