with fact as 
(
    select * from {{ ref('FACT_COP') }}
)
SELECT 
{{ dbt_utils.generate_surrogate_key(['ORDER_ID','CUSTOMER_ID']) }} AS FACT_KEY,
xxhash64(ORDER_ID, CUSTOMER_ID) as FACT_KEY_NUMERIC,
*
FROM fact