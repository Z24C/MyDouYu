//
//  RookieIcon.h
//  我的斗鱼
//
//  Created by 周驰 on 15/12/1.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RookieIcon : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameLabel;

+ (instancetype)icon;
@end
