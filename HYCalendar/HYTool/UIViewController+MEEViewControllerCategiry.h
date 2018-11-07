//
//  UIViewController+MEEViewControllerCategiry.m
//  MEEEJ
//
//  Created by 徐浩宇 on 2017/9/25.
//  Copyright © 2017年 XuHaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MEEViewControllerCategiry)

///** 导航栏跳转 */
//- (void)pushNextVC:(UIViewController *)nextVC;
//- (void)popVC;
//
///** 没有导航栏跳转 */
//- (void)presentVC:(UIViewController *)nextVC animated:(BOOL)flag;
//- (void)dismissVCWithAnimate:(BOOL)flag;

/** 显示悬浮框 Ipad 使用 */
- (void)showPopoverWithViewController:(UIViewController *)viewController senderView:(UIView *)senderView delegate:(id <UIPopoverPresentationControllerDelegate>)delegate preferredContentSize:(CGSize)preferredContentSize;

@end
