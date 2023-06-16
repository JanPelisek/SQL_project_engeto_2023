-- tvorba primární tabulky t_jan_pelisek_project_SQL_primary_final
-- k vytvoření této tabulky bylo zapotřebí spojit tabulky czechia_price, czechia_price_category, czechia_payroll a czechia_payroll_industry_brunch
-- začal jsem vytvořením dvou dočasných tabulek. První jsem vytvořil spojením tabulek s daty o cenách základních potravin a druhou spojením tabulek s daty mezd. Při tomto kroku jsem si z tabulek vytáhl pouze data, která nás v tomto projektu budou zajímat (tzn. v první tabulce jsem si data o časovém období upravil na roky a ceny potravin jsem si pro dané roky zprůměroval. V  druhé tabulce jsem si vybral pouze data o mzdách pro přepočtený počet zaměstnanců na plný úvazek a pouze pro období shodné s první tabulkou). V druhé tabulce jsem se pomocí LEFT JOIN zbavil NULL hodnot a upravil období tak, aby se shodovalo s obdobím v první tabulce.
-- po vytvoření těchto dočasných tabulek, je stačilo pouze spojit a vytvořit tím finální tabulku, ve které nebylo potřeba nic upravovat.
-- První jsem vytvořil spojením tabulek s daty o cenách základních potravin a druhou spojením tabulek s daty mezd. Při tomto kroku jsem si z tabulek vytáhl pouze data, která nás v tomto projektu budou zajímat


CREATE TEMPORARY TABLE czechia_price_temporary AS
SELECT
	YEAR(cp.date_from) AS 'year', -- data o časovém období jsem upravil na roky
	cpc.code,
	cpc.name,
	round(AVG(cp.value),2) AS 'avg_price_value', -- ceny potravin jsem si pro dané roky zprůměroval
	cpc.price_unit 
FROM czechia_price cp
JOIN czechia_price_category cpc
	ON cp.category_code = cpc.code
GROUP BY YEAR(cp.date_from), name 

SELECT * FROM czechia_price_temporary

CREATE TEMPORARY TABLE czechia_payroll_temporary AS
SELECT
	cp.payroll_year AS 'year',
	cpib.code,
	cpib.name AS 'industry_branch_name',
	round(avg(CP.value)) AS 'avg_payroll_value' 
FROM czechia_payroll cp
LEFT JOIN czechia_payroll_industry_branch cpib -- pomocí LEFT JOIN jsem se zbavil NULL hodnot
	ON cp.industry_branch_code = cpib.code
WHERE cp.value_type_code = 5958 -- pouze data o mzdách
	AND cp.calculation_code = 200 -- pouze data pro přepočtený počet zaměstnanců na plný úvazek
	AND cp.payroll_year BETWEEN 2006 AND 2018 -- pouze pro období shodné s první tabulkou
	AND cp.industry_branch_code IS NOT NULL
GROUP BY cpib.name, cp.payroll_year
ORDER BY cpib.name, cp.payroll_year

SELECT * FROM czechia_payroll_temporary

-- po vytvoření těchto dočasných tabulek, je stačilo pouze spojit a vytvořit tím finální tabulku, ve které nebylo potřeba nic upravovat.
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
