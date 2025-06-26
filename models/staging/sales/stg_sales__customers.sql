with
    raw_data as (
        select *
        from {{ source('source_sales', 'CUSTOMER') }}
    )

    , renamed as (
        select
            cast(customerid as int) as customerid
            , cast(personid as string) as personid
            , cast(storeid as int) as storeid
            , cast(territoryid as int) as territoryid
            , cast(rowguid as string) as rowguid
        from raw_data
    )

select *
from renamed