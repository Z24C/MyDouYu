//
//  DYData.h
//  我的斗鱼
//
//  Created by 周驰 on 15/11/28.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYData : NSObject
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *cate_id;

@property (nonatomic, strong) NSArray *roomlist;
@end
