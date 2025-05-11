{% macro log_dbt_results(results, dag_id, dag_run_id) %}

{%- if execute -%}
    {%- set parsed_results = parse_dbt_results(results) -%}
    {%- if parsed_results | length > 0 -%}
        {% set insert_dbt_results_query %}
insert into {{ source('nextgen_audit', 'dbt_audit_logs') }} (
    invocation_id,
    unique_id,
    database_name,
    schema_name,
    name,
    resource_type,
    model_type,  -- 👈 NEW COLUMN
    started_at,
    completed_at,
    status,
    rows_affected,
    dag_id,
    dag_run_id,
    message,
    run_user  
)
values
{%- for parsed_result_dict in parsed_results %}
    {%- set started_at_val = parsed_result_dict.get('started_at') -%}
    {%- if started_at_val != 'None' and started_at_val is not none -%}
        {%- set started_at = "TO_TIMESTAMP_NTZ('" ~ started_at_val[:23].replace('T', ' ') ~ "')" -%}
    {%- else -%}
        {%- set started_at = "CURRENT_TIMESTAMP" -%}
    {%- endif -%}

    {%- set completed_at_val = parsed_result_dict.get('completed_at') -%}
    {%- if completed_at_val != 'None' and completed_at_val is not none -%}
        {%- set completed_at = "TO_TIMESTAMP_NTZ('" ~ completed_at_val[:23].replace('T', ' ') ~ "')" -%}
    {%- else -%}
        {%- set completed_at = "DATEADD(second, " ~ parsed_result_dict.get('execution_time', 0) ~ ", CURRENT_TIMESTAMP)" -%}
    {%- endif -%}

    (
        '{{ parsed_result_dict.get('invocation_id') }}',
        '{{ parsed_result_dict.get('unique_id') }}',
        '{{ parsed_result_dict.get('database_name') }}',
        '{{ parsed_result_dict.get('schema_name') }}',
        '{{ parsed_result_dict.get('name') }}',
        '{{ parsed_result_dict.get('resource_type') }}',
        '{{ parsed_result_dict.get('materialization') }}',  -- MATERIALIZATION VALUE
        {{ started_at }},
        {{ completed_at }},
        '{{ parsed_result_dict.get('status') }}',
        {{ parsed_result_dict.get('rows_affected') }},
        case when '{{ var("dag_id") }}' = 'Null' then Null else '{{ var("dag_id") }}' end,
        case when '{{ var("dag_run_id") }}' = 'Null' then Null else '{{ var("dag_run_id") }}' end,
        case when '{{ parsed_result_dict.get('message') }}' = '0' or '{{ parsed_result_dict.get('message') }}' = 'None' or '{{ parsed_result_dict.get('status') }}' = 'success' then null else '{{ parsed_result_dict.get('message') }}' end,
        '{{ parsed_result_dict.get('run_user', 'unknown') }}'
    ){% if not loop.last %},{% endif %}
{%- endfor %}

        {% endset %}

        {%- do run_query(insert_dbt_results_query) -%}
    {%- endif -%}
{%- endif -%}

{{ return('') }}
{% endmacro %}
