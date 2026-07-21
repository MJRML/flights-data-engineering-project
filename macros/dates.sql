{#
    Converts an integer or string in YYYYMMDD format
    into a Snowflake DATE.
#}

{% macro to_date_yyyymmdd(column_name) %}

    try_to_date(cast({{column_name}} as varchar), 'YYYYMMDD')

{% endmacro %}