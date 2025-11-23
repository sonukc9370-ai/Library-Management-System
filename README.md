# Library Management System SQL Project 📚

## Project Overview

**Project Title**: Library Management System  
**Database**: MySQL  

This project demonstrates the implementation of a **Library Management System** using **SQL**. It includes the database schema design, data population, and complex SQL queries to manage day-to-day library operations. 

The project covers the entire lifecycle of a library database, from setting up tables to defining business logic for borrowing, returning, and fining books.

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

## 📝 Key SQL Problems Solved

Below are some of the key tasks addressed in the project:

1.  **Branch Performance Report**: 
    * Calculates total books issued, returned, and revenue generated per branch.
2.  **Overdue Analysis**: 
    * Identifies members with overdue books and calculates fines based on a $0.50/day policy.
3.  **Member Activity**: 
    * Identifies active members (issued books in the last 2 months) and high-risk members (those who have returned damaged books more than twice).
4.  **Dynamic Status Updates**: 
    * Uses a Stored Procedure `book_assign` to automatically check if a book is available ('yes') before issuing it.

---

## 💻 How to Run

### 1. Clone the Repository
```bash
git clone [https://github.com/yourusername/Library-Management-System.git](https://github.com/yourusername/Library-Management-System.git)
