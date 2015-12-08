//
//  SettingSlideCell.h
//  我的斗鱼
//
//  Created by 周驰 on 15/12/5.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingSlideCell;
@class SettingSliderItem;

@protocol SettingSlideCellDelegate <NSObject>

@optional
- (void)settingSlideCell:(SettingSlideCell *)cell slideValue:(CGFloat)value;

@end

@interface SettingSlideCell : UITableViewCell
@property (nonatomic, strong) SettingSliderItem *item;

@property (nonatomic, weak) id<SettingSlideCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
