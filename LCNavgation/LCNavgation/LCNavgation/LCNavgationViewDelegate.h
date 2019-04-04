//
//  LCNavgationViewDelegate.h
//  LCNavgation
//
//  Created by Luca on 2019/3/25.
//  Copyright © 2019 Luca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LCNavgationViewDelegate <NSObject>
@optional;
//nav返回
- (void)nav_leftActionWithLeftItem:(UIButton *)leftItem;
//右按钮点击
- (void)nav_rightActionWithRightItem:(UIButton *)rightItem;

@end

NS_ASSUME_NONNULL_END
