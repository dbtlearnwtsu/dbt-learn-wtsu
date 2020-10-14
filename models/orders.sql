WITH orders AS (
    SELECT * FROM {{ref('stg_orders')}}
),

payments AS (
    SELECT * FROM {{ref('stg_payments')}}
),

final AS (
    SELECT 
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        sum(payments.amount) AS amount
    FROM orders
    JOIN payments USING(order_id)
    WHERE payments.status = 'success'
    GROUP BY 1,2,3
)

SELECT * FROM final
