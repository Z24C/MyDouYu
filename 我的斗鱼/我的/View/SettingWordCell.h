//
//  SettingWordCell.h
//  我的斗鱼
//
//  Created by 周驰 on 15/12/5.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingWordItem;

@interface SettingWordCell : UITableViewCell

@property (nonatomic, strong) SettingWordItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
