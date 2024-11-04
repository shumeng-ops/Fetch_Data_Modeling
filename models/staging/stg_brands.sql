select 
    json_data:_id:"$oid"::string as id,
    json_data:barcode::string as barcode,
    json_data:brandCode::string as brandCode,
    json_data:category::string as category,
    json_data:categoryCode::string as categoryCode,
    json_data:cpg:"$id":"$oid"::string as cpg_id,
    json_data:cpg:"$ref"::string as cpg_ref,
    json_data:"name"::string as name,
    json_data:topBrand::string as topBrand
from
    {{source('source_data','brands_json')}}