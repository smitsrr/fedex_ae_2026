{{ config(
    materialized='table',
    unique_key='date_day'
) }}

with date_dimension as (
    {{ dbt_date.get_date_dimension(var("dbt_date:start_date"), var("dbt_date:end_date")) }}
)

select
    -- Create a clean, smart surrogate key (e.g., 20260711)
    cast(format_date('%Y%m%d', date_day) as int64) as date_key,
    *
from date_dimension