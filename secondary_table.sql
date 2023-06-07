-- tvorba sekundární tabulky t_jan_pelisek_project_sql_secondary_final
-- tuto tabulku jsem vytvořil spojením tabulek economies a countries přes sloupec country, data ve výsledné tabulce jsem omezil na sledované období a pouze na evropské země

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
