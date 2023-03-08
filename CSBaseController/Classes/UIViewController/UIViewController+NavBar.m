//
//  UIViewController+NavBarOldAPI.m
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/28.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "UIViewController+NavBar.h"
#import "UIBarButtonItem+Action.h"
#import "JZNavigationExtension.h"

#define  NAVIGATION_BAR_BTNCOLOR [UIColor blackColor]

UIButton * __createNavBarButton(CGRect frame, NSString *title, NSString *imageName, NSString *imageHLName, id target, SEL action)
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];

    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"CSBaseKit" ofType:@"bundle"]];
    if (imageName) {
        UIImage *image = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
        if (!image) {
            image = [UIImage imageNamed:imageName];
        }
        [button setImage:image forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if (imageHLName) {
        UIImage *image = [UIImage imageNamed:imageHLName inBundle:bundle compatibleWithTraitCollection:nil];
        if (!image) {
            image = [UIImage imageNamed:imageHLName];
        }
        [button setImage:image forState:UIControlStateHighlighted];
    }
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    [button setContentMode:UIViewContentModeScaleAspectFill];

    return button;
}

@implementation UIViewController (NavBar)

#pragma mark - # Hidden/Show NavBar
- (void)setNeedHideNavigationBar:(BOOL)needHideNavigationBar
{
    self.jz_wantsNavigationBarVisible = !needHideNavigationBar;
}

- (BOOL)needHideNavigationBar
{
    return !self.jz_wantsNavigationBarVisible;
}

#pragma mark - # Bar Button
- (UIBarButtonItem *)addBackBarButton
{
    if (self != [self.navigationController.viewControllers objectAtIndex:0]) {
        UIButton *backButton = __createNavBarButton(CGRectMake(0, 0, 30, 30), nil, @"common_back_icon", @"common_back_icon", self, @selector(backAction:));
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = barButtonItem;
        return barButtonItem;
    }
    return nil;
}

- (void)doBackOrCloseAction {
    BOOL shouldDismiss = NO;
    if (self.presentingViewController != nil) {
        if (self.navigationController == nil) {
            shouldDismiss = YES;
        } else {
            if (self.navigationController.viewControllers.count == 1) {
                shouldDismiss = YES;
            }
        }
    }
    if (shouldDismiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//MARK: 隐藏/重置
- (void)hideNavigationRightBarItemWithTag:(NSInteger)tag {
    NSMutableArray *arr = [self.navigationItem.rightBarButtonItems mutableCopy];
    [arr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        UIBarButtonItem *item = (UIBarButtonItem *)obj;
        if (item.tag == tag) {
            [arr removeObject:item];
            *stop = YES;
        }
    }];

    self.navigationItem.rightBarButtonItems = arr;
}

- (void)resetRightButton {
    self.navigationItem.rightBarButtonItems = nil;
}


//MARK: Private
- (UIBarButtonItem *)navigationRightSpace
{
    UIBarButtonItem *navigationRightSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    return navigationRightSpace;
}

#pragma mark - # 新右侧按钮

//MAKR: 添加文本按钮
- (UIBarButtonItem *)addRightBarButtonWithTitle:(NSString *)title clickAction:(void (^)(UIBarButtonItem *))clickAction
{
    return [self addRightBarButtonWithTitle:title textColor:nil clickAction:clickAction];
}

- (UIBarButtonItem *)addRightBarButtonWithTitle:(NSString *)title textColor:(UIColor *)textColor clickAction:(void (^)(UIBarButtonItem *))clickAction
{
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:14],
                                  NSForegroundColorAttributeName: textColor ? textColor : [UIColor blackColor] };
    NSDictionary *disableAttributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:14],
                                         NSForegroundColorAttributeName: [UIColor lightGrayColor] };
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:title actionBlick:^{
        if (clickAction) {
            clickAction(nil);
        }
    }];
    [rightBtn setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [rightBtn setTitleTextAttributes:attributes forState:UIControlStateHighlighted];
    [rightBtn setTitleTextAttributes:disableAttributes forState:UIControlStateDisabled];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.navigationRightSpace, rightBtn, nil];
    return rightBtn;
}

- (UIBarButtonItem *)addRightBarButtonWithImage:(UIImage *)image clickAction:(void (^)(UIBarButtonItem *buttonItem))clickAction
{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] actionBlick:^{
        if (clickAction) {
            clickAction(nil);
        }
    }];
    self.navigationItem.rightBarButtonItems = @[rightBtn];
    return rightBtn;
}

@end
