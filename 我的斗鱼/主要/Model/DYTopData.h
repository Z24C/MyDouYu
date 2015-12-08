//
//  DYTopData.h
//  我的斗鱼
//
//  Created by 周驰 on 15/11/28.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYRoom.h"

@interface DYTopData : NSObject
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *pic_url;

@property (nonatomic, strong) DYRoom *room;
@end
