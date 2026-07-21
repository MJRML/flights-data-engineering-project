select
    transaction_id,
    cancelled,
    diverted,
    flight_status
from {{ ref ('int_flights_enriched') }}
where
    (cancelled = true and flight_status <> 'Cancelled')
    or
    (diverted = true and flight_status <> 'Diverted')
    or
    (
        cancelled = false
        and diverted = false
        and flight_status <> 'Completed'
    )