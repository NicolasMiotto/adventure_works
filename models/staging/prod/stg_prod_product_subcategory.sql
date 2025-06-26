with
    raw_data as (
        select *
        from {{ source('source_production', 'PRODUCTSUBCATEGORY') }}
    )

    , renamed as (
        select
            cast(productsubcategoryid as int) as productsubcategoryid
            , cast(productcategoryid as int) as productcategoryid
            , cast(name as string) as name
        from raw_data
    )

select *
from renamed