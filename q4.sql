-- chybí t_v_q4_3 a t_v_q3_3
CREATE OR REPLACE TEMPORARY TABLE tt_payrise
SELECT 
	`year`,
	round(avg(perc_narust_pay), 2) AS avg_pay_rise
FROM t_v_q4_3 tvq
GROUP BY `year`

CREATE OR REPLACE TEMPORARY TABLE tt_pricerise
SELECT
	`year`,
	round(avg(perc_narust_price), 2) AS avg_price_rise
FROM t_v_q3_3
GROUP BY `year`

CREATE OR REPLACE TEMPORARY TABLE tt_pay_vs_price_rise AS
SELECT
	tpi.`year`,
	tpy.avg_pay_rise,
	tpi.avg_price_rise
FROM tt_payrise tpy
JOIN tt_pricerise tpi ON tpi.`year` = tpy.`year`

SELECT 
	*,
	avg_pay_rise - avg_price_rise AS difference
FROM tt_pay_vs_price_rise
