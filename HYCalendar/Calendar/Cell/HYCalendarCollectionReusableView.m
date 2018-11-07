//
//  HYCalendarCollectionReusableView.m
//  HYCalendar
//
//  Created by 徐浩宇 on 2018/11/5.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import "HYCalendarCollectionReusableView.h"
#import "HYCalendarHeader.h"
#import "UIColor+HYCategory.h"

@implementation HYCalendarCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createReusableView];
    }
    return self;
}

- (void)createReusableView
{
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:headerView];

    _headerLabel = [[UILabel alloc]init];
    _headerLabel.frame = CGRectMake(40, 0, self.frame.size.width - 80, self.frame.size.height);
    _headerLabel.textAlignment = NSTextAlignmentLeft;
    _headerLabel.font = [UIFont systemFontOfSize:28 weight:UIFontWeightRegular];
    _headerLabel.backgroundColor = [UIColor whiteColor];
    _headerLabel.textColor = [UIColor hy_colorWithHexString:@"333333"];
    [headerView addSubview:_headerLabel];
    
    
    UIView *topLineView = [[UIView alloc]init];
    topLineView.frame = CGRectMake(0, 0, headerView.frame.size.width, 1);
    topLineView.backgroundColor = [UIColor hy_colorWithHexString:@"f1f2f3"];
    [headerView addSubview:topLineView];
    
    UIView *bottomLineView = [[UIView alloc]init];
    bottomLineView.frame = CGRectMake(0, headerView.frame.size.height - 1, headerView.frame.size.width, 1);
    bottomLineView.backgroundColor = [UIColor hy_colorWithHexString:@"f1f2f3"];
    [headerView addSubview:bottomLineView];
}

@end
