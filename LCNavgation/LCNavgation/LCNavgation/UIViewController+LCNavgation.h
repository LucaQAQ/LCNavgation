//
//  UIViewController+LCNavgation.h
//  LCNavgation
//
//  Created by Luca on 2019/3/25.
//  Copyright © 2019 Luca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCNavgationView.h"

@class LCNavgationView;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LCNavgation)

@property (nonatomic, strong) LCNavgationView *navgationView;
@property (nonatomic, copy) NSString *navTitle;

/**
   导航栏的设置 初始化导航栏分别在VC的ViewDidLoad、ViewWillAppear、WillLayoutSubviews方法里进行设置
 */
- (void)initNavgationInViewDidLoad;
- (void)setNavgationInViewWillAppear;
- (void)setNavgationInViewWillLayoutSubviews;

- (void)hideNavLeftItem;
- (void)hideNav;
- (void)showNav;
- (void)hideNavRightItem;
- (void)showNavRightItem;

#pragma mark - UI
- (void)setNavBgColors:(NSArray *)navBgColors;
//渐变色的方向(当navBgColors有多个颜色的时候生效)
- (void)setNavDirection:(LCGradientColorsDirection)direction;
- (void)setNavBgImage:(UIImage *)bgImage;
- (void)setNavShadowColor:(UIColor *)shadowColor;
- (void)setNavShadowOffset:(CGSize)shadowOffset;
- (void)setNavShadowOpacity:(CGFloat)shadowOpacity;
- (void)setNavShadowRadius:(CGFloat)shadowRadius;
- (void)setNavTitleFont:(UIFont *)navTitleFont;
- (void)setNavTitleColor:(UIColor *)navTitleColor;
- (void)setNavTitleLabmaxWidth:(CGFloat)navTitleLabmaxWidth;
- (void)setNavLeftItemLeft:(CGFloat)navBackLeft;

//设置左按钮图片
- (void)setNavLeftItemImg:(UIImage *)image state:(UIControlState)state;
//设置右按钮
- (void)setNavRightItemRight:(CGFloat)rightBtnRight;
- (void)setNavRightItemFont:(UIFont *)rightBtnFont;
- (void)setNavRightItemBgColor:(UIColor *)rightBtnBgColor;

- (void)setNavRightItemImg:(UIImage *)image state:(UIControlState)state;
- (void)setNavRightItemText:(NSString *)text state:(UIControlState)state;
- (void)setNavRightItemTtitleColor:(UIColor *)color state:(UIControlState)state;

//添加视图
- (void)addNavAdditionalView:(UIView *)additionalView;

@end

NS_ASSUME_NONNULL_END
