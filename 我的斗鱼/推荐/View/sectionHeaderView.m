//
//  sectionHeaderView.m
//  我的斗鱼
//
//  Created by 周驰 on 15/11/30.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "sectionHeaderView.h"

@interface sectionHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *lineView;
@end

@implementation sectionHeaderView
+ (instancetype)headerView
{
    sectionHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"sectionHeaderView" owner:nil options:nil] lastObject];
    view.lineView.layer.cornerRadius = 2.5;
    view.lineView.layer.masksToBounds = YES;
    return view;
}
@end
