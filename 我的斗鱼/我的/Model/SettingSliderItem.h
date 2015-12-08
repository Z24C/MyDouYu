//
//  SettingSliderItem.h
//  我的斗鱼
//
//  Created by 周驰 on 15/12/5.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingSlideCell.h"

typedef enum {
    /** 透明度 */
    SettingSlideCellTypeAlpha,
    /** 字体大小 */
    SettingSlideCellTypeSize
} SettingSlideCellType;

@interface SettingSliderItem : NSObject
@property (nonatomic, assign) SettingSlideCellType type;
/** slider的值 */
@property (nonatomic, assign) float value;

+ (instancetype)itemWithTyple:(SettingSlideCellType)type value:(double)value;
@end
