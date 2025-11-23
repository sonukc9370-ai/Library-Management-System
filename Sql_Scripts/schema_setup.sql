CREATE TABLE Books(
	isbn VARCHAR(30) PRIMARY KEY,
	book_title VARCHAR(80),
    Category VARCHAR(20),
    rental_price DECIMAL(10,2),
    status VARCHAR(10),
    author VARCHAR(50),
    publisher VARCHAR(80)

);

CREATE TABLE Branch(
	branch_id VARCHAR(20) PRIMARY KEY,
    manager_id VARCHAR(20),
    branch_address VARCHAR (50),
    contact_no VARCHAR(30)
);

CREATE TABLE employees(
	emp_id VARCHAR(20) PRIMARY KEY,
    emp_name VARCHAR(30),
	position VARCHAR(20),
    salary DECIMAL(10,2),
    branch_id VARCHAR(20),
    Constraint fk_branch_id FOREIGN KEY(branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE members (
	member_id VARCHAR(20) PRIMARY KEY,
    member_name VARCHAR(30),
    member_address VARCHAR(50),
    reg_date DATE
);

CREATE TABLE Issued_Status (
	issued_id VARCHAR(20) PRIMARY KEY,
    issued_member_id VARCHAR(20),
    issued_book_name VARCHAR(80),
    issued_date DATE,
    issued_book_isbn VARCHAR(30),
    issued_emp_id VARCHAR(20),
    Constraint fk_isbn FOREIGN KEY(issued_book_isbn) REFERENCES Books (isbn),
    Constraint fk_emp_id FOREIGN KEY(issued_emp_id) REFERENCES employees (emp_id),
	Constraint fk_member_id FOREIGN KEY(issued_member_id) REFERENCES members (member_id)
);

CREATE TABLE return_status (
	return_id VARCHAR(20) PRIMARY KEY,
    issued_id  VARCHAR(20),
    return_book_name VARCHAR(50),
    return_date DATE,
    return_book_isbn VARCHAR(20),
    Constraint fk_issued_id FOREIGN KEY(issued_id) REFERENCES issued_Status(issued_id)
);


