with 
    sales_orderheader_sales_reason as (
        select *
        from {{ ref ('stg_sales__order_header_sales_reason')}}
    )

    , sales_reason as (
        select *
        from {{ ref ('stg_sales__sales_reason')}}
    )

    , sales_reason_modelling as (
        select
            sales_orderheader_sales_reason.salesorderid
            , coalesce(listagg(sales_reason.reasontype, ', '), 'No Reason') as reason_type
            , sales_reason.name
        from sales_orderheader_sales_reason
        left join sales_reason
            on sales_reason.salesreasonid = sales_orderheader_sales_reason.salesreasonid
        group by 
            salesorderid,
            sales_reason.name
    )

    , foreign_key as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'salesorderid'
                , 'reason_type'
            ]) }} as sk_sales_reason
            , *
        from sales_reason_modelling
    )

select *
from foreign_key