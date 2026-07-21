select
    transaction_id,
    distance_miles,
    distance_band
from {{ref ('int_flights_enriched') }}
where
    (
        distance_miles < 500
        and distance_band <> 'Short Haul'
    )
    or
    (
        distance_miles between 500 and 1500
        and distance_band <> 'Medium Haul'
    )
    or
    (
        distance_miles > 1500
        and distance_band <> 'Long haul'
    )