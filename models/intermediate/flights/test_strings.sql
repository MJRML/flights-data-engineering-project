select
    airline_name,
    {{ extract_airline_name('airline_name') }} as cleaned_airline_name,

    origin_airport_name,
    {{ extract_airport_name('origin_airport_name') }} as cleaned_origin_airport_name,

    destination_airport_name,
    {{ extract_airport_name('destination_airport_name') }} as cleaned_destination_airport_name,

    distance_miles,
    {{ extract_number('distance_miles') }} as cleaned_distance_miles

from {{ ref('stg_flights') }}
limit 20