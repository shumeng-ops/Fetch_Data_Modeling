select 
    json_data:_id:"$oid"::string as id,
    json_data:active::boolean as active,
    to_timestamp(json_data:createdDate:"$date"::number / 1000) as createdDate,
    to_timestamp(json_data:lastLogin:"$date"::number / 1000 )as lastLogin,
    json_data:"role"::string as role,
    json_data:signUpSource::string as signUpSource,
    json_data:"state"::string as state
from
    {{source('source_data','users_json')}}