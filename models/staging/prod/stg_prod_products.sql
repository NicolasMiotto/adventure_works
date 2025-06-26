with
source as (
    select *
    from {{ source('source_production', 'PRODUCT') }}
)

, renamed as (
    select
        cast(productid as int) as productid
        , cast(productsubcategoryid as int) as productsubcategoryid 
        , cast(name as string) as product_name
        , cast(productnumber as string) as productnumber
        , cast(makeflag as boolean) as makeflag
        , cast(finishedgoodsflag as boolean) as finishedgoodsflag
        , cast(reorderpoint as int) as reorderpoint
        , cast(standardcost as int) as standardcost
        , cast(listprice as int) as listprice
        , cast(daystomanufacture as string) as daystomanufacture
        , cast(sellstartdate as date) as sellstartdate
    from source
)

select *
from renamed