//
//  RecommendCollectionFlowLayout.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/2.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "RecommendCollectionFlowLayout.h"
#import "Common.h"

@implementation RecommendCollectionFlowLayout
- (instancetype)init
{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(RECOMMEND_ITEM_WIDTH, RECOMMEND_ITEM_HEIGHT);
        self.minimumLineSpacing = ITEM_PADDING;
        self.minimumInteritemSpacing = ITEM_PADDING;
        self.sectionInset = UIEdgeInsetsMake(0, ITEM_PADDING, 0, ITEM_PADDING);
    }
    return self;
}
@end
