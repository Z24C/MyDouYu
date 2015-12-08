//
//  PlayerController.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/2.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "PlayerController.h"
#import "FMGVideoPlayView.h"
#import "DYRoom.h"
#import "Common.h"
#import "NSString+NowTime.h"
#import "NSString+onlineNumber.h"
#import "YFViewPager.h"

@interface PlayerController () <FMGVideoPlayViewDelegate>
@property (nonatomic, weak) FMGVideoPlayView *playView;
@property (nonatomic, weak) YFViewPager *pageView;
@end

@implementation PlayerController
- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupPlayView];
    [self setupPageView];
}

- (void)setupPlayView
{
    FMGVideoPlayView *playView = [FMGVideoPlayView videoPlayView];
    self.playView = playView;
    playView.delegate = self;
    playView.urlString = [NSString stringWithFormat:@"http://www.douyutv.com/api/v1/room/105313?aid=ios&time=%@&client_sys=ios&auth=1eb01833455d5249cf9665a1fe5a16de", [NSString nowTime]];
    [self.view addSubview:playView];
    playView.Onlines.text = [self.room.online onlinePeople];
    // 设置显示位置（竖屏时）
    playView.frame = CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_WIDTH*9/16);
    // 指定一个作为播放的控制器
    playView.contrainerViewController = self;
}

- (void)setupPageView
{
    NSArray *titles = @[@"聊天", @"主播", @"排行"];
    UIWebView *webView = [[UIWebView alloc] init];
    UIView *orangeView = [[UIView alloc] init];
    orangeView.backgroundColor = [UIColor orangeColor];
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    });
    NSArray *views = @[webView, whiteView, orangeView];
    
    YFViewPager *pageView = [[YFViewPager alloc] initWithFrame:CGRectMake(0,SCREEN_WIDTH * 9 / 16+20, SCREEN_WIDTH ,SCREEN_HEIGHT-SCREEN_WIDTH * 9 / 16-20)
                                             titles:titles
                                              icons:nil
                                      selectedIcons:nil
                                              views:views];
    self.pageView = pageView;
    [self.view addSubview:pageView];
    
    // 设置点击操作
    [pageView didSelectedBlock:^(id viewPager, NSInteger index) {
        switch (index) {
            case 0:
            {
                NSLog(@"点击第一个菜单");
            }
                break;
            case 1:
            {
                NSLog(@"点击第二个菜单");
            }
                break;
            case 2:
            {
                NSLog(@"点击第三个菜单");
            }
                break;
                
            default:
                break;
        }
    }];
}

- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)shareAction
{
    DYLog(@"share");
}

@end
