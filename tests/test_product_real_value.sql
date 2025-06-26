with
    test_product_real_value as (
        select
            sum(product_real_value) as total_value
        from {{ ref('int_sales') }}
    )
    
select
    total_value
from test_product_real_value
where total_value between 110371836 and 110371856