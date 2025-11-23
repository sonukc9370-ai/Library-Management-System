# Library Management System SQL Project 📚

## Project Overview

**Project Title**: Library Management System  
**Database**: MySQL  

This project demonstrates the implementation of a **Library Management System** using **SQL**. It includes the database schema design, data population, and complex SQL queries to manage day-to-day library operations. 

The project covers the entire lifecycle of a library database, from setting up tables to defining business logic for borrowing, returning, and fining books.
![Library Management System](Diagram/images1.png)

---

## 🚀 Features & Functionality

* **Database Schema Design**: Normalized database with tables for Books, Branches, Employees, Members, Issued Status, and Return Status.
* **Data Integrity**: Usage of Primary Keys, Foreign Keys, and Constraints to ensure referential integrity.
* **Advanced SQL Operations**:
    * **CTAS (Create Table As Select)**: Used for generating summary tables and performance reports.
    * **Stored Procedures**: Automating the book issuing process and managing book availability status.
    * **Triggers**: Automatically updating book status (Available/Not Available) upon return.
    * **Window Functions & CTEs**: Used for advanced data analysis, such as identifying overdue books.
* **Business Analysis**: Solved 20 specific business questions (e.g., branch performance, overdue books, active members).

---

## 🛠️ Tech Stack

* **Database**: MySQL 8.0
* **Language**: SQL (DDL, DML, DQL, TCL)
* **Tools**: MySQL Workbench

---

## 📂 Schema Structure

1.  **Books**: Contains book details (ISBN, Title, Category, Rental Price, Status).
2.  **Branch**: Library branch details and manager information.
3.  **Employees**: Staff details and their assigned branches.
4.  **Members**: Registered library members.
5.  **Issued_Status**: Logs of books issued to members.
6.  **Return_Status**: Logs of returned books and their condition.

---

## Schema Setup
![ERD](Diagram/ERD.png)

---

### CRUD OPERATIONS 
- **Create**: Inserted sample records into the `books` table.
- **Read**: Retrieved and displayed data from various tables.
- **Update**: Updated records in the `employees` table.
- **Delete**: Removed records from the `members` table as needed.

**Task 1. Create a New Book Record**
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

```sql
INSERT INTO Books (isbn,book_title,category,rental_price,status,author,publisher) VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM Books;
```

**Task 2: Update an Existing Member's Address**

```sql
UPDATE members
Set member_address = '125 Oak St.'
WHERE member_id='C101';
```

**Task 3: Delete a Record from the Issued Status Table**
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

```sql
DELETE FROM issued_status
WHERE Issued_id='IS121';
```

**Task 4: Retrieve All Books Issued by a Specific Employee**
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

```sql
SELECT
   issued_emp_id,
   issued_book_name
FROM Issued_Status WHERE issued_emp_id='E101';
```

**Task 5: List Members Who Have Issued More Than One Book**
-- Objective: Use GROUP BY to find members who have issued more than one book.

```sql
SELECT
   Issued_member_id,
   count(*) as Total_Books_Issued
FROM Issued_status 
GROUP BY Issued_member_id
HAVING Count(*)>1;
```

### CTAS (Create Table As Select)

- **Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

```sql
CREATE TABLE Summary As (
SELECT
	b.isbn,
    b.book_title,
    count(i.issued_id) as No_Of_times_Issues
FROM Books b JOIN issued_status i ON b.isbn=i.issued_book_isbn
GROUP BY b.isbn,b.book_title
);
SELECT * FROM Summary;
```

### 4. Data Analysis & Findings

The following SQL queries were used to address specific questions:

Task 7. **Retrieve All Books in a Specific Category**:

```sql
SELECT * FROM Books
WHERE Category='Classic';
```

8. **Task 8: Find Total Rental Income by Category**:

```sql
SELECT
	Category,
    CONCAT("$",Sum(rental_price)) Total_Rental_Income
FROM Books
GROUP BY Category;
```

9. **List Members Who Registered in the Last 180 Days**:

```sql
SELECT * FROM Members 
WHERE reg_date >= DATE_SUB(curdate(),INTERVAL 180 DAY);
```

10. **List Employees with Their Branch Manager's Name and their branch details**:

