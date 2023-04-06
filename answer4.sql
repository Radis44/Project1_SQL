-- dotaz 4: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

CREATE OR REPLACE TABLE t_prices_salary AS
SELECT
	`year` AS whole_year,
	ROUND (avg (avg_price),2) AS avg_year_price,
	ROUND (avg (avg_salary),2) AS avg_year_salary
FROM
	t_radek_ivaniskin_project_sql_primary_final
GROUP BY
	`year`;

SELECT *,
	ROUND ((((ps2.avg_year_price / ps.avg_year_price)* 100)-100),2) AS price_diff,
	ROUND ((((ps2.avg_year_salary / ps.avg_year_salary)* 100)-100),2) AS salary_diff,
	(ROUND ((((ps2.avg_year_price / ps.avg_year_price)* 100)-100),2)) - (ROUND ((((ps2.avg_year_salary / ps.avg_year_salary)* 100)-100),2)) AS diff
FROM
	t_prices_salary AS ps
JOIN t_prices_salary AS ps2  
    ON
	ps.whole_year = ps2.whole_year - 1 
;

