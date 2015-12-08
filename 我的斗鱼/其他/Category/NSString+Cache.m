//
//  NSString+Cache.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/6.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "NSString+Cache.h"

@implementation NSString (Cache)

- (long long)fileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL isDir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDir];
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    
    if (isDir) { // self是一个文件夹
        // 遍历caches里面的所有内容 --- 直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:self];
        long long totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [mgr attributesOfItemAtPath:self error:nil].fileSize;
    }
}

- (void)removeFile
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL isDir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDir];
    // 文件\文件夹不存在
    if (!exists) return;
    
    if (isDir) {
        NSArray *subPaths = [mgr subpathsAtPath:self];
        
        for (NSString *subPath in subPaths) {
            NSString *path = [self stringByAppendingPathComponent:subPath];
            if ([mgr fileExistsAtPath:path]) {
                [mgr removeItemAtPath:path error:nil];
            }
        }
    } else {
        [mgr removeItemAtPath:self error:nil];
    }
}

@end
