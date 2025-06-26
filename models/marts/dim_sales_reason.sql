with 
    dim_sales_reason as (
        select *
        from {{ ref ('int_sales_reason')}}
    )
select *
from dim_sales_reason