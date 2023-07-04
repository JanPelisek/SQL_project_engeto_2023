-- vytvořil jsem si tabulku s daty pro požadované produkty v daném období
CREATE OR REPLACE TEMPORARY TABLE tt_q2_products AS
SELECT DISTINCT 
	`year`,
    product_name,
    product_code,
    avg_price_value,
    price_unit
FROM t_jan_pelisek_project_sql_primary_final
WHERE product_code IN (111301, 114201) AND `year` IN (2006, 2018);

-- pohled s daty pro požadované mzdy v daném období
CREATE OR REPLACE VIEW v_q2_payroll AS 
SELECT DISTINCT 
	`year`,
	branch_code,
	industry_branch_name,
	avg_payroll_value
FROM t_jan_pelisek_project_sql_primary_final
WHERE `year` IN (2006, 2018);

-- dočasná tabulka s průměrnou mzdou v roce 2018
CREATE OR REPLACE TEMPORARY TABLE  tt_q2_avg_payroll2018 AS 
SELECT
	`year`,
	round(avg(avg_payroll_value), 2)
FROM v_q2_payroll vqp 
WHERE `year` = 2018

-- dočasná tabulka s průměrnou mzdou v roce 2006
CREATE OR REPLACE TEMPORARY TABLE tt_q2_avg_payroll AS
SELECT
	`year`,
	round(avg(avg_payroll_value), 2) AS avg_payroll
FROM v_q2_payroll vqp 
WHERE `year` = 2006

-- finální tabulku pro data mezd jsem získal vložením dat z tt_q2_avg_payroll2018 do tt_q2_avg_payroll
INSERT INTO tt_q2_avg_payroll 
SELECT * FROM tt_q2_avg_payroll2018 

-- finální data jsem získal spojením finální tabulky pro data mezd s tabulkou pro data produktů
SELECT 
	ps.`year`,
	ps.product_name, 
	ps.avg_price_value, 
	ps.price_unit,
	pl.avg_payroll,
	concat(round(pl.avg_payroll / ps.avg_price_value, 2), ' ', ps.price_unit) AS units_per_payroll
FROM tt_q2_products ps
JOIN tt_q2_avg_payroll pl ON ps.`year` = pl.`year` 
