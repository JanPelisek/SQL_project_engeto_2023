WITH cte_q1 AS (
SELECT 
	`year`,
	industry_branch_name,
	avg_payroll_value,
	LAG(avg_payroll_value,1) OVER (PARTITION BY industry_branch_name ORDER BY `year`) AS previous_payroll,
	CASE 
		WHEN LAG(avg_payroll_value,1) OVER (PARTITION BY industry_branch_name ORDER BY `year`) < avg_payroll_value THEN 1 -- = nynější průměrná mzda je vyšší než ta z minulého roku
		ELSE 0 -- = nynější průměrná mzda je nižší než ta z minulého roku
	END is_rising
FROM t_jan_pelisek_project_sql_primary_final
GROUP BY industry_branch_name, `year`
)
SELECT * FROM cte_q1
WHERE previous_payroll IS NOT NULL AND is_rising = 0
ORDER BY `year`
-- nepočítal jsem s možností, kde by byly mzdy za oba porovnávané roky stejné, protože je velice nepravděpodobná. Pokud by ta situace nastala, řešil by jsem ji tím, že by jsem do sloupce `is_rising` dal pouze hodnoty 0 a zbytek by jsem nechal NULL.
