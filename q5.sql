WITH cte_gdp AS (
SELECT
	`year`,
	country,
	GDP,
	LAG(GDP) OVER (ORDER BY `year` ASC) AS gdp_previous_year,
	round(((GDP - LAG(GDP) OVER (ORDER BY `year`))/ LAG(GDP) OVER (ORDER BY `year` ASC)) * 100, 2) AS gdp_rise
FROM t_jan_pelisek_project_sql_secondary_final
WHERE country = 'Czech Republic'
),
price_default AS (
SELECT DISTINCT 
	`year`,
	product_name,
	avg_price_value
FROM t_jan_pelisek_project_sql_primary_final
ORDER BY product_name, `year`
),
price_rise AS (
SELECT
	*,
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
	gdp.`year`,
	gdp.gdp_rise,
	apy.avg_pay_rise,
	api.avg_price_rise
FROM cte_gdp gdp
JOIN avg_pay_rise apy ON apy.`year` = gdp.`year`
JOIN avg_price_rise api ON api.`year` = gdp.`year`
