//
//  LCViewControllerInterceptor.m
//  LCNavgation
//
//  Created by Luca on 2019/3/25.
//  Copyright © 2019 Luca. All rights reserved.
//

#import "LCViewControllerInterceptor.h"
#import <Aspects.h>
#import "UIViewController+LCNavgation.h"
#import <RSSwizzle.h>

@implementation LCViewControllerInterceptor
+(void)load{
    
    [super load];
    
    [LCViewControllerInterceptor sharedInstance];
}
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static LCViewControllerInterceptor *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LCViewControllerInterceptor alloc] init];
    });
    return sharedInstance;
}
- (instancetype)init{
    if (self = [super init]) {

        [RSSwizzle swizzleInstanceMethod:@selector(viewDidLoad) inClass:[UIViewController class] newImpFactory:^id(RSSwizzleInfo *swizzleInfo) {
            return ^(__unsafe_unretained id self){

                [[LCViewControllerInterceptor sharedInstance] ots_viewDidLoad:self];
            };
        } mode:RSSwizzleModeAlways key:@"viewDidLoad"];

        [RSSwizzle swizzleInstanceMethod:@selector(viewWillAppear:) inClass:[UIViewController class] newImpFactory:^id(RSSwizzleInfo *swizzleInfo) {
            return ^(__unsafe_unretained id self,BOOL animated){
                
                [[LCViewControllerInterceptor sharedInstance] ots_viewWillAppear:animated controller:self];
            };
        } mode:RSSwizzleModeAlways key:@"viewWillAppear"];
    }
    return self;
}
#pragma mark - Hook Methods
- (void)ots_viewDidLoad:(UIViewController<LCNavgationViewDelegate> *)controller{
    BOOL hasNav = [controller conformsToProtocol:@protocol(LCNavgationViewDelegate)];
    if (hasNav) {
        //导航栏切片
        [controller initNavgationInViewDidLoad];
    }
}
- (void)ots_viewWillAppear:(BOOL)animated
                controller:(UIViewController *)controller{
    BOOL hasNav = [controller conformsToProtocol:@protocol(LCNavgationViewDelegate)];
    
    if (hasNav) {
        [controller setNavgationInViewWillAppear];
    }
}


@end
