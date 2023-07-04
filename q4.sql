-- při tvorbě tohoto dotazu jsem využil selecty z předchozího dotazu
-- začal jsem základním pohledem na data cen produktů
CREATE OR REPLACE VIEW v_q4price_1 AS
SELECT DISTINCT 
	`year`,
	product_name,
	avg_price_value
FROM t_jan_pelisek_project_sql_primary_final
ORDER BY product_name, `year`

-- přidal jsem LAG() funkci pro zobrazení předchozích hodnot cen
-- přidal jsem výpočet meziročního procentuálního nárustu
CREATE OR REPLACE VIEW v_q4price_2 AS
SELECT 
	*,
	LAG(avg_price_value, 1) OVER (PARTITION BY product_name ORDER BY `year` ASC) AS previous_price_value,
	round(((avg_price_value - 	LAG(avg_price_value, 1) OVER (PARTITION BY product_name ORDER BY `year` ASC))/ 	LAG(avg_price_value, 1) OVER (PARTITION BY product_name ORDER BY `year` ASC)) * 100, 2) AS perc_narust_price
FROM v_q4price_1

-- do finální tabulky s daty o cenách jsem dal výpočet průměrného procentuálního nárůstu
CREATE OR REPLACE TEMPORARY TABLE tt_pricerise
SELECT 
	`year`,
	round(avg(perc_narust_price), 2) AS avg_price_rise
FROM v_q4price_2
GROUP BY `year`

SELECT * FROM tt_pricerise

-- základní pohled na data mezd
CREATE OR REPLACE VIEW v_q4pay_1 AS
SELECT DISTINCT
	`year`,
	industry_branch_name ,
	avg_payroll_value
FROM t_jan_pelisek_project_sql_primary_final
ORDER BY product_name, `year`

-- přidal jsem LAG() funkci pro zobrazení předchozích hodnot mezd
-- přidal jsem výpočet meziročního nárůstu mezd		
CREATE OR replace VIEW v_q4pay_2 AS
SELECT 
	*,
	LAG(avg_payroll_value, 1) OVER (PARTITION BY industry_branch_name ORDER BY `year` ASC) AS previous_pay_value,
	round(((avg_payroll_value - LAG(avg_payroll_value, 1) OVER (PARTITION BY industry_branch_name ORDER BY `year` ASC))/ LAG(avg_payroll_value, 1) OVER (PARTITION BY industry_branch_name ORDER BY `year` ASC)) * 100, 2) AS perc_narust_pay
FROM v_q4pay_1

-- do finální tabulky s daty mezd jsem setjně jako do finální tabulky s daty cen dal výpočet pro půměrný nárůst v procentech
CREATE OR REPLACE TEMPORARY TABLE tt_payrise
SELECT
	`year`,
	round(avg(perc_narust_pay), 2) AS avg_pay_rise
FROM v_q4pay_3
GROUP BY `year`

-- a nakonec jsem vytvořil finální dotaz
SELECT
	tpi.`year`,
	tpy.`avg_pay_rise`,
	tpi.avg_price_rise,
	abs(tpy.avg_pay_rise - tpi.avg_price_rise) AS difference
FROM tt_payrise tpy
JOIN tt_pricerise tpi ON tpi.`year` = tpy.`year`
ORDER BY difference DESC 
