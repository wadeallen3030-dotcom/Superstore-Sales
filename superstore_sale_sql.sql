SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    AVG(discount) AS AVG_discount
FROM orders
GROUP BY category;

SELECT
    p.person,
    SUM(o.sales) AS total_sales,
    SUM(o.profit) AS total_profit
FROM orders o 
INNER JOIN people p
ON o.region = p.region
GROUP BY person;

-- Identify the top 5 Product Names 
--that have been returned most frequently. 

SELECT
    o.product_name,
    COUNT(r.order_id) as returned_time
FROM orders o 
INNER JOIN returns r 
ON o.order_id = r.order_id
GROUP BY o.product_name
ORDER BY COUNT(r.order_id) DESC
LIMIT 5;


-- List all Order IDs where the Profit was negative, 
-- and the Discount was higher than 0.3 (30%). Sort them by the biggest loss.

SELECT 
    order_id,
    profit
FROM orders
WHERE profit < 0
AND discount > 0.3
ORDER BY profit ASC

-- Calculate the average number of days it takes to ship an order (Ship Date - Order Date) 
-- for each Ship Mode.

SELECT
    ship_mode,
    AVG(DATE_TRUNC('day', ship_date) - DATE_TRUNC('day', order_date)) as day_to_ship
FROM orders
GROUP BY ship_mode

-- Calculate the total Profit lost due to returns per Region. (Compare the profit of 
-- orders in the Returns table vs. those that were kept).
WITH refunded_values AS(
    SELECT
        SUM(o.sales) AS refunded_value
    FROM orders o 
    INNER JOIN returns r 
    ON o.order_id = r.order_id
),

kept_values AS(
    SELECT 
        SUM(sales) AS total_kept
    FROM orders
    WHERE order_id NOT IN (
        SELECT 
            order_id
        FROM returns
        WHERE order_id IS NOT NULL
    )
)

SELECT
    rv.refunded_value,
    kv.total_kept,
    (rv.refunded_value + kv.total_kept) AS gross_value,
    (rv.refunded_value / (kv.total_kept + rv.refunded_value) *100) AS refund_rate_pct
FROM refunded_values rv, kept_values kv

-- Customer Loyalty: Find customers who have placed more than 10 orders but have 
-- never returned an item. These are your "VIP" targets.

WITH big_volume AS(
    SELECT
        o.customer_id,
        COUNT(DISTINCT o.order_id) AS unique_order
    FROM orders o 
    GROUP BY o.customer_id
    HAVING COUNT(DISTINCT o.order_id) > 10
),

no_refund AS(
    SELECT
        o.customer_id,
        CASE WHEN r.returned IS NULL THEN 'no_refund_customer'
        ELSE 'has_refund_customer'
        END AS refund_or_not
    FROM orders o 
    LEFT JOIN returns r 
    ON o.order_id = r.order_id
)

SELECT
    n.customer_id,
    b.unique_order,
    n.refund_or_not
FROM no_refund n
LEFT JOIN big_volume b 
ON n.customer_id = b.customer_id
WHERE unique_order > 10
AND refund_or_not = 'no_refund_customer'

SELECT 
    o.customer_id,
    COUNT(DISTINCT o.order_id) AS unique_order,
    'no_refund_customer' AS refund_or_not
FROM Orders o
LEFT JOIN Returns r 
    ON o.order_id = r.order_id
GROUP BY o.customer_id
HAVING COUNT(DISTINCT o.order_id) > 10  -- Big volume condition
   AND COUNT(r.order_id) = 0;

--  Segment Deep-Dive: For each Segment (Consumer, Corporate, etc.), 
--  calculate the percentage of total sales that come from the "West" region.
WITH west_sale AS(
    SELECT
        SUM(sales) as west_sales
    FROM orders
    WHERE region = 'West'
),

total_sale AS(
    SELECT
        SUM(sales) AS total_sales
    FROM orders
)

SELECT
    west_sales,
    total_sales,
    west_sales *100 / total_sales AS west_sales_pct
FROM total_sale, west_sale

-- import query:

SELECT
    o.order_id,
    o.order_date,
    o.ship_date,
    o.ship_mode,
    o.segment,
    o.customer_id,
    o.state,
    o.region,
    o.product_name,
    o.product_id,
    o.category,
    o.sub_category,
    o.sales,
    o.quantity,
    o.discount,
    o.profit,
   o.sales-o.profit AS cost,
    o.sales / (1-o.discount) AS original_price,
    (o.sales / NULLIF(1-o.discount, 0)) + o.profit - o.sales AS profit_without_discount,
    p.person,
    r.returned
FROM orders o 
LEFT JOIN people p 
ON o.region = p.region
LEFT JOIN returns r 
ON o.order_id = r.order_id
