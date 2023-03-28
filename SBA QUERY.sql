/****** Script for SelectTopNRows command from SSMS  ******/

/* Extract code numbers to create separte columnn and remove empty spaces*/
SELECT *
INTO naics_code_and_descriptions
FROM(
	SELECT [NAICS_Industry_Description],
		IIF([NAICS_Industry_Description] LIKE '%–%', substring([NAICS_Industry_Description], 8, 2), '') LookUpCodes,
		IIF([NAICS_Industry_Description] LIKE '%–%', ltrim(substring([NAICS_Industry_Description], CHARINDEX('–', [NAICS_Industry_Description]) + 1, LEN([NAICS_Industry_Description]))), '') Sector
	    FROM [SBA].[dbo].[naics_standards]
	    WHERE [NAICS_Codes] = ''
 ) MAIN
	WHERE LookUpCodes != ''
	