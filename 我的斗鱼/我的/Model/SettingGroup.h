//
//  SettingGroup.h
//  我的斗鱼
//
//  Created by 周驰 on 15/12/4.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingGroup : NSObject
@property (nonatomic, copy) NSString *header;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, copy) NSString *footer;
@end
