//
//  LCNavgationView.h
//  LCNavgation
//
//  Created by Luca on 2019/3/20.
//  Copyright © 2019 Luca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCNavTools.h"
#import "LCNavgationViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCNavgationView : UIView

@property (nonatomic, weak) id<LCNavgationViewDelegate> delegate;
@property (nonatomic, strong) NSString *title;

//背景，多个表示渐变色
@property (nonatomic, strong) NSArray *navBgColors;
//渐变色的方向(当navBgColors有多个颜色的时候生效)
@property (nonatomic, assign) LCGradientColorsDirection direction;
//背景图片
@property (nonatomic, strong) UIImage *bgImage;
//底部阴影
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, assign) CGFloat shadowOpacity;
@property (nonatomic, assign) CGFloat shadowRadius;

//标题
@property (nonatomic, strong) UIFont *navTitleFont;
@property (nonatomic, strong) UIColor *navTitleColor;
@property (nonatomic, assign) CGFloat navTitleLabmaxWidth;

//返回按钮左间距
@property (nonatomic, assign) CGFloat navLeftItemLeft;
//右按钮
@property (nonatomic, strong) UIButton *rightItem;
@property (nonatomic, assign) CGFloat rightItemRight;
@property (nonatomic, strong) UIFont *rightItemFont;
@property (nonatomic, strong) UIColor *rightItemBgColor;

//初始化(放基类、或者swizzing viewDidLoad)
-(instancetype)initWithController:(UIViewController<LCNavgationViewDelegate> *)controller;

//隐藏左按钮
- (void)hideLeftItem;
//隐藏、显示
- (void)hideNav;
- (void)showNav;

//隐藏右按钮
- (void)hideRightItem;
- (void)showRightItem;

//设置左按钮图片
- (void)setNavLeftItemImg:(UIImage *)image state:(UIControlState)state;
//设置右按钮
- (void)setNavRightItemImg:(UIImage *)image state:(UIControlState)state;
- (void)setNavRightItemText:(NSString *)text state:(UIControlState)state;
- (void)setNavRightItemTtitleColor:(UIColor *)color state:(UIControlState)state;

//添加视图
- (void)addAdditionalView:(UIView *)additionalView;

@end

NS_ASSUME_NONNULL_END
