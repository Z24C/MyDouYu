//
//  ColumnData.h
//  我的斗鱼
//
//  Created by 周驰 on 15/12/3.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColumnData : NSObject
@property(nonatomic,strong)NSString *cate_id;
/**游戏图标*/
@property(nonatomic,strong)NSString *game_icon;
/**游戏名称*/
@property(nonatomic,strong)NSString *game_name;

@property(nonatomic,strong)NSString *short_name;

@property(nonatomic,strong)NSString *game_url;

@property(nonatomic,strong)NSString *game_src;

@property(nonatomic,strong)NSString *online_room;

@property(nonatomic,strong)NSString *online_room_ios;
@end
