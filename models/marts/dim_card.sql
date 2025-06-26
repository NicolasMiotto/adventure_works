with 
    dim_cards as (
        select *
        from {{ ref ('int_card')}}
    )
select *
from dim_cards