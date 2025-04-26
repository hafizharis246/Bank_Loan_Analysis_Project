SELECT * FROM bank_loan_data

--------------------------------------------------------
-- Total count of Loans issued
SELECT COUNT(id) AS TOTAL_LOAN_APPLICATIONS FROM bank_loan_data

-- Total count of loans in December
SELECT COUNT(id) AS DEC_2021_APPLICATIONS FROM bank_loan_data WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Total count of loans in Previous Month of December
SELECT COUNT(id) AS NOV_2021_APPLICATIONS FROM bank_loan_data WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--------------------------------------------------------
-- Total Loan amount issued
SELECT SUM(loan_amount) AS TOTAL_LOAN_AMOUNT FROM bank_loan_data

-- Total loan amount issued in December
SELECT SUM(loan_amount) AS DEC_TOTAL_AMOUNT FROM bank_loan_data WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Total loan amount issued in Previous Month of December
SELECT SUM(loan_amount) AS NOV_TOTAL_AMOUNT FROM bank_loan_data WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--------------------------------------------------------
-- Total Amount Recieved
SELECT SUM(total_payment) AS TOTAL_PAYMENT_RECIEVED FROM bank_loan_data

-- Total Amount Recieved in December
SELECT SUM(total_payment) AS DEC_TOTAL_PAYMENT_RECIEVED FROM bank_loan_data WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Total Amount Recieved in Previous Month of December
SELECT SUM(total_payment) AS NOV_TOTAL_PAYMENT_RECIEVED FROM bank_loan_data WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--------------------------------------------------------
-- Avg Interest Rates
SELECT ROUND(AVG(int_rate) * 100, 2) AS AVG_INTEREST_RATE FROM bank_loan_data

-- Avg Interest Rates for the DECEMBER Month
SELECT ROUND(AVG(int_rate) * 100, 2) AS DEC_AVG_INTEREST_RATE FROM bank_loan_data WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Avg Interest Rates for the Previous to DECEMBER Month
SELECT ROUND(AVG(int_rate) * 100, 2) AS NOV_AVG_INTEREST_RATE FROM bank_loan_data WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--------------------------------------------------------
-- Avg dept-to-income
SELECT ROUND(AVG(dti) * 100, 2) AS AVG_DEPT_TO_INCOME FROM bank_loan_data

-- Avg dept-to-income for December
SELECT ROUND(AVG(dti) * 100, 2) AS AVG_DEPT_TO_INCOME FROM bank_loan_data WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Avg dept-to-income for Previous to December Month
SELECT ROUND(AVG(dti) * 100, 2) AS AVG_DEPT_TO_INCOME FROM bank_loan_data WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


--------------------------------------------------------
-- Avg of Good Loan
SELECT
	ROUND((COUNT(CASE WHEN loan_status = 'Fully Paid'  OR loan_status = 'current' THEN id END) * 100) 
	/
	COUNT(id), 2) AS GOOD_LOAD_PERCENTAGE from bank_loan_data

-- Count of Good Loans Applications
SELECT COUNT(id) AS Count_of_Good_Loans_Applications FROM bank_loan_data WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Another Way to Count of Good Loans Applications
SELECT COUNT(id) AS Count_of_Good_Loans_Applications FROM bank_loan_data WHERE loan_status IN ('Fully Paid', 'Current')

-- Total Good Loan Funded Amount
SELECT SUM(loan_amount) AS Total_Good_Loans_Funded_Amount FROM bank_loan_data WHERE loan_status IN ('Fully Paid', 'Current')

-- Total Good Loan Amount Recieved
SELECT SUM(total_payment) AS Total_Good_Loans_Funded_Amount_Recieved FROM bank_loan_data WHERE loan_status IN ('Fully Paid', 'Current')


--------------------------------------------------------
-- Avg of Bad Loan
SELECT
	ROUND((COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100) 
	/
	COUNT(id), 2) AS BAD_LOAN_PERCENTAGE from bank_loan_data

-- Count of Bad Loans Applications
SELECT COUNT(id) AS Count_of_Bad_Loans_Applications FROM bank_loan_data WHERE loan_status = 'Charged Off' 

-- Another Way to Count of Bad Loans Applications
SELECT COUNT(id) AS Count_of_Bad_Loans_Applications FROM bank_loan_data WHERE loan_status IN ('Charged Off')

-- Total Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Total_Bad_Loans_Funded_Amount FROM bank_loan_data WHERE loan_status IN ('Charged Off')

-- Total Bad Loan Amount Recieved
SELECT SUM(total_payment) AS Total_Bad_Loans_Funded_Amount_Recieved FROM bank_loan_data WHERE loan_status IN ('Charged Off')

--------------------------------------------------------
-- Grid View Of Different Load Status
SELECT
	loan_status,
	COUNT(id) AS Loan_Count,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount,
	AVG(int_rate * 100) AS Interest_Rate,
	AVG(dti * 100) AS DTI
FROM
	bank_loan_data
GROUP BY
	loan_status


SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status



-- Bank Loan Report --
-- By Month
SELECT 
	MONTH(issue_date) AS Month_Number, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

-- By State
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state

-- By Term
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term

-- By Purpose
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC

-- By Home OwnerShip
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership



