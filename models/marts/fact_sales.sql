with 
    fact_sales as (
        select *
        from {{ ref ('int_sales')}}
    )
select *
from fact_sales