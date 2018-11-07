//
//  UIViewController+MEEViewControllerCategiry.m
//  MEEEJ
//
//  Created by 徐浩宇 on 2017/9/25.
//  Copyright © 2017年 XuHaoyu. All rights reserved.
//

#import "UIViewController+MEEViewControllerCategiry.h"

@implementation UIViewController (MEEViewControllerCategiry)

- (void)showPopoverWithViewController:(UIViewController *)viewController senderView:(UIView *)senderView delegate:(id <UIPopoverPresentationControllerDelegate>)delegate preferredContentSize:(CGSize)preferredContentSize {
    //  初始化弹出控制器
//    MEESelectDecorateAddPopVC *viewController = [[MEESelectDecorateAddPopVC alloc]init];
    //  背景色
    viewController.view.backgroundColor   = [UIColor whiteColor];
    //  弹出视图的显示样式
    viewController.modalPresentationStyle = UIModalPresentationPopover;
    //  1、弹出视图的大小
    viewController.preferredContentSize   = (preferredContentSize.width>0)?preferredContentSize:CGSizeMake(300, 300);
    //  弹出视图的代理
    viewController.popoverPresentationController.delegate   = delegate;
    //  弹出视图的参照视图、从哪弹出
    viewController.popoverPresentationController.sourceView = senderView;
    //  弹出视图的尖头位置：参照视图底边中间位置
    viewController.popoverPresentationController.sourceRect = senderView.bounds;
    //  弹出视图的箭头方向
    viewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
//    viewController.dataArray     = self.houseListArray;
//    viewController.delegate      = self;
//    viewController.currentModel  = self.currentHouseModel;
    //  弹出
    [self presentViewController:viewController animated:YES completion:nil];
}
@end
