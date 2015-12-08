//
//  SettingWordItem.h
//  我的斗鱼
//
//  Created by 周驰 on 15/12/5.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingWordItem : NSObject
@property (nonatomic, assign) double alpha;
@property (nonatomic, assign) double fontSize;

+ (instancetype)itemWithFontSize:(double)fontSize alpha:(double)alpha;
@end
