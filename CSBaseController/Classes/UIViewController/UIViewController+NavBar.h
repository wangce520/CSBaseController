//
//  UIViewController+NavBarOldAPI.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/28.
//  Copyright © 2017年 转转. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol UIViewControllerNavBarExtensionProtocol <NSObject>

@optional;

/**
 * controller的back回退键处理
 */
- (void)backAction:(id)sender;

/**
 * controller的back关闭键处理
 */
- (void)closeAction:(id)sender;

@end

@interface UIViewController (NavBar) <UIViewControllerNavBarExtensionProtocol>

/// 隐藏navBar（默认为NO）
@property (nonatomic, assign) BOOL needHideNavigationBar;

// 返回按钮的事件
- (void)doBackOrCloseAction;

#pragma mark - # 返回按钮

- (UIBarButtonItem *)addBackBarButton;

// MARK: 隐藏/重置
- (void)resetRightButton;

#pragma mark - # 新右侧按钮

/// 添加文本按钮
- (UIBarButtonItem *)addRightBarButtonWithTitle:(NSString *)title clickAction:(void (^)(UIBarButtonItem *buttonItem))clickAction;

/// 添加文本按钮
- (UIBarButtonItem *)addRightBarButtonWithTitle:(NSString *)title textColor:(UIColor *)textColor clickAction:(void (^)(UIBarButtonItem *buttonItem))clickAction;

/// 添加图片按钮
- (UIBarButtonItem *)addRightBarButtonWithImage:(UIImage *)image clickAction:(void (^)(UIBarButtonItem *buttonItem))clickAction;

@end
