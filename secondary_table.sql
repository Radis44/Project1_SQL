CREATE OR REPLACE
TABLE t_radek_ivaniskin_project_SQL_secondary_final AS
SELECT
	c.country,
	e.`year`,
	e.GDP,
	e.gini,
	e.population
FROM
	countries AS c
JOIN economies AS e
ON
	c.country = e.country
WHERE
	c.continent = 'Europe'
	AND e.`year` >= 2006
	AND e.`year` <= 2018
ORDER BY
	c.country,
	e.`year`;





