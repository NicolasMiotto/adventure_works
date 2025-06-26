with
    raw_data as (
        select *
        from {{ source('source_sales', 'SALESREASON') }}
    )

    , renamed as (
        select
            cast(salesreasonid as int) as salesreasonid
            , cast(name as string) as name
            , cast(reasontype as string) as reasontype
        from raw_data
    )

select *
from renamed