//
//  ZZBaseViewController
//  imbangbang
//
//  Created by chixk on 14/8/21.
//  Copyright (c) 2014年 chixk. All rights reserved.
//


/*
 * 所有controller的基类，实现功用的资源管理
 */

#import <UIKit/UIKit.h>

@protocol CSBaseViewControllerProtocol <NSObject>

@optional
/**
 *  controller通过手势完成返回，子类可重载
 */
- (void)gestureDidPop;

/**
 *  controller Pop时调用
 */
- (void)viewControllerWillPop;

@end


@interface CSBaseViewController : UIViewController <CSBaseViewControllerProtocol>

/// 禁用手势返回（默认为NO）
@property (nonatomic, assign) BOOL disablePopGesture;

@end
