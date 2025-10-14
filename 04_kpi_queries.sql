---------------------------------------------- Bank Loan Performance Analysis-------------------------------------------------

-- Key Performance Indicator Queries

-- 1. Total number of loans and total principal
select 
    count(*) as Total_loans,
    format(sum(principal), 'N0') as Total_principal
from loans

-- 2. Total loan amount by loan type
select 
	loan_type, 
	format(sum(principal), 'N0') as Total_principal
from Loans
group by loan_type
order by total_principal desc

-- 3. Average interest rate by branch
select 
    b.branch_name, 
    format(avg(l.interest_rate), 'N2') + ' %' as Avg_interest_rate
from loans l
inner join branches b on l.branch_id = b.branch_id
group by b.branch_name
order by avg(l.interest_rate) desc

-- 4. Loan count and NPA% by branch
select 
    b.branch_name,
    format(count(*), 'N0') as Total_loans,
    format(sum(case when l.status = 'Default' then 1 else 0 end), 'N0') as Default_loans,
    format(
        sum(case when l.status = 'Default' then 1 else 0 end) * 100.0 / count(*),
        'N2'
    ) + ' %' as NPA_percentage
from loans l
inner join branches b on l.branch_id = b.branch_id
group by b.branch_name
order by sum(case when l.status = 'Default' then 1 else 0 end) * 100.0 / count(*) desc

-- 5. Loan distribution by region
select 
	b.region, 
	COUNT(*) as Total_loans, 
	FORMAT(SUM(l.principal), 'N0') as Total_principal
from Loans l
inner join Branches b on l.branch_id = b.branch_id
group by b.region

-- 6. Customer income vs loan amount ratio
select 
    c.customer_id,
    c.first_name + ' ' + c.last_name as customer_name,
    format(c.annual_income, 'N0') as annual_income,
    format(sum(l.principal), 'N0') as total_loan,
    format(sum(l.principal) / nullif(c.annual_income, 0), 'N2') as loan_to_income_ratio,
    case 
        when sum(l.principal) / nullif(c.annual_income, 0) < 0.5 then 'Low Risk'
        when sum(l.principal) / nullif(c.annual_income, 0) between 0.5 and 1.5 then 'Medium Risk'
        else 'High Risk'
    end as risk_category
from customers c
join loans l on c.customer_id = l.customer_id
group by c.customer_id, c.first_name, c.last_name, c.annual_income
order by sum(l.principal) / nullif(c.annual_income, 0) desc


-- 7. Total interest income projection per loan
select 
    loan_id,
    principal,
    interest_rate,
    term_months,
    FORMAT(ROUND(principal * (interest_rate/100) * (term_months/12.0), 2), 'N0') as Total_interest_income
from Loans
order by total_interest_income desc

-- 8. Top 3 largest loans per branch
with RankedLoans as (
    select
        b.branch_name,
        l.loan_id,
        l.principal,
        ROW_NUMBER() over (PARTITION BY l.branch_id ORDER BY l.principal DESC) as rn
    from Loans l
    inner join Branches b on l.branch_id = b.branch_id
)
select branch_name, loan_id, principal
from RankedLoans
where rn <= 3
order by branch_name, principal desc

-- 9. Monthly payment trends
select
    FORMAT(payment_date, 'yyyy-MM') as Month,
    format(SUM(amount),'N0') as Total_paid
from Payments
group by FORMAT(payment_date, 'yyyy-MM')
order by month

-- 10. Identify delinquent loans
select 
    l.loan_id,
    MAX(p.payment_date) as Last_payment_date,
    DATEDIFF(DAY, MAX(p.payment_date), GETDATE()) as Days_since_payment
from Loans l
left join Payments p ON l.loan_id = p.loan_id
group by l.loan_id
having DATEDIFF(DAY, MAX(p.payment_date), GETDATE()) > 30

-- STEP 7 - Creating Loan Portfolio Summary
create view vw_LoanPortfolioSummary as
select 
    b.region,
    b.branch_name,
    l.loan_type,
    COUNT(*) as Total_loans,
    format(SUM(l.principal),'N0') as total_principal,
    format(avg(l.interest_rate), 'N2') + ' %' as Avg_interest_rate,
    SUM(CASE WHEN l.status = 'Default' THEN l.principal ELSE 0 END) as npa_amount,
    CAST(SUM(CASE WHEN l.status = 'Default' THEN l.principal ELSE 0 END) * 100.0 / SUM(l.principal) AS DECIMAL(10,2)) as npa_percentage
from Loans l
inner join Branches b on l.branch_id = b.branch_id
group by b.region, b.branch_name, l.loan_type