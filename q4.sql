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
CREATE OR REPLACE VIEW v_q4price_2 AS
SELECT 
	*,
	LAG(avg_price_value, 1) OVER (PARTITION BY product_name ORDER BY `year` ASC) AS previous_price_value
FROM v_q4price_1

-- přidal jsem výpočet meziročního procentuálního nárustu
CREATE OR REPLACE VIEW v_q4price_3 AS
SELECT *,
	round(((avg_price_value - previous_price_value)/ previous_price_value) * 100, 2) AS perc_narust_price
FROM v_q4price_2

-- do finální tabulky s daty o cenách jsem dal výpočet průměrného procentuálního nárůstu
CREATE OR REPLACE TEMPORARY TABLE tt_pricerise
SELECT 
	`year`,
	round(avg(perc_narust_price), 2) AS avg_price_rise
FROM v_q4price_3
GROUP BY `year`

-- základní pohled na data mezd
CREATE OR REPLACE VIEW v_q4pay_1 AS
SELECT DISTINCT
	`year`,
	industry_branch_name ,
	avg_payroll_value
FROM t_jan_pelisek_project_sql_primary_final
ORDER BY product_name, `year`

-- přidal jsem LAG() funkci pro zobrazení předchozích hodnot mezd	
CREATE OR replace VIEW v_q4pay_2 AS
SELECT 
	*,
	LAG(avg_payroll_value, 1) OVER (PARTITION BY industry_branch_name ORDER BY `year` ASC) AS previous_pay_value
FROM v_q4pay_1

-- přidal jsem výpočet meziročního nárůstu mezd	
CREATE OR REPLACE VIEW v_q4pay_3 AS
SELECT *,
	round(((avg_payroll_value - previous_pay_value)/ previous_pay_value) * 100, 2) AS perc_narust_pay
FROM v_q4pay_2

-- do finální tabulky s daty mezd jsem setjně jako do finální tabulky s daty cen dal výpočet pro půměrný nárůst v procentech
CREATE OR REPLACE TEMPORARY TABLE tt_payrise
SELECT
	`year`,
	round(avg(perc_narust_pay), 2) AS avg_pay_rise
FROM v_q4pay_3
GROUP BY `year`

-- finální tabulku pro tento dotaz jsem získal spojením finálních tabulek mezd a cen
CREATE OR REPLACE TEMPORARY TABLE tt_pay_vs_price_rise AS
SELECT
	tpi.`year`,
	tpy.`avg_pay_rise`,
	tpi.avg_price_rise
FROM tt_payrise tpy
JOIN tt_pricerise tpi ON tpi.`year` = tpy.`year`

-- v posledním kroce stačilo dotazovat finální tabulku s jednoduchým výpočtem rozdílu	
SELECT 
	*,
	abs(avg_pay_rise - avg_price_rise) AS difference
FROM tt_pay_vs_price_rise
ORDER BY difference DESC
