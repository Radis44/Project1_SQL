-- dotaz 2: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

SELECT DISTINCT 
	`year`,
	product,
	avg_price,
	ROUND (sum (avg_salary) / count (avg_salary),
	2) AS year_salary_avg,
	ROUND (((sum (avg_salary) / count (avg_salary)) / avg_price)) AS unit_avg,
	ROUND (((sum (avg_salary) / count (avg_salary)) / avg_price) * 12) AS unit_year
FROM
	t_radek_ivaniskin_project_sql_primary_final AS pri
WHERE
	category_code IN (114201, 111301)
	AND `year` IN (2006, 2018)
GROUP BY
	`year`,
	product ;

