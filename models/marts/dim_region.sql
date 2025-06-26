with 
    dim_region as (
        select *
        from {{ ref ('int_region')}}
    )
select *
from dim_region