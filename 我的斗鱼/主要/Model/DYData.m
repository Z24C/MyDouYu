//
//  DYData.m
//  我的斗鱼
//
//  Created by 周驰 on 15/11/28.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "DYData.h"
#import "MJExtension.h"
#import "DYRoom.h"

@implementation DYData
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"roomlist":[DYRoom class]};
}
@end
