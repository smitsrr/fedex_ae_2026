SELECT index,
  `Order ID` as order_id,
  `Date` as order_date,
  `Status` as order_status,
  `Fulfilment` as fulfillment, -- note, typo?
  `Sales Channel ` as sales_channel,
  `ship-service-level` as ship_service_level,
  `style` as style_code,
  `SKU` as sku,
  `Category` as category,
  `Size` as size,
  `ASIN` as asin,
  `Courier Status` as courier_status,
  `Qty` as quantity,
  `currency` as currency,
  `Amount` as amount,
  lower(`ship-city`) as ship_city,
  lower(`ship-state`) as ship_state,
  `ship-postal-code` as ship_postal_code, -- seems to be an integer, and we certainly don't want to do math with it, I would probably cast to string
  `ship-country` as ship_country_code,
  `promotion-ids` as promotion_ids, -- this should be converted into an array, or similar
  `B2B` as is_b2b,
  `fulfilled-by` as fulfilled_by,
  safe_cast(`Unnamed: 22` as boolean) as is_boolean
FROM {{ source('fashionable_raw', 'fashionable_sales_report')}}