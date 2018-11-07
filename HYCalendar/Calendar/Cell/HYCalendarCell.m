//
//  HYCalendarCell.m
//  HYCalendar
//
//  Created by 徐浩宇 on 2018/11/5.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import "HYCalendarCell.h"
#import "HYTagListView.h"
#import "UIView+HYCategory.h"
#import "UIColor+HYCategory.h"
#import "HYCalendarHeaderModel.h"


@interface HYCalendarCell ()

/** 标签视图 */
@property (weak, nonatomic) HYTagListView *tagView;

@property (weak, nonatomic) UIView *redLine;
@property (weak, nonatomic) UIView *downLine;
@property (weak, nonatomic) UIView *rightLine;

@end
@implementation HYCalendarCell
#pragma mark - ⬅️⬅️⬅️⬅️ Getter & Setter ➡️➡️➡️➡️
#pragma mark -
- (UIView *)redLine {
    if (!_redLine) {
        UIView *tempView = [[UIView alloc]init];
        tempView.backgroundColor = [UIColor redColor];
        [self addSubview:tempView];
        _redLine = tempView;
    }
    return _redLine;
}

- (UIView *)downLine {
    if (!_downLine) {
        UIView *tempView = [[UIView alloc]init];
        tempView.backgroundColor = [UIColor hy_colorWithHexString:@"f1f2f3"];
        [self addSubview:tempView];
        _downLine = tempView;
    }
    return _downLine;
}

- (UIView *)rightLine {
    if (!_rightLine) {
        UIView *tempView = [[UIView alloc]init];
        tempView.backgroundColor = [UIColor hy_colorWithHexString:@"f1f2f3"];
        [self addSubview:tempView];
        _rightLine = tempView;
    }
    return _rightLine;
}

- (UILabel *)dayLabel {
    if (!_dayLabel) {
        UILabel *tempView = [[UILabel alloc]init];
        tempView.textColor = [UIColor hy_colorWithHexString:@"333333"];
        tempView.font = [UIFont systemFontOfSize:18];
        tempView.textAlignment = NSTextAlignmentRight;
        [self addSubview:tempView];
        _dayLabel = tempView;
    }
    return _dayLabel;
}

- (UILabel *)chinesDayLabel {
    if (!_chinesDayLabel) {
        UILabel *tempView = [[UILabel alloc]init];
        tempView.textColor = [UIColor hy_colorWithHexString:@"999999"];
        tempView.font = [UIFont systemFontOfSize:13];
        [self addSubview:tempView];
        _chinesDayLabel = tempView;
    }
    return _chinesDayLabel;
}

- (HYTagListView *)tagView {
    if (!_tagView) {
        HYTagListView *tempView = [[HYTagListView alloc]init];
        [self addSubview: tempView];
        _tagView = tempView;
    }
    return _tagView;
}

- (void)setModel:(HYCalendarModel *)model {
    _model = model;
    if (model.day>0) {
        self.dayLabel.text = [NSString stringWithFormat:@"%ld",(long)model.day];
        self.chinesDayLabel.text = model.chineseCalendar;
        
        if (model.isWholeMonth) {
            self.chinesDayLabel.textColor = [UIColor redColor];
        }else {
            self.chinesDayLabel.textColor = [UIColor darkGrayColor];
        }
        
    }else {
        self.dayLabel.text = @"";
        self.chinesDayLabel.text = @"";
    }
    
    if (model.isWholeMonth) {
        self.redLine.hidden = NO;
    }else {
        self.redLine.hidden = YES;
    }
    
    if (model.tempArray.count) {
        self.tagView.hidden = NO;
        NSDictionary *tempDic = model.tempArray[0];
        if (tempDic) {
            self.tagView.dataArray = tempDic[@"data"];
        }else {
            self.tagView.dataArray = @[];
        }
    }else {
        self.tagView.hidden = YES;
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat tempLabelY = 5;
        CGFloat tempLabelW = 50;
        CGFloat tempLabelH = 25;
        CGFloat tempLabelM = 10;//距左或距右 的间距
        self.chinesDayLabel.frame = CGRectMake(tempLabelM, tempLabelY, tempLabelW, tempLabelH);
        self.redLine.frame = CGRectMake(tempLabelM, tempLabelY+tempLabelH-2, 25, 1.5);
        self.dayLabel.frame = CGRectMake(self.width_hy-tempLabelW-tempLabelM, tempLabelY, tempLabelW, tempLabelH);
        self.tagView.frame = CGRectMake(5, tempLabelY+tempLabelH, self.width_hy-10, self.height_hy - (tempLabelY+tempLabelH));
        
        self.downLine.frame = CGRectMake(0, self.height_hy-1, self.width_hy, 1);
        self.rightLine.frame = CGRectMake(self.width_hy-1, 1, 1,self.height_hy-2);
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
//    CGFloat tempY =  self.chinesDayLabel.maxY_hy;
//    self.tagView.frame = CGRectMake(5, tempY, self.width_hy-10, self.height_hy - tempY);
//    NSLog(@"111111 --->  %@",NSStringFromCGRect(self.tagView.frame));
    // Initialization code
}



@end
