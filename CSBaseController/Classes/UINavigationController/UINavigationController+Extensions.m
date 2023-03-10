//
//  UINavigationController+Extensions.m
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/28.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "UINavigationController+Extensions.h"

@implementation UINavigationController (Extensions)

- (id)findViewController:(NSString*)className
{
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            return viewController;
        }
    }
    
    return nil;
}

#pragma mark - # Push Pop
- (NSArray *)popToViewControllerWithClassName:(NSString*)className animated:(BOOL)animated;
{
    return [self popToViewController:[self findViewController:className] animated:YES];
}

- (NSArray *)popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated
{
    NSInteger viewControllersCount = self.viewControllers.count;
    if (viewControllersCount > level) {
        NSInteger idx = viewControllersCount - level - 1;
        UIViewController *viewController = self.viewControllers[idx];
        return [self popToViewController:viewController animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}

- (void)pushViewControllerAndSuicide:(UIViewController *)viewController animated:(BOOL)animated
{
    [self popViewControllerAnimated:NO];
    [self pushViewController:viewController animated:animated];
}


@end
