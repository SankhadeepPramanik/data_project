select  
order_id,
return_id,
order_sequence_number,
order_country,
status,
order_updated_timestamp,
payments_id,
payments_type,
payments_card_type,
payments_value
from {{ ref('order_placed_payments_history') }} where record_status='current'
union all       
select  
order_id,
return_id,
order_sequence_number,
order_country,
status,
order_updated_timestamp,
payments_id,
payments_type,
payments_card_type,
payments_value
from {{ ref('order_return_payments_history') }} where record_status='current'