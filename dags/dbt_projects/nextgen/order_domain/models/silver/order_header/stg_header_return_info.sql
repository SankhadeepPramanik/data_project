with cte as (
    select order_id,return_id,sequence_number,country,source,order_updated_timestamp,status from {{ref('stg_header_return_submitted')}}
    union all
    select order_id,return_id,sequence_number,country,source,order_updated_timestamp,status from {{ref('stg_header_returned')}}
  
)

select * from cte
