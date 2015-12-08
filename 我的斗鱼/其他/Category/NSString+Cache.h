//
//  NSString+Cache.h
//  我的斗鱼
//
//  Created by 周驰 on 15/12/6.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Cache)
/**
 *  计算当前文件\文件夹的内容大小
 */
- (long long)fileSize;

/**
 *  删除该路径下所有文件
 */
- (void)removeFile;
@end
