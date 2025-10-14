# BankLoan_Performance_Analysis
This repository contains a Bank Loan Analysis project using SQL, designed to demonstrate data analysis and risk assessment for a banking portfolio. It showcases how SQL can be used to generate customer, branch, and loan insights, perform risk segmentation, and track loan performance metrics.

## Project Structure

1. **01_Create_Tables.sql**  
   - Createed database and all necessary tables: **Branches, Customers, Loans, Payments**  
   - Includes **data types, primary keys, and foreign key relationships**
     
2. **02_load_sample_data.sql**  
   - Inserted **scenario-oriented sample data** to simulate real-world banking situations  
   - Includes diverse customer incomes, loan sizes, terms, and statuses

3. **03_data_quality_tests.sql**  
   - Performed **data validation**: null checks, duplicates, outliers, etc  
   - Ensures **data integrity** before analysis

4. **04_kpi_queries.sql**  
   - Calculated **key metrics & KPIs**:  
     - Customer-level: total loans, loan-to-income ratio, default counts  
     - Branch-level: total loans, average interest rate, NPA %, NPA amount  
     - Risk segmentation: low, medium, high-risk customers  
     - Time-based trends: monthly new loans, monthly defaults  
     - Interest rate analysis by loan term  
     - Produces insights for **portfolio risk assessment and performance monitoring**
       
## ER Diagram
![ER_Diagram](ER_Diagram.png)  
*Visual representation of the database structure and relationships.*
    
## Notes
- All sample data is **fictional** and designed for **demonstration purposes**.  
- Queries are written in **standard T-SQL** for **MS SQL Server**, but can be adapted for other relational databases.

## Author
**Priyasi Shah** – Aspiring SQL Developer / Data Analyst  
- GitHub: https://github.com/PriyasiShah1211
- LinkedIn: https://www.linkedin.com/in/priyasi-shah/
