WITH price_default AS (
SELECT DISTINCT 
	`year`,
	product_name,
	avg_price_value
FROM t_jan_pelisek_project_sql_primary_final
ORDER BY product_name, `year`
),
price_rise AS (
SELECT
	*, -- přidal jsem výpočet meziročního procentuálního nárustu
	LAG(avg_price_value, 1) OVER (PARTITION BY product_name ORDER BY `year` ASC) AS previous_price_value,
	round(((avg_price_value - 	LAG(avg_price_value, 1) OVER (PARTITION BY product_name ORDER BY `year` ASC))/ 	LAG(avg_price_value, 1) OVER (PARTITION BY product_name ORDER BY `year` ASC)) * 100, 2) AS perc_narust_price
FROM price_default
),
avg_price_rise AS (
SELECT 
	`year`,
	round(avg(perc_narust_price), 2) AS avg_price_rise
FROM price_rise
GROUP BY `year`
),
pay_default AS(
SELECT DISTINCT
	`year`,
	industry_branch_name ,
	avg_payroll_value
FROM t_jan_pelisek_project_sql_primary_final
ORDER BY product_name, `year`
),
pay_rise AS (
SELECT 
	*,	
	LAG(avg_payroll_value, 1) OVER (PARTITION BY industry_branch_name ORDER BY `year` ASC) AS previous_pay_value,
	round(((avg_payroll_value - LAG(avg_payroll_value, 1) OVER (PARTITION BY industry_branch_name ORDER BY `year` ASC))/ LAG(avg_payroll_value, 1) OVER (PARTITION BY industry_branch_name ORDER BY `year` ASC)) * 100, 2) AS perc_narust_pay
FROM pay_default
),
avg_pay_rise AS (
SELECT
	`year`,
	round(avg(perc_narust_pay), 2) AS avg_pay_rise
FROM pay_rise
GROUP BY `year`
)
SELECT
	api.`year`,
	apy.`avg_pay_rise`,
	api.avg_price_rise,
	abs(apy.avg_pay_rise - api.avg_price_rise) AS difference
FROM avg_pay_rise apy
JOIN avg_price_rise api ON api.`year` = apy.`year`
ORDER BY difference DESC 
