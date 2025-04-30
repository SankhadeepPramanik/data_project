
select 
    sequence_number,
    id,
    pay.value:id :: varchar as payments_id,
    pay.value:type:: varchar as payments_type,
    pay.value:"value":: varchar as payments_vaue,
    pay_item.value:card_detail:card_type:: varchar payments_card_type,
    pay_item.value:"value":: varchar as payment_items_value,
    pay_item.value:card_detail:card_holder_name:given:: varchar as card_holder_name,
    pay_item.value:transaction_id::varchar as transaction_id
 

from {{ref('order_json_flattening')}} oc,
lateral flatten(input => oc.payments ) as  pay,
lateral flatten(input => pay.value:payment_items ) as  pay_item
where
    partition_key = 'sales_v1_order_created'
