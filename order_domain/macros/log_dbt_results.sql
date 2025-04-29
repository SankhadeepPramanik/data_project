

    {% macro log_dbt_results(results,dag_id,dag_run_id) %}

    {%- if execute -%}
        {%- set parsed_results = parse_dbt_results(results) -%}
        {%- if parsed_results | length  > 0 -%}
            {% set insert_dbt_results_query -%}
                insert into {{ source('nextgen_audit','dbt_audit_logs') }}
                    (
                        invocation_id,
                        unique_id,
                        database_name,
                        schema_name,
                        name,
                        resource_type,
                        started_at,
                        completed_at,
                        status,
                        rows_affected,
                        dag_id,
                        dag_run_id,
                        message
                ) values
                    {%- for parsed_result_dict in parsed_results -%}
                        (
                            '{{ parsed_result_dict.get('invocation_id') }}',
                            '{{ parsed_result_dict.get('unique_id') }}',
                            '{{ parsed_result_dict.get('database_name') }}',
                            '{{ parsed_result_dict.get('schema_name') }}',
                            '{{ parsed_result_dict.get('name') }}',
                            '{{ parsed_result_dict.get('resource_type') }}',
                            case when '{{ parsed_result_dict.get('started_at') }}' !='None' then cast( substr(replace('{{ parsed_result_dict.get('started_at') }}','T',' '),1,23) as timestamp) else current_timestamp end,
                            case when '{{ parsed_result_dict.get('completed_at') }}' !='None'  then cast( substr(replace('{{ parsed_result_dict.get('completed_at') }}','T',' '),1,23) as timestamp) else DATE_ADD(current_timestamp, CAST({{ parsed_result_dict.get('execution_time') }} AS INTERVAL second)) end,                        
                            '{{ parsed_result_dict.get('status') }}',
                            {{ parsed_result_dict.get('rows_affected') }},
                            case when '{{ var("dag_id") }}'='Null' then Null else '{{ var("dag_id") }}' end,
                            case when '{{ var("dag_run_id") }}'='Null' then Null else '{{ var("dag_run_id") }}' end,
                            case when '{{ parsed_result_dict.get('message') }}'='0' or '{{ parsed_result_dict.get('message') }}'='None' or '{{ parsed_result_dict.get('status') }}'='success' then null else '{{ parsed_result_dict.get('message') }}' end 
                        ) {{- "," if not loop.last else "" -}}
                    {%- endfor -%}
            {%- endset -%}
            {%- do run_query(insert_dbt_results_query) -%}
        {%- endif -%}
    {%- endif -%}
    -- This macro is called from an on-run-end hook and therefore must return a query txt to run. Returning an empty string will do the trick
    {{ return ('') }}
{% endmacro %}

