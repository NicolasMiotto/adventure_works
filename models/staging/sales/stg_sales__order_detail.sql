with
    raw_data as (
        select *
        from {{ source('source_sales', 'SALESORDERDETAIL') }}
    )

    , renamed as (
        select
            cast(salesorderid as int) as salesorderid
            , cast(salesorderdetailid as int) as salesorderdetailid
            , cast(carriertrackingnumber as string) as carriertrackingnumber
            , cast(orderqty as int) as orderqty
            , cast(productid as int) as productid
            , cast(specialofferid as int) as specialofferid
            , cast(unitprice as float) as unitprice
            , cast(unitpricediscount as int) as unitpricediscount
            , cast(rowguid as string) as rowguid
        from raw_data
    )

select *
from renamed