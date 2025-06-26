with
    raw_data as (
        select *
        from {{ source('source_sales', 'SALESORDERHEADERSALESREASON') }}
    )

    , renamed as (
        select
            cast(salesorderid as int) as salesorderid
            , cast(salesreasonid as int) as salesreasonid
        from raw_data
    )

select *
from renamed