//
//  ViewController.m
//  LCNavgation
//
//  Created by Luca on 2019/3/20.
//  Copyright © 2019 Luca. All rights reserved.
//

#import "ViewController.h"
#import "LCNavgationView.h"
#import "UIViewController+LCNavgation.h"
#import "CEEViewController.h"

@interface ViewController ()<LCNavgationViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavTitle:@"首页"];
    [self hideNavLeftItem];
    [self setNavRightItemText:@"确定" state:UIControlStateNormal];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 40)];
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
}

- (void)clickAction{
    
    CEEViewController *ccvc = [[CEEViewController alloc]init];
    [self.navigationController pushViewController:ccvc animated:YES];
}

@end
