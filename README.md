# Library Management System SQL Project 📚

## Project Overview

**Project Title**: Library Management System  
**Database**: MySQL  

This project demonstrates the implementation of a **Library Management System** using **SQL**. It includes the database schema design, data population, and complex SQL queries to manage day-to-day library operations. The project covers the entire lifecycle of a library database, from setting up tables to defining business logic for borrowing, returning, and fining books.

![Library System](Images/images1.png)

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

![ERD](Images/ERD.png)

| Table | Description |
| :--- | :--- |
| **Books** | Contains book details (ISBN, Title, Category, Rental Price, Status). |
| **Branch** | Library branch details and manager information. |
| **Employees** | Staff details and their assigned branches. |
| **Members** | Registered library members. |
| **Issued_Status** | Logs of books issued to members. |
| **Return_Status** | Logs of returned books and their condition. |

---

## 🔍 Key Analysis & Queries

This project involves 20+ SQL queries solving real-world library management problems. You can find the complete solution code in the `sql_scripts/4_analysis_queries.sql` file.

### Sample Problems Solved:
1.  **Branch Performance Report**: Calculated total books issued, returned, and revenue generated per branch.
2.  **Overdue Analysis**: Identified members with overdue books and calculated fines based on a $0.50/day policy.
3.  **Member Activity**: Identified active members (issued books in the last 2 months) and high-risk members (those who have returned damaged books more than twice).
4.  **Dynamic Status Updates**: Created a Stored Procedure `book_assign` to automatically check if a book is available ('yes') before issuing it.

---

## 💻 How to Use

1. **Clone the Repository**
   ```sh
   git clone [https://github.com/sonukc9370-ai/Library-Management-System.git](https://github.com/sonukc9370-ai/Library-Management-System.git)

Set Up the Database Execute the SQL scripts in the sql_scripts folder in the following order:

	1. schema_setup.sql
	2. insert_data.sql
	3. Execute analysis_queries.sql to view the reports and data insights.
