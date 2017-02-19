//
//  YAAlinShowPlayView.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/9/18.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YAAlinShowPlayView.h"
#import "YAAlineShowBottomToolView.h"

@interface YAAlinShowPlayView()

@property(nonatomic, strong)IJKFFMoviePlayerController *moviePlayerController;
@property(nonatomic, strong)YAAlineShowBottomToolView *showBottomToolView;


@end
@implementation YAAlinShowPlayView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self afterView];
    }
    return self;
}
-(void)afterView
{
    [self  addSubview:[self defaultImageView]];
    [self insertSubview:[self showBottomToolView] aboveSubview:self.defaultImageView];
}
-(UIImageView *)defaultImageView
{
    if (!_defaultImageView) {
        
        UIImageView *defaultImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ALinScreenWidth, ALinScreenHeight)];
        [defaultImageView setImage:[UIImage imageNamed:@"profile_user_414x414"]];
        defaultImageView.userInteractionEnabled = NO;
        _defaultImageView = defaultImageView;
    }
    return _defaultImageView;
}
-(YAAlineShowBottomToolView *)showBottomToolView
{
    weakSelf(weakself);
    if (!_showBottomToolView) {
        _showBottomToolView = [[YAAlineShowBottomToolView alloc] initWithFrame:CGRectMake(0, self.height - 50, self.width, 40)];
        _showBottomToolView.AliveToolButtonType = ^(YAAlineShowBottomToolViewType toolviewTpye)  {
            switch (toolviewTpye) {
                    
                case ALiveToolTypePublicTalk:{
                    
                }
                   
                    break;
                case ALiveToolTypePrivateTalk:{
                    
                }
                    
                    break;
                case ALiveToolTypeGift:{
                    
                }
                    
                    break;
                case ALiveToolTypeRank:{
                    
                }
                    
                    break;
                case ALiveToolTypeShare:{
                    
                }
                    
                    break;
                case ALiveToolTypeClose:{
                    [weakself closeAline];
                }
                   
                    break;
                default:
                    break;
            }
        };
    }
    return _showBottomToolView;
}
//关闭直播
-(void)closeAline
{
    if (_moviePlayerController) {
        [self.moviePlayerController shutdown];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
   
    [self.presenVC dismissViewControllerAnimated:NO completion:^{
        
    }];
}
-(void)setCellModel:(YAHotCellModel *)cellModel
{
    _cellModel = cellModel;
    [self handleDataStream:cellModel.flv pictureUrl:cellModel.bigpic];
    
}
-(void)handleDataStream:(NSString *)streamUrl pictureUrl:(NSString *)bigpic
{
    //避免缓存和复用
    if (_moviePlayerController) {
        [self.contentView insertSubview:self.defaultImageView aboveSubview:_moviePlayerController.view];
        [_moviePlayerController shutdown];
        [_moviePlayerController.view removeFromSuperview];
        _moviePlayerController = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
     weakSelf(weakCell);
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:bigpic] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakCell.defaultImageView setImage:[UIImageView blurImage:image blur:0.8]];
            [weakCell.presenVC showGifLoding:nil  inView:weakCell.defaultImageView];
           
        });
        
    }];
    
    //获得直播流
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    //设置videotoolbox框架
    [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];
    //设置帧速率
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    //设置最大帧
    [options setPlayerOptionIntValue:60 forKey:@"max-fps"];
    //设置音量
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:streamUrl withOptions:options];
    moviePlayer.view.frame = self.contentView.bounds;
    //填充格式fill
    moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    //设置不自动播放
    moviePlayer.shouldAutoplay = NO;
    //不显示hud
    moviePlayer.shouldShowHudView = NO;
    //设置监听
    [self setNotificationOfMoviePlayer];
    self.moviePlayerController = moviePlayer;
    [self.contentView insertSubview:self.moviePlayerController.view atIndex:0];
    [moviePlayer prepareToPlay];
    
}
-(void)setNotificationOfMoviePlayer
{
    //监听完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieplayerFinishPlay) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayerController];
    //监听状态变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieplayerStateChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayerController];
}
-(void)movieplayerFinishPlay
{
    weakSelf(weakself);

    if (self.moviePlayerController.loadState & IJKMPMovieLoadStateStalled && !self.presenVC.gifView) {
        [self.presenVC showGifLoding:nil inView:self.moviePlayerController.view];
        return;
    }
    [[YANetWorkHandleTool shareNetWorkTool] GET:_cellModel.flv parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败, 加载失败界面, 关闭播放器%@", error);
        [weakself.moviePlayerController shutdown];
        [weakself.moviePlayerController.view removeFromSuperview];
#pragma mark - 记得做播放完处理
        
    }];

}
-(void)movieplayerStateChange
{
    if ((self.moviePlayerController.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        weakSelf(weakself);
        if (!self.moviePlayerController.isPlaying) {
            [self.moviePlayerController play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_defaultImageView) {
                    [_defaultImageView removeFromSuperview];
                    _defaultImageView = nil;
                }
                [weakself.presenVC hideGufLoding];
            });
        }else{
            if (self.presenVC.gifView.isAnimating) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself.presenVC hideGufLoding];
                });
            }
        }
    }else if(self.moviePlayerController.loadState & IJKMPMovieLoadStateStalled){ // 网速不佳, 自动暂停状态
        [self.presenVC showGifLoding:nil inView:self.moviePlayerController.view];
    }
}
@end
