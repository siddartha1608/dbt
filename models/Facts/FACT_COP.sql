{{ config(
    schema='FACT'
) }}

with orders as  (
    select * from {{ ref ('orders' )}}
),

payments as (
    select * from {{ ref ('payments') }}
),

dim_customers as (
    select * from {{ ref ('DIM_CUSTOMERS') }}
),


order_payments as (
    select
        order_id,
        sum (case when status = 'success' then amount end) as amount

    from payments
    group by 1
),

 final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        dim_customers.first_order_date,
        dim_customers.most_recent_order_date,
        coalesce (order_payments.amount, 0) as amount
    from orders
    left join order_payments using (order_id)
    left join dim_customers using(customer_id)
)

select * from final