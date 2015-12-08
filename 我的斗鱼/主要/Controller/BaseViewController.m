//
//  BaseViewController.m
//  我的斗鱼
//
//  Created by 周驰 on 15/11/28.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "BaseViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "Common.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
}

- (void)setupNavigationBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"Image_scan" target:self action:@selector(leftItemClicked)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"btn_search" target:self action:@selector(rightItemClicked)];
    
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 104, 28)];
    titleView.image = [UIImage imageNamed:@"logo"];
    self.navigationItem.titleView = titleView;
}

- (void)leftItemClicked
{
    DYLog(@"scan clicked");
}

- (void)rightItemClicked
{
    DYLog(@"search clicked");
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
