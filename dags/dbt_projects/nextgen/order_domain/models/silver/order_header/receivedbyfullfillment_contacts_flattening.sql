

with contacts as (
    select * from 
{{ref('receivedbyfullfillment_contacts')}}
),contact_flattening as(

select sequence_number, 
        MAX(CASE WHEN contact_type = 'EMAIL' THEN contact_value  END) as EMAIL_contact_value_1
        ,MAX(CASE WHEN contact_type = 'HOMEPHONE' THEN contact_value  END) as HOMEPHONE_contact_value
        ,MAX(CASE WHEN contact_type = 'Email' THEN contact_value  END) as Email_contact_value

  from contacts  
group by sequence_number
)

select 
    sequence_number,
    coalesce(EMAIL_contact_value_1,Email_contact_value) as email,
    HOMEPHONE_contact_value as homephone
from contact_flattening  