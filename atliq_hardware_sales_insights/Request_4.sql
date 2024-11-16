-- Follow-up: Which segment had the most increase in unique products in
-- 2021 vs 2020? The final output contains these fields,
-- segment
-- product_count_2020
-- product_count_2021
-- difference

WITH pc_2020 (segment, A) AS 
		(
        SELECT P.segment, COUNT(DISTINCT(M.product_code)) AS A 
		FROM fact_manufacturing_cost AS M JOIN dim_product AS P
		ON M.product_code = P.product_code
		WHERE cost_year = 2020
		GROUP BY P.segment
        ),
	pc_2021 (segment, A) AS
		(
        SELECT P.segment, COUNT(DISTINCT(M.product_code)) AS A 
		FROM fact_manufacturing_cost AS M JOIN dim_product AS P
		ON M.product_code = P.product_code
		WHERE cost_year = 2021
		GROUP BY P.segment
        )
SELECT 
	pc_2020.segment AS segment, 
    pc_2020.A AS product_count_2020,
    pc_2021.A AS product_count_2021,
    (pc_2021.A - pc_2020.A) AS difference
FROM 
	pc_2020, pc_2021
    WHERE pc_2020.segment = pc_2021.segment;
