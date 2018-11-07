//
//  HYPopoverVC.m
//  HYCalendar
//
//  Created by 徐浩宇 on 2018/11/6.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import "HYPopoverVC.h"
#import "UIColor+HYCategory.h"

@interface HYPopoverVC ()

@end

@implementation HYPopoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 180, 100)];
    tempLabel.text = @"在此界面定制需要显示的页面";
    tempLabel.numberOfLines = 0;
    [self.view addSubview:tempLabel];
    self.view.backgroundColor = [UIColor hy_colorWithHexString:@"f5ebff"];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
