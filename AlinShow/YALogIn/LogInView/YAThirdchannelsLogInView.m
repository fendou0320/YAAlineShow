//
//  YAThirdchannelsLogInView.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/1.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YAThirdchannelsLogInView.h"

@implementation YAThirdchannelsLogInView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self layoutSettings];
        
    }
    return self;
}
-(void)layoutSettings
{
    UIButton *sinaButton     = [self createButton:[UIImage imageNamed:@"wbLoginicon_60x60"] LogInType:LOGINSINA];
    UIButton *qqButton       = [self createButton:[UIImage imageNamed:@"qqloginicon_60x60"] LogInType:LOGINQQ];
    UIButton *weChatButton   = [self createButton:[UIImage imageNamed:@"wxloginicon_60x60"] LogInType:LOGINWECHAT];
    [self addSubview:sinaButton];
    [self addSubview:qqButton];
    [self addSubview:weChatButton];
    
    [sinaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
        make.width.height.equalTo(@60);
        
    }];
    [qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.centerY.equalTo(sinaButton);
        make.right.equalTo(sinaButton.mas_left).offset(-20);
        make.size.equalTo(sinaButton);
    }];
    [weChatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(sinaButton);
        make.left.equalTo(sinaButton.mas_right).offset(20);
        make.size.equalTo(sinaButton);
        
    }];
    
}
-(UIButton *)createButton:(UIImage *)image LogInType:(ThirdLogInType)logIntype
{
    UIButton *logInButton = [YAUIFactoryTool setButtonImage:image targert:self selector:@selector(thirdLogInSuccess:)];
    logInButton.tag       = logIntype;
    return logInButton;
    
}
-(void)thirdLogInSuccess:(UIButton *)button
{
    if (self.LogInBlock) {
        self.LogInBlock(button.tag);
    }
}
@end
