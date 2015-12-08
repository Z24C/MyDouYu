//
//  FMGVideoPlayView.m
//  02-远程视频播放(AVPlayer)
//
//  Created by apple on 15/8/16.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "FMGVideoPlayView.h"
#import "FullViewController.h"

@interface FMGVideoPlayView()

@property(nonatomic, strong)UIButton *selButton;

/* 播放器 */
@property (nonatomic, strong) AVPlayer *player;

// 播放器的Layer
@property (weak, nonatomic) AVPlayerLayer *playerLayer;

/* playItem */
@property (nonatomic, weak) AVPlayerItem *currentItem;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIView *toolView;

@property (strong, nonatomic) IBOutlet UIButton *backButton;

@property (strong, nonatomic) IBOutlet UIButton *ShareButton;

@property (strong, nonatomic) IBOutlet UIButton *Big_Sml;


// 记录当前是否显示了工具栏
@property (assign, nonatomic) BOOL isShowToolView;

/* 定时器 */
@property (nonatomic, strong) NSTimer *progressTimer;

/* 工具栏的显示和隐藏 */
@property (nonatomic, strong) NSTimer *showTimer;

/* 工具栏展示的时间 */
@property (assign, nonatomic) NSTimeInterval showTime;

/* 全屏控制器 */
@property (nonatomic, strong) FullViewController *fullVc;

#pragma mark - 监听事件的处理

- (IBAction)switchOrientation:(UIButton *)sender;

- (IBAction)tapAction:(UITapGestureRecognizer *)sender;

- (IBAction)BackAction:(UIButton *)sender;

- (IBAction)ShareAction:(UIButton *)sender;




@end

@implementation FMGVideoPlayView


// 快速创建View的方法
+ (instancetype)videoPlayView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"FMGVideoPlayView" owner:nil options:nil] firstObject];
}
- (AVPlayer *)player
{
    if (!_player) {

        // 初始化Player和Layer
        _player = [[AVPlayer alloc] init];
    }
    return _player;
}

- (void)awakeFromNib
{
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.imageView.layer addSublayer:self.playerLayer];
    
    // 设置工具栏的状态
    self.toolView.alpha = 0;
    self.isShowToolView = NO;
    
    
    [self showToolView:YES];
}

#pragma mark - 观察者对应的方法

#pragma mark - 重新布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.playerLayer.frame = self.bounds;
}

#pragma mark - 设置播放的视频
- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
   
    NSURL *url = [NSURL URLWithString:urlString];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    self.currentItem = item;
    
    [self.player replaceCurrentItemWithPlayerItem:self.currentItem];
    
    [self.player play];
    
}

// 是否显示工具的View
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [self showToolView:!self.isShowToolView];
    
}

- (IBAction)BackAction:(UIButton *)sender {
    
    
    if (sender.selected) {
        
        _Big_Sml.selected=NO;
        [self videoplayViewSwitchOrientation:!sender.selected];
    }
    else {
        
        [self.delegate backAction];
    }
    
}

- (IBAction)ShareAction:(UIButton *)sender {
    
    [self.delegate shareAction];
}



- (void)showToolView:(BOOL)isShow
{
    self.toolView.alpha=!self.isShowToolView;
   
    [UIView animateWithDuration:1.0 animations:^{
        self.isShowToolView = !self.isShowToolView;
        self.backButton.hidden=!self.isShowToolView;
        self.ShareButton.hidden=!self.isShowToolView;
    }];
}


#pragma mark - 切换屏幕的方向

- (IBAction)switchOrientation:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [self videoplayViewSwitchOrientation:sender.selected];
}

- (void)videoplayViewSwitchOrientation:(BOOL)isFull
{
    _backButton.selected=isFull;
    
    if (isFull) {
    
        [self.contrainerViewController presentViewController:self.fullVc animated:NO completion:^{
            [self.fullVc.view addSubview:self];
            self.center = self.fullVc.view.center;
            
            [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                self.frame = self.fullVc.view.bounds;
            } completion:nil];
        }];
    } else {
    
        [self.fullVc dismissViewControllerAnimated:NO completion:^{
            [self.contrainerViewController.view addSubview:self];
            
            [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                self.frame = CGRectMake(0, 20, self.contrainerViewController.view.bounds.size.width, self.contrainerViewController.view.bounds.size.width * 9 / 16);
            } completion:nil];
        }];
    }
}

#pragma mark - 懒加载代码
- (FullViewController *)fullVc
{
    if (_fullVc == nil) {
        _fullVc = [[FullViewController alloc] init];
    }
    return _fullVc;
}

@end
