{{ config(
        materialized='incremental',
        on_schema_change='append_new_columns',
        unique_key='id',
        incremental_strategy='merge',
        post_hook=['INSERT INTO {{ source("order_log","audit_log_order")}} (updated_ts, max_timestamp, record_count, status, table_name) SELECT current_timestamp, max(order_updated_timestamp), count(*), \'success\', \'{{this}}\' FROM {{ this }}'],
        tags=["order_header_table","order_table","order_scd2_table","order_header_scd2_table"]
    ) }}


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
 , math_discount
 , math_base_price
 , math_net_price
 , math_shipping_base
 , math_shipping_discount
 , math_shipping_tax
 , math_shipping_total
 , math_tax
 , math_tax_total
 , math_taxable
 , math_total_price
 , math_total_price_with_shipping
 , shipping_address_line1
 , shipping_address_line2
 , shipping_address_line3
 , shipping_city
 , shipping_district
 , shipping_postal_code
 , shipping_country
 , shipping_region
 , shipping_family_name



 from {{ref('order_header') }}
 {% if is_incremental() %}
    where order_updated_timestamp > (select max(order_updated_timestamp) from {{ this }})
 {% endif %}