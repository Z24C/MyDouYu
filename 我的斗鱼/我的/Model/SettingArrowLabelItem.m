//
//  SettingArrowLabelItem.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/4.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "SettingArrowLabelItem.h"

@implementation SettingArrowLabelItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon text:(NSString *)text destVc:(Class)destVcClass
{
    SettingArrowLabelItem *item = [super itemWithTitle:title icon:icon destVc:destVcClass];
    item.text = text;
    return item;
}

@end
