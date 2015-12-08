//
//  SettingArrowItem.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/4.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "SettingArrowItem.h"

@implementation SettingArrowItem
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon destVc:(Class)destVcClass
{
    SettingArrowItem *item = [super itemWithTitle:title icon:icon];
    item.destVcClass = destVcClass;
    return item;
}
@end
