//
//  DYRookieData.h
//  我的斗鱼
//
//  Created by 周驰 on 15/11/29.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYRookieData : NSObject
@property(nonatomic,copy)NSString *nickname; //昵称

@property(nonatomic,copy)NSString *game_name; //游戏类名

@property(nonatomic,copy)NSString *game_url;

@property(nonatomic,copy)NSString *owner_uid;

@property(nonatomic,copy)NSString *url;

@property(nonatomic,copy)NSString *vod_quality;

@property(nonatomic,copy)NSString *specific_status;

@property(nonatomic,copy)NSString *specific_catalog;

@property(nonatomic,copy)NSString *show_status;

@property(nonatomic,copy)NSString *show_time;

@property(nonatomic,copy)NSString *room_name;

@property(nonatomic,copy)NSString *cate_id;

@property(nonatomic,copy)NSString *room_src;

@property(nonatomic,copy)NSString *room_id;
@end
