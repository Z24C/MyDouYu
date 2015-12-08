//
//  SettingWordItem.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/5.
//  Copyright © 2015年 周驰. All rights reserved.
//  “弹幕君今天没吃药，感觉萌萌哒”item

#import "SettingWordItem.h"

@implementation SettingWordItem

+ (instancetype)itemWithFontSize:(double)fontSize alpha:(double)alpha
{
    SettingWordItem *item = [[self alloc] init];
    item.fontSize = fontSize;
    item.alpha = alpha;
    
    return item;
}

@end
