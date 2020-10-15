-- 1. can I pull the column values from the table directly
-- 2. how do I deal with extra commas
-- 3. can we erase extra white space
-- 4. are there other options? + should this matter
SELECT 
  order_id,
  {%- set methods = dbt_utils.get_column_values(table=ref('stg_payments'), column='payment_method') -%}
  {% for payment_method in methods %}
  sum(case when payment_method = '{{ payment_method }}' then amount else 0 end) as {{payment_method}}_amount
    {%- if loop.last -%}
    {%- else -%}
    ,
    {%- endif -%}
  {% endfor %}
FROM {{ ref('stg_payments')}}
GROUP BY 1
