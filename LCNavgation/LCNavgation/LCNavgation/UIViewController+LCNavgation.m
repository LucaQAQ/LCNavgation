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

@implementation UIViewController (LCNavgation)

-(void)setNavgationView:(LCNavgationView *)navgationView{
    
    objc_setAssociatedObject(self, &navgationViewKey, navgationView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(LCNavgationView *)navgationView{
 
    return objc_getAssociatedObject(self, &navgationViewKey);
}
- (void)hideNavBackBtn{
    
    [self.navgationView hideLeftBtn];
}
- (void)hideNav{
    
    [self.navgationView hideNav];
}
- (void)showNav{
    
    [self.navgationView showNav];
}
#pragma mark - LCNavgationViewDelegate
//nav返回
- (void)nav_backActionWithController:(UIViewController *)controller{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UI
- (void)setNavTitle:(NSString *)title{
    self.navgationView.title = title;
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
- (void)setNavBackLeft:(CGFloat)navBackLeft{
    self.navgationView.navBackLeft = navBackLeft;
}
- (void)setNavRightBtnRight:(CGFloat)rightBtnRight{
    self.navgationView.rightBtnRight = rightBtnRight;
}
- (void)setNavRightBtnFont:(UIFont *)rightBtnFont{
    self.navgationView.rightBtnFont = rightBtnFont;
}
- (void)setNavRightBtnBgColor:(UIColor *)rightBtnBgColor{
    self.navgationView.rightBtnBgColor = rightBtnBgColor;
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
@end
