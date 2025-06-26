with
    raw_data as (
        select *
        from {{ source('source_person', 'COUNTRYREGION') }}
    )

    , renamed as (
        select
            cast(countryregioncode as string) as countryregioncode
            , cast(name as string) as c_region_name
        from raw_data
    )

select *
from renamed