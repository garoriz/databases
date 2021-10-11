INSERT INTO products VALUES (4, 'cake', 0);

WITH cte_size_order AS (
 SELECT uniqueId,
 (CASE
 WHEN countOfProducts > 9
 THEN 'LARGE ORDER'
 ELSE 'SMALL ORDER'
 END) size_order
 FROM orders)
 SELECT uniqueId, size_order
from cte_size_order;

WITH cte_availability_products AS (
 SELECT uniqueId,
 name,
 (CASE
 WHEN count = 0
 THEN 'NO PRODUCTS'
 ELSE 'THERE ARE PRODUCTS'
 END) availability_products
 FROM products)
 SELECT uniqueId, name, availability_products
from cte_availability_products;