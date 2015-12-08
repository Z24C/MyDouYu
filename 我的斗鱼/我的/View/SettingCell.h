//
//  SettingCell.h
//  我的斗鱼
//
//  Created by 周驰 on 15/12/4.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingItem;

@interface SettingCell : UITableViewCell
@property (nonatomic, strong) SettingItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
