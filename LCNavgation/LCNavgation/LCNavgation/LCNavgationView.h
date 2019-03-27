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

//返回按钮
@property (nonatomic, assign) CGFloat navBackLeft;
//右按钮
@property (nonatomic, assign) CGFloat rightBtnRight;
@property (nonatomic, strong) UIFont *rightBtnFont;
@property (nonatomic, strong) UIColor *rightBtnBgColor;

//初始化(放基类、或者swizzing viewDidLoad)
-(instancetype)initWithController:(UIViewController *)controller;
                             ;
//重置状态(viewWillAppear:)
- (void)setNavWhenViewWillAppear;

//隐藏左按钮
- (void)hideLeftBtn;
//隐藏、显示
- (void)hideNav;
- (void)showNav;

//设置左按钮图片
- (void)setNavLeftItemImg:(UIImage *)image state:(UIControlState)state;
//设置右按钮
- (void)setNavRightItemImg:(UIImage *)image state:(UIControlState)state;
- (void)setNavRightItemText:(NSString *)text state:(UIControlState)state;
- (void)setNavRightItemTtitleColor:(UIColor *)color state:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
