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

- (void)hideNavBackBtn;
- (void)hideNav;
- (void)showNav;

#pragma mark - UI
- (void)setNavTitle:(NSString *)title;
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
- (void)setNavBackLeft:(CGFloat)navBackLeft;
- (void)setNavRightBtnRight:(CGFloat)rightBtnRight;
- (void)setNavRightBtnFont:(UIFont *)rightBtnFont;
- (void)setNavRightBtnBgColor:(UIColor *)rightBtnBgColor;

//设置左按钮图片
- (void)setNavLeftItemImg:(UIImage *)image state:(UIControlState)state;
//设置右按钮
- (void)setNavRightItemImg:(UIImage *)image state:(UIControlState)state;
- (void)setNavRightItemText:(NSString *)text state:(UIControlState)state;
- (void)setNavRightItemTtitleColor:(UIColor *)color state:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
