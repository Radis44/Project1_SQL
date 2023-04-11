CREATE OR REPLACE
TABLE t_radek_ivaniskin_project_SQL_primary1_final AS
	SELECT
	YEAR (cp.date_from) AS 'year',
	cp.category_code,
	cpc.name AS 'product',
	ROUND (avg (cp.value),2) AS avg_price
FROM
	czechia_price AS cp
JOIN czechia_price_category AS cpc ON
	cp.category_code = cpc.code
WHERE
	YEAR (cp.date_from) >= 2006
	AND YEAR (cp.date_from) <= 2018
GROUP BY
	YEAR (cp.date_from),
	cpc.name
ORDER BY
	YEAR (cp.date_from);

CREATE OR REPLACE
TABLE t_radek_ivaniskin_project_SQL_primary2_final AS
SELECT
	cp.payroll_year AS 'year',
	cpib.code,
	cpib.name AS 'industry',
	sum (cp.value) / count(*) AS 'avg_salary'
FROM
	czechia_payroll AS cp
JOIN czechia_payroll_value_type AS cpvt ON
	cp.value_type_code = cpvt.code
LEFT JOIN czechia_payroll_industry_branch AS cpib ON
	cp.industry_branch_code = cpib.code
WHERE
	cp.value IS NOT NULL
	AND cpib.code IS NOT NULL
	AND cp.value_type_code = 5958
	AND cp.payroll_year >= 2006
	AND cp.payroll_year <= 2018
	AND cp.calculation_code = 100
GROUP BY
	cp.payroll_year,
	cpib.code ;
	
CREATE OR REPLACE
TABLE t_radek_ivaniskin_project_SQL_primary_final AS 
SELECT
	pri1.`YEAR`,
	pri1.category_code,
	pri1.product,
	pri1.avg_price,
	pri2.code,
	pri2.industry,
	pri2.avg_salary,
	ROUND (pri2.avg_salary / pri1.avg_price) AS unit_per_salary 
FROM
	t_radek_ivaniskin_project_sql_primary1_final AS pri1
LEFT JOIN t_radek_ivaniskin_project_sql_primary2_final AS pri2
ON
	pri1.`YEAR` = pri2.`YEAR`
;