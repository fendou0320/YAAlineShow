//
//  YALogInViewController.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/7/28.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YALogInViewController.h"
#import "YAThirdchannelsLogInView.h"
@interface YALogInViewController ()

@property(nonatomic, strong)IJKFFMoviePlayerController *movePlayer;

///快速通道
@property(nonatomic, strong)UIButton                   *quicklyButton;
///第三方登录
@property(nonatomic, strong)YAThirdchannelsLogInView   *thirdLogInView;
///palyer未播放状态下的视图
@property(nonatomic, strong)UIImageView                *coverImageView;


@end

@implementation YALogInViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self layoutSettings];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(void)layoutSettings
{
    self.coverImageView.hidden = NO;
    [self sendNotification];
    
    [self.quicklyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@50);
        make.right.equalTo(@-50);
        make.bottom.equalTo(@-50);
        make.bottom.height.equalTo(@40);
        
    }];
    
    [self.thirdLogInView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(@0);
        make.height.equalTo    (@60);
        make.bottom.equalTo(self.quicklyButton.mas_top).offset(-40);
        
    }];
}
-(void)sendNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveplayerFinished) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moveStatusDidChanged) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
}
-(void)moveplayerFinished
{
    ///重新播放
    [self.movePlayer play];
}
-(void)moveStatusDidChanged
{
    //防止player不在播放状态下的时候出现黑屏
    if ((self.movePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        
        if (!self.movePlayer.isPlaying) {
            [self.view insertSubview:self.coverImageView atIndex:0];
            [self.movePlayer play];
            self.quicklyButton.hidden   = NO;
        }
    }
}

-(IJKFFMoviePlayerController *)movePlayer
{
    if (!_movePlayer) {
        NSString *resourcePath                  = arc4random_uniform(10)/2 ?@"login_video":@"loginmovie";
        IJKFFMoviePlayerController *movePlayer  = [[IJKFFMoviePlayerController alloc] initWithContentURLString:[[NSBundle mainBundle] pathForResource:resourcePath ofType:@"mp4"] withOptions:[IJKFFOptions optionsByDefault]];
        movePlayer.view.frame                   = [UIScreen mainScreen].bounds;
        movePlayer.scalingMode                  = IJKMPMovieScalingModeAspectFill;
        movePlayer.shouldAutoplay               = NO;
        [self.view addSubview:movePlayer.view];
        _movePlayer                             = movePlayer;
        [_movePlayer prepareToPlay];
        
    }
    return _movePlayer;
}
-(UIImageView *)coverImageView
{
    if (!_coverImageView) {
        UIImageView  *coverImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        coverImageView.image         = [UIImage imageNamed:@"LaunchImage.png"];
        _coverImageView              = coverImageView;
        [self.movePlayer.view addSubview:coverImageView];
    }
    return _coverImageView;
}
-(UIButton *)quicklyButton
{
    if (!_quicklyButton) {
        
        UIButton  *quicklyButton = [YAUIFactoryTool setButtonFont:16.0 Title:@"Alin直播快速通道" selectedTitle:@"Alin直播快速通道" normalTitleColor:[UIColor yellowColor] selectedTitleColor:[UIColor yellowColor] targert:self selector:@selector(logInSuccess)];
        quicklyButton.backgroundColor   = [UIColor clearColor];
        quicklyButton.layer.borderColor = [UIColor yellowColor].CGColor;
        quicklyButton.layer.borderWidth = 1;
        quicklyButton.layer.cornerRadius = 10;
//        quicklyButton.hidden     = YES;
        _quicklyButton           = quicklyButton;
        [self.view addSubview:_quicklyButton];
    }
    return _quicklyButton;
}
-(YAThirdchannelsLogInView *)thirdLogInView
{
    if (!_thirdLogInView) {
        
        weakSelf(weakSelf)
        YAThirdchannelsLogInView *thirdLogInView = [[YAThirdchannelsLogInView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
        thirdLogInView.LogInBlock = ^(ThirdLogInType logInType){
           
            //目前先调用Success
            [weakSelf logInSuccess];
            
        };
        [self.view addSubview:thirdLogInView];
        _thirdLogInView   = thirdLogInView;
    }
    return _thirdLogInView;
}
-(void)logInSuccess
{
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        [self.movePlayer stop];
        [self.movePlayer.view removeFromSuperview];
        self.movePlayer = nil;
//    });
    [YACommonOperation setAppRootViewController:YES];
    
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
