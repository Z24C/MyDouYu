//
//  NSString+NowTime.m
//  我的斗鱼
//
//  Created by 周驰 on 15/11/28.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "NSString+NowTime.h"

@implementation NSString (NowTime)
+ (NSString *)nowTime
{
    NSDate *now = [NSDate date];
    return [NSString stringWithFormat:@"%.0f", now.timeIntervalSince1970];
}
@end
