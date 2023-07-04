-- za použití LAG() funkce vytvořil nový sloupec dat, která značila průměrnou mzdu z předchozího roku pro danné odvětví.
-- použil jsem funkci case pro nový sloupec dat, kde 1 = nynější průměrná mzda je vyšší než ta z minulého roku a 0 = nynější průměrná mzda je nižší než ta z minulého roku.
WITH cte_q1 AS (
SELECT 
	`year`,
	industry_branch_name,
	avg_payroll_value,
	LAG(avg_payroll_value,1) OVER (PARTITION BY industry_branch_name ORDER BY `year`) AS previous_payroll,
	CASE 
		WHEN LAG(avg_payroll_value,1) OVER (PARTITION BY industry_branch_name ORDER BY `year`) < avg_payroll_value THEN 1
		ELSE 0
	END is_rising
FROM t_jan_pelisek_project_sql_primary_final
GROUP BY industry_branch_name, `year`
)
SELECT * FROM cte_q1 -- nakonec jsem zadal dotaz na finální view a vytáhl si pouze data, kde mzdy vůči předchozímu roku klesly.
WHERE previous_payroll IS NOT NULL AND is_rising = 0
-- nepočítal jsem s možností, kde by byly mzdy za oba porovnávané roky stejné, protože je velice nepravděpodobná. Pokud by ta situace nastala, řešil by jsem ji tím, že by jsem do sloupce `is_rising` dal pouze hodnoty 0 a zbytek by jsem nechal NULL.
