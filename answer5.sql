-- dotaz 5: Má výška HDP vliv na změny ve mzdách a cenách potravin? 
-- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách 
-- ve stejném nebo násdujícím roce výraznějším růstem?

CREATE OR REPLACE TABLE t_cz_prices_gdp AS
SELECT
	hdp.country,
	ps.whole_year,
	ps.avg_year_price,
	ps.avg_year_salary,
	hdp.GDP
FROM
	t_prices_salary AS ps
JOIN t_radek_ivaniskin_project_sql_secondary_final AS hdp  
    ON
	ps.whole_year = hdp.`year`
WHERE
	hdp.country = 'Czech Republic';

SELECT
	cz.country,
	cz2.whole_year,
	-- cz.avg_year_price,
	-- cz.avg_year_salary,
	-- cz.GDP,
	-- cz2.whole_year AS 'whole_year + 1',
	-- cz2.avg_year_price,
	-- cz2.avg_year_salary,
	-- cz2.GDP,
	ROUND ((((cz2.avg_year_price / cz.avg_year_price)* 100)-100),2) AS price_diff,
	ROUND ((((cz2.avg_year_salary / cz.avg_year_salary)* 100)-100),2) AS salary_diff,
	ROUND ((((cz2.GDP / cz.GDP)* 100)-100),2) AS GDP_diff
FROM
	t_cz_prices_gdp AS cz
JOIN t_cz_prices_gdp AS cz2  
    ON
	cz.whole_year = cz2.whole_year - 1 ;