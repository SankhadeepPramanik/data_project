{% set my_columns = {
    column_id : 'flag_value'
} %}

with flag as (
    select * from 
{{ ref('order_created_flag') }}

),flag_flattening as(

select sequence_number, {{  flatten_case_when 
(
    'flag_type' ,['Guest','DropShip'],my_columns 
) 
    }}  from flag  
group by sequence_number
)

select 
    sequence_number,
    Guest_flag_value as guest_flag,
    DropShip_flag_value as dropShip_flag,
from flag_flattening  