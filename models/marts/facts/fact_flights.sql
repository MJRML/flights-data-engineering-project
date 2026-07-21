with flights as (

    select *
    from {{ ref('int_flights_enriched') }}

),

final_facts as (

    select

        {{ dbt_utils.generate_surrogate_key(['flights.transaction_id']) }} as flight_key,

        -- Source business keys
        flights.transaction_id,
        flights.flight_number,
        flights.tail_number,

        -- Dimension foreign keys
        airlines.airline_key,
        origin_airport.airport_key      as origin_airport_key,
        destination_airport.airport_key as destination_airport_key,
        dates.date_key,

        -- Measures
        flights.departure_delay_minutes,
        flights.arrival_delay_minutes,
        flights.taxi_out_minutes,
        flights.taxi_in_minutes,
        flights.scheduled_elapsed_time_minutes,
        flights.actual_elapsed_time_minutes,
        flights.distance_miles,

        -- Flags
        flights.cancelled,
        flights.diverted

    from flights

    left join {{ ref('dim_airlines') }} airlines
        on flights.airline_code = airlines.airline_code

    left join {{ ref('dim_airports') }} origin_airport
        on flights.origin_airport_code = origin_airport.airport_code

    left join {{ ref('dim_airports') }} destination_airport
        on flights.destination_airport_code = destination_airport.airport_code

    left join {{ ref('dim_dates') }} dates
        on flights.flight_date = dates.date

)

select *
from final_facts