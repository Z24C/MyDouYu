//
//  SettingItem.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/4.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "SettingItem.h"

@implementation SettingItem

+ (instancetype)itemWithTitle:(NSString *)title
{
    SettingItem *item = [[self alloc] init];
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    SettingItem *item = [self itemWithTitle:title];
    item.icon = icon;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title operation:(SettingOpertion)operation;
{
    SettingItem *item = [self itemWithTitle:title];
    item.operation = operation;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon operation:(SettingOpertion)operation
{
    SettingItem *item = [self itemWithTitle:title icon:icon];
    item.operation = operation;
    return item;
}

- (void)setOperation:(SettingOpertion)operation
{
    _operation = operation;
}

@end
