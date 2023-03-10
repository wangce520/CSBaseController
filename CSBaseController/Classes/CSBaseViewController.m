//
//  ZZBaseViewController
//  imbangbang
//
//  Created by chixk on 14/8/21.
//  Copyright (c) 2014年 chixk. All rights reserved.
//

#import "CSBaseViewController.h"
#import "CSNavigationController.h"
#import "UIViewController+NavBar.h"
#import "JZNavigationExtension.h"

#define NAVIGATION_BAR_BGCOLOR    [UIColor whiteColor]
#define NAVIGATION_BAR_TITLECOLOR [UIColor blackColor]

@interface CSBaseViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) id gestureDelegate;

@end

@implementation CSBaseViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.needHideNavigationBar = NO;
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakself = self;
    [self.navigationController jz_setInteractivePopGestureRecognizerCompletion:^(UINavigationController *navigationController, BOOL finished) {
        if (finished) {
            [weakself viewControllerWillPop];
            [weakself gestureDidPop];
        }
    }];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 设置导航栏
    [self setNavigationBarBackgroundColor:UIColor.whiteColor titleColor:UIColor.blackColor];
    [self addBackBarButton];
}

/// 设置导航栏的颜色
- (void)setNavigationBarBackgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor{
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance * appearance = [[UINavigationBarAppearance alloc] init];
        // 背景色
        appearance.backgroundColor = backgroundColor;
        // 去除导航栏阴影（如果不设置clear，导航栏底下会有一条阴影线）
        appearance.shadowColor = [UIColor clearColor];
        // 去掉半透明效果
        appearance.backgroundEffect = nil;
        appearance.titleTextAttributes = @{
            NSFontAttributeName: [UIFont systemFontOfSize:18],
            NSForegroundColorAttributeName: titleColor};
        // 带scroll滑动的页面
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        // 常规页面
        self.navigationController.navigationBar.standardAppearance = appearance;
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[self imageFromColor:backgroundColor] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self.navigationController.navigationBar setTitleTextAttributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:18],
            NSForegroundColorAttributeName: titleColor }];
        [self.navigationController.navigationBar setTintColor:titleColor];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.navigationController.childViewControllers containsObject:self]) {
        if (self.disablePopGesture) {
            if ([self.navigationController respondsToSelector:@selector(systemInteractivePopGestureRecognizerDelegate)]) {
                self.navigationController.interactivePopGestureRecognizer.delegate = self;
            } else {
                NSLog(@"不能禁用成右滑手势");
            }
        } else {
            if ([self.navigationController respondsToSelector:@selector(systemInteractivePopGestureRecognizerDelegate)]) {
                id delegate = [self.navigationController valueForKey:@"systemInteractivePopGestureRecognizerDelegate"];
                if (delegate) {
                    self.gestureDelegate = self.navigationController.interactivePopGestureRecognizer.delegate = delegate;
                }
            }
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)setDisablePopGesture:(BOOL)disablePopGesture {
    _disablePopGesture = disablePopGesture;
    if ([self.navigationController.childViewControllers containsObject:self]) {
        if (disablePopGesture) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        } else if (self.gestureDelegate) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self.gestureDelegate;
        }
    }
}

- (void)backAction:(id)sender {
    [self viewControllerWillPop];
    [self doBackOrCloseAction];
}

- (void)gestureDidPop {
    
}

- (void)viewControllerWillPop {

}

- (void)dealloc {
    if ([self isViewLoaded]) {
        [self findScrollView:self.view];
    }
}

- (BOOL)findScrollView:(UIView *)parentView {
    NSArray *childrenViews = parentView.subviews;

    if (childrenViews == nil || childrenViews.count == 0) {
        return NO;
    }

    for (int i = 0; i < childrenViews.count; i++) {
        UIView *childView = [childrenViews objectAtIndex:i];
        if ([childView isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)childView).delegate = nil;
        }
        if ([childView isKindOfClass:[UITableView class]]) {
            ((UITableView *)childView).dataSource = nil;
        }
        if ([childView isKindOfClass:[UICollectionView class]]) {
            ((UICollectionView *)childView).dataSource = nil;
        }
        [self findScrollView:childView];
    }
    return NO;
}

#pragma mark - # Delegate

//MARK: UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return NO;
}

/// iOS 13 之后, 禁用键盘三指手势, 避免限制输入框长度后,触发三指手势撤销崩溃 
- (UIEditingInteractionConfiguration)editingInteractionConfiguration {
    return UIEditingInteractionConfigurationNone;
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
