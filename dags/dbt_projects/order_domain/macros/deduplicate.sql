{%- macro deduplicate(relation, partition_by, order_by) -%}
    with cte as(
    select *,  row_number() over (
            partition by {{ partition_by }}
            order by {{ order_by }}
        ) as rnk
    from {{ relation }} as tt)
select * from cte where rnk = 1
{%- endmacro -%}