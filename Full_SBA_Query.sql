/*Removing text from Sector numbers*/

SELECT *
FROM [SBA].[dbo].[naics_code_and_descriptions]
ORDER BY LookUpCodes

INSERT INTO [SBA].[dbo].[naics_code_and_descriptions]
VALUES
('Sector 31 – 33 – Manufacturing', 32, 'Manufacturing'),
('Sector 31 – 33 – Manufacturing', 33, 'Manufacturing'),
('Sector 44 - 45 – Retail Trade', 45, 'Retail Trade'),
('Sector 48 - 49 – Transportation and Warehousing', 49, 'Transportation and Warehousing')

UPDATE [SBA].[dbo].[naics_code_and_descriptions]
SET Sector = 'Manufacturing'
WHERE LookUpCodes = 31