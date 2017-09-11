DECLARE @Year AS INT,
@FirstDateOfYear DATETIME,
@LastDateOfYear DATETIME
-- You can change @year to any year you desire
SELECT @year = 2017
SELECT @FirstDateOfYear = DATEADD(yyyy, @Year - 1900, 0)
SELECT @LastDateOfYear = DATEADD(yyyy, @Year - 1900 + 1, 0)
-- Creating Query to Prepare Year Data
;WITH cte AS (
SELECT 1 AS DayID,
@FirstDateOfYear AS FromDate,
DATENAME(dw, @FirstDateOfYear) AS Dayname
UNION ALL
SELECT cte.DayID + 1 AS DayID,
DATEADD(d, 1 ,cte.FromDate),
DATENAME(dw, DATEADD(d, 1 ,cte.FromDate)) AS Dayname
FROM cte
WHERE DATEADD(d,1,cte.FromDate) < @LastDateOfYear
)
SELECT FromDate AS Date, Dayname
FROM CTE
WHERE DayName IN ('Saturday','Sunday')
/*
WHERE DayName IN ('Saturday,Sunday') -- For Weekend
WHERE DayName NOT IN ('Saturday','Sunday') -- For Weekday
WHERE DayName LIKE 'Monday' -- For Monday
WHERE DayName LIKE 'Sunday'-- For Sunday
*/
OPTION (MaxRecursion 370)

