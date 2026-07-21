with flights as (

    select *
    from {{ ref('stg_flights') }}

),

cleaned as (

    select

        -- Flight identifiers
        transaction_id,
        flight_number,
        tail_number,

        -- Airline
        airline_code,
        {{ extract_airline_name('airline_name') }} as airline_name,

        -- Flight date
        flight_date,

        -- Origin
        origin_airport_code,
        {{ extract_airport_name('origin_airport_name') }} as origin_airport_name,
        origin_city_name,
        origin_state,
        origin_state_name,

        -- Destination
        destination_airport_code,
        {{ extract_airport_name('destination_airport_name') }} as destination_airport_name,
        destination_city_name,
        destination_state,
        destination_state_name,

        -- Times
        scheduled_departure_time,
        scheduled_departure_next_day,

        departure_time,
        departure_next_day,

        wheels_off_time,
        wheels_on_time,

        scheduled_arrival_time,
        scheduled_arrival_next_day,

        arrival_time,
        arrival_next_day,

        -- Delays
        departure_delay_minutes,
        taxi_out_minutes,
        taxi_in_minutes,
        arrival_delay_minutes,

        scheduled_elapsed_time_minutes,
        actual_elapsed_time_minutes,

        -- Distance
        {{ extract_number('distance_miles') }} as distance_miles,

        -- Status
        cancelled,
        diverted,

        -- Metadata
        source_file,
        source_line,
        source_modified,
        fivetran_synced

    from flights

)

select

    *,

    -- Business Enrichments

    {{ distance_band('distance_miles') }} as distance_band,

    {{ flight_duration_category('actual_elapsed_time_minutes') }} as flight_duration_category,

    {{ flight_status('cancelled', 'diverted') }} as flight_status,

    {{ is_delayed('departure_delay_minutes') }} as is_departure_delayed,

    {{ is_delayed('arrival_delay_minutes') }} as is_arrival_delayed,

    {{ delay_category('departure_delay_minutes') }} as departure_delay_category,

    {{ delay_category('arrival_delay_minutes') }} as arrival_delay_category,

    {{ on_time_performance('departure_delay_minutes') }} as departure_on_time_performance,

    {{ on_time_performance('arrival_delay_minutes') }} as arrival_on_time_performance

from cleaned