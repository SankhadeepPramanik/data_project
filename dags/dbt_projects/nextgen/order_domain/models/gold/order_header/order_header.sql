 
select 
order_updated_timestamp
 , id
 , order_id
 , return_id
 , status
 , source
 , country
 , sequence_number
 , invoice_id
 , guest_flag
 , dropship_flag
 , mobilephone
 , email
 , buyeraccount
 , sponsoraccount
 , selleraccount
 , order_info_account_classification
 , order_info_country
 , order_info_category
 , order_info_channel
 , order_info_created_by
 , order_info_created_time
 , order_info_location_id
 , order_info_location_name
 , order_info_market
 , order_info_order_comments
 , order_info_order_date
 , order_info_order_type
 , order_info_subscription_id
 , order_info_price_date
 , reason_code
 , reason_message
 , math_currency 
 , math_discount ::decimal(18,2) as math_discount
 , math_base_price ::decimal(18,2) as math_base_price
 , math_net_price ::decimal(18,2) as math_net_price
 , math_shipping_base ::decimal(18,2) as math_shipping_base
 , math_shipping_discount ::decimal(18,2) as math_shipping_discount
 , math_shipping_tax ::decimal(18,2) as math_shipping_tax
 , math_shipping_total ::decimal(18,2) as math_shipping_total
 , math_tax ::decimal(18,2) as math_tax
 , math_tax_total ::decimal(18,2) as math_tax_total
 , math_taxable ::decimal(18,2) as math_taxable
 , math_total_price ::decimal(18,2) as math_total_price
 , math_total_price_with_shipping ::decimal(18,2) as math_total_price_with_shipping
 , shipping_address_line1
 , shipping_address_line2
 , shipping_address_line3
 , shipping_city
 , shipping_district
 , shipping_postal_code
 , shipping_country
 , shipping_region
 , shipping_family_name

