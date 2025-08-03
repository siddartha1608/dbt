{% snapshot SNAP_CUSTOMERS %}
{{
    config(
        target_schema='snapshots',
        unique_key=['id'],
        strategy='check',
        check_cols=['id', 'FIRST_NAME', 'LAST_NAME'],
        invalidate_hard_deletes=True
    )
}}

select
    id ,
    FIRST_NAME,
    LAST_NAME
from 
RAW_DEMO.JAFFLE_SHOP.CUSTOMERS
{% endsnapshot %}