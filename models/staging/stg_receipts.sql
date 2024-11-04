select 
    json_data:_id:"$oid"::string as id,
    json_data:bonusPointsEarned::number as bonusPointsEarned,
    json_data:bonusPointsEarnedReason::string as bonusPointsEarnedReason,
    to_timestamp(json_data:createdDate:"$date"::number / 1000) as createdDate,
    to_timestamp(json_data:dateScanned:"$date"::number / 1000) as dateScanned,
    to_timestamp(json_data:finishedDate:"$date"::number / 1000) as finishedDate,
    to_timestamp(json_data:modifyDate:"$date"::number / 1000) as modifyDate,
    to_timestamp(json_data:pointsAwardedDate:"$date"::number / 1000) as pointsAwardedDate,
    json_data:pointsEarned::number as pointsEarned,
    to_timestamp(json_data:purchaseDate:"$date"::number / 1000) as purchaseDate,
    json_data:purchasedItemCount::number as purchasedItemCount,
    json_data:rewardsReceiptItemList::array as rewardsReceiptItemList,
    json_data:rewardsReceiptStatus::string as rewardsReceiptStatus,
    json_data:totalSpent::number as totalSpent,
    json_data:userId::string as userId
from
    {{source('source_data','receipts_json')}}