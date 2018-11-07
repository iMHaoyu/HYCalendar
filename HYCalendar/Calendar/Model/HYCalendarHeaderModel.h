//
//  HYCalendarHeaderModel.h
//  HYCalendar
//
//  Created by 徐浩宇 on 2018/11/5.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HYCalendarModel;
@interface HYCalendarHeaderModel : NSObject

@property (nonatomic,copy) NSString *headerText;
@property (nonatomic,copy) NSArray<HYCalendarModel *> *calendarItemArray;

@end



typedef NS_ENUM(NSInteger, HYCalendarType) {
    HYCalendarBeforeToday = -1L,//今天之前的
    HYCalendarToday      ,
    HYCalendarAfterToday ,      //今天之后的
    
};
@interface HYCalendarModel : NSObject

@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,assign) BOOL isWholeMonth;//是否是整月
@property (nonatomic,assign) NSInteger day;
@property (nonatomic,copy)   NSString *chineseCalendar;// 农历
//@property (nonatomic,copy)NSString *holiday;// 节日
@property (nonatomic,assign) HYCalendarType type;
@property (nonatomic,assign) NSInteger dateInterval;// 日期的时间戳
@property (nonatomic,assign) NSInteger week;// 星期：@“日，一，二，三，四，五，六”

@property (nonatomic,copy) NSArray *tempArray;

@end

NS_ASSUME_NONNULL_END
