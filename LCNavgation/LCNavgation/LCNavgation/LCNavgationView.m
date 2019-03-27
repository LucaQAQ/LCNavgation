//
//  LCNavgationView.m
//  LCNavgation
//
//  Created by Luca on 2019/3/20.
//  Copyright © 2019 Luca. All rights reserved.
//

#import "LCNavgationView.h"

// 判断是否是iPhone X系列
#define LC_IS_iPhoneX      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?\
(\
CGSizeEqualToSize(CGSizeMake(375, 812),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(812, 375),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(414, 896),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(896, 414),[UIScreen mainScreen].bounds.size))\
:\
NO)
// 导航栏高度
#define LC_NAVBAR_HEIGHT 44.0f
//状态栏高度
#define LC_STATUSBAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)
//屏幕宽度
#define LC_SCREENWIDTH [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define LC_SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface LCNavgationView()

//当前controller
@property (nonatomic, weak) UIViewController *controller;
//背景
@property (nonatomic, strong) UIImageView *navBgImageView;
//标题lab
@property (nonatomic, strong) UILabel *titleLab;
//返回按钮
@property (nonatomic, strong) UIButton *backBtn;
//右上角按钮
@property (nonatomic, strong) UIButton *rightBtn;

//当前返回按钮image
@property (nonatomic, strong) UIImage *navBackImg;
@property (nonatomic, assign) CGFloat rightContentWidth;

@end

@implementation LCNavgationView

