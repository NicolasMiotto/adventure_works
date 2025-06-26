with 
    dim_region as (
        select *
        from {{ ref ('int_products')}}
    )
select *
from dim_region