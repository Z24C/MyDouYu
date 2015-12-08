//
//  RookieTableViewCell.h
//  我的斗鱼
//
//  Created by 周驰 on 15/11/30.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RookieTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray *rookieDatas;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
