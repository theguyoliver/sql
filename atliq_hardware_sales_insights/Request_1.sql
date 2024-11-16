-- Provide the list of markets in which customer "Atliq Exclusive" operates its
-- business in the APAC region.

SELECT customer, market FROM dim_customer
WHERE region = 'APAC' AND customer = 'Atliq Exclusive'
GROUP BY market
ORDER BY market;