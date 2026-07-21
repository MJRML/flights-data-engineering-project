select
    cancelled,
    {{ to_boolean('cancelled') }} as flight_cancelled
from {{ source('raw', 'flights')}}
limit 20