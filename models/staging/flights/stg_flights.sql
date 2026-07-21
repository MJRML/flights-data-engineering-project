with source as (

    select *
    from {{ source('raw', 'flights') }}

),

renamed as (

    select

        -- Identifiers
        transactionid as transaction_id,
        flightnum as flight_number,
        tailnum as tail_number,

        -- Airline
        airlinecode as airline_code,
        trim(airlinename) as airline_name,

        -- Flight Date
        {{ to_date_yyyymmdd('flightdate') }} as flight_date,

        -- Origin
        originairportcode as origin_airport_code,
        origairportname as origin_airport_name,
        origincityname as origin_city_name,
        originstate as origin_state,
        originstatename as origin_state_name,

        -- Destination
        destairportcode as destination_airport_code,
        destairportname as destination_airport_name,
        destcityname as destination_city_name,
        deststate as destination_state,
        deststatename as destination_state_name,

        -- Flight Times
        {{ to_time_hhmm('crsdeptime') }} as scheduled_departure_time,
        {{ is_next_day('crsdeptime') }} as scheduled_departure_next_day,

        {{ to_time_hhmm('deptime') }} as departure_time,
        {{ is_next_day('deptime') }} as departure_next_day,

        {{ to_time_hhmm('wheelsoff') }} as wheels_off_time,

        {{ to_time_hhmm('wheelson') }} as wheels_on_time,

        {{ to_time_hhmm('crsarrtime') }} as scheduled_arrival_time,
        {{ is_next_day('crsarrtime') }} as scheduled_arrival_next_day,

        {{ to_time_hhmm('arrtime') }} as arrival_time,
        {{ is_next_day('arrtime') }} as arrival_next_day,

        -- Operational Metrics
        depdelay as departure_delay_minutes,
        taxiout as taxi_out_minutes,
        taxiin as taxi_in_minutes,
        arrdelay as arrival_delay_minutes,
        crselapsedtime as scheduled_elapsed_time_minutes,
        actualelapsedtime as actual_elapsed_time_minutes,
        distance as distance_miles,

        -- Status Flags
        {{ to_boolean('cancelled') }} as cancelled,
        {{ to_boolean('diverted') }} as diverted,

        -- Fivetran Metadata
        "_file" as source_file,
        "_line" as source_line,
        "_modified" as source_modified,
        "_fivetran_synced" as fivetran_synced

    from source

)

select *
from renamed