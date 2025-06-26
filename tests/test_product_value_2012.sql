with
    test_total_product_value_2012 as (
        select
            sum(product_real_value) as product_real_value
        from {{ ref('int_sales') }}
        where duedate between '2012-01-01' and '2012-12-31'
    )
    
select
    product_real_value
from test_total_product_value_2012
where product_real_value between 12646086 and 12647006