/****** Script for SelectTopNRows command from SSMS  ******/
 ---What is the summary of all approved PPP Loans?
SELECT
	year(DateApproved) year_approved,
	COUNT(LoanNumber) Number_of_Approved,
	SUM(InitialApprovalAmount) Approved_Amount,
	AVG(InitialApprovalAmount) Average_Loan_Size
  FROM [SBA].[dbo].[sba_public_data]
  WHERE year(DateApproved) = 2020
  GROUP BY year(DateApproved)

  UNION

  SELECT
	year(DateApproved) year_approved,
	COUNT(LoanNumber) Number_of_Approved,
	SUM(InitialApprovalAmount) Approved_Amount,
	AVG(InitialApprovalAmount) Average_Loan_Size
  FROM [SBA].[dbo].[sba_public_data]
  WHERE year(DateApproved) = 2021
  GROUP BY year(DateApproved)
  


  SELECT year(DateApproved) year_approved,
	COUNT(DISTINCT OriginatingLender) OriginatingLender,
	COUNT(LoanNumber) Number_of_Approved,
	SUM(InitialApprovalAmount) Approved_Amount,
	AVG(InitialApprovalAmount) Average_Loan_Size
  FROM [SBA].[dbo].[sba_public_data]
  WHERE year(DateApproved) = 2020
  GROUP BY year(DateApproved)
  

  UNION

SELECT year(DateApproved) year_approved,
	COUNT(DISTINCT OriginatingLender) OriginatingLender,
	COUNT(LoanNumber) Number_of_Approved,
	SUM(InitialApprovalAmount) Approved_Amount,
	AVG(InitialApprovalAmount) Average_Loan_Size
  FROM [SBA].[dbo].[sba_public_data]
  WHERE year(DateApproved) = 2021
  GROUP BY year(DateApproved)

 ---Top 15 Originating Lenders by loan count, total amount, and average in 2020 and 2021
 SELECT TOP 15
	OriginatingLender,
	COUNT(LoanNumber) Number_of_Approved,
	SUM(InitialApprovalAmount) Approved_Amount,
	AVG(InitialApprovalAmount) Average_Loan_Size
  FROM [SBA].[dbo].[sba_public_data]
  WHERE year(DateApproved) = 2021
  GROUP BY OriginatingLender
  ORDER BY 3 DESC


   SELECT TOP 15
	OriginatingLender,
	COUNT(LoanNumber) Number_of_Approved,
	SUM(InitialApprovalAmount) Approved_Amount,
	AVG(InitialApprovalAmount) Average_Loan_Size
  FROM [SBA].[dbo].[sba_public_data]
  WHERE year(DateApproved) = 2020
  GROUP BY OriginatingLender
  ORDER BY 3 DESC

  ---Top 20 Industries that received the PPP Loans in 2020  and 2021
   WITH CTE AS 
   (
   SELECT TOP 20
	d.Sector,
	COUNT(LoanNumber) Number_of_Approved,
	SUM(InitialApprovalAmount) Approved_Amount,
	AVG(InitialApprovalAmount) Average_Loan_Size
  FROM [SBA].[dbo].[sba_public_data] p
  INNER JOIN [dbo].[naics_code_and_descriptions] d
	ON LEFT(p.NAICSCode, 2) = d.LookUpCodes
  WHERE year(DateApproved) = 2020
  GROUP BY d.Sector
  ---ORDER BY 3 DESC
  )
  SELECT Sector,
  Number_of_Approved,
  Approved_Amount,
  Average_Loan_Size,
  Approved_Amount/SUM(Approved_Amount) OVER()* 100 Percentage_by_amount
  FROM CTE
  ORDER BY 3 DESC


   SELECT TOP 20
	d.Sector,
	COUNT(LoanNumber) Number_of_Approved,
	SUM(InitialApprovalAmount) Approved_Amount,
	AVG(InitialApprovalAmount) Average_Loan_Size
  FROM [SBA].[dbo].[sba_public_data] p
  INNER JOIN [dbo].[naics_code_and_descriptions] d
	ON LEFT(p.NAICSCode, 2) = d.LookUpCodes
  WHERE year(DateApproved) = 2021
  GROUP BY d.Sector
  ORDER BY 3 DESC

  ---What percentage of the total approved amount of loans?
   WITH CTE AS 
   (
   SELECT TOP 20
	d.Sector,
	COUNT(LoanNumber) Number_of_Approved,
	SUM(InitialApprovalAmount) Approved_Amount,
	AVG(InitialApprovalAmount) Average_Loan_Size
  FROM [SBA].[dbo].[sba_public_data] p
  INNER JOIN [dbo].[naics_code_and_descriptions] d
	ON LEFT(p.NAICSCode, 2) = d.LookUpCodes
  WHERE year(DateApproved) = 2020
  GROUP BY d.Sector
  ---ORDER BY 3 DESC
  )
  SELECT Sector,
  Number_of_Approved,
  Approved_Amount,
  Average_Loan_Size,
  Approved_Amount/SUM(Approved_Amount) OVER()* 100 Percentage_by_amount
  FROM CTE
  ORDER BY 3 DESC


  --How Much of the PPP Loans of 2021 have been fully forgiven?
  SELECT COUNT(LoanNumber) Number_of_Approved,
	SUM(CurrentApprovalAmount) Current_Approved_Amount,
	AVG(CurrentApprovalAmount) Current_Average_Loan_Size,
	SUM(ForgivenessAmount) Amount_Forgiven,
	SUM(ForgivenessAmount)/SUM(CurrentApprovalAmount) * 100 percent_forgiven
  FROM [SBA].[dbo].[sba_public_data]
  WHERE year(DateApproved) = 2021
   ORDER BY 3 DESC

--The month and year where the highest amount of loans where approved?
SELECT month(DateApproved) month_approved,
		year(DateApproved) year_approved,
		SUM(InitialApprovalAmount) Approved_Amount,
	AVG(InitialApprovalAmount) Average_Loan_Size
  FROM [SBA].[dbo].[sba_public_data]
   GROUP BY month(DateApproved),
			year(DateApproved)
   ORDER BY Approved_Amount DESC