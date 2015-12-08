//
//  SettingSliderItem.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/5.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "SettingSliderItem.h"
#import "SaveTool.h"

@implementation SettingSliderItem

+ (instancetype)itemWithTyple:(SettingSlideCellType)type value:(double)value
{
    SettingSliderItem *item = [[self alloc] init];
    item.type = type;
    
    // 读取存储数据
    float loadValue = [SaveTool floatForKey:[NSString stringWithFormat:@"%d", type]];
    item.value = loadValue > 0 ? loadValue : value;
    
    return item;
}

@end
