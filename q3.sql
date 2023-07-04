-- pro řešení tohoto dotazu jsem využil tří common table expressions, postupně jsem pomocí nich získával potřebné údaje
WITH cte_q3 AS (  
SELECT DISTINCT -- select pro výchozí data
	`year`,
	product_name,
	avg_price_value
FROM t_jan_pelisek_project_sql_primary_final
ORDER BY product_name, `year`
    ),
cte2_q3 AS (
    SELECT -- select s funkcí LAG() pro výpočet předchozí ceny produktu
	*,
	LAG(avg_price_value, 1) OVER (PARTITION BY product_name ORDER BY `year` ASC) AS previous_price_value
FROM cte_q3
	),
cte3_q3 AS (
SELECT *, -- select s výpočtem meziročního procentuálního nárůstu cen produktů
	round(((avg_price_value - previous_price_value)/ previous_price_value) * 100, 2) AS perc_narust
FROM cte2_q3
)
SELECT -- finální select s výpočtem pro průměrný percentuální nárůst produktů za celé sledované období
	product_name,
	round(avg(perc_narust), 2) AS perc_narust_final
FROM cte3_q3
GROUP BY product_name 
ORDER BY perc_narust_final ASC
