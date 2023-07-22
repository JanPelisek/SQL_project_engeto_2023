WITH 
avg_price AS (
SELECT DISTINCT -- data cen pro požadované produkty a období
	`year`,
	product_name,
	product_code,
	avg_price_value,
	price_unit
FROM t_jan_pelisek_project_sql_primary_final
WHERE product_code IN (111301, 114201) AND `year` IN (2006, 2018)
),
pay_value AS (
SELECT DISTINCT -- data mez ze všech odvětví pro požadované období
	`year`,
	branch_code,
	industry_branch_name,
	avg_payroll_value
FROM t_jan_pelisek_project_sql_primary_final
WHERE `year` IN (2006, 2018)
), 
avg_pay AS (
SELECT -- průměrná mzda napříč odvětvími
	`year`,
	round(avg(avg_payroll_value), 2) AS avg_payroll
FROM pay_value
WHERE `year` = 2018
UNION
SELECT
	`year`,
	round(avg(avg_payroll_value), 2) AS avg_payroll
FROM pay_value
WHERE `year` = 2006
)
SELECT
	pr.`year`,
	pr.product_name, 
	pr.avg_price_value, 
	pr.price_unit,
	pl.avg_payroll,
	concat(round(pl.avg_payroll / pr.avg_price_value, 2), ' ', pr.price_unit) AS units_per_payroll
FROM avg_price pr
JOIN avg_pay pl ON pr.`year` = pl.`year` 
