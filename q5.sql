-- s pomocí dočasných tabulek z předchozího dotazu tt_payrise a tt_pricerise
WITH cte_pay_price AS (
SELECT
	tpi.`year`,
	tpy.`avg_pay_rise`,
	tpi.avg_price_rise
FROM tt_payrise tpy
JOIN tt_pricerise tpi ON tpi.`year` = tpy.`year`
),
cte_GDP AS (
SELECT
	`year`,
	country,
	GDP,
	LAG(GDP) OVER (ORDER BY `year` ASC) AS gdp_previous_year,
	round(((GDP - LAG(GDP) OVER (ORDER BY `year`))/ LAG(GDP) OVER (ORDER BY `year` ASC)) * 100, 2) AS gdp_rise
FROM t_jan_pelisek_project_sql_secondary_final
WHERE country = 'Czech Republic'
)
SELECT 
	gdp.`year`,
	cpp.avg_pay_rise,
	cpp.avg_price_rise,
	gdp.gdp_rise
FROM cte_GDP gdp
JOIN cte_pay_price cpp ON gdp.`year` = cpp.`year`
