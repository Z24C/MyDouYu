//
//  SaveTool.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/5.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "SaveTool.h"

@implementation SaveTool
+ (void)setObject:(id)value forKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
    
}

+ (id)objectForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:key];
    [defaults synchronize];
}

+ (BOOL)boolForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+ (void)setFloat:(float)value forKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:value forKey:key];
    [defaults synchronize];
}

+ (float)floatForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] floatForKey:key];
}

@end
