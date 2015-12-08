//
//  SettingItem.h
//  我的斗鱼
//
//  Created by 周驰 on 15/12/4.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SettingOpertion)();

@interface SettingItem : NSObject
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, strong) SettingOpertion operation;
/** 设置标题 */
+ (instancetype)itemWithTitle:(NSString *)title;
/** 设置标题，图标 */
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
/** 设置标题，点击操作 */
+ (instancetype)itemWithTitle:(NSString *)title operation:(SettingOpertion)operation;
/** 设置标题，图标，点击操作 */
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon operation:(SettingOpertion)operation;
/** 设置点击操作 */
- (void)setOperation:(SettingOpertion)operation;
@end
