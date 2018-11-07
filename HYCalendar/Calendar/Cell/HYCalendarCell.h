//
//  HYCalendarCell.h
//  HYCalendar
//
//  Created by 徐浩宇 on 2018/11/5.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HYCalendarModel;
@interface HYCalendarCell : UICollectionViewCell
/** 公历日期 */
@property (weak, nonatomic)  UILabel *dayLabel;
/** 农历日期 */
@property (weak, nonatomic)  UILabel *chinesDayLabel;
/** 日历模型 */
@property (strong, nonatomic) HYCalendarModel *model;

@end

NS_ASSUME_NONNULL_END
