with
    raw_data as (
        select *
        from {{ source('source_sales', 'PERSONCREDITCARD') }}
    )

    , renamed as (
        select
            cast(businessentityid as int) as businessentityid
            , cast(creditcardid as int) as creditcardid
            , cast(cardnumber as int) as cardnumber
            , cast(expmonth as int) as expmonth
            , cast(expyear as int) as expyear
        from raw_data
    )

select *
from renamed