//
//  LCNavTools.h
//  LCNavgation
//
//  Created by Luca on 2019/3/21.
//  Copyright © 2019 Luca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, LCGradientColorsDirection) {
    LCGradientColorsDirectionLeft,//从左往右
    LCGradientColorsDirectionRight,//从右往左
    LCGradientColorsDirectionTop,//从上往下
    LCGradientColorsDirectionBottom,//从下往上
};
@interface LCNavTools : NSObject

/**
 渐变色
 
 @param colors 颜色数组
 @param size size
 @param direction 渐变方向
 @return 渐变色
 */
+ (UIColor *)getGradientColors:(NSArray *)colors
                          size:(CGSize)size
                     direction:(LCGradientColorsDirection)direction;

//计算文字size
+ (CGSize)sizeWithText:(NSString *)text
        maxContentSize:(CGSize)maxContentSize
                  font:(UIFont *)fontSize
               context:(NSStringDrawingContext *)context;
+ (CGSize)sizeWithText:(NSString *)text
        maxContentSize:(CGSize)maxContentSize
                  font:(UIFont *)font
               context:(NSStringDrawingContext *)context
          lineSpaceing:(CGFloat)lineSpaceing;

@end

NS_ASSUME_NONNULL_END
