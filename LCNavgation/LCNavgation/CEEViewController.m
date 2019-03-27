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
    [self setTitle:@"MM"];
    [self setNavBgColors:@[[UIColor whiteColor]]];
    
    //原生方法无效
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
//    self.edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(openMenuClick)];
    self.edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] init];
     SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    [self.edgePanGestureRecognizer addTarget:self.navigationController.self.interactivePopGestureRecognizer.delegate action:action];
    self.edgePanGestureRecognizer.delegate = self;
    self.edgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:self.edgePanGestureRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

//-(void)openMenuClick{
//    //进行相应操作
//    [self.navigationController popViewControllerAnimated:YES];
//}

@end
