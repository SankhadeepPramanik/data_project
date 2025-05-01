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
from {{ ref('stg_return_submitted_payments') }}
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
from {{ ref('stg_returned_payments') }}