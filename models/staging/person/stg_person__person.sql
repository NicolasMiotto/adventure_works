with
    raw_data as (
        select *
        from {{ source('source_person', 'PERSON') }}
    )

    , renamed as (
        select
            cast(businessentityid as int) as businessentityid
            , case
                when persontype  = 'SC' then 'Store Contact' 
                when persontype  = 'IN' then 'Individual Client' 
                when persontype  = 'SP' then 'Sales Person'
                when persontype  = 'EM' then 'Employee' 
                when persontype  = 'VC' then 'Vendor Contact'
                when persontype  = 'GC' then 'General Contact'
                else persontype
            end as persontype
            , cast(namestyle as string) as namestyle
            , cast(firstname as string) as firstname
            , cast(middlename as string) as middlename
            , cast(lastname as string) as lastname
            , coalesce(trim(concat_ws(' ', firstname, middlename, lastname)),'') as full_name
        from raw_data
    )

select *
from renamed
