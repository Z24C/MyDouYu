//
//  OnlineViewController.m
//  我的斗鱼
//
//  Created by 周驰 on 15/11/26.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "OnlineViewController.h"
#import "HttpTool.h"
#import "DYRoom.h"
#import "DYData.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "Common.h"
#import "UIBarButtonItem+Extension.h"

static NSString * const URL = @"http://www.douyutv.com/api/v1/live?aid=ios&auth=b317487532542c2f8200f374f3153da2&client_sys=ios&limit=20";
static NSString * const URL_a = @"0";
static NSString * const URL_b = @"time=1446684180";

@interface OnlineViewController ()

@end

@implementation OnlineViewController

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

- (void)loadMoreData
{
    self.roomCount += 20;
    NSString *roomCount = [NSString stringWithFormat:@"%ld", self.roomCount];
    NSString *urlStr = [NSString stringWithFormat:@"%@&offset=%@&time=%@",URL,roomCount,URL_b];
    
    [HttpTool get:urlStr params:nil success:^(id responseObj) {
        NSArray *rooms = [DYRoom mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        [self.rooms addObjectsFromArray:rooms];
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        DYLog(@"%s %@", __FUNCTION__, error);
    }];
}

- (void)loadNewData
{
    NSString *urlStr = [NSString stringWithFormat:@"%@&offset=%@&time=%@",URL,URL_a,URL_b];
    
    [HttpTool get:urlStr params:nil success:^(id responseObj) {
        NSArray *rooms = [DYRoom mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        if (self.rooms.count == 0) {
            self.rooms = [rooms mutableCopy];
        } else {
            NSMutableArray *tempArray = [NSMutableArray array];
            [tempArray addObjectsFromArray:rooms];
            [tempArray addObjectsFromArray:self.rooms];
            self.rooms = tempArray;
        }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        DYLog(@"%s %@", __FUNCTION__, error);
    }];
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
