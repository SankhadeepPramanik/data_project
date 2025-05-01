select 
oc.id as order_id,
oc.flow_published_at as order_updated_timestamp,
oc.status as status,
oc.source as source,
oc.country as country,
oc.sequence_number as order_sequence_number
from 
{{ref('order_created')}} oc
left join
{{ref('order_created_order_info')}} ocoi
on oc.sequence_number = ocoi.sequence_number
left join
{{ref('created_flag_flattening')}} ocf
on oc.sequence_number = ocf.sequence_number
left join
{{ref('created_parties_flattening')}} ocp
on oc.sequence_number = ocp.sequence_number
left join
{{ref('order_created_math')}} ocm
on oc.sequence_number = ocm.sequence_number
left join
{{ref('created_contacts_flattening')}} occ
on oc.sequence_number = occ.sequence_number