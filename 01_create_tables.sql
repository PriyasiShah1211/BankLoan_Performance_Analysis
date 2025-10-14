---------------------------------------------- Bank Loan Performance Analysis-------------------------------------------------

-- Creating the database
create database BankLoanDB

-- Put the database into use
use BankLoanDB

-- Creating master tables
create table Branches (
    branch_id INT PRIMARY KEY IDENTITY(1,1),
    branch_name VARCHAR(100),
    region VARCHAR(50)
)

create table Customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    gender CHAR(1),
    employment_status VARCHAR(50),
    annual_income DECIMAL(15,2),
    join_date DATE
)

create table Loans (
    loan_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    branch_id INT,
    loan_type VARCHAR(50),
    principal DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    term_months INT,
    start_date DATE,
    status VARCHAR(20),  
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
)

create table Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    loan_id INT,
    payment_date DATE,
    amount DECIMAL(15,2),
    payment_type VARCHAR(20), 
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
)

