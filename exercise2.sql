-- 1
SELECT customers.*
FROM customers LEFT JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.order_id IS NULL;

-- 2
SELECT customers.company_name, COUNT(orders.order_id) AS number_of_orders
FROM customers JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.company_name
HAVING COUNT(orders.order_id) > 10;

-- 3
SELECT *
FROM products
WHERE products.unit_price > (SELECT AVG(unit_price) FROM products)

-- 5
SELECT country, count(customer_id) customers_in_country
FROM customers
GROUP BY country
HAVING count(customer_id) >= 5;

-- 6
SELECT customers.*
FROM customers LEFT JOIN orders ON customers.customer_id = orders.customer_id AND EXTRACT(YEAR FROM orders.order_date) = 1998
WHERE orders.order_id IS NULL;

-- 7
SELECT customers.*
FROM customers LEFT JOIN orders ON customers.customer_id = orders.customer_id AND orders.order_date >= '1998-01-01'
WHERE customers.country = 'France' AND orders.order_id IS NULL;

-- 8
SELECT customers.*
FROM customers JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id
HAVING COUNT(orders.order_id) = 3;

-- 10
SELECT suppliers.*
FROM suppliers JOIN products ON suppliers.supplier_id = products.supplier_id
WHERE suppliers.country = 'USA'
GROUP BY suppliers.supplier_id
HAVING COUNT(products.product_id) > 1;
