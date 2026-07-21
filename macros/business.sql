{#
    Caregorise flights into distance bands

    Business Rules:
        - Short Haul:  < 500 miles
        - Medium Haul: 500-1500 miles
        - Long Haul: > 1500 miles

#}

{% macro distance_band(column_name) %}

case
    when {{ column_name }} is null then null
    when {{ column_name }} < 500 then 'Short Haul'
    when {{ column_name }} <= 1500 then 'Medium Haul'
    else 'Long haul'
end

{% endmacro %}

{#
    Determine the overall flights status

    Business Rules:
    - Cancelled flights take the precedence
    - Diverted flight
    - Otherwise the flight is marked as completed
#}

{% macro flight_status(cancelled_column, diverted_column) %}

case
    when {{ cancelled_column }} then 'Cancelled'
    when {{ diverted_column }} then 'Diverted'
    else 'Completed'
end

{% endmacro %}

{#
    Flag flights delayed more than 15 minutes
    
    Business Rules:
    - A flight is considered delayed if the delay is greather then 15 minutes
#}

{% macro is_delayed(column_name) %}

case
    when {{ column_name }} is null then null
    when {{ column_name }} > 15 then true
    else false
end

{% endmacro %}

{#
    Categorise delay severity

    Business Rules:
    - <= 0 Minutes : On Time
    - 1-15 minutes: Minor Delay
    - 16-60 minutes: Moderate Delay
    - >60 Minutes: Major Delay
#}

{% macro delay_category(column_name) %}

case
    when {{ column_name }} is null then null
    when {{ column_name }} <= 0 then 'On Time / Early'
    when {{ column_name  }} <= 15 then 'Minor Delay'
    when {{ column_name }} <= 60 then 'Moderate Delay'
    else 'Major Delay'
end

{% endmacro %}

{#
    Categorise flights by actual flight duration.

    Business Rules:
    - Very Short: < 60 minutes
    - Short:      60–180 minutes
    - Medium:     181–300 minutes
    - Long:       > 300 minutes
#}

{% macro flight_duration_category(column_name) %}

case
    when {{ column_name }} is null then null
    when {{ column_name }} < 60 then 'Very Short'
    when {{ column_name }} <= 180 then 'Short'
    when {{ column_name }} <= 300 then 'Medium'
    else 'Long'
end

{% endmacro %}

{#
    Classify flights based on on-time performance.

    Business Rule:
    - On Time: <= 15 minutes delay
    - Delayed: > 15 minutes delay
#}

{% macro on_time_performance(column_name) %}

case
    when {{ column_name }} is null then null
    when {{ column_name }} <= 15 then 'On Time'
    else 'Delayed'
end

{% endmacro %}
