SELECT * FROM bank_loan
use [Bank Loan DB]
--Total no of loan application recieved during a specific period.monitor month-to-date loan app and track changes month-over-month
SELECT COUNT(ID) as PMTD_tot_loan_app FROM bank_loan 
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
--Total funded amount also mtd tot funded amount and analyse the M-O-M changes
SELECT sum(loan_amount) as mtd_totfundedamount FROM bank_loan 
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
--previous mtd
SELECT sum(loan_amount) as pmtd_totfundedamount FROM bank_loan 
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021
--Total amount recieved
SELECT sum(total_payment) as total_amount_recieved FROM bank_loan 
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
--previous mtd
SELECT sum(total_payment) as pre_total_amount_recieved FROM bank_loan 
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021
--average interest rate
SELECT ROUND(AVG(int_rate)*100,2) AS MTD_avg_int_rate FROM bank_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
--previous mtd
SELECT ROUND(AVG(int_rate)*100,2) AS PMTD_avg_int_rate FROM bank_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021
--Average to income ratio
SELECT ROUND(AVG(dti)*100,2) AS avg_dti FROM bank_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
--previous mtd
SELECT ROUND(AVG(dti)*100,2) AS PRE_avg_dti FROM bank_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021
--Total no of application percentage for loan(good as well as bad)
SELECT (COUNT(CASE WHEN loan_status ='Fully Paid' OR loan_status = 'Current' THEN id END )*100)
       /
       COUNT(id) AS good_loan_percent
FROM bank_loan
--good loan count
SELECT COUNT(id) AS good_loan_app FROM bank_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
--good loan funded amount
SELECT SUM(loan_amount) AS good_loan_fun_amount FROM bank_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
--total amount recieved
SELECT SUM(total_payment) AS good_loan_rec_amount FROM bank_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
--total percent of bad loan
SELECT (COUNT(CASE WHEN loan_status ='Charged off' THEN id END )*100)
       /
       COUNT(id) AS bad_loan_percent
FROM bank_loan
--total bad loan applications 
SELECT COUNT(id) AS bad_loanapp FROM bank_loan
WHERE loan_status = 'Charged off'
----bad loan funded amount
SELECT SUM(loan_amount) AS bad_loan_fun_amount FROM bank_loan
WHERE loan_status = 'Charged off'
----total bad amount recieved
SELECT SUM(total_payment) AS bad_loan_rec_amount FROM bank_loan
WHERE loan_status = 'Charged off'
----loan status grid view
SELECT 
       loan_status,
	   COUNT(id) AS tot_loan_app,
	   SUM(total_payment)AS total_amount_recieved,
	   SUM(loan_amount) AS total_funded_amount,
	   AVG(int_rate * 100) AS interest_rate,
	   AVG(dti*100) AS DTI
	   FROM bank_loan
	   GROUP BY
	    loan_status
----total m-t-d funded and recieved amount
SELECT loan_status,
SUM(total_payment)AS mtdtotal_amount_recieved,
	   SUM(loan_amount) AS mtdtotal_funded_amount
FROM  bank_loan
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status
-----monthwise tot app,amount funded,recieved
SELECT
MONTH(issue_date) AS months, 
DATENAME(MONTH,issue_date) AS month_name,
COUNT(id) AS total_applications,
SUM(loan_amount) AS tot_funded_amount,
SUM(total_payment) AS tot_payment_recieved FROM bank_loan
GROUP BY MONTH(issue_date),DATENAME(MONTH,issue_date)
ORDER BY MONTH(issue_date)
-----regionally tot app,amount funded,recieved
SELECT address_state,
COUNT(id) AS total_applications,
SUM(loan_amount) AS tot_funded_amount,
SUM(total_payment) AS tot_payment_recieved
FROM bank_loan
GROUP BY address_state
ORDER BY address_state
--loan term analysis
SELECT term,
COUNT(id) AS total_applications,
SUM(loan_amount) AS tot_funded_amount,
SUM(total_payment) AS tot_payment_recieved
FROM bank_loan
GROUP BY term
ORDER BY term
----employee lenth analysis
SELECT * FROM bank_loan
SELECT emp_length,
COUNT(id) AS total_applications,
SUM(loan_amount) AS tot_funded_amount,
SUM(total_payment) AS tot_payment_recieved
FROM bank_loan
GROUP BY emp_length
ORDER BY emp_length
---purpose of loan
SELECT purpose,
COUNT(id) AS total_applications,
SUM(loan_amount) AS tot_funded_amount,
SUM(total_payment) AS tot_payment_recieved
FROM bank_loan
GROUP BY purpose
ORDER BY count(id) desc
---wrt home ownership
SELECT home_ownership,
COUNT(id) AS total_applications,
SUM(loan_amount) AS tot_funded_amount,
SUM(total_payment) AS tot_payment_recieved
FROM bank_loan
GROUP BY home_ownership
ORDER BY COUNT(id) DESC