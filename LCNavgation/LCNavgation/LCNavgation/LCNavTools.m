//
//  LCNavTools.m
//  LCNavgation
//
//  Created by Luca on 2019/3/21.
//  Copyright © 2019 Luca. All rights reserved.
//

#import "LCNavTools.h"

@implementation LCNavTools

+ (UIColor *)getGradientColors:(NSArray *)colors
                          size:(CGSize)size
                     direction:(LCGradientColorsDirection)direction{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    NSMutableArray *gradientColors = [NSMutableArray array];
    for (UIColor *colorItem in colors) {
        [gradientColors addObject:(id)colorItem.CGColor];
    }
    gradientLayer.colors = [NSArray arrayWithArray:gradientColors];
    
    if (direction == LCGradientColorsDirectionLeft) {
        
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
    }else if (direction == LCGradientColorsDirectionRight){
        
        gradientLayer.startPoint = CGPointMake(1.0, 0);
        gradientLayer.endPoint = CGPointMake(0, 0);
    }else if (direction == LCGradientColorsDirectionTop){
        
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
    }else if (direction == LCGradientColorsDirectionBottom){
        
        gradientLayer.startPoint = CGPointMake(0, 1);
        gradientLayer.endPoint = CGPointMake(0, 0);
    }
    
    UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, gradientLayer.opaque, 0);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *gradientImage = outputImage;
    return [UIColor colorWithPatternImage:gradientImage];
}
+ (CGSize)sizeWithText:(NSString *)text maxContentSize:(CGSize)maxContentSize font:(UIFont *)font context:(NSStringDrawingContext *)context {
    return [self sizeWithText:text maxContentSize:maxContentSize font:font context:context lineSpaceing:0];
}

+ (CGSize)sizeWithText:(NSString *)text maxContentSize:(CGSize)maxContentSize font:(UIFont *)font context:(NSStringDrawingContext *)context lineSpaceing:(CGFloat)lineSpaceing {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //设置行间距
    [paragraphStyle setLineSpacing:lineSpaceing];
    [paragraphStyle setLineHeightMultiple:1.0];
    //设置字体
    NSDictionary *attriDic = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
    //根据字体的行间距和字体大小获取高度
    CGRect boundingRect = [text boundingRectWithSize:maxContentSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attriDic context:context];
    CGSize size = CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
    return size;
}

@end
