//
//  MoreCollectionFlowLayout.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/3.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "MoreCollectionFlowLayout.h"
#import "Common.h"

@implementation MoreCollectionFlowLayout

- (instancetype)init
{
    if (self = [super init]) {
        self.sectionInset = UIEdgeInsetsMake(ITEM_PADDING, ITEM_PADDING, ITEM_PADDING, ITEM_PADDING);
    }
    return self;
}

@end
