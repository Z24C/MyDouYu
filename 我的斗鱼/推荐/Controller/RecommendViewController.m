//
//  RecommendViewController.m
//  我的斗鱼
//
//  Created by 周驰 on 15/11/26.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "RecommendViewController.h"
#import "SDRotationLoopProgressView.h"
#import "Common.h"
#import "DYRoom.h"
#import "DYData.h"
#import "DYTopData.h"
#import "NSString+NowTime.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "DYRookieData.h"
#import "SDCycleScrollView.h"
#import "sectionHeaderView.h"
#import "RookieTableViewCell.h"
#import "RecommendTableViewCell.h"
#import "PlayerController.h"
#import "MJRefresh.h"
#import "MoreViewController.h"

@interface RecommendViewController () <UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate, RecommendTableViewCellDelegate>
/**
 *  tableView数据模型
 */
@property (nonatomic, strong) NSArray *dyDatas;
/**
 *  loading提示
 */
@property (nonatomic, weak) SDRotationLoopProgressView *progressView;
/**
 *  顶部滚动数据模型
 */
@property (nonatomic, strong) NSArray *dyTopDatas;
/**
 *  中间新人推荐数据模型
 */
@property (nonatomic, strong) NSArray *dyRookieDatas;
@property (nonatomic, weak) SDCycleScrollView *headerView;
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation RecommendViewController

- (SDRotationLoopProgressView *)progressView
{
    if (_progressView == nil) {
        _progressView = [SDRotationLoopProgressView progressView];
        _progressView.bounds = CGRectMake(0, 0, SCREEN_WIDTH * 0.3, SCREEN_HEIGHT * 0.3);
        _progressView.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5);
        _progressView.tintColor = TabBar_T_Color;
        [self.view addSubview:_progressView];
    }
    return _progressView;
}

- (SDCycleScrollView *)headerView
{
    if (_headerView == nil) {
        NSArray *imgURLs = [self.dyTopDatas valueForKeyPath:@"pic_url"];
        SDCycleScrollView *headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/16*9) imageURLStringsGroup:imgURLs];
        _headerView = headerView;
        _headerView.autoScrollTimeInterval = 5.0;
        NSArray *titles = [self.dyTopDatas valueForKeyPath:@"title"];
        _headerView.titlesGroup = titles;
        _headerView.placeholderImage = [UIImage imageNamed:@"Img_default"];
        _headerView.delegate = self;
        _headerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _headerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _headerView.titleLabelTextFont = [UIFont systemFontOfSize:17];
    }
    return _headerView;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabBarController.tabBar.frame.size.height-64) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView = tableView;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self loadDYData];
    [self loadDYTopData];
    [self loadDYRookieData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAll)];
}

- (void)refreshAll
{
    [self loadDYData];
    [self loadDYTopData];
    [self loadDYRookieData];
}

- (void)loadDYData
{
    self.progressView.hidden = NO;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",CHANEL_URl, [NSString nowTime]];
    [HttpTool get:url params:nil success:^(id responseObj) {
        self.dyDatas = [DYData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        [UIView animateWithDuration:0.5 animations:^{
            self.progressView.hidden = YES;
        }];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        DYLog(@"_DYData加载失败,%@", error);
    }];
}

- (void)loadDYTopData
{
    NSDictionary *params = @{@"aid":@"ios"
                             ,@"auth":@"97d9e4d3e9dfab80321d11df5777a107"
                             ,@"client_sys":@"ios"
                             ,@"time":[NSString nowTime]};
    [HttpTool get:TOP_URl params:params success:^(id responseObj) {
        self.dyTopDatas = [DYTopData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        // 设置tableHeaderView
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.tableHeaderView = self.headerView;
        });
    } failure:^(NSError *error) {
        DYLog(@"_DYTopData加载失败,%@", error);
    }];
}

- (void)loadDYRookieData
{
    NSString *url=[NSString stringWithFormat:@"%@%@",NEW_URl,[NSString nowTime]];
    
    [HttpTool get:url params:nil success:^(id responseObj) {
        self.dyRookieDatas = [DYRookieData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        // 刷新第一行tableView
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        });
    } failure:^(NSError *error) {
        DYLog(@"_DYRookieData加载失败,%@", error);
    }];
}

#pragma mark - tableView数据源及代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dyDatas.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 新秀推荐
        RookieTableViewCell *cell = [RookieTableViewCell cellWithTableView:tableView];
        cell.rookieDatas = self.dyRookieDatas;
        return cell;
    } else {
        // 视频推荐
        RecommendTableViewCell *cell = [RecommendTableViewCell cellWithTableView:tableView];
        cell.delegate = self;
        DYData *dyData = self.dyDatas[indexPath.section-1];
        cell.dyData = dyData;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return ROOKIE_CELL_HEIGHT;
    } else {
        return RECOMMEND_CELL_HEIGHT;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    sectionHeaderView *header = [sectionHeaderView headerView];
    if (section == 0) {
        header.titleLabel.text = @"新秀推荐";
        header.moreLabel.hidden = YES;
        header.moreImageView.hidden = YES;
    } else {
        header.moreLabel.hidden = NO;
        header.moreImageView.hidden = NO;
        header.titleLabel.text = [self.dyDatas[section-1] title];
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderViewTapped:)];
        header.tag = section - 1;
        [header addGestureRecognizer:tap];
    }
    return header;
}

#pragma mark - cycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    PlayerController *playerVc = [[PlayerController alloc] init];
    playerVc.room = [self.dyTopDatas[index] room];
    [self presentViewController:playerVc animated:YES completion:nil];
}

#pragma mark - recommendTableViewCellDelegate

- (void)recommendTableViewCell:(RecommendTableViewCell *)cell didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerController *playerVc = [[PlayerController alloc] init];
    playerVc.room = [self.dyDatas[indexPath.section] roomlist][indexPath.item];
    [self presentViewController:playerVc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 手势点击处理

- (void)sectionHeaderViewTapped:(UIGestureRecognizer *)tap
{
    DYLog(@"%s %ld", __FUNCTION__, tap.view.tag);
    MoreViewController *moreVc = [[MoreViewController alloc] init];
    moreVc.dyData = self.dyDatas[tap.view.tag];
    [self.navigationController pushViewController:moreVc animated:YES];
}

@end
