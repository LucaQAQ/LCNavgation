//
//  CEEViewController.m
//  LCNavgation
//
//  Created by Luca on 2019/3/26.
//  Copyright © 2019 Luca. All rights reserved.
//

#import "CEEViewController.h"
#import "LCNavgation/UIViewController+LCNavgation.h"

@interface CEEViewController ()<UIGestureRecognizerDelegate,LCNavgationViewDelegate>
/** 左滑手势 */
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer;
@end

@implementation CEEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navTitle = @"CEE";
    [self setNavBgColors:@[[UIColor redColor],[UIColor greenColor]]];
}

@end
