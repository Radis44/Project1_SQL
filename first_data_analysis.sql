-- czechia payroll propojeni s: 
-- value type code hodnota '316' prum pocet zamest, hodnota '5958' prum mzda
-- unit code - souvisi s value type - Kc vs tis zamest. 
-- calculation code - hodnoty 100 a 200 - fyzicky, prepocteny
-- industry branch code - hodnoty A - S - popis odvetvi
-- year 2000 - 2021 bez NULL hodnot

SELECT
	DISTINCT min (payroll_year),
	max (payroll_year)
FROM
	czechia_payroll
WHERE
	payroll_year IS NOT NULL ;

SELECT
	DISTINCT payroll_year
FROM
	czechia_payroll
ORDER BY
	payroll_year ;

-- czechia price - propojeni s: 
-- category code - 27 unikatnich kategorii zbozi s objemem (price value) a mernou jednotkou (kg, l, atd.)
-- date from to - casove rozmezi po tydnech, v letech 2006 - 2018
-- czechia region code - kod + nazev 14 kraju CR 

SELECT
	min (YEAR (date_from))
FROM
	czechia_price cp ;

SELECT
	max (YEAR (date_from))
FROM
	czechia_price cp ;

SELECT
	DISTINCT YEAR (date_from)
FROM
	czechia_price cp
ORDER BY
	YEAR (date_from);

-- tabulky countries, economies
-- propojeni pres country
-- NULL hodnoty v country nejsou
-- obdobi 1960 - 2020

SELECT
	*
FROM
	countries
WHERE
	country IS NULL;

SELECT
	*
FROM
	economies
WHERE
	country IS NULL;

SELECT
	DISTINCT `year`
FROM
	economies
ORDER BY
	`year` ;

-- czechia price - selekce dat + výpočet avg price
	
SELECT
	YEAR (cp.date_from) AS 'year',
	cp.category_code,
	cpc.name AS 'product',
	ROUND (avg (cp.value), 2) AS avg_price
FROM
	czechia_price AS cp
JOIN czechia_price_category AS cpc ON cp.category_code = cpc.code
WHERE
	YEAR (cp.date_from) >= 2006 AND YEAR (cp.date_from) <= 2018
GROUP BY
	YEAR (cp.date_from), cpc.name
ORDER BY
	YEAR (cp.date_from);

-- kontrola price

SELECT
	cpc.name,
	avg (cp.value)
FROM
	czechia_price AS cp
JOIN czechia_price_category AS cpc 
ON
	cp.category_code = cpc.code
WHERE
	cpc.code = 2000001
	AND YEAR (cp.date_from) = 2006 ;

SELECT
	cpc.name,
	avg (cp.value),
	sum (value) / count (*)
FROM
	czechia_price AS cp
JOIN czechia_price_category AS cpc 
ON
	cp.category_code = cpc.code
WHERE
	cpc.code = 212101
	AND YEAR (cp.date_from) = 2006 ;


SELECT
	sum (value) / count (*),
	avg (cp.value)
FROM
	czechia_price cp
WHERE
	category_code = 112101
	AND YEAR (cp.date_from) = 2008;


SELECT *
FROM
	czechia_price AS cp
JOIN czechia_price_category AS cpc 
ON
	cp.category_code = cpc.code
WHERE
	cpc.code = 212101
ORDER BY date_from 
;


-- czechia payroll

SELECT
	cp.payroll_year AS 'year',
	cpib.code,
	cpib.name AS 'industry',
	sum (cp.value) / count(*) AS 'avg_payroll'
FROM
	czechia_payroll AS cp
JOIN czechia_payroll_value_type AS cpvt ON cp.value_type_code = cpvt.code
LEFT JOIN czechia_payroll_industry_branch AS cpib  ON cp.industry_branch_code = cpib.code
WHERE
	cp.value IS NOT NULL AND cpib.code IS NOT NULL
	AND cp.value_type_code = 5958
	AND cp.payroll_year >= 2006 AND cp.payroll_year <= 2018
	AND cp.calculation_code = 100
GROUP BY
	cp.payroll_year,
	cpib.code ;

-- kontrola payroll

SELECT *
FROM czechia_payroll AS cp
WHERE payroll_year = 2006 AND value_type_code = 5958 AND industry_branch_code = 'A' ;

SELECT sum (cp.value) / count(*) AS 'avg_payroll', avg (value)
FROM czechia_payroll AS cp
WHERE payroll_year = 2012 AND value_type_code = 5958 AND calculation_code = 100 AND industry_branch_code = 'I' ;


-----------------------------------------------------------------------