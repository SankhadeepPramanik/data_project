select 
oc.id as order_id,
oc.sequence_number as order_sequence_number,
oc.country as order_country,
oc.status as status,
oc.flow_published_at as order_updated_timestamp,
op.payments_id as payments_id,
op.payments_type as payments_type,
op.payments_card_type as payments_card_type,
coalesce(op.payments_value,op.payment_items_value) as payments_value
from 
{{ref('order_submitted_for_fullfillment')}} oc
join
{{ref('order_submitted_for_fullfillment_payments')}} op
on oc.sequence_number = op.sequence_number
