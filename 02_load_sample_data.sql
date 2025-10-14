---------------------------------------------- Bank Loan Performance Analysis-------------------------------------------------

-- Inserting Sample Data
insert into Branches (branch_name, region)
values 
('Mumbai Central', 'West'),
('Delhi Connaught', 'North'),
('Kolkata Park Street', 'East'),
('Chennai Mount Road', 'South'),
('Pune FC Road', 'West')


insert into Branches (branch_name, region)
values 
('Mumbai Central', 'West'),
('Delhi Connaught', 'North'),
('Kolkata Park Street', 'East'),
('Chennai Mount Road', 'South'),
('Pune FC Road', 'West')

insert into Customers (first_name, last_name, dob, gender, employment_status, annual_income, join_date)
values
('Ravi', 'Sharma', '1988-05-11', 'M', 'Salaried', 900000, '2019-03-10'),
('Priya', 'Iyer', '1992-11-20', 'F', 'Self-Employed', 1200000, '2018-07-15'),
('Amit', 'Patel', '1990-01-05', 'M', 'Salaried', 650000, '2020-01-25'),
('Neha', 'Kaur', '1985-02-13', 'F', 'Business Owner', 2500000, '2017-09-09'),
('Suresh', 'Menon', '1993-12-29', 'M', 'Salaried', 700000, '2021-04-18')

insert into Loans (customer_id, branch_id, loan_type, principal, interest_rate, term_months, start_date, status)
values
(1, 1, 'Home Loan', 3000000, 8.5, 180, '2019-04-01', 'Active'),
(2, 2, 'Business Loan', 2000000, 10.0, 60, '2018-08-01', 'Closed'),
(3, 5, 'Personal Loan', 500000, 14.0, 36, '2020-02-01', 'Default'),
(4, 3, 'Home Loan', 4500000, 9.2, 180, '2017-10-01', 'Active'),
(5, 4, 'Auto Loan', 800000, 11.5, 60, '2021-05-01', 'Default')

insert into Payments (loan_id, payment_date, amount, payment_type)
values
(1, '2024-09-01', 28000, 'EMI'),
(1, '2024-10-01', 28000, 'EMI'),
(2, '2023-08-01', 45000, 'EMI'),
(3, '2021-09-01', 15000, 'EMI'),
(4, '2024-10-01', 50000, 'EMI'),
(5, '2024-01-01', 18000, 'EMI')
