with 
    products as (
        select *
        from {{ ref ('stg_prod_products')}}
    )

    ,product_category as (
        select *
        from {{ ref ('stg_prod_product_category')}}
    )

    ,product_subcategory as (
        select *
        from {{ ref ('stg_prod_product_subcategory')}}
    )

    , category_modelling as (
        select
            product_subcategory.productsubcategoryid
            , product_subcategory.name
            , product_category.category_name
        from
            product_subcategory
        left join
            product_category on product_category.productcategoryid = product_subcategory.productcategoryid
    )

    , joining_products as (
        select
             products.productid
            , products.product_name
            , category_modelling.name as subcategory_name
            , category_modelling.category_name
        from
            products
        left join
            category_modelling on category_modelling.productsubcategoryid = products.productsubcategoryid 
    )

    , foreign_key as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'productid'
                , 'product_name'
            ]) }} as sk_products
            , *
        from joining_products
    )

select *
from foreign_key

--select *
--from joining_products