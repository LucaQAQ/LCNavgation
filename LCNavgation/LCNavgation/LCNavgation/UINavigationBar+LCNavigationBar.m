//
//  UINavigationBar+LCNavigationBar.m
//  AFNetworking
//
//  Created by Luca on 2019/3/28.
//

#import "UINavigationBar+LCNavigationBar.h"

@implementation UINavigationBar (LCNavigationBar)

//系统导航栏不接受event
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    return nil;
}

@end
