//
//  UIBarButtonItem+Action.m
//  TLKit
//
//  Created by 李伯坤 on 2017/8/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "UIBarButtonItem+Action.h"
#import <objc/runtime.h>

char * const UIBarButtonItemActionBlock = "UIBarButtonItemActionBlock";

@implementation UIBarButtonItem (Action)

- (id)initWithTitle:(NSString *)title actionBlick:( UIBarButonActionBlock)actionBlock
{
    if (self = [self initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil]) {
        [self setActionBlock:actionBlock];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image actionBlick:( UIBarButonActionBlock)actionBlock
{
    if (self = [self initWithImage:image style:UIBarButtonItemStylePlain target:nil action:nil]) {
        [self setActionBlock:actionBlock];
    }
    return self;
}

- (void)performActionBlock {
    dispatch_block_t block = self.actionBlock;
    
    if (block) {
        block();
    }
}

- (UIBarButonActionBlock)actionBlock {
    return objc_getAssociatedObject(self, UIBarButtonItemActionBlock);
}

- (void)setActionBlock:(UIBarButonActionBlock)actionBlock {
    if (actionBlock != self.actionBlock) {
        [self willChangeValueForKey:@"actionBlock"];
        objc_setAssociatedObject(self, UIBarButtonItemActionBlock, actionBlock, OBJC_ASSOCIATION_COPY);
        [self setTarget:self];
        [self setAction:@selector(performActionBlock)];
        
        [self didChangeValueForKey:@"actionBlock"];
    }
}
@end
