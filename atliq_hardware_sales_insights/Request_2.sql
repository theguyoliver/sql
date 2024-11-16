-- What is the percentage of unique product increase in 2021 vs. 2020? The
-- final output contains these fields,
-- unique_products_2020
-- unique_products_2021
-- percentage_chg

SELECT 
	X.A AS unique_products_2020,
	Y.B AS unique_product_2021, 
    ROUND(((Y.B-X.A)* 100/X.A), 2) AS percentage_chg
FROM
	(SELECT COUNT(DISTINCT(product_code)) AS A
	 FROM fact_manufacturing_cost 
	 WHERE cost_year = 2020) X,
	(SELECT COUNT(DISTINCT(product_code)) AS B
	 FROM fact_manufacturing_cost
	 WHERE cost_year = 2021) Y;
