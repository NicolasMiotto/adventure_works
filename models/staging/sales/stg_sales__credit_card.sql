with
    raw_data as (
        select *
        from {{ source('source_sales', 'CREDITCARD') }}
    )

    , renamed as (
        select
            cast(creditcardid as int) as creditcardid
            , cast(cardtype as string) as cardtype
            , cast(cardnumber as int) as cardnumber
            , cast(expmonth as int) as expmonth
            , cast(expyear as int) as expyear
        from raw_data
    )

select *
from renamed