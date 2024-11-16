-- Get the products that have the highest and lowest manufacturing costs.
-- The final output should contain these fields,
-- product_code
-- product
-- manufacturing_cost

SELECT 
	P.product_code, 
    P.product,
    M.manufacturing_cost
FROM 
	dim_product AS P INNER JOIN fact_manufacturing_cost AS M
	ON P.product_code = M.product_code
WHERE M.manufacturing_cost IN 
	(
    SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost
	UNION
	SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost
    )
ORDER BY manufacturing_cost DESC;