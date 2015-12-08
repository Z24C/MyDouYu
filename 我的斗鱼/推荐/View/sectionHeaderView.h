//
//  sectionHeaderView.h
//  我的斗鱼
//
//  Created by 周驰 on 15/11/30.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sectionHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *moreImageView;
+ (instancetype)headerView;
@end
