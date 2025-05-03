select 

order_updated_timestamp
,order_id
,return_id
,status
,source
,country
,sequence_number
,coalesce(invoice_id , last_value(invoice_id) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as invoice_id
,coalesce(guest_flag, last_value(guest_flag) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as guest_flag
,coalesce(dropship_flag, last_value(dropship_flag) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as dropship_flag
,coalesce(mobilephone, last_value(mobilephone) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as mobilephone
,coalesce(email, last_value(email) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as email
,coalesce(buyeraccount, last_value(buyeraccount) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as buyeraccount
,coalesce(sponsoraccount,   last_value(sponsoraccount) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as sponsoraccount
,coalesce(selleraccount, last_value(selleraccount) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as selleraccount
,coalesce(order_info_account_classification,    last_value(order_info_account_classification) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as order_info_account_classification
,coalesce(order_info_country, last_value(order_info_country) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as order_info_country
,coalesce(order_info_category, last_value(order_info_category) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as order_info_category
,coalesce(order_info_channel, last_value(order_info_channel) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as order_info_channel
,coalesce(order_info_created_by, last_value(order_info_created_by) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as order_info_created_by
,coalesce(order_info_created_time, last_value(order_info_created_time) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as order_info_created_time
,coalesce(order_info_location_id, last_value(order_info_location_id) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as order_info_location_id
,coalesce(order_info_location_name, last_value(order_info_location_name) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as order_info_location_name
,coalesce(order_info_market, last_value(order_info_market) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as order_info_market
,coalesce(order_info_order_comments, last_value(order_info_order_comments) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as order_info_order_comments
,coalesce(order_info_order_date, last_value(order_info_order_date) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as order_info_order_date
,coalesce(order_info_order_type, last_value(order_info_order_type) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as order_info_order_type
,coalesce(order_info_subscription_id,   last_value(order_info_subscription_id) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as order_info_subscription_id
,coalesce(order_info_price_date, last_value(order_info_price_date) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as order_info_price_date
,coalesce(reason_code,  last_value(reason_code) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as reason_code
,coalesce(reason_message, last_value(reason_message) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as reason_message
,coalesce(math_currency,    last_value(math_currency) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as math_currency
,coalesce(math_discount, last_value(math_discount) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as math_discount
,coalesce(math_base_price, last_value(math_base_price) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as math_base_price
,coalesce(math_net_price, last_value(math_net_price) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as math_net_price
,coalesce(math_shipping_base, last_value(math_shipping_base) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as math_shipping_base
,coalesce(math_shipping_discount, last_value(math_shipping_discount) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as math_shipping_discount
,coalesce(math_shipping_tax, last_value(math_shipping_tax) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as math_shipping_tax
,coalesce(math_shipping_total, last_value(math_shipping_total) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as math_shipping_total
,coalesce(math_tax, last_value(math_tax) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as math_tax
,coalesce(math_tax_total,   last_value(math_tax_total) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as math_tax_total
,coalesce(math_taxable, last_value(math_taxable) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as math_taxable
,coalesce(math_total_price, last_value(math_total_price) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as math_total_price
,coalesce(math_total_price_with_shipping, last_value(math_total_price_with_shipping) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as math_total_price_with_shipping
,coalesce(shipping_address_line1, last_value(shipping_address_line1) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as shipping_address_line1
,coalesce(shipping_address_line2, last_value(shipping_address_line2) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as shipping_address_line2
,coalesce(shipping_address_line3, last_value(shipping_address_line3) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as shipping_address_line3
,coalesce(shipping_city, last_value(shipping_city) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as shipping_city
,coalesce(shipping_district, last_value(shipping_district) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as shipping_district
,coalesce(shipping_postal_code, last_value(shipping_postal_code) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as shipping_postal_code
,coalesce(shipping_country, last_value(shipping_country) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as shipping_country
,coalesce(shipping_region, last_value(shipping_region) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as shipping_region
,coalesce(shipping_family_name, last_value(shipping_family_name) IGNORE NULLS over (partition by return_id order by order_updated_timestamp rows between unbounded preceding and current row)) as shipping_family_name


from
(

select 
order_updated_timestamp,
order_id,
return_id as return_id,
status,
source,
country,
sequence_number,
NULL as invoice_id,
NULL as guest_flag,
NULL as dropship_flag,
NULL as mobilephone,
NULL as email,
buyeraccount,
sponsoraccount,
selleraccount,
order_info_account_classification,
order_info_country,
order_info_category,
order_info_channel,
order_info_created_by,
order_info_created_time,
order_info_location_id,
order_info_location_name,
order_info_market,
order_info_order_comments,
order_info_order_date,
order_info_order_type,
NULL as order_info_subscription_id,
order_info_price_date,
reason_code,
reason_message,
math_currency,
math_discount,
math_base_price,
math_net_price,
math_shipping_base,
math_shipping_discount,
math_shipping_tax,
math_shipping_total,
math_tax,
math_tax_total,
math_taxable,
math_total_price,
math_total_price_with_shipping,
NULL as shipping_address_line1,
NULL as shipping_address_line2,    
NULL as shipping_address_line3,
NULL as shipping_city,
NULL as shipping_district,
NULL as shipping_postal_code,
NULL as shipping_country,
NULL as shipping_region,
null  as shipping_family_name
from {{ref('stg_header_return_submitted')}}

union all

select 
order_updated_timestamp,
order_id,
return_id as return_id,
status,
source,
country,
sequence_number,
NULL as invoice_id,
NULL as guest_flag,
NULL as dropship_flag,
NULL as mobilephone,
NULL as email,
buyeraccount,
sponsoraccount,
selleraccount,
order_info_account_classification,
order_info_country,
order_info_category,
order_info_channel,
order_info_created_by,
order_info_created_time,
order_info_location_id,
order_info_location_name,
order_info_market,
order_info_order_comments,
order_info_order_date,
order_info_order_type,
NULL as order_info_subscription_id,
order_info_price_date,
reason_code,
reason_message,
math_currency,
math_discount,
math_base_price,
math_net_price,
math_shipping_base,
math_shipping_discount,
math_shipping_tax,
math_shipping_total,
math_tax,
math_tax_total,
math_taxable,
math_total_price,
math_total_price_with_shipping,
NULL as shipping_address_line1,
NULL as shipping_address_line2,    
NULL as shipping_address_line3,
NULL as shipping_city,
NULL as shipping_district,
NULL as shipping_postal_code,
NULL as shipping_country,
NULL as shipping_region,
null  as shipping_family_name
from {{ref('stg_header_returned')}}
)