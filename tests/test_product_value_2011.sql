with
    tst_total_product_value_2011 as (
        select
            sum(product_real_value) as product_real_value
        from {{ ref('int_sales') }}
        where duedate between '2011-01-01' and '2011-12-31'
    )
    
select
    product_real_value
from tst_total_product_value_2011
where product_real_value between 12646086 and 12647006