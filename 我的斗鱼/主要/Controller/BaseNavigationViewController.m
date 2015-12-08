//
//  BaseNavigationViewController.m
//  我的斗鱼
//
//  Created by 周驰 on 15/11/26.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "Common.h"
#import "UIBarButtonItem+Extension.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

+ (void)initialize
{
    if (self == [BaseNavigationViewController class]) {
        UINavigationBar *navigationBar = [UINavigationBar appearance];
        navigationBar.tintColor = [UIColor whiteColor];
        navigationBar.barTintColor = TabBar_T_Color;
        NSDictionary *attrs = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        [navigationBar setTitleTextAttributes:attrs];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 统一设置push控制器的back
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"btn_nav_back" target:self action:@selector(backBarButtonItemClicked)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)backBarButtonItemClicked
{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
