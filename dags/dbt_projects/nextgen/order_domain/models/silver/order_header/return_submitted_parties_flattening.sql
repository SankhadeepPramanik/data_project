{% set my_columns = {
    column_id : 'parties_id'
} %}

with parties as (
    select * from 
{{ ref('return_submitted_parties') }}

),parties_flattening as(

select sequence_number, {{  flatten_case_when 
(
    'parties_type' ,['BuyerAccount','SponsorAccount','SellerAccount'],my_columns 
) 
    }}  from parties  
group by sequence_number
)

select 
    sequence_number,
    BuyerAccount_parties_id as buyeraccount,
    SponsorAccount_parties_id as sponsoraccount,
    SellerAccount_parties_id as selleraccount
from parties_flattening  