from (
select 
ol.order_updated_timestamp,
ol.order_id as id,
ol.order_id,
NULL as return_id,
ol.status,
ol.source,
ol.country,
ol.sequence_number,
oi.invoice_id,
coalesce(orec.guest_flag,osf.guest_flag,oh.guest_flag) guest_flag,
coalesce(orec.dropship_flag,osf.dropship_flag,oh.dropship_flag) dropship_flag,
coalesce(orec.homephone,osf.mobilephone,oh.mobilephone) as mobilephone,
coalesce(orec.email,osf.email,oh.email ) email,
coalesce(orec.buyeraccount,osf.buyeraccount,oh.buyeraccount) as buyeraccount,
coalesce(orec.sponsoraccount,osf.sponsoraccount,oh.sponsoraccount) sponsoraccount,
coalesce(orec.selleraccount,osf.selleraccount,oh.selleraccount) selleraccount,
coalesce(orec.order_info_account_classification,osf.order_info_account_classification,oh.order_info_account_classification) order_info_account_classification,
coalesce(orec.order_info_country,osf.order_info_country,oh.order_info_country) order_info_country,
coalesce(orec.order_info_category,osf.order_info_category,oh.order_info_category) order_info_category,
coalesce(orec.order_info_channel,osf.order_info_channel,oh.order_info_channel) order_info_channel,
coalesce(orec.order_info_created_by,osf.order_info_created_by,oh.order_info_created_by) order_info_created_by,
coalesce(orec.order_info_created_time,osf.order_info_created_time,oh.order_info_created_time) order_info_created_time,
coalesce(orec.order_info_location_id,osf.order_info_location_id,oh.order_info_location_id) order_info_location_id,
coalesce(orec.order_info_location_name,osf.order_info_location_name,oh.order_info_location_name) order_info_location_name,
coalesce(orec.order_info_market,osf.order_info_market,oh.order_info_market) order_info_market,
coalesce(orec.order_info_order_comments, osf.order_info_order_comments, oh.order_info_order_comments) order_info_order_comments,
coalesce(orec.order_info_order_date, osf.order_info_order_date,oh.order_info_order_date) order_info_order_date,
coalesce(orec.order_info_order_type, osf.order_info_order_type,oh.order_info_order_type) order_info_order_type,
coalesce(orec.order_info_subscription_id, osf.order_info_subscription_id,oh.order_info_subscription_id) order_info_subscription_id,
coalesce(orec.order_info_price_date, osf.order_info_price_date,oh.order_info_price_date) order_info_price_date,
coalesce(orec.reason_code,  osf.reason_code,oh.reason_code) reason_code,
coalesce(orec.reason_message, osf.reason_message,oh.reason_message) reason_message,
coalesce(orec.math_currency, osf.math_currency,oh.math_currency) math_currency,
coalesce(orec.math_discount, osf.math_discount,oh.math_discount) math_discount,
coalesce(orec.math_base_price, osf.math_base_price,oh.math_base_price) math_base_price,
coalesce(orec.math_net_price, osf.math_net_price,oh.math_net_price) math_net_price,
coalesce(orec.math_shipping_base,   osf.math_shipping_base,oh.math_shipping_base) math_shipping_base,
coalesce(orec.math_shipping_discount, osf.math_shipping_discount,oh.math_shipping_discount) math_shipping_discount,
coalesce(orec.math_shipping_tax,    osf.math_shipping_tax,oh.math_shipping_tax) math_shipping_tax,
coalesce(orec.math_shipping_total, osf.math_shipping_total,oh.math_shipping_total) math_shipping_total,
coalesce(orec.math_tax, osf.math_tax,oh.math_tax) math_tax,
coalesce(orec.math_tax_total, osf.math_tax_total,oh.math_tax_total) math_tax_total,
coalesce(orec.math_taxable, osf.math_taxable,oh.math_taxable) math_taxable,
coalesce(orec.math_total_price, osf.math_total_price,oh.math_total_price) math_total_price,
coalesce(orec.math_total_price_with_shipping, osf.math_total_price_with_shipping,oh.math_total_price_with_shipping) math_total_price_with_shipping,
coalesce(os.shipping_address,orec.shipping_address_line1) as shipping_address_line1,
coalesce(os.shipping_address2,orec.shipping_address_line2) as shipping_address_line2,    
orec.shipping_address_line3 as shipping_address_line3,
coalesce(os.shipping_city, orec.shipping_city ) as shipping_city,
orec.shipping_district as shipping_district,
coalesce(os.shipping_postal_code,orec.shipping_postal_code) as shipping_postal_code,
coalesce(os.shipping_country,orec.shipping_country) as shipping_country,
coalesce(os.shipping_region,orec.shipping_region) as shipping_region,
coalesce(os.shipping_family_name,orec.shipping_family_name) as shipping_family_name


 from 
{{ref('stg_header_latest_order_info')}} ol
left join
{{ref('stg_header_created')}} oh on ol.order_id = oh.order_id
left join
{{ref('stg_header_received_by')}} orec on ol.order_id = orec.order_id
left join
{{ref('stg_header_invoiced')}} oi on ol.order_id = oi.order_id        
left join
{{ref('stg_header_shipped')}} os on ol.order_id = os.order_id
left join
{{ref('stg_header_submitted_for')}} osf on ol.order_id = osf.order_id
left join
{{ref('stg_header_manifested')}} om on ol.order_id = om.order_id
left join
{{ref('stg_header_cancelled')}} ocan on ol.order_id = ocan.order_id

union all
select 


rl.order_updated_timestamp,
rl.return_id as id,
rl.order_id,
rl.return_id as return_id,
rl.status,
rl.source,
rl.country,
rl.sequence_number,
NULL as invoice_id,
NULL as guest_flag,
NULL as dropship_flag,
NULL as mobilephone,
NULL as email,
coalesce(ore.buyeraccount,ors.buyeraccount) as buyeraccount,
coalesce(ore.sponsoraccount,ors.sponsoraccount) sponsoraccount,
coalesce(ore.selleraccount,ors.selleraccount) selleraccount,
coalesce(ore.order_info_account_classification,ors.order_info_account_classification) order_info_account_classification,
coalesce(ore.order_info_country,ors.order_info_country) order_info_country,
coalesce(ore.order_info_category,ors.order_info_category) order_info_category,
coalesce(ore.order_info_channel,ors.order_info_channel) order_info_channel,
coalesce(ore.order_info_created_by,ors.order_info_created_by) order_info_created_by,
coalesce(ore.order_info_created_time,ors.order_info_created_time) order_info_created_time,
coalesce(ore.order_info_location_id,ors.order_info_location_id) order_info_location_id,
coalesce(ore.order_info_location_name,ors.order_info_location_name) order_info_location_name,
coalesce(ore.order_info_market,ors.order_info_market) order_info_market,
coalesce(ore.order_info_order_comments, ors.order_info_order_comments) order_info_order_comments,
coalesce(ore.order_info_order_date, ors.order_info_order_date) order_info_order_date,
coalesce(ore.order_info_order_type, ors.order_info_order_type) order_info_order_type,
NULL as  order_info_subscription_id,
coalesce(ore.order_info_price_date, ors.order_info_price_date) order_info_price_date,
coalesce(ore.reason_code,  ors.reason_code) reason_code,
coalesce(ore.reason_message, ors.reason_message) reason_message,
coalesce(ore.math_currency, ors.math_currency) math_currency,
coalesce(ore.math_discount, ors.math_discount) math_discount,
coalesce(ore.math_base_price, ors.math_base_price) math_base_price,
coalesce(ore.math_net_price, ors.math_net_price) math_net_price,
coalesce(ore.math_shipping_base,   ors.math_shipping_base) math_shipping_base,
coalesce(ore.math_shipping_discount, ors.math_shipping_discount) math_shipping_discount,
coalesce(ore.math_shipping_tax,    ors.math_shipping_tax) math_shipping_tax,
coalesce(ore.math_shipping_total, ors.math_shipping_total) math_shipping_total,
coalesce(ore.math_tax, ors.math_tax) math_tax,
coalesce(ore.math_tax_total, ors.math_tax_total) math_tax_total,
coalesce(ore.math_taxable, ors.math_taxable) math_taxable,
coalesce(ore.math_total_price, ors.math_total_price) math_total_price,
coalesce(ore.math_total_price_with_shipping, ors.math_total_price_with_shipping) math_total_price_with_shipping,
NULL as shipping_address_line1,
NULL as shipping_address_line2,    
NULL as shipping_address_line3,
NULL as shipping_city,
NULL as shipping_district,
NULL as shipping_postal_code,
NULL as shipping_country,
NULL as shipping_region,
NULL as shipping_family_name

from 
{{ref('stg_header_latest_retun_info')}} rl
left join
{{ref('stg_header_return_submitted')}} ors on rl.return_id = ors.return_id
left join
{{ref('stg_header_returned')}} ore on rl.return_id = ore.return_id
)