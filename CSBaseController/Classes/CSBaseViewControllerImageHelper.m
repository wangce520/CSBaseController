//
//  CSHUDImageHelper.m
//  CSHUD
//
//  Created by ce.wang on 2023/3/9.
//

#import "CSBaseViewControllerImageHelper.h"

@implementation CSBaseViewControllerImageHelper

+ (NSBundle *)bundleName:(NSString *)bundleName {
    NSURL *associateBundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
    associateBundleURL = [associateBundleURL URLByAppendingPathComponent:bundleName];
    associateBundleURL = [associateBundleURL URLByAppendingPathExtension:@"framework"];
    NSBundle *associateBunle = associateBundleURL?[NSBundle bundleWithURL:associateBundleURL]:[NSBundle mainBundle];
    associateBundleURL = [associateBunle URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *bundle = associateBundleURL?[NSBundle bundleWithURL:associateBundleURL]:[NSBundle mainBundle];
    return bundle;
}

+ (UIImage *)imgWithName:(NSString *)name{
    NSBundle *resource_bundle = [self bundleName:@"CSBaseViewController"];
    UIImage *image = [UIImage imageNamed:name
                                    inBundle:resource_bundle
               compatibleWithTraitCollection:nil];
    return image;
}

@end
