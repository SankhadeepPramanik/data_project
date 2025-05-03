{% macro parse_dbt_results(results) %}
    {%- set parsed_results = [] %}
    {% for run_result in results %}
        {% set run_result_dict = run_result.to_dict() %}
        {% set node = run_result_dict.get('node') %}
        {% set materialization = node.get('config', {}).get('materialized', 'unknown') %}
        {% set rows_affected = run_result_dict.get('adapter_response', {}).get('rows_affected', 0) %}

        {# Override rows_affected to 0 if its a view #}
        {% if materialization == 'view' %}
            {% set rows_affected = 0 %}
        {% endif %}
        {%- if not rows_affected -%}
            {% set rows_affected = 0 %}
        {%- endif -%}

        {% if run_result_dict.get('timing') | length >= 1 %}
            {% set task_started_at = run_result_dict.get('timing')[-1].get('started_at') %}
            {% set task_completed_at = run_result_dict.get('timing')[-1].get('completed_at') %}
        {% else %}
            {% set task_started_at = None %}
            {% set task_completed_at = None %}
        {% endif %}

        {% set cleaned_message = run_result_dict.get('message', None) | replace("'", "") | replace("’", "") %}

        {% set parsed_result_dict = {
            'invocation_id': invocation_id,
            'unique_id': node.get('unique_id'),
            'database_name': node.get('database'),
            'schema_name': node.get('schema'),
            'name': node.get('name'),
            'resource_type': node.get('resource_type'),
            'materialization': materialization,
            'started_at': task_started_at,
            'completed_at': task_completed_at,
            'status': run_result_dict.get('status'),
            'rows_affected': rows_affected,
            'execution_time': run_result_dict.get('execution_time'),
            'message': cleaned_message
        } %}
        {% do parsed_results.append(parsed_result_dict) %}
    {% endfor %}
    {{ return(parsed_results) }}
{% endmacro %}
