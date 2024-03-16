SELECT * FROM finance_1;
SELECT * FROM finance_2;

# KPI 1 - YEAR WISE LOAN AMOUNT STATS 

SELECT issue_d AS year, SUM(loan_amnt) AS Total_Loan_amnt
FROM Finance_1
GROUP BY issue_d;

# KPI 2 - GRADE AND SUB GRADE WISE REVOL_BAL 

select grade, sub_grade,sum(revol_bal) as total_revol_bal
from Finance_1 B1 inner join Finance_2 B2 
on(B1.id = B2.id) 
group by grade,sub_grade
order by grade;
 
# KPI 3 - Total Payment for Verified Status Vs Total Payment for Non Verified Status 
select verification_status, round(sum(total_pymnt),2) as Total_payment
from Finance_1 B1 inner join finance_2 B2 
on(B1.id = B2.id) 
where verification_status in('Verified', 'Not Verified')
group by verification_status;

# KPI 4 - State wise and last_credit_pull_d wise loan status 
select addr_state, last_credit_pull_d ,loan_status
from Finance_1 B1 inner join Finance_2 B2 
on(B1.id = B2.id) 
order by addr_state;
   
# KPI 5 - Home ownership Vs last payment date stats #####

select home_ownership, count(last_pymnt_d)
from Finance_1 B1 inner join Finance_2 B2 
on(B1.id = B2.id) 
group by home_ownership;

SELECT 
    finance_2.last_pymnt_d as Last_Payment_Date,
    finance_1.home_ownership,
    CONCAT('$ ', FORMAT(SUM(finance_2.last_pymnt_amnt), 2)) as Total_Payment
FROM 
    finance_1
JOIN 
    finance_2 ON finance_1.id = finance_2.id
WHERE 
    finance_1.home_ownership IN ('RENT', 'MORTGAGE', 'OWN', 'OTHER', 'NONE')
GROUP BY 
    finance_2.last_pymnt_d, finance_1.home_ownership
HAVING 
    SUM(finance_2.last_pymnt_amnt) != 0
ORDER BY 
    finance_2.last_pymnt_d, SUM(finance_2.last_pymnt_amnt) DESC;



SELECT finance_1.home_ownership,
       CONCAT('$ ', FORMAT(SUM(finance_2.last_pymnt_amnt), 2)) as 'Total_Payment'
FROM finance_1
JOIN finance_2 ON finance_1.id = finance_2.id
WHERE finance_1.home_ownership IN ('RENT', 'MORTGAGE', 'OWN', 'OTHER', 'NONE')
GROUP BY finance_1.home_ownership
HAVING SUM(finance_2.last_pymnt_amnt) != 0
ORDER BY SUM(finance_2.last_pymnt_amnt) DESC;

SELECT 
    f1.home_ownership,
    COUNT(*) AS Total_Loans,
    MAX(f2.last_pymnt_d) AS Latest_Payment_Date,
    MIN(f2.last_pymnt_d) AS Earliest_Payment_Date
FROM
    finance_1 f1
        JOIN
    finance_2 f2 ON f1.id = f2.id
GROUP BY f1.home_ownership;







