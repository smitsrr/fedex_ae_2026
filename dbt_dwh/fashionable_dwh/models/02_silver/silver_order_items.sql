
-- By default all models are materialized as views and I make no performance considerations
-- In a production environment I would assess daily performance and import patterns
-- to establish incremental imports where possible to balance cost and time. 

SELECT
    index as order_item_id,
   ASIN,
   order_id,
   order_date,
   style_code, 
   sku,
   category,
   size,
   quantity,
   amount
FROM {{ ref('br_fashionable_sales_report') }}