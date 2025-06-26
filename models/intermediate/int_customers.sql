with 
    person as (
        select *
        from {{ ref ('stg_person__person')}}
    )

    , customers as (
        select *
        from {{ ref ('stg_sales__customers')}}
    )

    , sales_territory as (
        select *
        from {{ ref ('stg_sales__territory')}}
    )

    , customer_modelling as (
        select
            customers.customerid
            , customers.personid
            , customers.storeid
            , customers.territoryid
            , person.full_name
            , person.persontype
        from customers
        left join person
            on person.businessentityid = customers.personid
        left join sales_territory
            on sales_territory.territoryid = customers.territoryid
    )

    , foreign_key as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'customerid'
                , 'personid'
            ]) }} as sk_customer
            , *
        from customer_modelling
    )

select *
from foreign_key