with
    test_sales_2011 as (
        select
            sum(product_real_value) as product_value
        from {{ ref('int_sales') }}
        where duedate between '2011-01-01' and '2011-12-31'
    )
    
select
    product_value
from test_sales_2011
where product_real_value between 12646112.05 and 12646112.30