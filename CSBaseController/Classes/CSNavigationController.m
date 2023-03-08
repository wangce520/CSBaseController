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
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance * appearance = [[UINavigationBarAppearance alloc] init];
        // 背景色
        appearance.backgroundColor = UIColor.whiteColor;
        // 去除导航栏阴影（如果不设置clear，导航栏底下会有一条阴影线）
        appearance.shadowColor = [UIColor clearColor];
        // 去掉半透明效果
        appearance.backgroundEffect = nil;
        appearance.titleTextAttributes = @{
            NSFontAttributeName: [UIFont systemFontOfSize:18],
            NSForegroundColorAttributeName: UIColor.whiteColor};
        // 带scroll滑动的页面
        self.navigationBar.scrollEdgeAppearance = appearance;
        // 常规页面
        self.navigationBar.standardAppearance = appearance;
    }else{
        [self.navigationBar setBackgroundImage:[self imageFromColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:[UIImage new]];
        [self.navigationBar setTitleTextAttributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:18],
            NSForegroundColorAttributeName: UIColor.whiteColor }];
        [self.navigationBar setTintColor:UIColor.blueColor];
    }
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

- (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end

