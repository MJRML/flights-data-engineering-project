{#
    Remove any characters that are not number in Distance_miles
#}

{% macro extract_number(column_name) %}

    regexp_replace({{ column_name }}, '[^0-9]', '')::number
 
 {% endmacro %}

 {#
    Extarct airline name, removing airline code
 #}

 {% macro extract_airline_name(column_name) %}

    trim(split_part({{ column_name }}, ':', 1))

{% endmacro %}

{#
    Extract airport name, removing state
#}

{% macro extract_airport_name(column_name) %}

    trim(split_part({{ column_name }}, ':', 2))

{% endmacro %}