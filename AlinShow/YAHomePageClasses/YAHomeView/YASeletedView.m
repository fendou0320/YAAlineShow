//
//  YASeletedView.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/8/10.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YASeletedView.h"

// 首页的选择器的宽度
#define Home_Seleted_Item_W 60
#define DefaultMargin       10

@interface YASeletedView()

@property(nonatomic, strong)UILabel  *underLine;
@property(nonatomic, strong)UIButton *selectedButton;

@end
@implementation YASeletedView
-(UILabel *)underLine
{
    if (!_underLine) {
        
        UILabel *underLine = [[UILabel alloc] initWithFrame:CGRectMake(15,self.height - 4, Home_Seleted_Item_W + DefaultMargin, 2)];
        underLine.backgroundColor = [UIColor whiteColor];
        _underLine = underLine;
        [self addSubview:underLine];
    }
    return _underLine;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self buildsView];
    }
    return self;
}
-(void)buildsView
{
    UIButton *hottestButton = [self createButton:@"最热" homePageType:HOTTESTSHOW];
    UIButton *newestButton  = [self createButton:@"最新" homePageType:NEWESTSHOW];
    UIButton *attentionButton = [self createButton:@"关注" homePageType:ATTENTIONSHOW];
    [self addSubview:hottestButton];
    [self addSubview:newestButton];
    [self addSubview:attentionButton];
    
    [newestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
        make.width.equalTo(@Home_Seleted_Item_W);
    }];
    
    [hottestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(DefaultMargin * 2));
        make.centerY.equalTo(self);
        make.width.equalTo(@Home_Seleted_Item_W);
        
    }];
    [attentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(@(-DefaultMargin * 2));
        make.centerY.equalTo(self);
        make.width.equalTo(@Home_Seleted_Item_W);
        
    }];
    
    //强制更新一次，否则初始化下划线位置不对（如果不想这样写那就直接创建好下划线不要懒加载）
    [self layoutIfNeeded];
    //默认选中最热
    [self seletedButtonAction:hottestButton];
    
}
-(void)seletedButtonAction:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    weakSelf(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.underLine.centerX = button.centerX;
    }];
    if (self.homeSeletedBlock) {
        self.homeSeletedBlock(button.tag);
    }
}
-(UIButton *)createButton:(NSString *)title homePageType:(HomePageType)pagetype
{
    UIButton *homeButton = [YAUIFactoryTool setButtonFont:17 Title:title selectedTitle:title normalTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] selectedTitleColor:[UIColor whiteColor] targert:self selector:@selector(seletedButtonAction:)];
    homeButton.tag      = pagetype;
    return homeButton;
}
-(void)setHomePageType:(HomePageType)homePageType
{
    _homePageType = homePageType;
    self.selectedButton.selected = NO;
    for (UIView* targetView in self.subviews) {
        if ([targetView isKindOfClass:[UIButton class]] && targetView.tag == homePageType) {
            self.selectedButton = (UIButton *)targetView;
            self.selectedButton.selected = YES;
        }
    }
    weakSelf(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        
        weakSelf.underLine.centerX = self.selectedButton.centerX;
    }];
}
@end
