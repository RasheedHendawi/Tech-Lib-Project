DROP TABLE IF EXISTS Loans;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Borrowers;

CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY(1,1),  -- Identity column for auto-incrementing BookID
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    ISBN VARCHAR(13) UNIQUE NOT NULL,
    PublishedDate DATE,
    Genre VARCHAR(50),
    ShelfLocation VARCHAR(50),
    CurrentStatus VARCHAR(10) CHECK (CurrentStatus IN ('Available', 'Borrowed'))
);

CREATE TABLE Borrowers (
    BorrowerID INT PRIMARY KEY IDENTITY(1,1),  -- Identity column for auto-incrementing BorrowerID
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    DateOfBirth DATE,
    MembershipDate DATE NOT NULL
);
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY IDENTITY(1,1),  -- Identity column for auto-incrementing LoanID
    BookID INT NOT NULL,
    BorrowerID INT NOT NULL,
    DateBorrowed DATE NOT NULL,
    DueDate DATE NOT NULL,
    DateReturned DATE NULL,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
);
