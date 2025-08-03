with customers as (

     select * from {{ ref('SNAP_CUSTOMERS') }}

),

orders as ( 

    select * from {{ ref('SNAP_ORDERS') }}

),

customer_orders as (

    select
        USER_ID AS customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(ID) as number_of_orders

    from orders
    group by 1

),

final as (

    select
        customers.ID AS customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce (customer_orders.number_of_orders, 0) 
        as number_of_orders

    from customers
    left join customer_orders on customers.id = customer_orders.customer_id
)

select * from final