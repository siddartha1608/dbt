{{ config(
    materialized='incremental',
    unique_key='payment_id' 
) }}
WITH PAYMENT AS (
   SELECT * FROM {{ ref('payments_ephemeral') }}
)
select
    payment_id,
    order_id,
   payment_method,
    status,
    amount,
    created_at
from PAYMENT
{% if is_incremental() %}
  WHERE created_at > (SELECT MAX(created_at) FROM {{ this }})
{% endif %}