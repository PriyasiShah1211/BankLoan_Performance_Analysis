---------------------------------------------- Bank Loan Performance Analysis-------------------------------------------------

-- Data Quality Checks

-- Check 1 - Missing Foreign Keys
-- Loans linked to invalid customers
select l.loan_id
from Loans l
LEFT JOIN Customers c on l.customer_id = c.customer_id
where c.customer_id is null

-- Loans linked to invalid branches
select l.loan_id
from loans l
left join branches b on l.branch_id = b.branch_id
where b.branch_id is null

-- Payments linked to invalid loans
select p.payment_id
from payments p
left join loans l on p.loan_id = l.loan_id
where l.loan_id is null

-- Customers without any loans (business audit)
select c.customer_id, c.first_name, c.last_name
from customers c
left join loans l on c.customer_id = l.customer_id
where l.loan_id is null

-- Branches without any loans
select b.branch_id, b.branch_name
from branches b
left join loans l on b.branch_id = l.branch_id
where l.loan_id is null

-- Loans without any payments recorded
select l.loan_id, l.loan_type, l.status
from loans l
left join payments p on l.loan_id = p.loan_id
where p.payment_id is null

-- Check 2 - NULL values in key columns
select 'customers' as table_name, count(*) as null_id_count
from customers
where customer_id is null
union all
select 'branches', count(*) from branches where branch_id is null
union all
select 'loans', count(*) from loans where loan_id is null
union all
select 'payments', count(*) from payments where payment_id is null

-- Check 3 - Negative interest or invalid ranges
select loan_id, interest_rate
from Loans
where interest_rate <= 0 OR interest_rate > 40

-- Check 4 - Duplicate records in key columns
select 'customers' as table_name, count(*) as duplicate_ids
from (
    select customer_id
    from customers
    group by customer_id
    having count(*) > 1
) a

union all

select 'branches', count(*)
from (
    select branch_id
    from branches
    group by branch_id
    having count(*) > 1
) b

union all

select 'loans', count(*)
from (
    select loan_id
    from loans
    group by loan_id
    having count(*) > 1
) c

union all

select 'payments', count(*)
from (
    select payment_id
    from payments
    group by payment_id
    having count(*) > 1
) d

-- Check 5 - Payments without valid loan reference
select p.payment_id
from Payments p
left join Loans l on p.loan_id = l.loan_id
where l.loan_id is null