-(void)dealloc{
    
    NSLog(@"sdddd");
}
//初始化
-(instancetype)initWithController:(UIViewController *)controller{
    
    if (self = [super init]) {
        
        self.controller = controller;
        self.rightBtnFont = [UIFont systemFontOfSize:15];
        self.rightBtnRight = 7.0;
        self.direction = LCGradientColorsDirectionLeft;
        self.frame = CGRectMake(0, 0, LC_SCREENWIDTH, LC_STATUSBAR_HEIGHT+LC_NAVBAR_HEIGHT);
        [self.controller.view addSubview:self];
        [self addSubview:self.navBgImageView];
        [self.navBgImageView addSubview:self.titleLab];
        [self.navBgImageView addSubview:self.backBtn];
    }
    return self;
}
//重置状态(viewWillAppear:)
- (void)setNavWhenViewWillAppear{
    
    // 隐藏系统导航栏
    [_controller.navigationController setNavigationBarHidden:YES];
    //放最顶层
    [_controller.view bringSubviewToFront:self];
}
//隐藏左按钮
- (void)hideLeftBtn{
    
    self.backBtn.hidden = YES;
}
//隐藏、显示
- (void)hideNav{
    
    self.hidden = YES;
}
- (void)showNav{
    
    self.hidden = NO;
}
#pragma mark - Action
- (void)nav_leftBackAction{
    
    if (_delegate && [_delegate respondsToSelector:@selector(nav_backActionWithController:)]) {
        [_delegate nav_backActionWithController:self.controller];
    }
}
- (void)nav_rightAction{
    if (_delegate && [_delegate respondsToSelector:@selector(nav_rightActionWithController:)]) {
        [_delegate nav_rightActionWithController:self.controller];
    }
}
#pragma mark - set/get
-(UIButton *)rightBtn{
    
    if (!_rightBtn) {
        
        _rightBtn = [[UIButton alloc]init];
        [_rightBtn addTarget:self action:@selector(nav_rightAction) forControlEvents:UIControlEventTouchUpInside];
        [self.navBgImageView addSubview:_rightBtn];
    }
    return _rightBtn;
}
-(UIButton *)backBtn{
    
    if (!_backBtn) {
        
        UIImage *backImg = [UIImage imageNamed:@"nar_backImg"];
        self.navBackImg = backImg;
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, LC_STATUSBAR_HEIGHT, backImg.size.width+14, LC_NAVBAR_HEIGHT)];
        [_backBtn setImage:backImg forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(nav_leftBackAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
-(void)setTitle:(NSString *)title{
    
    self.titleLab.text = title;
}
-(UIImageView *)navBgImageView{
    
    if (!_navBgImageView) {
        
        _navBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LC_SCREENWIDTH, LC_STATUSBAR_HEIGHT+LC_NAVBAR_HEIGHT)];
        _navBgImageView.userInteractionEnabled = YES;
        _navBgImageView.backgroundColor = [UIColor whiteColor];
        
        //底部默认阴影
        _navBgImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        _navBgImageView.layer.shadowOffset = CGSizeMake(0,0);
        _navBgImageView.layer.shadowOpacity = 0.1;
        _navBgImageView.layer.shadowRadius = 3;
        float shadowPathWidth = _navBgImageView.layer.shadowRadius;
        CGRect shadowRect = CGRectMake(0, _navBgImageView.bounds.size.height, _navBgImageView.bounds.size.width, shadowPathWidth);
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];
        _navBgImageView.layer.shadowPath = path.CGPath;
    }
    return _navBgImageView;
}
-(UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(LC_SCREENWIDTH/4, LC_STATUSBAR_HEIGHT, LC_SCREENWIDTH/2, LC_NAVBAR_HEIGHT)];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont boldSystemFontOfSize:16];
    }
    return _titleLab;
}
#pragma mark - UI样式自定义
//背景色
-(void)setNavBgColors:(NSArray *)navBgColors{
    
    _navBgColors = navBgColors;
    if (navBgColors.count>0) {
        if (navBgColors.count == 1) {
            //单色
            id color = navBgColors[0];
            if ([color isKindOfClass:[UIColor class]]) {
                self.navBgImageView.backgroundColor = color;
            }
        }else{
            //渐变色
            UIColor *bgColor = [LCNavTools getGradientColors:navBgColors size:CGSizeMake(LC_SCREENWIDTH, self.frame.size.height) direction:self.direction];
            self.navBgImageView.backgroundColor = bgColor;
        }
    }
}
-(void)setDirection:(LCGradientColorsDirection)direction{
    
    if (self.navBgColors.count>0) {
        
        _direction = direction;
        UIColor *bgColor = [LCNavTools getGradientColors:self.navBgColors size:CGSizeMake(LC_SCREENWIDTH, self.frame.size.height) direction:direction];
        self.navBgImageView.backgroundColor = bgColor;
    }
}
//设置背景
-(void)setBgImage:(UIImage *)bgImage{
    
    _bgImage = bgImage;
    self.navBgImageView.image = bgImage;
}
//设置阴影
-(void)setShadowColor:(UIColor *)shadowColor{
    if (shadowColor) {
        _shadowColor = shadowColor;
        self.navBgImageView.layer.shadowColor = shadowColor.CGColor;
    }
}
-(void)setShadowOffset:(CGSize)shadowOffset{
    _shadowOffset = shadowOffset;
    self.navBgImageView.layer.shadowOffset = shadowOffset;
}
-(void)setShadowOpacity:(CGFloat)shadowOpacity{
    _shadowOpacity = shadowOpacity;
    self.navBgImageView.layer.shadowOpacity = shadowOpacity;
}
-(void)setShadowRadius:(CGFloat)shadowRadius{
    
    _shadowRadius = shadowRadius;
    self.navBgImageView.layer.shadowRadius = shadowRadius;
}
//title
-(void)setNavTitleFont:(UIFont *)navTitleFont{
    
    if (navTitleFont) {
        _navTitleFont = navTitleFont;
        self.titleLab.font = navTitleFont;
    }
}
-(void)setNavTitleColor:(UIColor *)navTitleColor{
    if (navTitleColor) {
        _navTitleColor = navTitleColor;
        self.titleLab.textColor = navTitleColor;
    }
}
-(void)setNavTitleLabmaxWidth:(CGFloat)navTitleLabmaxWidth{
    
    if (navTitleLabmaxWidth>0) {
        _navTitleLabmaxWidth = navTitleLabmaxWidth;
        self.titleLab.frame = CGRectMake((LC_SCREENWIDTH-navTitleLabmaxWidth)/2, LC_STATUSBAR_HEIGHT, navTitleLabmaxWidth, LC_NAVBAR_HEIGHT);
    }
}
-(void)setNavBackLeft:(CGFloat)navBackLeft{
    
    _navBackLeft = navBackLeft;
    _backBtn.frame = CGRectMake(0, LC_STATUSBAR_HEIGHT, self.navBackImg.size.width+navBackLeft*2, LC_NAVBAR_HEIGHT);
}
//设置左按钮图片
- (void)setNavLeftItemImg:(UIImage *)image state:(UIControlState)state{
    
    self.navBackImg = image;
    _backBtn.frame = CGRectMake(0, LC_STATUSBAR_HEIGHT, self.navBackImg.size.width+self.navBackLeft*2, LC_NAVBAR_HEIGHT);
    [_backBtn setImage:image forState:state];
}
-(void)setRightBtnRight:(CGFloat)rightBtnRight{
    
    _rightBtnRight = rightBtnRight;
    self.rightBtn.frame = CGRectMake(LC_SCREENWIDTH-(rightBtnRight*2+self.rightContentWidth), LC_STATUSBAR_HEIGHT, rightBtnRight*2+self.rightContentWidth, LC_NAVBAR_HEIGHT);
}
-(void)setRightBtnFont:(UIFont *)rightBtnFont{
    
    if (rightBtnFont) {
        _rightBtnFont = rightBtnFont;
        self.rightBtn.titleLabel.font = _rightBtnFont;
    }
}
- (void)setNavRightItemImg:(UIImage *)image state:(UIControlState)state{
    
    self.rightContentWidth = image.size.width;
    [self.rightBtn setTitle:@"" forState:UIControlStateNormal|UIControlStateDisabled|UIControlStateSelected];
    [self.rightBtn setImage:image forState:state];
    self.rightBtn.frame = CGRectMake(LC_SCREENWIDTH-(_rightBtnRight*2+self.rightContentWidth), LC_STATUSBAR_HEIGHT, _rightBtnRight*2+self.rightContentWidth, LC_NAVBAR_HEIGHT);
}
- (void)setNavRightItemText:(NSString *)text state:(UIControlState)state{
    
    [self.rightBtn setTitle:text forState:state];
    CGSize size = [LCNavTools sizeWithText:text maxContentSize:CGSizeMake(100, LC_NAVBAR_HEIGHT) font:_rightBtnFont context:nil];
    self.rightContentWidth = size.width;
    [self.rightBtn setImage:nil forState:UIControlStateNormal|UIControlStateDisabled|UIControlStateSelected];
    self.rightBtn.frame = CGRectMake(LC_SCREENWIDTH-(_rightBtnRight*2+self.rightContentWidth), LC_STATUSBAR_HEIGHT, _rightBtnRight*2+self.rightContentWidth, LC_NAVBAR_HEIGHT);
}
- (void)setNavRightItemTtitleColor:(UIColor *)color state:(UIControlState)state{
    
    if (color) {
        [self.rightBtn setTitleColor:color forState:state];
    }
}
-(void)setRightBtnBgColor:(UIColor *)rightBtnBgColor{
    
    if (rightBtnBgColor) {
        _rightBtnBgColor = rightBtnBgColor;
        self.rightBtn.backgroundColor = rightBtnBgColor;
    }
}

@end
