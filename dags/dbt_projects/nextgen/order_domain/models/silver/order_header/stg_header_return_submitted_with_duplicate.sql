select 
oc.id as return_id,
oc.flow_published_at as order_updated_timestamp,
oc.status as status,
oc.source as source,
oc.country as country,
oc.sequence_number as sequence_number,
ocp.buyeraccount as buyeraccount,
ocp.sponsoraccount as sponsoraccount,
ocp.selleraccount as selleraccount,
ocoi.order_info_parent_order_id as order_id, 
ocoi.order_info_account_classification,
ocoi.order_info_country,
ocoi.order_info_category,
ocoi.order_info_channel,
ocoi.order_info_created_by,
ocoi.order_info_created_time,
ocoi.order_info_location_id,
ocoi.order_info_location_name,
ocoi.order_info_market,
ocoi.order_info_order_comments,
ocoi.order_info_order_date,
ocoi.order_info_created_time,
ocoi.order_info_order_type,
ocoi.order_info_price_date,
ocoi.reason_code,
ocoi.reason_message,
ocm.math_currency,
ocm.math_discount,
ocm.math_base_price,
ocm.math_net_price,
ocm.math_shipping_base,
ocm.math_shipping_discount,
ocm.math_shipping_tax,
ocm.math_shipping_total,
ocm.math_tax,
ocm.math_tax_total,
ocm.math_taxable,
ocm.math_total_price,
ocm.math_total_price_with_shipping
from 
{{ref('order_return_submitted')}} oc
left join
{{ref('return_submitted_order_info')}} ocoi
on oc.sequence_number = ocoi.sequence_number
left join
{{ref('return_submitted_parties_flattening')}} ocp
on oc.sequence_number = ocp.sequence_number
left join
{{ref('return_submitted_math')}} ocm
on oc.sequence_number = ocm.sequence_number
