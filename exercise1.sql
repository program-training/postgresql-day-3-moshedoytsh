-- Active: 1694602835533@@127.0.0.1@5432@northwind@public
-- 1
SELECT employees.last_name || ' ' || employees.first_name as full_name, COUNT(orders.order_id)
FROM employees LEFT OUTER JOIN orders
ON orders.employee_id = employees.employee_id
GROUP BY full_name;

-- 2
SELECT categories.category_name, SUM(order_details.quantity * order_details.unit_price * (1 - order_details.discount)) AS total_sales
FROM categories LEFT OUTER JOIN products
ON categories.category_id = products.category_id
LEFT OUTER JOIN order_details
ON products.product_id = order_details.product_id
GROUP BY categories.category_name
ORDER BY total_sales DESC;

-- 3
WITH order_with_total AS (
    SELECT orders.order_id,
           orders.customer_id,
           SUM(order_details.quantity * order_details.unit_price * (1 - order_details.discount)) AS total_for_order
    FROM orders JOIN order_details on orders.order_id = order_details.order_id
    GROUP BY orders.order_id
)
SELECT customers.company_name, AVG(order_with_total.total_for_order) as average_order_price
FROM customers JOIN order_with_total ON customers.customer_id = order_with_total.customer_id
GROUP BY customers.company_name
ORDER BY average_order_price DESC;

-- 4
SELECT customers.*, SUM(order_details.quantity * order_details.unit_price * (1 - order_details.discount)) total_orders
FROM customers JOIN orders ON customers.customer_id = orders.customer_id
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY customers.customer_id
ORDER BY total_orders DESC
LIMIT 10;

-- 5
SELECT EXTRACT(MONTH FROM orders.order_date) as month, SUM(order_details.unit_price * order_details.quantity * (1 - order_details.discount)) as total_sales
FROM order_details LEFT OUTER JOIN orders ON orders.order_id = order_details.order_id
GROUP BY month
ORDER BY month;

-- 6
SELECT product_name, units_in_stock
FROM products 
WHERE units_in_stock < 10;

-- 7
WITH order_with_total AS (
    SELECT orders.order_id,
           orders.customer_id,
           SUM(order_details.quantity * order_details.unit_price * (1 - order_details.discount)) AS total_for_order
    FROM orders JOIN order_details on orders.order_id = order_details.order_id
    GROUP BY orders.order_id
)
SELECT customers.company_name, order_with_total.total_for_order as highest_order
FROM customers JOIN order_with_total ON customers.customer_id = order_with_total.customer_id
ORDER BY highest_order DESC
LIMIT 1;

-- 8
SELECT orders.ship_country, SUM(order_details.unit_price * order_details.quantity * (1 - order_details.discount)) as total_revenue
FROM orders LEFT OUTER JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY orders.ship_country
ORDER BY total_revenue DESC;

-- 9
SELECT shippers.company_name, COUNT(orders.order_id) as orders_shipped
FROM shippers INNER JOIN orders ON shippers.shipper_id = orders.ship_via
GROUP BY shippers.company_name
ORDER BY orders_shipped DESC
LIMIT 1;

-- 10
SELECT products.*
FROM products LEFT OUTER JOIN order_details ON products.product_id = order_details.product_id
WHERE order_details.order_id is NULL;