```sql
SELECT
	e.emp_id,
    e.emp_name,
    e2.emp_name as Manager,
    e.position,
    b.*
FROM employees e JOIN branch b
ON e.branch_id=b.branch_id JOIN
employees e2 ON e2.emp_id=b.manager_id;
```

Task 11. **Create a Table of Books with Rental Price Above a Certain Threshold**:
```sql
CREATE TABLE expensive_books AS 
	SELECT * FROM Books
    WHERE rental_price > 8.00;
SELECT * FROM expensive_books;
```

Task 12: **Retrieve the List of Books Not Yet Returned**
```sql
SELECT
	b.*
FROM books b LEFT JOIN issued_status i
on b.isbn=i.issued_book_isbn
LEFT JOIN return_status r ON i.issued_id=r.issued_id
WHERE r.return_date IS NULL;
```

## Advanced SQL Operations

**Task 13: Identify Members with Overdue Books**  
Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue.

```sql
SELECT 
	m.member_id,
    m.member_name,
    b.book_title,
    i.issued_date,
    (current_date()- Issued_date) as Over_due
FROM members m JOIN issued_Status i  ON m.member_id=i.issued_member_id
JOIN Books b ON i.issued_book_isbn=b.isbn
LEFT JOIN return_status r ON i.issued_id=r.issued_id
WHERE r.return_date IS NULL AND 
(current_date()-i.issued_date) > 30;
```

**Task 14: Update Book Status on Return**  
Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).


```sql
DELIMITER $$
CREATE TRIGGER update_status_on_insert
AFTER INSERT ON return_status
FOR EACH ROW
BEGIN
	UPDATE books 
    Set Status= 'Yes'
    WHERE isbn=NEW.return_book_isbn;
	
END $$
DELIMITER ;

-- -Testing for Update
SELECT * FROM Books WHERE Isbn= '978-0-307-58837-1';
SELECT * FROM Books WHERE Isbn= '978-0-375-41398-8';


INSERT INTO return_Status (return_id,issued_id,return_book_name,return_date,return_book_isbn,book_quality)
VALUES ('RS119','IS122','Fahrenheit 451','2025-09-20','978-0-307-58837-1','Damaged');

INSERT INTO return_Status (return_id,issued_id,return_book_name,return_date,return_book_isbn,book_quality)
VALUES ('RS120','IS123','Dune','2025-09-25','978-0-375-41398-8','Good');

SELECT * FROM Books WHERE Isbn= '978-0-307-58837-1';
SELECT * FROM Books WHERE Isbn= '978-0-375-41398-8';
```

**Task 15: Branch Performance Report**  
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.

```sql
SELECT 
	b.branch_ID,
    b.manager_ID,
    Count(i.issued_id) as Total_Books_Issued,
    Count(r.return_id) as Total_Books_returned,
    CONCAT("$",Sum(bk.rental_price)) as Total_revenue_generated
FROM Branch b LEFT JOIN Employees e
ON b.branch_ID=e.branch_ID LEFT JOIN Issued_Status i 
ON e.emp_id=i.issued_emp_id LEFT JOIN return_status r 
ON i.issued_id=r.issued_id LEFT JOIN books bk
ON i.issued_book_isbn=bk.isbn
GROUP BY b.branch_ID,b.manager_ID
ORDER BY b.branch_ID;

select * from issued_status;
```

**Task 16: CTAS: Create a Table of Active Members**  
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.

```sql
CREATE TABLE Active_Users As 
	SELECT issued_member_id as Active_Users FROM issued_status 
	WHERE issued_date >= current_date()-INTERVAL 2 MONTH;

SELECT * FROM Active_Users;
```

-- Task 17: Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues.
--  Display the employee name, number of books processed, and their branch.

```sql
SELECT 
	e.emp_Name,
    b.*,
    count(i.issued_id) as Total_books_Processed
FROM Employees e JOIN Issued_Status i
ON e.emp_id=i.issued_emp_id JOIN branch b
ON e.branch_id=b.branch_id
GROUP BY 1,2
ORDER BY count(i.issued_id) DESC 
LIMIT 3;
```

**Task 18: Identify Members Issuing High-Risk Books**  
Write a query to identify members who have issued books more than twice with the status "damaged" in the books table. Display the member name, book title, and the number of times they've issued damaged books.    

