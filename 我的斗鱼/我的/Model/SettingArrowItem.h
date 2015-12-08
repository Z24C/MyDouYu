//
//  SettingArrowItem.h
//  我的斗鱼
//
//  Created by 周驰 on 15/12/4.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "SettingItem.h"

@interface SettingArrowItem : SettingItem
@property (nonatomic, assign) Class destVcClass;

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon destVc:(Class)destVcClass;
@end
