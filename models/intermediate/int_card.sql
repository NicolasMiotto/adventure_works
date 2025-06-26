with

    credit_cards as (
        select *
        from {{ ref('stg_sales__credit_card') }}
    )

    , sales_order_header as (
        select *
        from {{ ref ('stg_sales__order_header')}}
    )

    

    , card_transformation as (
        select
            distinct(sales_order_header.creditcardid)
            , credit_cards.cardtype
            , credit_cards.cardnumber
            , credit_cards.expyear
        from sales_order_header
        left join credit_cards
            on credit_cards.creditcardid = sales_order_header.creditcardid
        where credit_cards.creditcardid is not null
    )

    , foreing_key as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'creditcardid'
                , 'cardnumber'
            ]) }} as sk_credit_card
            , *
        from card_transformation
    )

select *
from foreing_key