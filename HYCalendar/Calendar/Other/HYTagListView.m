//
//  HYTagListView.m
//  HYTestProject
//
//  Created by 徐浩宇 on 2018/11/6.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import "HYTagListView.h"
#import "UIView+HYCategory.h"
#import "UIColor+HYCategory.h"

@interface HYTagListView ()
@end
@implementation HYTagListView

//- (instancetype)initWithDataArray:(NSArray *)dataArray {
//    self = [super init];
//    if (self) {
//        _dataArray = [dataArray copy];
//    }
//    return self;
//}
//
//- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray {
//    self = [super initWithFrame:frame];
//    if (self) {
//
//        _dataArray = [dataArray copy];
//        if (frame.size.height) {
//            [self setupSubViews];
//        }
//
//    }
//    return self;
//}
//
//- (void)setFrame:(CGRect)frame {
//    [super setFrame:frame];
//
//}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    if (dataArray.count) {
        for (UILabel *tempLabel in self.subviews) {
            [tempLabel removeFromSuperview];
        }
        [self setupSubViews];
    }
}

- (void)setupSubViews {
    
    if (!self.frame.size.height) return;
    
    CGFloat tempH = 18;
    CGFloat tempMargin = 3;
    for (int i = 0; i < _dataArray.count; i++) {
        CGFloat tempY =  i*(tempH + tempMargin);
        UILabel *tempView = [[UILabel alloc]initWithFrame:CGRectMake(0, tempY, self.width_hy, tempH)];
        tempView.font = [UIFont systemFontOfSize:12];

        
        [self addSubview:tempView];
        if (i > 3 ) {
            NSInteger sss = _dataArray.count - i;
            tempView.text = [NSString stringWithFormat:@"  还有 %ld 户在装修...",(long)sss];
            tempView.textColor = [UIColor darkGrayColor];
            tempView.backgroundColor = [UIColor clearColor];
            break;
        }else {
            tempView.text = [NSString stringWithFormat:@"  %@",_dataArray[i]];
            tempView.textColor = [UIColor hy_colorWithHexString:@"000000"];
            tempView.backgroundColor = [UIColor hy_colorWithHexString:@"c5ebff"];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
