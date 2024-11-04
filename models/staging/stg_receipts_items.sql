with receipt_data as (

    select * from {{ ref('stg_receipts') }}

),

exploded_items as (

    -- Here, we explode or unnest `rewardsReceiptItemList` into individual rows
    select 
        receipt_data.id as receipt_id,
        item.value as reward_item -- rewardsReceiptItemList is a JSON array of items
    from receipt_data,
    lateral flatten(input => receipt_data.rewardsReceiptItemList) as item

)

select 
    {{
        dbt_utils.generate_surrogate_key([
            'receipt_id',
            'reward_item:partnerItemId'
        ])
    }} as receipts_items_key,
    receipt_id,
    -- Items:
    reward_item:barcode::string as barcode,
    reward_item:description::string as description,
    reward_item:brandCode::string as brandCode,
    reward_item:itemNumber::string as itemNumber,
    reward_item:competitiveProduct::boolean as competitiveProduct,
    -- Price
    reward_item:finalPrice::float as finalPrice,
    reward_item:itemPrice::float as itemPrice,
    reward_item:discountedItemPrice::float as discountedItemPrice,
    reward_item:targetPrice::float as targetPrice,
    reward_item:priceAfterCoupon::float as priceAfterCoupon,
    reward_item:originalFinalPrice::float as originalFinalPrice,
    -- Fetch Review
    reward_item:needsFetchReview::boolean as needsFetchReview,
    reward_item:needsFetchReviewReason::string as needsFetchReviewReason,
    -- Partner Item ID
    reward_item:partnerItemId::string as partnerItemId,
    -- Points
    reward_item:pointsEarned::float as pointsEarned,
    reward_item:pointsNotAwardedReason::string as pointsNotAwardedReason,
    reward_item:pointsPayerId::string as pointsPayerId,
    reward_item:preventTargetGapPoints::boolean as preventTargetGapPoints,
    -- Quantity Purchased
    reward_item:quantityPurchased::int as quantityPurchased,
    -- Rewards
    reward_item:rewardsGroup::string as rewardsGroup,
    reward_item:rewardsProductPartnerId::string as rewardsProductPartnerId,
    reward_item:competitorRewardsGroup::string as competitorRewardsGroup,
    -- User Flag
    reward_item:userFlaggedBarcode::string as userFlaggedBarcode,
    reward_item:userFlaggedNewItem::boolean as userFlaggedNewItem,
    reward_item:userFlaggedPrice::float as userFlaggedPrice,
    reward_item:userFlaggedQuantity::int as userFlaggedQuantity,
    reward_item:userFlaggedDescription::string as userFlaggedDescription,
    --Original
    reward_item:originalReceiptItemText::string as originalReceiptItemText,
    reward_item:originalMetaBriteQuantityPurchased::int as originalMetaBriteQuantityPurchased,
    reward_item:originalMetaBriteBarcode::string as originalMetaBriteBarcode,
    reward_item:originalMetaBriteDescription::string as originalMetaBriteDescription,
    reward_item:originalMetaBriteItemPrice::float as originalMetaBriteItemPrice,
    reward_item:metabriteCampaignId::string as metabriteCampaignId,
    -- deleted
    reward_item:deleted::boolean as deleted
from exploded_items