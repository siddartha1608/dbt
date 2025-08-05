select
    id as customer_id,
    first_name,
    last_name,
    {{ multiply_by_100('id') }} as macro_id
from {{ source('jaffle_shop1', 'stg_customers') }}

UNION ALL

select
    ID,
    FIRST_NAME,
    LAST_NAME,
    {{ multiply_by_100('id') }} as macro_id
FROM {{ ref('TEST_CUST') }}

