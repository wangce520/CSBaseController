//
//  UINavigationController+Extensions.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/28.
//  Copyright © 2017年 转转. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Extensions)

/**
 *  从nav堆栈里找指定class的VC
 */
- (id)findViewController:(NSString*)className;

/**
 *  pop到指定的viewcontroler
 *
 *  @param className 指定viewcontroler类名
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)popToViewControllerWithClassName:(NSString*)className animated:(BOOL)animated;

/**
 *  pop n层
 *
 *  @param level  n层
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;


/**
 *  自杀式push
 *
 *  从A push到B后，销毁A
 */
- (void)pushViewControllerAndSuicide:(UIViewController *)viewController animated:(BOOL)animated;


@end
