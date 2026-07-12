{{
  config(
    materialized = "table"
  )
}}

SELECT 
  order_id,
  order_date,
  TRIM(SPLIT(order_status, '-')[SAFE_OFFSET(0)]) as order_status_category,
  TRIM(SPLIT(order_status, "-")[SAFE_OFFSET(1)]) as order_status,
  fulfillment,
  sales_channel,
  ship_service_level,
  currency,
  ship_city,
  ship_state,
  ship_postal_code,
  ship_country_code,
  promotion_ids,
  is_b2b,
  fulfilled_by,
  sum(amount) as order_amount,
  count(*) as items_in_order
from {{ ref('br_fashionable_sales_report')}}
group by   order_id,
  order_date,
  TRIM(SPLIT(order_status, '-')[SAFE_OFFSET(0)]),
  TRIM(SPLIT(order_status, "-")[SAFE_OFFSET(1)]),
  fulfillment,
  sales_channel,
  ship_service_level,
  courier_status,
  currency,
  ship_city,
  ship_state,
  ship_postal_code,
  ship_country_code,
  promotion_ids,
  is_b2b,
  fulfilled_by