with
    tst_total_sales as (
        select
            sum(totaldue) as total_sales
        from {{ ref('int_sales') }}
    )
    
select
    total_sales
from tst_total_sales
where total_sales between 2926970124.0404 and 2926970124.0424