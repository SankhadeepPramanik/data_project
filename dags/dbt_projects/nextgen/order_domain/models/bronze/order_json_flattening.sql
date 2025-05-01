SELECT
sequence_number AS sequence_number
  ,partition_key AS meta_partition_key
 , CAST(order_json:"country" AS VARCHAR) AS country
 , flow_published_at
 , CAST(order_json:"fulfillment"."shipping_address"."address"."address_line1" AS VARCHAR) AS fulfillment_shipping_address_address_address_line1
 , CAST(order_json:"fulfillment"."shipping_address"."address"."address_line2" AS VARCHAR) AS fulfillment_shipping_address_address_address_line2
 , CAST(order_json:"fulfillment"."shipping_address"."address"."city" AS VARCHAR) AS fulfillment_shipping_address_address_city
 , CAST(order_json:"fulfillment"."shipping_address"."address"."country" AS VARCHAR) AS fulfillment_shipping_address_address_country
 , CAST(order_json:"fulfillment"."shipping_address"."address"."postal_code" AS VARCHAR) AS fulfillment_shipping_address_address_postal_code
 , CAST(order_json:"fulfillment"."shipping_address"."address"."region" AS VARCHAR) AS fulfillment_shipping_address_address_region
 , order_json:"fulfillment"."shipping_address"."contact"  AS fulfillment_shipping_address_contact
 , CAST(order_json:"fulfillment"."shipping_address"."instructions" AS VARCHAR) AS fulfillment_shipping_address_instructions
 , CAST(order_json:"fulfillment"."shipping_address"."name"."family" AS VARCHAR) AS fulfillment_shipping_address_name_family
 , CAST(order_json:"fulfillment"."shipping_address"."name"."full" AS VARCHAR) AS fulfillment_shipping_address_name_full
 , CAST(order_json:"id" AS VARCHAR) AS id
 , CAST(order_json:"invoice_id" AS INT) AS invoice_id
 , order_json:"item_status" AS item_status
 , order_json:"items_shipping" AS items_shipping
 , CAST(order_json:"math"."base_price" AS VARCHAR) AS math_base_price
 , CAST(order_json:"math"."currency" AS VARCHAR) AS math_currency
 , CAST(order_json:"math"."discount" AS VARCHAR) AS math_discount
 , CAST(order_json:"math"."net_price" AS VARCHAR) AS math_net_price
 , CAST(order_json:"math"."other_charges" AS VARCHAR) AS math_other_charges
 , CAST(order_json:"math"."round_off" AS VARCHAR) AS math_round_off
 , CAST(order_json:"math"."shipping_base" AS VARCHAR) AS math_shipping_base
 , CAST(order_json:"math"."shipping_discount" AS VARCHAR) AS math_shipping_discount
 , CAST(order_json:"math"."shipping_net" AS VARCHAR) AS math_shipping_net
 , CAST(order_json:"math"."shipping_tax" AS VARCHAR) AS math_shipping_tax
 , CAST(order_json:"math"."shipping_total" AS VARCHAR) AS math_shipping_total
 , CAST(order_json:"math"."tax" AS VARCHAR) AS math_tax
 , CAST(order_json:"math"."tax_on_base_price" AS VARCHAR) AS math_tax_on_base_price
 , CAST(order_json:"math"."tax_on_base_shipping" AS VARCHAR) AS math_tax_on_base_shipping
 , CAST(order_json:"math"."tax_on_other_charge" AS VARCHAR) AS math_tax_on_other_charge
 , CAST(order_json:"math"."tax_rounding" AS VARCHAR) AS math_tax_rounding
 , CAST(order_json:"math"."tax_total" AS VARCHAR) AS math_tax_total
 , CAST(order_json:"math"."taxable" AS VARCHAR) AS math_taxable
 , CAST(order_json:"math"."total_price" AS VARCHAR) AS math_total_price
 , CAST(order_json:"math"."total_price_with_shipping" AS VARCHAR) AS math_total_price_with_shipping
 , CAST(order_json:"order_details"."discounts" AS VARCHAR) AS order_details_discounts
 , order_json:"order_details"."flags"  AS order_details_flags
 , CAST(order_json:"order_details"."fulfillment"."fulfillment_id" AS INT) AS order_details_fulfillment_fulfillment_id
 , CAST(order_json:"order_details"."fulfillment"."shipment_creation_date" AS VARCHAR) AS order_details_fulfillment_shipment_creation_date
 , CAST(order_json:"order_details"."fulfillment"."shipment_id" AS INT) AS order_details_fulfillment_shipment_id
 , CAST(order_json:"order_details"."fulfillment"."shipping_address"."address"."address_line1" AS VARCHAR) AS order_details_fulfillment_shipping_address_address_address_line1
 , CAST(order_json:"order_details"."fulfillment"."shipping_address"."address"."address_line2" AS VARCHAR) AS order_details_fulfillment_shipping_address_address_address_line2
 , CAST(order_json:"order_details"."fulfillment"."shipping_address"."address"."address_line3" AS VARCHAR) AS order_details_fulfillment_shipping_address_address_address_line3
 , CAST(order_json:"order_details"."fulfillment"."shipping_address"."address"."city" AS VARCHAR) AS order_details_fulfillment_shipping_address_address_city
 , CAST(order_json:"order_details"."fulfillment"."shipping_address"."address"."country" AS VARCHAR) AS order_details_fulfillment_shipping_address_address_country
 , CAST(order_json:"order_details"."fulfillment"."shipping_address"."address"."district" AS VARCHAR) AS order_details_fulfillment_shipping_address_address_district
 , CAST(order_json:"order_details"."fulfillment"."shipping_address"."address"."postal_code" AS VARCHAR) AS order_details_fulfillment_shipping_address_address_postal_code
 , CAST(order_json:"order_details"."fulfillment"."shipping_address"."address"."region" AS VARCHAR) AS order_details_fulfillment_shipping_address_address_region
 , CAST(order_json:"order_details"."fulfillment"."shipping_address"."address"."type" AS VARCHAR) AS order_details_fulfillment_shipping_address_address_type
 , order_json:"order_details"."fulfillment"."shipping_address"."contact" AS order_details_fulfillment_shipping_address_contact
 , CAST(order_json:"order_details"."fulfillment"."shipping_address"."instructions" AS VARCHAR) AS order_details_fulfillment_shipping_address_instructions
 , CAST(order_json:"order_details"."fulfillment"."shipping_address"."name"."family" AS VARCHAR) AS order_details_fulfillment_shipping_address_name_family
 , CAST(order_json:"order_details"."fulfillment"."shipping_address"."name"."full" AS VARCHAR) AS order_details_fulfillment_shipping_address_name_full
 , CAST(order_json:"order_details"."fulfillment"."shipping_address"."name"."given" AS VARCHAR) AS order_details_fulfillment_shipping_address_name_given
 , CAST(order_json:"order_details"."fulfillment"."shipping_address"."name"."type" AS VARCHAR) AS order_details_fulfillment_shipping_address_name_type
 , order_json:"order_details"."parties"  AS order_details_parties
 , CAST(order_json:"order_info"."account_classification" AS VARCHAR) AS order_info_account_classification
 , CAST(order_json:"order_info"."category" AS VARCHAR) AS order_info_category
 , CAST(order_json:"order_info"."channel" AS VARCHAR) AS order_info_channel
 , CAST(order_json:"order_info"."country" AS VARCHAR) AS order_info_country
 , CAST(order_json:"order_info"."created_by" AS VARCHAR) AS order_info_created_by
 , CAST(order_json:"order_info"."created_time" AS VARCHAR) AS order_info_created_time
 , CAST(order_json:"order_info"."effective_order_date" AS VARCHAR) AS order_info_effective_order_date
 , CAST(order_json:"order_info"."gift_receipt" AS VARCHAR) AS order_info_gift_receipt
 , CAST(order_json:"order_info"."locale" AS VARCHAR) AS order_info_locale
 , CAST(order_json:"order_info"."location_id" AS VARCHAR) AS order_info_location_id
 , CAST(order_json:"order_info"."location_name" AS VARCHAR) AS order_info_location_name
 , CAST(order_json:"order_info"."market" AS VARCHAR) AS order_info_market
 , CAST(order_json:"order_info"."order_comments" AS VARCHAR) AS order_info_order_comments
 , CAST(order_json:"order_info"."order_date" AS VARCHAR) AS order_info_order_date
 , CAST(order_json:"order_info"."order_type" AS VARCHAR) AS order_info_order_type
 , CAST(order_json:"order_info"."parent_ofs_order_id" AS INT) AS order_info_parent_ofs_order_id
 , CAST(order_json:"order_info"."parent_order_id" AS VARCHAR) AS order_info_parent_order_id
 , CAST(order_json:"order_info"."price_date" AS VARCHAR) AS order_info_price_date
 , CAST(order_json:"order_info"."shipping_method"."pickup_location" AS VARCHAR) AS order_info_shipping_method_pickup_location
 , CAST(order_json:"order_info"."shipping_method"."shipping_condition" AS VARCHAR) AS order_info_shipping_method_shipping_condition
 , CAST(order_json:"order_info"."shipping_method"."shipping_method" AS VARCHAR) AS order_info_shipping_method_shipping_method
 , CAST(order_json:"order_info"."source" AS VARCHAR) AS order_info_source
 , CAST(order_json:"order_info"."subscription_id" AS VARCHAR) AS order_info_subscription_id
 , order_json:"order_items" AS order_items
 , CAST(order_json:"organization"."location_id" AS INT) AS organization_location_id
 , CAST(order_json:"organization"."location_name" AS VARCHAR) AS organization_location_name
 , CAST(order_json:"organization"."market" AS VARCHAR) AS organization_market
 , CAST(order_json:"partition_key" AS VARCHAR) AS partition_key
 , order_json:"payments" AS payments
 , CAST(order_json:"reason_code" AS VARCHAR) AS reason_code
 , CAST(order_json:"reason_message" AS VARCHAR) AS reason_message
 , order_json:"return_details"."parties" AS return_details_parties
 , order_json:"return_items" AS return_items
 , CAST(order_json:"source" AS VARCHAR) AS source
 , CAST(order_json:"status" AS VARCHAR) AS status
 , CAST(order_json:"ts" AS VARCHAR) AS ts
 , order_json AS json_view
 , CAST(order_json:"fulfillment"."fulfillment_id" AS INT) AS fulfillment_fulfillment_id
 , CAST(order_json:"fulfillment"."shipment_creation_date" AS TIMESTAMP) AS fulfillment_shipment_creation_date
 , CAST(order_json:"fulfillment"."shipment_id" AS INT) AS fulfillment_shipment_id
 , CAST(order_json:"fulfillment"."shipping_address"."address"."district" AS VARCHAR) AS fulfillment_shipping_address_address_district
 , CAST(order_json:"fulfillment"."shipping_address"."address"."type" AS VARCHAR) AS fulfillment_shipping_address_address_type
 , CAST(order_json:"fulfillment"."shipping_address"."name"."type" AS VARCHAR) AS fulfillment_shipping_address_name_type
 , CAST(order_json:"fulfillment"."shipping_address"."address"."address_line3" AS VARCHAR) AS fulfillment_shipping_address_address_address_line3
FROM
{{source('raw_data','nextgen_order')}}
