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