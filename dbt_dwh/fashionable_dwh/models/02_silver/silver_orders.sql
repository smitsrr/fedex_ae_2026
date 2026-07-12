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
  -- Currency is fairly often null - how can this be? 
  currency,
  -- Tableau was able to interpret these as geo fields, and I would make sure
  -- that whatever BI tool we use can also have a geo-based field
  ship_city,
  -- There is a ton of messiness in the city-field - misspellings and 
  -- variations. I would invest in cleaning these up
  ship_state,
  ship_postal_code,
  ship_country_code,
  -- The courier status contains whether the item is really fulfilled, since items
  -- can be shipped separately. I would work with the business to try to roll that up
  -- in a meaningful way here. 
  promotion_ids,
  is_b2b,
  fulfilled_by,
  sum(amount) as order_amount,
  -- I find it quite annoying that order_amount is NULL, which is almost certainly
  -- because this is from a downstream report. Ideally we would be able to get the 
  -- 'initial order value', or equivalent to keep track of the cost of returns, 
  -- and cancelled orders, for instance. 
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

  -- With more time I would create a gold layer that is the protected
  -- user-interface layer with strict contracts on data types and columns. 