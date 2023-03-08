//
//  _JZValue.h
//  navbarTest
//
//  Created by 李伯坤 on 2017/11/23.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface _JZValue : NSObject

@property (weak, readonly) id weakObjectValue;

+ (instancetype)valueWithWeakObject:(id)anObject;

- (instancetype)initWithWeakObject:(id)anObject;

@end
