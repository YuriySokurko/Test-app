//
//  UIViewController+DisplayChildViewController.m
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

#import "UIViewController+DisplayChildViewController.h"

@implementation UIViewController (DisplayChildViewController)

- (void)displayContentController:(UIViewController *)content {
    [self displayContentController: content withFrame: self.view.frame onView: self.view];
}

- (void)displayContentController:(UIViewController *)content withFrame:(CGRect)frame {
    [self displayContentController: content withFrame: frame onView: self.view];
}

- (void)displayContentController:(UIViewController *)content withFrame:(CGRect)frame onView: (UIView *)view {
    if (content != nil) {
        [self addChildViewController:content];
        content.view.frame = frame;
        [view addSubview:content.view];
        [content didMoveToParentViewController:self];
    }
}

- (void)hideContentController:(UIViewController *)content {
    [content willMoveToParentViewController:nil];
    [content.view removeFromSuperview];
    [content removeFromParentViewController];
}

@end
