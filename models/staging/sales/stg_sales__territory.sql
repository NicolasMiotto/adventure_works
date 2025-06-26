with
    raw_data as (
        select *
        from {{ source('source_sales', 'SALESTERRITORY') }}
    )

    , renamed as (
        select
            cast(territoryid as int) as territoryid
            , cast(name as string) as name
            , cast(countryregioncode as string) as countryregioncode
--            , cast(group as string) as continent
--            , cast(salesytd as numeric(18,4)) as salesytd
--            , cast(saleslastyear as numeric(18,4)) as saleslastyear
        from raw_data
    )

select *
from renamed