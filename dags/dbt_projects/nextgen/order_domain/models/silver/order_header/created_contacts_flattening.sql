{% set my_columns = {
    contact_value : 'contact_value'
} %}

with contacts as (
    select * from 
{{ ref('order_created_contacts') }}

),contact_flattening as(

select sequence_number, {{  flatten_case_when 
(
    'contact_type' ,['Email','MobilePhone'],my_columns 
) 
    }}  from contacts  
group by sequence_number
)

select 
    sequence_number,
    MobilePhone_contact_value as mobilephone,
    Email_contact_value as email
from contact_flattening  