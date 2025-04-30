
select 
    sequence_number,
    id,
    math_currency,
    math_base_price,
    math_discount,
    math_net_price,
    math_shipping_base,
    math_shipping_discount,
    math_shipping_tax,
    math_shipping_total,
    math_tax,
    math_tax_total,
    math_taxable,
    math_total_price,
    math_total_price_with_shipping

from {{ref('order_json_flattening')}}
where
    partition_key = 'sales_v1_order_returnSubmitted'
