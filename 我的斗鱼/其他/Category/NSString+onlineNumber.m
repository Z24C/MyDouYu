//
//  NSString+onlineNumber.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/2.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "NSString+onlineNumber.h"

@implementation NSString (onlineNumber)
- (NSString *)onlinePeople
{
    long long onlinePeople = self.longLongValue;
    if (onlinePeople <= 10000) {
        return self;
    } else {
        return [NSString stringWithFormat:@"%.1f万",onlinePeople/10000.0];
    }
}
@end
