{% macro generate_surrogate_key(columns) %}
    to_hex(
        md5(
            cast(
                {% for column in columns %}
                    coalesce(cast({{ column }} as VARCHAR), '_dbt_utils_surrogate_key_null_') 
                    {% if not loop.last %} || '-' || {% endif %}
                {% endfor %}
                as VARCHAR
            )
        )
    ) 
{% endmacro %}