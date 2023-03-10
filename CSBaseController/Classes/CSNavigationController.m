//
//  IMNavigationController.m
//  imbangbang
//
//  Created by 赵露 on 14-10-25.
//  Copyright (c) 2014年 com.58. All rights reserved.
//

#import "CSNavigationController.h"
#import "CSBaseViewController.h"
#import "JZNavigationExtension.h"

@interface CSNavigationController ()

@property (nonatomic, assign) BOOL isPushing;

@end

@implementation CSNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        self.systemInteractivePopGestureRecognizerDelegate = self.interactivePopGestureRecognizer.delegate;
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

- (BOOL)prefersStatusBarHidden {
    return self.visibleViewController.prefersStatusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.visibleViewController.preferredStatusBarStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return self.visibleViewController.preferredStatusBarUpdateAnimation;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return self.visibleViewController.supportedInterfaceOrientations;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (animated)  {
        if (!self.isPushing || ![self.viewControllers.lastObject isKindOfClass:[viewController class]]) {
            self.isPushing = YES;
            [super pushViewController:viewController animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.isPushing = NO;
            });
        }
    }
    else {
        self.isPushing = NO;
        [super pushViewController:viewController animated:NO];
    }
}



@end

