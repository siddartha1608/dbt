{% snapshot SNAP_ORDERS %}
{{
    config(
        target_schema='snapshots',
        unique_key=['id'],
        strategy='timestamp',
        updated_at='_ETL_LOADED_AT',
        invalidate_hard_deletes=True
    )
}}

select
    id ,
    user_id,
    order_date,
    status,
    _ETL_LOADED_AT
from 
RAW_DEMO.JAFFLE_SHOP.ORDERS
{% endsnapshot %}