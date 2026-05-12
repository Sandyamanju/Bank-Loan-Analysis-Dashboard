create database project;
use project;
-- 1. Year wise loan amount Stats
select * from finance_1;
select year(issue_d) as year, sum(loan_amnt) as total_loan_amount from finance_1
group by year(issue_d) order by year;

-- 2.Grade and sub grade wise revol_bal
select f1.grade, f1.sub_grade, sum(revol_bal) as total_revol_bal from finance_1 f1
join finance_2 f2 on f1.id=f2.id group by f1.grade,f1.sub_grade order by f1.grade, f1.sub_grade;
select * from finance_2;
alter table finance_2 change column ï»¿id id int;

-- 3. Total Payment for Verified Status Vs Total Payment for Non Verified Status
select verification_status, sum(f2.total_pymnt) as total_payment_sum from finance_1 f1
join finance_2 f2 on f1.id = f2.id group by f1.verification_status;

-- 4.State wise and month wise loan status
-- State wise
select addr_state as state, loan_status, count(*) as total_loans, sum(loan_amnt) as total_loan_amount
from finance_1 group by addr_state, loan_status order by addr_state;

--  month wise loan status
select date_format(issue_d, '%y-%m') as month,loan_status, count(*) as total_loans,
sum(loan_amnt) as total_loan_amount from finance_1 group by month, loan_status order by month;

-- 5.Home ownership Vs last payment date stats
select f1.home_ownership, f2.last_pymnt_amnt from finance_1 f1 join finance_2 f2
on f1.id= f2.id where f2.last_pymnt_d is not null;

select 
case
when f1.home_ownership in ('none','other') then 'others' else f1.home_ownership end as home_group,
count(f2.last_pymnt_d) as total_payments from finance_1 f1 join finance_2 f2 on f1.id=f2.id
group by
 case
when f1.home_ownership in ('none','other') then 'others' else f1.home_ownership
end
order by total_payments desc;
