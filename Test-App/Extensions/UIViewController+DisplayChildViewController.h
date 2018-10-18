//
//  UIViewController+DisplayChildViewController.h
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DisplayChildViewController)

- (void)displayContentController: (UIViewController *)content;
- (void)displayContentController: (UIViewController *)content withFrame: (CGRect)frame;
- (void)displayContentController: (UIViewController *)content withFrame: (CGRect)frame onView: (UIView *)view;
- (void)hideContentController: (UIViewController *)content;

@end
