//
//  MineViewController.m
//  我的斗鱼
//
//  Created by 周驰 on 15/11/26.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "MineViewController.h"
#import "SettingItem.h"
#import "SettingArrowItem.h"
#import "Common.h"
#import "SettingGroup.h"
#import "SettingArrowLabelItem.h"
#import "SettingCell.h"
#import "SettingLoginCell.h"
#import "SystemSettingViewController.h"
#import "UIView+Extension.h"

@interface MineViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *groups;
@end

@implementation MineViewController

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self setupData];
    
    [self setupTableView];
}

- (void)setupData
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    SettingArrowItem *login = [SettingArrowItem itemWithTitle:@"点击登录" icon:@"Image_head" destVc:nil];
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = @[login];
    [self.groups addObject:group];
}

- (void)setupGroup1
{
    SettingArrowItem *focus = [SettingArrowItem itemWithTitle:@"我的关注" icon:@"Image_focus" destVc:nil];
    SettingArrowItem *history = [SettingArrowItem itemWithTitle:@"观看历史" icon:@"Image_history" destVc:nil];
    SettingArrowItem *task = [SettingArrowItem itemWithTitle:@"我的任务" icon:@"Image_recommend" destVc:nil];
    SettingArrowItem *remind = [SettingArrowItem itemWithTitle:@"开播提醒" icon:@"Image_remind" destVc:nil];
    SettingArrowItem *setting = [SettingArrowItem itemWithTitle:@"系统设置" icon:@"Image_set" destVc:[SystemSettingViewController class]];
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = @[focus, history, task, remind, setting];
    [self.groups addObject:group];
}

- (void)setupGroup2
{
    SettingArrowLabelItem *recommend = [SettingArrowLabelItem itemWithTitle:@"精彩推荐" icon:@"Image_recommend" text:@"更多鱼丸等你来拿" destVc:nil];
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = @[recommend];
    [self.groups addObject:group];
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - tableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SettingGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingGroup *group = self.groups[indexPath.section];
    if (indexPath.section == 0) {
        SettingLoginCell *cell = [SettingLoginCell cellWithTableView:tableView];
        cell.item = group.items[indexPath.row];
        cell.height = SETTING_LOGIN_HEIGHT;
        return cell;
    } else {
        SettingCell *cell = [SettingCell cellWithTableView:tableView];
        cell.item = group.items[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return SETTING_LOGIN_HEIGHT;
    } else {
        return SETTING_CELL_HEIGHT;
    }
}

#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SettingGroup *group = self.groups[indexPath.section];
    SettingItem *item = group.items[indexPath.row];
    
    if (item.operation) {
        item.operation();
        return;
    }
    
    if ([item isKindOfClass:[SettingArrowItem class]]) {
        SettingArrowItem *arrowItem = (SettingArrowItem *)item;
        if (arrowItem.destVcClass) {
            UIViewController *vc = [[arrowItem.destVcClass alloc] init];
            vc.title = arrowItem.title;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
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
