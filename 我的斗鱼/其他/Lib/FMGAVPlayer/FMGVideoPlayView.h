//
//  FMGVideoPlayView.h
//  02-远程视频播放(AVPlayer)
//
//  Created by apple on 15/8/16.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol FMGVideoPlayViewDelegate <NSObject>



-(void)backAction;
-(void)shareAction;

@end

@interface FMGVideoPlayView : UIView

+ (instancetype)videoPlayView;


@property (nonatomic, copy) NSString *urlString;

@property(nonatomic,assign)id delegate;

@property (strong, nonatomic) IBOutlet UILabel *Onlines;

/* 包含在哪一个控制器中 */
@property (nonatomic, weak) UIViewController *contrainerViewController;

@end
