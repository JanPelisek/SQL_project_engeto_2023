-- začal jsem vytvořením dvou dočasných tabulek. První jsem vytvořil spojením tabulek s daty o cenách základních potravin a druhou spojením tabulek s daty mezd. 
-- po vytvoření těchto dočasných tabulek, je stačilo pouze spojit a vytvořit tím finální tabulku, ve které nebylo potřeba nic upravovat.

CREATE TEMPORARY TABLE czechia_price_temporary AS
SELECT
	YEAR(cp.date_from) AS 'year', 
	cpc.code,
	cpc.name,
	round(AVG(cp.value),2) AS 'avg_price_value', 
	cpc.price_unit 
FROM czechia_price cp
JOIN czechia_price_category cpc
	ON cp.category_code = cpc.code
GROUP BY YEAR(cp.date_from), name 

CREATE TEMPORARY TABLE czechia_payroll_temporary AS
SELECT
	cp.payroll_year AS 'year',
	cpib.code,
	cpib.name AS 'industry_branch_name',
	round(avg(CP.value)) AS 'avg_payroll_value' 
FROM czechia_payroll cp
LEFT JOIN czechia_payroll_industry_branch cpib -- pomocí LEFT JOIN jsem se zbavil NULL hodnot
	ON cp.industry_branch_code = cpib.code
WHERE cp.value_type_code = 5958 -- = pouze data o mzdách
	AND cp.calculation_code = 200 -- = pouze data pro přepočtený počet zaměstnanců na plný úvazek
	AND cp.payroll_year BETWEEN 2006 AND 2018
	AND cp.industry_branch_code IS NOT NULL
GROUP BY cpib.name, cp.payroll_year
ORDER BY cpib.name, cp.payroll_year

CREATE OR REPLACE TABLE t_jan_pelisek_project_SQL_primary_final AS
SELECT
	cpayt.year,
	cpayt.code AS 'branch_code',
	cpayt.industry_branch_name,
	cpayt.avg_payroll_value,
	cpricet.code AS 'product_code',
	cpricet.name AS 'product_name',
	cpricet.avg_price_value,
	cpricet.price_unit
FROM czechia_payroll_temporary cpayt
JOIN czechia_price_temporary cpricet
	ON cpayt.year = cpricet.year

SELECT * FROM t_jan_pelisek_project_sql_primary_final
