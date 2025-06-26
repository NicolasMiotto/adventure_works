with
    dim_customers as (
        select *
        from {{ ref('int_customers') }}
    )
    
    , dim_cards as (
        select *
        from {{ ref('int_card') }}
    )

    , dim_products as (
        select *
        from {{ ref('int_products') }}
    )

    , dim_region as (
        select *
        from {{ ref('int_region') }}
    )
    , dim_sales_reason as (
        select *
        from {{ ref('int_sales_reason') }}
    )

    , order_details as (
        select 
            salesorderid
            , productid
            , unitprice
            , orderqty
            , unitpricediscount
            , orderqty * (unitprice - unitpricediscount) as product_real_value
        from {{ ref('stg_sales__order_detail') }}
    )

    , order_header as (
        select
            salesorderid
            , customerid
            , salespersonid
            , territoryid
            , billtoaddressid
            , creditcardid
            , case
                when status = 1 then 'Processing'
                when status = 2 then 'Approved'
                when status = 3 then 'Order on hold'
                when status = 4 then 'Rejected'
                when status = 5 then 'Shipped'
                when status = 6 then 'Cancelled'
            end as order_status
            , have_online_order
            , subtotal
            , taxamt
            , freight
            , totaldue
            , orderdate
            , shipdate
            , duedate
        from {{ ref('stg_sales__order_header') }}
    )

    , orders_details_transformation as (
        select
            order_details.salesorderid
            , order_details.productid
            , order_details.orderqty
            , order_details.unitprice
            , order_details.unitpricediscount
            , order_details.product_real_value
            , ifnull(dim_sales_reason.reason_type, 'No Information') as reason_type
        from order_details
        left join dim_products
            on dim_products.productid = order_details.productid
        left join dim_sales_reason
            on dim_sales_reason.salesorderid = order_details.salesorderid
    )

    , sales_order_header_transformation as (
        select
            order_header.salesorderid
            , order_header.salespersonid
            , order_header.customerid
            , order_header.billtoaddressid
            , order_header.territoryid
            , order_header.creditcardid
            , order_header.order_status
            , order_header.have_online_order
            , order_header.freight
            , order_header.taxamt
            , order_header.subtotal
            , order_header.totaldue
            , order_header.orderdate
            , order_header.shipdate
            , order_header.duedate
        from order_header
        left join dim_customers
            on dim_customers.customerid = order_header.customerid
        left join dim_cards
            on dim_cards.creditcardid = order_header.creditcardid
        left join dim_region
            on dim_region.billtoaddressid = order_header.billtoaddressid
    )

    , join_fact_sales as (
        select
            orders_details_transformation.salesorderid
            , orders_details_transformation.productid
            , sales_order_header_transformation.customerid
            , sales_order_header_transformation.salespersonid
            , sales_order_header_transformation.territoryid
            , sales_order_header_transformation.billtoaddressid
            , sales_order_header_transformation.creditcardid
            , orders_details_transformation.orderqty
            , orders_details_transformation.unitprice
            , orders_details_transformation.unitpricediscount
            , orders_details_transformation.product_real_value
            , orders_details_transformation.reason_type
            , sales_order_header_transformation.order_status
            , sales_order_header_transformation.have_online_order
            , sales_order_header_transformation.subtotal
            , sales_order_header_transformation.taxamt
            , sales_order_header_transformation.freight
            , sales_order_header_transformation.totaldue
            , sales_order_header_transformation.duedate
            , sales_order_header_transformation.shipdate
            , {{ dbt_utils.generate_surrogate_key([
                    'orders_details_transformation.salesorderid'
                    , 'orders_details_transformation.productid'
                    , 'sales_order_header_transformation.customerid'
                    , 'sales_order_header_transformation.billtoaddressid'
                    , 'sales_order_header_transformation.creditcardid'
                    , 'sales_order_header_transformation.duedate'
                ]) 
            }} as sk_fact_sales
        from orders_details_transformation
        left join sales_order_header_transformation
            on sales_order_header_transformation.salesorderid = orders_details_transformation.salesorderid
    )

select *
from join_fact_sales