with
    source as (
        select *
        from {{ source('source_person', 'ADDRESS') }}
    )

    , renamed as (
        select
            cast(addressid as int) as addressid
            , cast(addressline1 as string) as addressline1
            , cast(city as string) as city
            , cast(stateprovinceid as int) as stateprovinceid
            , cast(postalcode as string) as postalcode
            , cast(spatiallocation as string) as spatiallocation
            , cast(rowguid as string) as rowguid
        from source
    )

select *
from renamed