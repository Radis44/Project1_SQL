-- dotaz 1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

-- 1.varianta - lze použít pro všechny kódy indrustry - časová řada pro odvětví ukáže, zda mzdy klesají

SELECT DISTINCT `year`, code, industry, avg_salary  
FROM t_radek_ivaniskin_project_sql_primary_final 
WHERE code = 'A';


-- 2.varianta - lze použít pro všechny kódy, záporná hodnota salary_diff znamená meziroční pokles mezd

CREATE OR REPLACE TABLE t_average_salary_A
SELECT DISTINCT 
	`year`,
	code,
	industry,
	avg_salary
FROM
	t_radek_ivaniskin_project_sql_primary_final
WHERE
	code = 'A';

SELECT
	tasa.code,
	tasa.industry,
	tasa.`year`,
	tasa.avg_salary,
	tasa2.`year`,
	tasa2.avg_salary,
	tasa.avg_salary - tasa2.avg_salary AS salary_diff
FROM
	t_average_salary_a tasa
JOIN t_average_salary_a tasa2  
    ON
	tasa.code = tasa2.code
	AND tasa.`year` = tasa2.`year` + 1 ;



