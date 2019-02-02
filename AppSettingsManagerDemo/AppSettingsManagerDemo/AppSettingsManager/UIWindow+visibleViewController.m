//
//  UIWindow+visibleViewController.m
//  JLUIKit
//
//  Created by laizhijian on 2018/11/23.
//  Copyright © 2018 janlionly. All rights reserved.
//

#import "UIWindow+visibleViewController.h"

@implementation UIWindow (visibleViewController)

+ (UIViewController *)visibleViewControllerFromController:(UIViewController *)ctrl {
    if ([ctrl isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nc = (UINavigationController *)ctrl;
        return [UIWindow visibleViewControllerFromController:nc.visibleViewController];
    } else if ([ctrl isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tc = (UITabBarController *)ctrl;
        return [UIWindow visibleViewControllerFromController:tc.selectedViewController];
    } else {
        UIViewController *pc = ctrl.presentedViewController;
        if (pc) {
            return [UIWindow visibleViewControllerFromController:pc];
        } else {
            return ctrl;
        }
    }
}

- (UIViewController *)visibleViewController {
    return [UIWindow visibleViewControllerFromController:self.rootViewController];
}

@end
