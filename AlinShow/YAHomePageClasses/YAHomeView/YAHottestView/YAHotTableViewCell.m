//
//  YAHotTableViewCell.m
//  AlinShow
//
//  Created by 蓝姬英 on 16/9/13.
//  Copyright © 2016年 Anna Yang. All rights reserved.
//

#import "YAHotTableViewCell.h"
static CGFloat YAHotTableViewCellHeight = 465.0;
@interface YAHotTableViewCell()

/*-头像-----*/
@property(nonatomic, strong)UIImageView *headPortrait;
/*--昵称----*/
@property(nonatomic, strong)UILabel *nameLabel;
/*--星级---*/
@property(nonatomic, strong)UIImageView *levelImage;
/*--观众数量--*/
@property(nonatomic, strong)UILabel *allNumLable;
/*--主播大图--*/
@property(nonatomic, strong)UIImageView *bigPictureImageView;
/*---城市--*/
@property(nonatomic, strong)UIButton *cityButton;
/*--直播提示-*/
@property(nonatomic, strong)UIButton *liveButton;
/*--用户背景View---*/
@property(nonatomic, strong)UIView *userBackView;

@end
@implementation YAHotTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self settingAttribute];
        [self afterView];
        [self resetSize];
    }
    return self;
}
-(void)settingAttribute
{
    self.backgroundColor = Color(241, 241, 241);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
-(void)afterView
{
    [self addSubview:[self userBackView]];
    [self addSubview:[self headPortrait]];
    [self addSubview:[self nameLabel]];
    [self addSubview:[self levelImage]];
    [self addSubview:[self cityButton]];
    [self addSubview:[self allNumLable]];
    [self addSubview:[self bigPictureImageView]];
    [self addSubview:[self liveButton]];
    
}
-(void)resetSize
{
    [self.headPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headPortrait.mas_right).offset(10);
        make.top.equalTo(_headPortrait);
        make.height.equalTo(@20);
    }];
    [self.levelImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(10);
        make.top.equalTo(_nameLabel.mas_top);
        make.bottom.equalTo(_nameLabel.mas_bottom);
        make.width.equalTo(@40);
    }];
    [self.allNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(_headPortrait.mas_bottom);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    [self.cityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headPortrait.mas_right).offset(10);
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        make.bottom.equalTo(_headPortrait);
    }];
    [self.bigPictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headPortrait.mas_bottom).offset(10);
        make.left.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.equalTo(self.mas_width);
       
    }];
    [self.liveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bigPictureImageView).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.width.equalTo(@45);
        make.height.equalTo(@22);
    }];
}
-(void)setHotCellModel:(YAHotCellModel *)hotCellModel
{
    _hotCellModel = hotCellModel;
    weakSelf(weakself)
    [_headPortrait sd_setImageWithURL:[NSURL URLWithString:hotCellModel.smallpic] placeholderImage:[UIImage imageNamed:@"placeholder_head.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        image = [UIImageView  circleImage:image borderColor:[UIColor redColor] borderWidth:1];
        weakself.headPortrait.image = image;
    }];
    _nameLabel.text = _hotCellModel.myname;
    [_levelImage setImage:[self starImage]];
    
    if (!hotCellModel.gps.length) {
        hotCellModel.gps = @"喵星";
    }
    [_cityButton setTitle:hotCellModel.gps forState:UIControlStateNormal];
    [_bigPictureImageView sd_setImageWithURL:[NSURL URLWithString:hotCellModel.bigpic] placeholderImage:[UIImage imageNamed:@"profile_user_414x414"]];
    // 设置当前观众数量
    NSString *fullNum = [NSString stringWithFormat:@"%@人在看", hotCellModel.allnum];
    NSRange range = [fullNum rangeOfString:[NSString stringWithFormat:@"%@", hotCellModel.allnum]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fullNum];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:AlineThemColor range:range];
    self.allNumLable.attributedText = attr;

}
-(UIImageView *)headPortrait
{
    if (!_headPortrait) {
        _headPortrait = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder_head.png"]];
    }
    return _headPortrait;
}
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [YAUIFactoryTool setLabel:@"喵播" titleFont:14.0 textAlignment:0];
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}
-(UIImageView *)levelImage
{
    if (!_levelImage) {
        _levelImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"girl_star1_40x19.png"]];
    }
    return _levelImage;
}
-(UILabel *)allNumLable
{
    if (!_allNumLable) {
        _allNumLable = [YAUIFactoryTool setLabel:@"0人在看" titleFont:14.0 textAlignment:2];
        [_allNumLable sizeToFit];
    }
    return _allNumLable;
}
-(UIButton *)cityButton
{
    if (!_cityButton) {
        _cityButton = [YAUIFactoryTool setButtonImage:[UIImage imageNamed:@"home_location_8x8.png"] targert:self selector:nil];
        [_cityButton setTitle:@"喵播" forState:UIControlStateNormal];
        _cityButton.titleLabel.font = [UIFont systemFontOfSize:11.0];
        _cityButton.userInteractionEnabled = NO;
    }
    return _cityButton;
}
-(UIButton *)liveButton
{
    if (!_liveButton) {
        _liveButton = [YAUIFactoryTool setButtonImage:[UIImage imageNamed:@"home_live_43x22.png"] targert:self selector:nil];
    }
    return _liveButton;
}
-(UIImageView *)bigPictureImageView
{
    if (!_bigPictureImageView) {
        _bigPictureImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_user_414x414.png"]];
    }
    return _bigPictureImageView;
}
- (UIImage *)starImage
{
    if (_hotCellModel.starlevel) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"girl_star%@_40x19", _hotCellModel.starlevel]];
    }
    return [UIImage imageNamed:@"girl_star1_40x19.png"];
}
-(UIView *)userBackView
{
    if (!_userBackView) {
        _userBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ALinScreenWidth, 60)];
        _userBackView.backgroundColor = [UIColor whiteColor];
        
    }
    return _userBackView;
}
+(CGFloat)hotTableViewCellHeight
{
    return YAHotTableViewCellHeight;
}
@end
