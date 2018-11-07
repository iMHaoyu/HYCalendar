//
//  HYCalendarView.h
//  HYCalendar
//
//  Created by 徐浩宇 on 2018/11/6.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HYCalendarModel,HYCalendarCell;
@protocol HYCalendarViewDelegate <NSObject>
@optional
- (void)calendarItemDidSelectedWithCalendarModel:(HYCalendarModel *)model withCalendarCell:(HYCalendarCell *)calendarCell;

@end
@interface HYCalendarView : UIView

@property (nonatomic, weak) id<HYCalendarViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
