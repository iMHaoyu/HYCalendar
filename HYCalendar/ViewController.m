//
//  ViewController.m
//  HYCalendar
//
//  Created by 徐浩宇 on 2018/11/5.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import "ViewController.h"
#import "HYCalendarView.h"
#import "UIViewController+MEEViewControllerCategiry.h"
#import "HYPopoverVC.h"

@interface ViewController ()<HYCalendarViewDelegate,UIPopoverPresentationControllerDelegate>

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    HYCalendarView *tempV = [[HYCalendarView alloc]initWithFrame:self.view.bounds];
    tempV.delegate = self;
    [self.view addSubview:tempV];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)calendarItemDidSelectedWithCalendarModel:(HYCalendarModel *)model withCalendarCell:(nonnull HYCalendarCell *)calendarCell {
    
    HYPopoverVC *tempVC = [[HYPopoverVC alloc]init];
    [self showPopoverWithViewController:tempVC senderView:(UIView *)calendarCell delegate:self preferredContentSize:CGSizeMake(200, 200)];
}

@end
