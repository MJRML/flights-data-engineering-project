select
    crsdeptime,
    {{ to_time_hhmm('crsdeptime') }} as scheduled_departure_time
from {{ source('raw', 'flights')}}
limit 20