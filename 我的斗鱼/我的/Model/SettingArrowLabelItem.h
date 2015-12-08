//
//  SettingArrowLabelItem.h
//  我的斗鱼
//
//  Created by 周驰 on 15/12/4.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "SettingArrowItem.h"

@interface SettingArrowLabelItem : SettingArrowItem
@property (nonatomic, copy) NSString *text;

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon text:(NSString *)text destVc:(Class)destVcClass;
@end
