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
SELECT issued_emp_id,issued_book_name FROM Issued_Status WHERE issued_emp_id='E101';
```

**Task 5: List Members Who Have Issued More Than One Book**
-- Objective: Use GROUP BY to find members who have issued more than one book.

```sql
SELECT Issued_member_id,count(*) as Total_Books_Issued FROM Issued_status 
GROUP BY Issued_member_id HAVING Count(*)>1;
```

