//
//  SaveTool.h
//  我的斗鱼
//
//  Created by 周驰 on 15/12/5.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveTool : NSObject
+ (void)setObject:(id)value forKey:(NSString *)key;

+ (id)objectForKey:(NSString *)key;

+ (void)setBool:(BOOL)value forKey:(NSString *)key;

+ (BOOL)boolForKey:(NSString *)key;

+ (void)setFloat:(float)value forKey:(NSString *)key;

+ (float)floatForKey:(NSString *)key;


@end
