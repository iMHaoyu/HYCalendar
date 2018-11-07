//
//  HYCalendarManager.h
//  HYCalendar
//
//  Created by 徐浩宇 on 2018/11/5.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class HYCalendarModel;
@interface HYCalendarManager : NSObject

- (NSArray *)getCalendarDataSoruceWithLimitMonth:(NSInteger)limitMonth withArray:(NSArray *)tempArray;

@end



@interface HYChineseCalendarManager : NSObject

- (void)getChineseCalendarWithDate:(NSDate *)date calendarItem:(HYCalendarModel *)calendarItem;

@end

NS_ASSUME_NONNULL_END
