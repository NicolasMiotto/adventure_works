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

    , country_state_transformation as (
        select
            state_province.stateprovinceid 
            , country_region.c_region_name 
            , state_province.province_name
            , state_province.stateprovincecode
            , state_province.territoryid
        from
            state_province
        left join
            country_region on country_region.countryregioncode = state_province.countryregioncode
    )
    
    , adress_transformation as (
        select
            person_address.addressid
            , person_address.city
            , country_state_transformation.c_region_name 
            , country_state_transformation.province_name
            , country_state_transformation.stateprovincecode            
            
        from
            person_address
        left join
            country_state_transformation on country_state_transformation.stateprovinceid = person_address.stateprovinceid
    )


    , foreign_key as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'addressid'
                , 'stateprovincecode'
            ]) }} as sk_region
            , *
        from adress_transformation
    )

select *
from foreign_key