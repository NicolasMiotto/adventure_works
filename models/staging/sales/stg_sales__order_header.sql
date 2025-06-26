with
    raw_data as (
        select *
        from {{ source('source_sales', 'SALESORDERHEADER') }}
    )

    , renamed as (
        select
            cast(salesorderid as int) as salesorderid
            , cast(revisionnumber as int) as revisionnumber
            , cast(orderdate as date) as orderdate
            , cast(duedate as date) as duedate
            , cast(shipdate as date) as shipdate
            , cast(status as int) as status
            , cast(onlineorderflag as boolean) as have_online_order 
            , cast(purchaseordernumber as string) as purchaseordernumber
            , cast(accountnumber as string) as accountnumber
            , cast(customerid as int) as customerid
            , cast(salespersonid as int) as salespersonid
            , cast(territoryid as int) as territoryid
            , cast(billtoaddressid as int) as billtoaddressid
            , cast(shiptoaddressid as int) as shiptoaddressid
            , cast(shipmethodid as int) as shipmethodid
            , cast(creditcardid as int) as creditcardid
            , cast(subtotal as numeric(18,2)) as subtotal
            , cast(taxamt as numeric(18,4)) as taxamt
            , cast(freight as numeric(18,4)) as freight
            , cast(totaldue as numeric(18,4)) as totaldue
            , cast(orderdate as date) as orderdate
            , cast(duedate as date) as duedate
            , cast(shipdate as date) as shipdate
        from raw_data
    )

select *
from renamed