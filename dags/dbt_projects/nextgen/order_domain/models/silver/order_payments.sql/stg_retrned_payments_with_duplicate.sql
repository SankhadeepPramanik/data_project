select 
oc.id as return_id,
oi.order_info_parent_order_id as order_id,
oc.sequence_number as order_sequence_number,
oc.country as order_country,
oc.status as status,
oc.flow_published_at as order_updated_timestamp,
op.payments_id as payments_id,
op.payments_type as payments_type,
op.payments_card_type as payments_card_type,
op.payment_items_value as payments_value
from 
{{ref('order_returned')}} oc
join
{{ref('returned_paymens')}} op
on oc.sequence_number = op.sequence_number
join
{{ref('returned_order_info')}} oi
on op.sequence_number = oi.sequence_number
