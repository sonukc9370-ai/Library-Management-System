-- Importing data for Books table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Books.csv'
INTO TABLE Books
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Importing data for Branch table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Branch.csv'
INTO TABLE Branch
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Importing data for Employees table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Importing data for Members table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/members.csv'
INTO TABLE members
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Importing data for Issued_Status table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Issued_Status.csv'
INTO TABLE issued_status
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Importing data for return_status table

Set FOREIGN_KEY_CHECKS=0;     -- disabling foreign key due to error that Child table cannot be updated cuz of foreign key constraint.
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/return_Status.csv'
INTO TABLE return_status
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SET FOREIGN_KEY_CHECKS=1;
-- Checking for any value that is present in return_status and not in Issued_Status
SELECT DISTINCT issued_id FROM return_status
WHERE issued_id NOT IN (SELECT issued_id FROM Issued_Status);

-- Deleting those values From return_status to maintain referential integrity
SET SQL_Safe_Updates=0;
DELETE FROM return_status
 WHERE issued_id NOT IN (SELECT issued_id FROM Issued_Status);
 
--  --Inserting new values for Issued_status
 INSERT INTO issued_status(issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id)
VALUES
('IS151', 'C118', 'The Catcher in the Rye', CURRENT_DATE - INTERVAL 24 day,  '978-0-553-29698-2', 'E108'),
('IS152', 'C119', 'The Catcher in the Rye', CURRENT_DATE - INTERVAL 13 day,  '978-0-553-29698-2', 'E109'),
('IS153', 'C106', 'Pride and Prejudice', CURRENT_DATE - INTERVAL 7 day,  '978-0-14-143951-8', 'E107'),
('IS154', 'C105', 'The Road', CURRENT_DATE - INTERVAL 32 day,  '978-0-375-50167-0', 'E101');

-- Adding new column in return_status
ALTER TABLE return_status
ADD Column book_quality VARCHAR(15) DEFAULT('Good');

UPDATE return_status
SET book_quality = 'Damaged'
WHERE issued_id 
    IN ('IS112', 'IS117', 'IS118');

 
 -- Fetching records from Imported Table (Imported using table import wizard)
SELECT * FROM Books;
SELECT * FROM Branch;
SELECT * FROM Employees;
SELECT * FROM members;
SELECT * FROM Issued_Status;
SELECT * FROM return_Status;


