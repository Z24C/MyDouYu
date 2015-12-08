//
//  CacheTool.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/6.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "CacheTool.h"
#import "NSString+Cache.h"

@implementation CacheTool
+ (float)cacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    long long cacheBytes = [cachePath fileSize];
    return (cacheBytes / 1024.0 / 1024.0);
}

+ (void)clearCache
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    [cachePath removeFile];
}
@end
