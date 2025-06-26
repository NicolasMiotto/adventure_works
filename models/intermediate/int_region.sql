with 
     country_region as (
        select *
        from {{ ref ('stg_person__country_region')}}
    )


    , state_province as (
        select *
        from {{ ref ('stg_person__state_province')}}
    )

    , person_address as (
        select *
        from {{ ref ('stg_person__address')}}
    )

    , order_header as (
        select
            *
        from {{ ref('stg_sales__order_header') }}
    )

    ,  region_transformation as (
        select
            distinct(order_header.billtoaddressid)
            , country_region.c_region_name
            , person_address.city
            , state_province.province_name
        from order_header
        left join person_address
            on order_header.shiptoaddressid = person_address.addressid
        left join state_province
            on state_province.stateprovinceid = person_address.stateprovinceid
        left join country_region
            on country_region.countryregioncode = state_province.countryregioncode
    )

    , foreign_key as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'billtoaddressid'
            ]) }} as sk_region
            , *
        from region_transformation
    )

select *
from foreign_key