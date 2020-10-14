SELECT 
    id AS payment_id,
    orderid AS order_id,
    paymentmethod AS payment_method,
    status,
    amount/100.00 AS amount,
    created AS created_at
FROM raw.stripe.payment