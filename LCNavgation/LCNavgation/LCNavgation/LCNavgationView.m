//
//  LCNavgationView.m
//  LCNavgation
//
//  Created by Luca on 2019/3/20.
//  Copyright © 2019 Luca. All rights reserved.
//

#import "LCNavgationView.h"

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
@property (nonatomic, strong) UIButton *leftItem;

//当前返回按钮image
@property (nonatomic, strong) UIImage *navBackImg;
@property (nonatomic, assign) CGFloat rightContentWidth;

@end

@implementation LCNavgationView

//初始化
-(instancetype)initWithController:(UIViewController<LCNavgationViewDelegate> *)controller{
    
    if (self = [super init]) {
        
        self.controller = controller;
        self.rightItemFont = [UIFont systemFontOfSize:15];
        self.rightItemRight = 10.0;
        self.navLeftItemLeft = 10.0;
        self.delegate = controller;
        self.direction = LCGradientColorsDirectionLeft;
        self.frame = CGRectMake(0, 0, LC_SCREENWIDTH, LC_STATUSBAR_HEIGHT+LC_NAVBAR_HEIGHT);
        [self.controller.view addSubview:self];
        [self addSubview:self.navBgImageView];
        [self.navBgImageView addSubview:self.titleLab];
        [self.navBgImageView addSubview:self.leftItem];
        
        //原生方法无效
        controller.navigationController.interactivePopGestureRecognizer.enabled = NO;
        
        UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] init];
        SEL action = NSSelectorFromString(@"handleNavigationTransition:");
        [edgePanGestureRecognizer addTarget:controller.navigationController.self.interactivePopGestureRecognizer.delegate action:action];
        edgePanGestureRecognizer.edges = UIRectEdgeLeft;
        [controller.view addGestureRecognizer:edgePanGestureRecognizer];
    }
    return self;
}
//隐藏左按钮
- (void)hideLeftItem{
    
    self.leftItem.hidden = YES;
}
//隐藏右按钮
- (void)hideRightItem{
    if (_rightItem) {
        self.rightItem.hidden = YES;
    }
}
- (void)showRightItem{
    
    if (_rightItem) {
        self.rightItem.hidden = NO;
    }
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
    
    if (_delegate && [_delegate respondsToSelector:@selector(nav_leftActionWithLeftItem:)]) {
        [_delegate nav_leftActionWithLeftItem:self.leftItem];
    }
}
- (void)nav_rightAction{
    if (_delegate && [_delegate respondsToSelector:@selector(nav_rightActionWithRightItem:)]) {
        [_delegate nav_rightActionWithRightItem:self.rightItem];
    }
}
#pragma mark - set/get
-(UIButton *)rightItem{
    
    if (!_rightItem) {
        
        _rightItem = [[UIButton alloc]init];
        [_rightItem addTarget:self action:@selector(nav_rightAction) forControlEvents:UIControlEventTouchUpInside];
        [self.navBgImageView addSubview:_rightItem];
    }
    return _rightItem;
}
-(UIButton *)leftItem{
    
    if (!_leftItem) {
        
        UIImage *backImg = [UIImage imageNamed:@"nar_backImg"];
        self.navBackImg = backImg;
        _leftItem = [[UIButton alloc]initWithFrame:CGRectMake(0, LC_STATUSBAR_HEIGHT, backImg.size.width+14, LC_NAVBAR_HEIGHT)];
        [_leftItem setImage:backImg forState:UIControlStateNormal];
        [_leftItem addTarget:self action:@selector(nav_leftBackAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftItem;
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
-(void)setNavLeftItemLeft:(CGFloat)navLeftItemLeft{
    _navLeftItemLeft = navLeftItemLeft;
    _leftItem.frame = CGRectMake(0, LC_STATUSBAR_HEIGHT, self.navBackImg.size.width+navLeftItemLeft*2, LC_NAVBAR_HEIGHT);
}
//设置左按钮图片
- (void)setNavLeftItemImg:(UIImage *)image state:(UIControlState)state{
    
    self.navBackImg = image;
    _leftItem.frame = CGRectMake(0, LC_STATUSBAR_HEIGHT, self.navBackImg.size.width+self.navLeftItemLeft*2, LC_NAVBAR_HEIGHT);
    [_leftItem setImage:image forState:state];
}
-(void)setRightItemRight:(CGFloat)rightItemRight{
    
    _rightItemRight = rightItemRight;
    self.rightItem.frame = CGRectMake(LC_SCREENWIDTH-(rightItemRight*2+self.rightContentWidth), LC_STATUSBAR_HEIGHT, rightItemRight*2+self.rightContentWidth, LC_NAVBAR_HEIGHT);
}
-(void)setRightItemFont:(UIFont *)rightItemFont{
    
    if (rightItemFont) {
        _rightItemFont = rightItemFont;
        self.rightItem.titleLabel.font = _rightItemFont;
    }
}
- (void)setNavRightItemImg:(UIImage *)image state:(UIControlState)state{
    
    self.rightContentWidth = image.size.width;
    [self.rightItem setTitle:@"" forState:UIControlStateDisabled];
    [self.rightItem setTitle:@"" forState:UIControlStateNormal];
    [self.rightItem setTitle:@"" forState:UIControlStateSelected];
    [self.rightItem setImage:image forState:state];
    self.rightItem.frame = CGRectMake(LC_SCREENWIDTH-(_rightItemRight*2+self.rightContentWidth), LC_STATUSBAR_HEIGHT, _rightItemRight*2+self.rightContentWidth, LC_NAVBAR_HEIGHT);
}
- (void)setNavRightItemText:(NSString *)text state:(UIControlState)state{
    
    [self.rightItem setTitle:text forState:state];
    CGSize size = [LCNavTools sizeWithText:text maxContentSize:CGSizeMake(100, LC_NAVBAR_HEIGHT) font:_rightItemFont context:nil];
    self.rightContentWidth = size.width;
    [self.rightItem setImage:[UIImage new] forState:UIControlStateNormal];
    [self.rightItem setImage:[UIImage new] forState:UIControlStateDisabled];
    [self.rightItem setImage:[UIImage new] forState:UIControlStateSelected];
    self.rightItem.frame = CGRectMake(LC_SCREENWIDTH-(_rightItemRight*2+self.rightContentWidth), LC_STATUSBAR_HEIGHT, _rightItemRight*2+self.rightContentWidth, LC_NAVBAR_HEIGHT);
}
- (void)setNavRightItemTtitleColor:(UIColor *)color state:(UIControlState)state{
    
    if (color) {
        [self.rightItem setTitleColor:color forState:state];
    }
}
-(void)setRightItemBgColor:(UIColor *)rightItemBgColor{
    
    if (rightItemBgColor) {
        _rightItemBgColor = rightItemBgColor;
        self.rightItem.backgroundColor = rightItemBgColor;
    }
}
//添加视图
- (void)addAdditionalView:(UIView *)additionalView{
    
    [self.navBgImageView addSubview:additionalView];
    [self.navBgImageView sendSubviewToBack:additionalView];
}
@end
