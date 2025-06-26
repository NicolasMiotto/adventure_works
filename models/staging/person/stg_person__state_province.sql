with
    raw_data as (
        select *
        from {{ source('source_person', 'STATEPROVINCE') }}
    )

    , renamed as (
        select
            cast(stateprovinceid as int) as stateprovinceid
            , cast(stateprovincecode as string) as stateprovincecode
            , cast(countryregioncode as string) as countryregioncode
            , cast(isonlystateprovinceflag as string) as isonlystateprovinceflag
            , cast(name as string) as province_name
            , cast(territoryid as int) as territoryid
            , cast(rowguid as string) as rowguid
        from raw_data
    )

select *
from renamed