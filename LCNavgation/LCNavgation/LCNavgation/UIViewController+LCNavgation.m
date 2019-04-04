//
//  UIViewController+LCNavgation.m
//  LCNavgation
//
//  Created by Luca on 2019/3/25.
//  Copyright © 2019 Luca. All rights reserved.
//

#import "UIViewController+LCNavgation.h"
#import "LCNavgationView.h"
#import <objc/runtime.h>

static NSString *navgationViewKey = @"navgationViewKey";
static NSString *navTitleKey = @"navTitleKey";

@implementation UIViewController (LCNavgation)

#pragma mark - 初始化
- (void)initNavgationInViewDidLoad{
    
    //创建自定义导航栏
    self.navgationView = [[LCNavgationView alloc]initWithController:self];
    if (self.navTitle) {
        self.navgationView.title = self.navTitle;
    }
}
- (void)setNavgationInViewWillAppear{
    //设置系统导航栏透明、隐藏返回按钮、
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    self.navigationItem.title = @"";
    self.navigationController.navigationBar.hidden = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    //放最顶层
    [self.view bringSubviewToFront:self.navgationView];
}
- (void)setNavgationInViewWillLayoutSubviews{
    
    //新subview添加时，调整nav放最顶层
    [self.view bringSubviewToFront:self.navgationView];
}
#pragma mark - Nav
- (void)hideNavLeftItem{
    [self.navgationView hideLeftItem];
}
- (void)hideNav{
    [self.navgationView hideNav];
}
- (void)showNav{
    [self.navgationView showNav];
}
- (void)hideNavRightItem{
    [self.navgationView hideRightItem];
}
- (void)showNavRightItem{
    [self.navgationView showRightItem];
}
- (void)setNavBgColors:(NSArray *)navBgColors{
    self.navgationView.navBgColors = navBgColors;
}
//渐变色的方向(当navBgColors有多个颜色的时候生效)
- (void)setNavDirection:(LCGradientColorsDirection)direction{
    self.navgationView.direction = direction;
}
- (void)setNavBgImage:(UIImage *)bgImage{
    self.navgationView.bgImage = bgImage;
}
- (void)setNavShadowColor:(UIColor *)shadowColor{
    self.navgationView.shadowColor = shadowColor;
}
- (void)setNavShadowOffset:(CGSize)shadowOffset{
    self.navgationView.shadowOffset = shadowOffset;
}
- (void)setNavShadowOpacity:(CGFloat)shadowOpacity{
    self.navgationView.shadowOpacity = shadowOpacity;
}
- (void)setNavShadowRadius:(CGFloat)shadowRadius{
    self.navgationView.shadowRadius = shadowRadius;
}
- (void)setNavTitleFont:(UIFont *)navTitleFont{
    self.navgationView.navTitleFont = navTitleFont;
}
- (void)setNavTitleColor:(UIColor *)navTitleColor{
    self.navgationView.navTitleColor = navTitleColor;
}
- (void)setNavTitleLabmaxWidth:(CGFloat)navTitleLabmaxWidth{
    self.navgationView.navTitleLabmaxWidth = navTitleLabmaxWidth;
}
- (void)setNavLeftItemLeft:(CGFloat)navBackLeft{
    self.navgationView.navLeftItemLeft = navBackLeft;
}
- (void)setNavRightItemRight:(CGFloat)rightItemRight{
    self.navgationView.rightItemRight = rightItemRight;
}
- (void)setNavRightItemFont:(UIFont *)rightItemFont{
    self.navgationView.rightItemFont = rightItemFont;
}
- (void)setNavRightItemBgColor:(UIColor *)rightItemBgColor{
    self.navgationView.rightItemBgColor = rightItemBgColor;
}
//设置左按钮图片
- (void)setNavLeftItemImg:(UIImage *)image state:(UIControlState)state{
    
    [self.navgationView setNavLeftItemImg:image state:state];
}
//设置右按钮
- (void)setNavRightItemImg:(UIImage *)image state:(UIControlState)state{
    
    [self.navgationView setNavRightItemImg:image state:state];
}
- (void)setNavRightItemText:(NSString *)text state:(UIControlState)state{
    
    [self.navgationView setNavRightItemText:text state:state];
}
- (void)setNavRightItemTtitleColor:(UIColor *)color state:(UIControlState)state{
    
    [self.navgationView setNavRightItemTtitleColor:color state:state];
}
//添加视图
- (void)addNavAdditionalView:(UIView *)additionalView{
    
    [self.navgationView addAdditionalView:additionalView];
}
#pragma mark - LCNavgationViewDelegate
//nav返回
- (void)nav_leftActionWithLeftItem:(UIButton *)leftItem{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - set/get
-(void)setNavTitle:(NSString *)navTitle{
    
    objc_setAssociatedObject(self, &navTitleKey, navTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.navgationView.title = navTitle;
}
-(NSString *)navTitle{
    return objc_getAssociatedObject(self, &navTitleKey);
}
-(void)setNavgationView:(LCNavgationView *)navgationView{
    objc_setAssociatedObject(self, &navgationViewKey, navgationView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(LCNavgationView *)navgationView{
    return objc_getAssociatedObject(self, &navgationViewKey);
}
@end
