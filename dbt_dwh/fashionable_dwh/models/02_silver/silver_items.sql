select 
    asin,
    category,
    ARRAY_AGG(style_code) as style_code_array,
    ARRAY_AGG(sku) as skus_array,
    ARRAY_AGG(size) as sizes_array,

from {{ ref('br_fashionable_sales_report') }}
group by 
    asin,
    category