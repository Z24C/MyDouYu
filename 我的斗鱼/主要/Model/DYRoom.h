//
//  DYRoom.h
//  我的斗鱼
//
//  Created by 周驰 on 15/11/28.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYRoom : NSObject
@property (nonatomic, copy) NSString *room_id;
/**在线人数*/
@property (nonatomic, copy) NSString *online;
/**游戏名*/
@property (nonatomic, copy) NSString *game_name;
/**房间名*/
@property (nonatomic, copy) NSString *room_name;
/**特殊目录*/
@property (nonatomic, copy) NSString *specific_catalog;

@property (nonatomic, copy) NSString *show_time;

@property (nonatomic, copy) NSString *show_status;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *game_url;

@property (nonatomic, copy) NSString *owner_uid;
/**房间图片*/
@property (nonatomic, copy) NSString *room_src;
/**直播昵称*/
@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *cate_id;

@property (nonatomic, copy) NSString *fans;


@end
