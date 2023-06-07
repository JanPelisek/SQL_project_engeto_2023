CREATE TABLE t_jan_pelisek_project_sql_secondary_final AS
SELECT
	c.country,
	e.`year`,
	c.population,
	e.GDP,
	e.gini 
FROM countries c
JOIN economies e
	ON e.country = c.country 
WHERE e.`year` BETWEEN 2006 AND 2018
	AND c.continent = 'Europe'
GROUP BY e.`year`, c.country;
