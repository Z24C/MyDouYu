//
//  BaseTabBarViewController.m
//  我的斗鱼
//
//  Created by 周驰 on 15/11/26.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "RecommendViewController.h"
#import "MineViewController.h"
#import "OnlineViewController.h"
#import "ColumnViewController.h"
#import "Common.h"
#import "BaseNavigationViewController.h"

@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = TabBar_T_Color;
    UIView *bg = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bg.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:bg atIndex:0];
    self.tabBar.opaque = YES;
    
    [self setupChildControllers];
}

- (void)setupChildControllers
{
    RecommendViewController *recommendVc = [[RecommendViewController alloc] init];
    [self addChildViewControllerWithViewController:recommendVc norImage:[UIImage imageNamed:@"btn_home_normal"] selImage:[UIImage imageNamed:@"btn_home_selected"] title:@"推荐"];
    
    ColumnViewController *columnVc = [[ColumnViewController alloc] init];
    [self addChildViewControllerWithViewController:columnVc norImage:[UIImage imageNamed:@"btn_column_normal"] selImage:[UIImage imageNamed:@"btn_column_selected"] title:@"栏目"];
    
    OnlineViewController *onlineVc = [[OnlineViewController alloc] init];
    [self addChildViewControllerWithViewController:onlineVc norImage:[UIImage imageNamed:@"btn_live_normal"] selImage:[UIImage imageNamed:@"btn_live_selected"] title:@"直播"];
    
    MineViewController *mineVc = [[MineViewController alloc] init];
    [self addChildViewControllerWithViewController:mineVc norImage:[UIImage imageNamed:@"btn_user_normal"] selImage:[UIImage imageNamed:@"btn_user_selected"] title:@"我的"];
}

- (void)addChildViewControllerWithViewController:(UIViewController *)vc norImage:(UIImage *)norImg selImage:(UIImage *)selImg title:(NSString *)title
{
    [vc.tabBarItem setImage:norImg];
    [vc.tabBarItem setSelectedImage:selImg];
    vc.title = title;
    BaseNavigationViewController *nv = [[BaseNavigationViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:nv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
