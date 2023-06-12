-- Tvorba datového podkladu pro první otázku
-- Jako podklad pro odpověď na první otázku jsem použil dva views.
CREATE OR REPLACE VIEW view_q1 AS -- V prvním jsem za použití LAG() funkce vytvořil nový sloupec dat, která značila průměrnou mzdu z předchozího roku pro danné odvětví.
SELECT 
	`year`,
	industry_branch_name,
	avg_payroll_value,
	LAG(avg_payroll_value,1) OVER (PARTITION BY industry_branch_name ORDER BY `year`) AS previous_payroll 
FROM t_jan_pelisek_project_sql_primary_final 
GROUP BY industry_branch_name, `year`

CREATE OR REPLACE VIEW view_q1_v2 AS -- V druhém view jsem použil funkci case pro nový sloupec dat, kde 1 = nynější průměrná mzda je vyšší než ta z minulého roku a 0 = nynější průměrná mzda je nižší než ta z minulého roku.
SELECT 
	`year`,
	industry_branch_name,
	avg_payroll_value,
	previous_payroll, 
	CASE 
		WHEN previous_payroll < avg_payroll_value THEN 1
		ELSE 0
	END is_rising
FROM view_q1 

SELECT * FROM view_q1_v2 -- nakonec jsem zadal dotaz na finální view a vytáhl si pouze data, kde mzdy vůči předchozímu roku klesly.
WHERE previous_payroll IS NOT NULL AND is_rising = 0

-- nepočítal jsem s možností, kde by byly mzdy za oba porovnávané roky stejné, protože je velice nepravděpodobná. Pokud by ta situace nastala, řešil by jsem ji tím, že by jsem do sloupce `is_rising` dal pouze hodnoty 0 a zbytek by jsem nechal NULL.
