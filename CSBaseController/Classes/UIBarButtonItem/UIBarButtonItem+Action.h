//
//  UIBarButtonItem+Action.h
//  TLKit
//
//  Created by 李伯坤 on 2017/8/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIBarButonActionBlock)(void);

@interface UIBarButtonItem (Action)

- (id)initWithTitle:(NSString *)title actionBlick:( UIBarButonActionBlock)actionBlock;

- (id)initWithImage:(UIImage *)image actionBlick:( UIBarButonActionBlock)actionBlock;

@end