```sql
SELECT
	m.member_name,
    b.book_title,
    COUNT(CASE WHEN r.book_quality = 'damaged' THEN 1 END) AS Damaged_Books_Issued
FROM Books b JOIN issued_status i ON b.isbn=i.issued_book_isbn
JOIN members m ON i.issued_member_id=m.member_id
JOIN return_status r ON i.issued_id=r.issued_id
GROUP BY m.member_name,b.book_title
HAVING COUNT(CASE WHEN r.book_quality = 'damaged' THEN 1 END) > 2;
```

**Task 19: Stored Procedure**
Objective:
Create a stored procedure to manage the status of books in a library system.
Description:
Write a stored procedure that updates the status of a book in the library based on its issuance. The procedure should function as follows:
The stored procedure should take the book_id as an input parameter.
The procedure should first check if the book is available (status = 'yes').
If the book is available, it should be issued, and the status in the books table should be updated to 'no'.
If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.

```sql
DELIMITER $$
CREATE PROCEDURE book_assign(
	IN p_issued_id VARCHAR(10),
    IN p_issued_member_id VARCHAR(10),
    IN p_issued_book_isbn VARCHAR(30),
    IN p_issued_emp_id VARCHAR(10),
    OUT p_message VARCHAR(255)    
    )
	BEGIN
		DECLARE v_status VARCHAR(10);   
        
        SELECT status into v_status
        FROM books WHERE isbn=p_issued_book_isbn;
        
       -- checking for the avilability of the book
        IF v_status= 'Yes' THEN
			INSERT INTO issued_status(issued_id,issued_member_id,issued_book_isbn,issued_emp_id)
            VALUES (p_issued_id,p_issued_member_id,p_issued_book_isbn,p_issued_emp_id);
            
            -- Updating the status to No after issuing the available book
            UPDATE books
            Set Status='No'
            WHERE isbn=p_issued_book_isbn;
            
            -- returning a successful message
            Set p_message= 'Book Issued Successfully!';
            
		ELSE
			Set p_message= 'The book Is currently Unavailable, We Aplogize for the Inconvenience Caused.';
		END IF;
    
    END $$
DELIMITER ;

-- Intializing the variable to hold the message  
set @result_message=0;

-- Calling the procedure
SELECT status FROM Books Where isbn='978-0-06-112008-4';     -- checking status before book issuance (status=yes)

Call book_assign('IS155','C110', '978-0-06-112008-4','E104', @result_message);
SELECT @result_message as 'Status_For_Book_978-0-06-112008-4';

SELECT status FROM Books Where isbn='978-0-06-112008-4';     -- checking status after book issunace (status=no)

-- checking for a book which is not available in library
Call book_assign('IS156','C109', '978-0-7432-7357-1','E106', @result_message);
SELECT @result_message as 'Status_For_Book_978-0-7432-7357-1';
```

**Task 20: Create Table As Select (CTAS)**
Objective: Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.

Description: Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 30 days. The table should include:
    The number of overdue books.
    The total fines, with each day's fine calculated at $0.50.
    The number of books issued by each member.
    The resulting table should show:
    Member ID
    Number of overdue books
    Total fines

```sql
WITH
	Overdue_days As(SELECT
		m.member_ID,
		count(i.issued_id) as No_Of_books_Issued,
		Count(
			CASE WHEN DATEDIFF(curdate(),i.issued_date) > 30 AND r.return_date IS NULL 
			THEN 1 
			END
		) As No_Of_Overdue_books
	FROM Members m LEFT JOIN issued_status i 
	ON m.member_id= i.issued_member_id 
	LEFT JOIN return_status r ON i.issued_id=r.issued_id
	GROUP BY m.member_ID
)
SELECT
	member_id,
    No_Of_books_Issued,
    No_Of_Overdue_books,
    CONCAT("$",No_Of_Overdue_books * 0.50) As Total_Fine
FROM Overdue_days
ORDER BY member_id;
```

## How to Use

1. **Clone the Repository**: Clone this repository to your local machine.
   ```sh
   git clone https://github.com/sonukc9370-ai/Library-Management-System
   ```

2. **Set Up the Database**: Execute the SQL scripts in the Sql_Scipts Section to create and populate the database.
3. **Run the Queries**: Use the SQL queries in the `analysis_queries.sql` in Sql_Script Section to perform the analysis.

