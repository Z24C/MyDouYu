//
//  ColumnCollectionViewFlowLayout.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/3.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "ColumnCollectionViewFlowLayout.h"
#import "Common.h"

@implementation ColumnCollectionViewFlowLayout

- (instancetype)init
{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(COLUMN_ITEM_WIDTH, COLUMN_ITEM_HEIGHT);
        self.minimumLineSpacing = ITEM_PADDING;
        self.minimumInteritemSpacing = ITEM_PADDING;
        self.sectionInset = UIEdgeInsetsMake(ITEM_PADDING, ITEM_PADDING, ITEM_PADDING, ITEM_PADDING);
    }
    return self;
}

@end
