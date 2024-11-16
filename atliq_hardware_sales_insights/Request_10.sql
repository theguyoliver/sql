-- Get the Top 3 products in each division that have a high
-- total_sold_quantity in the fiscal_year 2021? The final output contains these
-- fields;
-- division
-- product_code
-- product
-- total_sold_quantity
-- rank_order

WITH CTE1 AS
		(
        SELECT P.product_code, P.product, P.division, SUM(S.sold_quantity) AS total_quantity 
		FROM dim_product AS P JOIN fact_sales_monthly AS S
		ON P.product_code = S.product_code
		WHERE S.fiscal_year = 2021
		GROUP BY P.product_code, P.division, P.product
        ),
	CTE2 AS
		(
        SELECT 
			division, 
			product_code, 
			total_quantity, 
			RANK() OVER(PARTITION BY division ORDER BY total_quantity desc) AS Rank_Order
		FROM
			CTE1
		)
SELECT CTE1.division, CTE1.product_code, CTE1.product, CTE2.total_quantity, CTE2.Rank_Order
FROM CTE1 JOIN CTE2 
ON CTE1.product_code = CTE2.product_code
WHERE CTE2.Rank_Order IN (1,2,3);