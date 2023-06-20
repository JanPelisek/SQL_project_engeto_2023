CREATE OR REPLACE TEMPORARY TABLE t_q2_products AS
SELECT DISTINCT 
	`year`,
    product_name,
    product_code,
    avg_price_value,
    price_unit
FROM t_jan_pelisek_project_sql_primary_final
WHERE product_code IN (111301, 114201) AND `year` IN (2006, 2018);

SELECT * FROM t_q2_products vqp 

CREATE OR REPLACE VIEW v_q2_payroll AS 
SELECT DISTINCT 
	`year`,
	branch_code,
	industry_branch_name,
	avg_payroll_value
FROM t_jan_pelisek_project_sql_primary_final
WHERE `year` IN (2006, 2018);

SELECT * FROM v_q2_payroll

CREATE OR REPLACE TEMPORARY TABLE  t_q2_avg_payroll18 AS 
SELECT
	`year`,
	round(avg(avg_payroll_value), 2)
FROM v_q2_payroll vqp 
WHERE `year` = 2018

CREATE OR REPLACE TEMPORARY TABLE t_q2_avg_payroll AS
SELECT
	`year`,
	round(avg(avg_payroll_value), 2) AS avg_payroll
FROM v_q2_payroll vqp 
WHERE `year` = 2006

INSERT INTO t_q2_avg_payroll 
SELECT * FROM v_q2_avg_payroll18 

SELECT * FROM t_q2_avg_payroll

SELECT 
	ps.`year`,
	ps.product_name, 
	ps.avg_price_value, 
	ps.price_unit,
	pl.avg_payroll,
	concat(round(pl.avg_payroll / ps.avg_price_value, 2), ' ', ps.price_unit) AS units_per_payroll
FROM t_q2_products ps
JOIN t_q2_avg_payroll pl ON ps.`year` = pl.`year` 
