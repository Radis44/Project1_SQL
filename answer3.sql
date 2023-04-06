-- dotaz 3: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

CREATE OR REPLACE TABLE t_avg_price
SELECT `year`, category_code, product, avg_price  
FROM t_radek_ivaniskin_project_sql_primary_final AS pri
GROUP BY `year`, category_code  
; 

CREATE OR REPLACE VIEW v_prices AS
SELECT tap.category_code, tap.product, tap.`year`, tap.avg_price, tap2.`year` AS 'year+1', tap2.avg_price AS 'avg_price+1',
ROUND ((((tap2.avg_price / tap.avg_price)*100)-100),2) AS pct_increase 
FROM
	t_avg_price AS tap
LEFT JOIN t_avg_price AS tap2  
    ON
	tap.category_code = tap2.category_code 
	AND tap.`year` = tap2.`year` -1
WHERE tap.`year` <= 2017 
ORDER BY ROUND ((((tap2.avg_price / tap.avg_price)*100)-100),2);

SELECT *
FROM v_prices vp 
WHERE pct_increase > 0
ORDER BY pct_increase
LIMIT 1;

-- dotaz 4: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

-- dotaz 5: Má výška HDP vliv na změny ve mzdách a cenách potravin? 
-- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách 
-- ve stejném nebo násdujícím roce výraznějším růstem?