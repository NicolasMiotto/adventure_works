with
    raw_data as (
        select *
        from {{ source('source_production', 'PRODUCTCATEGORY') }}
    )

    , renamed as (
        select
            cast(productcategoryid as int) as productcategoryid
            , cast(name as string) as category_name
        from raw_data
    )

select *
from renamed